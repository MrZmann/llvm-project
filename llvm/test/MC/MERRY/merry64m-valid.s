# RUN: llvm-mc %s -triple=riscv64 -mattr=+m -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 -mattr=+m < %s \
# RUN:     | llvm-objdump --mattr=+m -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s

# CHECK-ASM-AND-OBJ: mulw dc[1], dc[2], dc[3]
# CHECK-ASM: encoding: [0xbb,0x00,0x31,0x02]
mulw dc[1], dc[2], dc[3]
# CHECK-ASM-AND-OBJ: divw dc[4], dc[5], dc[6]
# CHECK-ASM: encoding: [0x3b,0xc2,0x62,0x02]
divw dc[4], dc[5], dc[6]
# CHECK-ASM-AND-OBJ: divuw dc[7], dc[8], dc[18]
# CHECK-ASM: encoding: [0xbb,0x53,0x24,0x03]
divuw dc[7], dc[8], dc[18]
# CHECK-ASM-AND-OBJ: remw dc[10], dc[11], dc[12]
# CHECK-ASM: encoding: [0x3b,0xe5,0xc5,0x02]
remw dc[10], dc[11], dc[12]
# CHECK-ASM-AND-OBJ: remuw dc[13], dc[14], dc[15]
# CHECK-ASM: encoding: [0xbb,0x76,0xf7,0x02]
remuw dc[13], dc[14], dc[15]
