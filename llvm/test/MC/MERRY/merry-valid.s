# RUN: llvm-mc %s -triple=riscv32 -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM %s
# RUN: llvm-mc %s -triple riscv64 -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM %s


# CHECK-ASM: encoding: [0x9b,0x70,0x00,0x00]
merry_asm dc[1], dc[0], dc[0]
