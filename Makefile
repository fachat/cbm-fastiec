

DOSFILES=dostst dosi0 dosdir dosmkdata dosvfdata dosfmt dosscr dosval doscat
CBMFILES=dosromldr cbmtst cbmi0 cbmcat cbmdir cbmmkdata cbmvfdata cbmscr cbmfmt
ESRFILES=esrtst esrdir

all: c128-orig.bin c128-commented.bin upet-fiec-core.bin $(DOSFILES) $(CBMFILES) $(ESRFILES)

%.bin: %.a65
	xa -XMASM -o $@ $<

upet-fiec-core.bin: upet-fiec-core.a65
	xa -P $@.lst -DPET -XMASM -o $@ $<

upet-fiec-esr-core.bin: upet-fiec-esr-core.a65
	xa -P $@.lst -DPET -XMASM -o $@ $<

dosromldr: dosromldr.a65 dosromcomp.a65 upet-fiec-core.a65
	xa -XMASM -w -P $@.lst -DPET -o $@ $<

%: %.a65 common.a65 upet-fiec-core.bin upet-fiec-esr-core.bin
	xa -XMASM -w -P $@.lst -DPET -o $@ $<
	
clean:
	rm -f *.bin *.lst
	rm -f $(DOSFILES) $(CBMFILES) $(ESRFILES)

