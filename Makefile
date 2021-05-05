export SHELL := /bin/bash

BASENAME=MemoryInstrTest
SOURCE=$(BASENAME).asm
RESULT=$(BASENAME).lst

ARCH=arm-none-eabi-

all:
	# Convert semicolons (ARM-style) to @ (GNU style), and assemble
	$(ARCH)as <(sed "s/;/@/g" $(SOURCE)) -o $(BASENAME)
	# Dump the results
	$(ARCH)objdump -d $(BASENAME) | tail -n +8 > $(RESULT)

clean:
	rm $(BASENAME)
	rm $(RESULT)
