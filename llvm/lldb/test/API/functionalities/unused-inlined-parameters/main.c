#include <stdio.h>

__attribute__((optnone)) __attribute__((nodebug)) void use(int used) {}

__attribute__((always_inline)) void f(void *unused1, int used) {
  use(used); // break here
}

int main(int argc, char **argv) {
  char *undefined;
  f(undefined, 42);
  return 0;
}
