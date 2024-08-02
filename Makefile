TARGET=bin/result
NIM=/home/jesus/.nimble/bin/nim
NIMLIBS=-p:~/.nimble/pkgs/nimgl-2.3.2 \
				-p:~/.nimble/pkgs/nimPNG-0.3.6/
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
