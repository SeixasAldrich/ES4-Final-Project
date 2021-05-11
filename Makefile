export SHELL := /bin/bash

BASENAME=branchtest
SOURCE=$(BASENAME).asm
RESULT=$(BASENAME).lst

ARCH=arm-none-eabi-

all:
	# Convert semicolons (ARM-style) to @ (GNU style), and assemble
	$(ARCH)as <(sed "s/;/@/g" $(SOURCE)) -o $(BASENAME)
	# Dump the results
	$(ARCH)objdump -d $(BASENAME) | tail -n +8 > $(RESULT)

get_hex: get_hex.cpp
	g++ get_hex.cpp -o get_hex -Wall -Wextra

get_text: 
	./get_hex $(BASENAME).lst > $(BASENAME).txt

clean:
	rm $(BASENAME)
	rm $(RESULT)
