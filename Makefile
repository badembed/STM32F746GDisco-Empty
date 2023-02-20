# Please set path to your project directory
# and your arm-none-eabi-gcc toolchain
PRJ = /home/alex/STM32CubeMX/Projects/empty
CCPATH = /home/alex/tool/gcc-arm-none-eabi-10.3-2021.10/bin

########################################################################
CC=$(CCPATH)/arm-none-eabi-gcc
LD=$(CCPATH)/arm-none-eabi-gcc
CP=$(CCPATH)/arm-none-eabi-objcopy

########################################################################
LDSCRIPT = -T$(PRJ)/STM32F746NGHx_FLASH.ld

########################################################################
INC += -I$(PRJ)/Inc

SRC += $(PRJ)/Src/main.c

ASM += $(PRJ)/startup_stm32f746xx.s

#######################################################################
OBJ=$(SRC:%.c=%.o)
OBJ+=$(ASM:%.s=%.o)

#######################################################################
CFLAGS += -mcpu=cortex-m7
CFLAGS += -mlittle-endian
CFLAGS += -mthumb
CFLAGS += -g
CFLAGS += $(INC)

LDFLAGS += -mcpu=cortex-m7
LDFLAGS += -mlittle-endian
LDFLAGS += -mthumb
LDFLAGS += $(LDSCRIPT)
LDFLAGS += -Wl,--gc-section

CDEFS = -DSTM32F746xx

######################################################################

all: main.elf
	@echo "\n"
	@echo "END"

main.elf: $(OBJ)
	@echo "\n"
	@echo "LINK"
	@echo "********************************************************"
	$(LD) $(LDFLAGS) $(OBJ) -o main.elf
	@echo "********************************************************"

%.o: %.c
	@echo "\n"
	@echo "COMPILE C"
	@echo "********************************************************"
	$(CC) $(CFLAGS) $(CDEFS) -c $< -o $@
	@echo "********************************************************"

%.o: %.s
	@echo "\n"
	@echo "COMPILE S"
	@echo "********************************************************"
	$(CC) $(CFLAGS) -c $< -o $@
	@echo "********************************************************"

clean:
	rm -f $(OBJ) main.elf main.hex
