#include "stm32f746xx.h"

void SystemInit(void)
{
}

int main(void)
{
  RCC->AHB1ENR |= RCC_AHB1ENR_GPIOIEN;

  // PI1 GP output mode
  GPIOI->MODER |= (0b01 << 2); // GPIO_MODER_MODER1_0

  // Button (PI11) is set as input by default after reset

  // Read Button PI11 - wait for button push
  while ((GPIOI->IDR & GPIO_IDR_ID11) != GPIO_IDR_ID11);

  // set LED PI1
  GPIOI->BSRR |= GPIO_BSRR_BS1;

  while(1);
}
