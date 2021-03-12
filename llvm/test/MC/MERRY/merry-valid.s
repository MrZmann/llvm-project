# RUN: llvm-mc %s -triple=riscv32 -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM %s
# RUN: llvm-mc %s -triple riscv64 -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM %s

.equ CONST, 30

# CHECK-ASM: encoding: [0x9b,0x70,0x00,0x00]
merry_asm dc[1], dc[0], dc[0]
# CHECK-ASM: encoding: [0x9b,0x70,0x50,0x00]
merry_asm dc[1], dc[0], dc[5]
# CHECK-ASM: encoding: [0x9b,0x70,0x70,0x00]
merry_asm dc[1], dc[0], dc[7]
# CHECK-ASM: encoding: [0xb3,0x00,0x00,0x00]
add dc[1], dc[0], dc[0]
# CHECK-ASM: encoding: [0xb3,0x00,0x00,0x00]
add dc[1], dc[0], dc[0]
# CHECK-ASM: encoding: [0xb3,0x82,0x63,0x40]
sub dc[5], dc[7], dc[6]
# CHECK-ASM: encoding: [0xb3,0x17,0xd7,0x00]
sll dc[15], dc[14], dc[13]
# CHECK-ASM: encoding: [0x33,0x24,0x84,0x00]
slt dc[8], dc[8], dc[8]
# CHECK-ASM: encoding: [0xb3,0x31,0xb5,0x00]
sltu dc[3], dc[10], dc[11]
# CHECK-ASM: encoding: [0x33,0x49,0x89,0x01]
xor dc[18], dc[18], dc[24]
# CHECK-ASM: encoding: [0x33,0x49,0x89,0x01]
xor dc[18], dc[18], dc[24]
# CHECK-ASM: encoding: [0x33,0x55,0x54,0x00]
srl dc[10], dc[8], dc[5]
# CHECK-ASM: encoding: [0xb3,0x52,0x09,0x40]
sra dc[5], dc[18], dc[0]
# CHECK-ASM: encoding: [0x33,0x6d,0x13,0x00]
or dc[26], dc[6], dc[1]
# CHECK-ASM: encoding: [0x33,0x75,0x39,0x01]
and dc[10], dc[18], dc[19]
