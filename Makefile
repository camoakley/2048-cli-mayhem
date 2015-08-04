CC      ?= clang
CFLAGS  += -Wno-visibility -Wno-incompatible-pointer-types -Wall -Wextra -O2 -DINVERT_COLORS -DVT100
LFLAGS  +=

PROGRAM := 2048
C_FILES := $(wildcard src/*.c)
MERGE_FILE := src/merge_std.c
FILTERED_C_FILES := $(filter-out src/gfx%.c src/merge%.c, $(C_FILES))

all: terminal

curses: $(FILTERED_C_FILES) src/gfx_curses.c
	$(CC) $(CFLAGS) $(FILTERED_C_FILES) $(MERGE_FILE) src/gfx_curses.c -o $(PROGRAM) -lcurses

terminal: $(FILTERED_C_FILES) src/gfx_terminal.c
	$(CC) $(CFLAGS) $(FILTERED_C_FILES) $(MERGE_FILE) src/gfx_terminal.c -o $(PROGRAM)

sdl: $(FILTERED_C_FILES) src/gfx_sdl.c
	$(CC) $(CFLAGS) $(FILTERED_C_FILES) $(MERGE_FILE) src/gfx_sdl.c -o $(PROGRAM) $(shell pkg-config --cflags sdl2) -lSDL2 -lSDL2_ttf

remake: clean all

clean:
	rm -f $(PROGRAM)

.PHONY: clean remake
