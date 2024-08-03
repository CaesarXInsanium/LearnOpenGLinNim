TARGET=bin/result
NIM=$(HOME)/.nimble/bin/nim
NIMFLAGS= --debugger:native --clib:glfw --app:gui --nanchecks:on --outdir:bin
SOURCE_DIR=src
SOURCES=$(shell fd --extension nim . $(SOURCE_DIR))

all: $(TARGET)

bin:
	mkdir $@

$(TARGET): src/main.nim bin
	$(NIM) c -o:$@ $(NIMFLAGS) $<

run: $(TARGET)
	$(TARGET)

clean:
	rm -rf bin
format:
	~/.nimble/bin/nimpretty --maxLineLen:80 $(SOURCES)
