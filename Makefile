TARGET=bin/result
NIM=~/.nimble/bin/nim
NIMLIBS=-p:~/.nimble/pkgs2/nimgl-1.3.2-9d94ff205d72321e896dd6130403510e9a1c8a5d \
				-p:~/.nimble/pkgs2/nimPNG-0.3.6-fda304ec37a10426630bf0e328650b5c45377e39
NIMFLAGS=--app:gui --nanchecks:on --outdir:bin

all: $(TARGET)

bin:
	mkdir $@

$(TARGET): learnopengl.nim bin
	$(NIM) c -o:$@ $(NIMFLAGS) $<

run: $(TARGET)
	$(TARGET)

clean:
	rm -rf bin
