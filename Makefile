NIM=$(HOME)/.nimble/bin/nim
SOURCE_DIR=src
SOURCES=$(shell fd --extension nim . $(SOURCE_DIR))
NIMFLAGS= --debugger:native \
					--clib:glfw \
					--app:gui \
					--path:$(SOURCE_DIR) \
					--nanchecks:on \
					--outdir:bin \
					--skipParentCfg \
					--skipProjCfg \
					--skipUserCfg
TARGET=bin/learngl
ENTRY=main.nim

all: $(TARGET)

bin:
	mkdir $@

$(TARGET): $(ENTRY) bin
	$(NIM) c -o:$@ $(NIMFLAGS) $<

run: $(TARGET)
	$(TARGET)

$(ENTRY): $(SOURCES)

clean:
	rm -rf bin
format:
	echo "Save and Close in Vim First"
	~/.nimble/bin/nimpretty --maxLineLen:80 $(SOURCES)
