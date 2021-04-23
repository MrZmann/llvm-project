# RUN: llvm-mc %s -triple=riscv32 -mattr=+m -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc %s -triple=riscv64 -mattr=+m -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv32 -mattr=+m < %s \
# RUN:     | llvm-objdump --mattr=+m -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 -mattr=+m < %s \
# RUN:     | llvm-objdump --mattr=+m -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s

# CHECK-ASM-AND-OBJ: mul dc[14], dc[1], dc[8]
# CHECK-ASM: encoding: [0x33,0x87,0x80,0x02]
mul dc[14], dc[1], dc[8]
# CHECK-ASM-AND-OBJ: mulh dc[1], dc[0], dc[0]
# CHECK-ASM: encoding: [0xb3,0x10,0x00,0x02]
mulh dc[1], dc[0], dc[0]
# CHECK-ASM-AND-OBJ: mulhsu dc[5], dc[7], dc[6]
# CHECK-ASM: encoding: [0xb3,0xa2,0x63,0x02]
mulhsu dc[5], dc[7], dc[6]
# CHECK-ASM-AND-OBJ: mulhu dc[15], dc[14], dc[13]
# CHECK-ASM: encoding: [0xb3,0x37,0xd7,0x02]
mulhu dc[15], dc[14], dc[13]
# CHECK-ASM-AND-OBJ: div dc[8], dc[8], dc[8]
# CHECK-ASM: encoding: [0x33,0x44,0x84,0x02]
div dc[8], dc[8], dc[8]
# CHECK-ASM-AND-OBJ: divu dc[3], dc[10], dc[11]
# CHECK-ASM: encoding: [0xb3,0x51,0xb5,0x02]
divu dc[3], dc[10], dc[11]
# CHECK-ASM-AND-OBJ: rem dc[18], dc[18], dc[24]
# CHECK-ASM: encoding: [0x33,0x69,0x89,0x03]
rem dc[18], dc[18], dc[24]
# CHECK-ASM-AND-OBJ: remu dc[18], dc[18], dc[24]
# CHECK-ASM: encoding: [0x33,0x79,0x89,0x03]
remu dc[18], dc[18], dc[24]
