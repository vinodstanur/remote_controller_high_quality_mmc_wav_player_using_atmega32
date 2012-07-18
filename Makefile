# AVR-GCC Makefile
PROJECT=wav_player
SOURCES=main.c
CC=avr-gcc
OBJCOPY=avr-objcopy
MMCU=atmega32

CFLAGS=-mmcu=$(MMCU)

$(PROJECT).hex: $(PROJECT).out
	$(OBJCOPY) -j .text -j .data -O ihex $(PROJECT).out $(PROJECT).hex

$(PROJECT).out: $(SOURCES)
	$(CC) $(CFLAGS) -O2 -I./ -o $(PROJECT).s $(SOURCES) -S
	$(CC) $(CFLAGS) -O2 -I./ -o $(PROJECT).out $(SOURCES)

burn_hex: $(PROJECT).hex
	avrdude -p m32 -c usbasp -U flash:w:$(PROJECT).hex:i

burn_fuse:
	avrdude -p m32 -c usbasp -U lfuse:w:0xef:m

clean:
	rm -f $(PROJECT).out
	rm -f $(PROJECT).hex
	rm -f $(PROJECT).s
