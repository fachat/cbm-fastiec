

DOSFILES=dostst dosi0 doscat dosmkdata dosvfdata dosfmt dosscr dosval 
CBMFILES=cbmtst cbmi0 cbmcat cbmmkdata cbmvfdata cbmfmt cbmscr cbmval
ESRFILES=esrtst esrcat
SUPPORT=dosromldr 

all: c128-orig.bin c128-commented.bin upet-fiec-core.bin $(SUPPORT) $(DOSFILES) $(CBMFILES) $(ESRFILES)

%.bin: %.a65
	xa -XMASM -o $@ $<

upet-fiec-core.bin: upet-fiec-core.a65
	xa -P $@.lst -DPET -XMASM -o $@ $<

upet-fiec-esr-core.bin: upet-fiec-esr-core.a65
	xa -P $@.lst -DPET -XMASM -o $@ $<

dosromldr: dosromldr.a65 dosromcomp.a65 upet-fiec-core.a65
	xa -XMASM -w -P $@.lst -DPET -o $@ $<

$(CBMFILES): cbm%: iec%.a65 cbm-core.a65 common.a65
	xa -XMASM -w -P $@.lst -DPET -DCORE=cbm-core.a65 -o $@ $<

$(DOSFILES): dos%: iec%.a65 cbm-core.a65 common.a65
	xa -XMASM -w -P $@.lst -DPET -DCORE=upet-fiec-core.a65 -o $@ $<

$(ESRFILES): esr%: iec%.a65 cbm-core.a65 common.a65
	xa -XMASM -w -P $@.lst -DPET -DCORE=upet-fiec-esr-core.a65 -o $@ $<

clean:
	rm -f *.bin *.lst
	rm -f $(DOSFILES) $(CBMFILES) $(ESRFILES)
	rm -f $(SUPPORT)

