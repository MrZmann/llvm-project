# RUN: llvm-mc %s -triple=riscv64 -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 < %s \
# RUN:     | llvm-objdump -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s

.equ CONST, 31

# CHECK-ASM-AND-OBJ: lwu dc[0], 4(dc[1])
# CHECK-ASM: encoding: [0x03,0xe0,0x40,0x00]
lwu dc[0], 4(dc[1])
# CHECK-ASM-AND-OBJ: lwu dc[2], 4(dc[3])
# CHECK-ASM: encoding: [0x03,0xe1,0x41,0x00]
lwu dc[2], +4(dc[3])
# CHECK-ASM-AND-OBJ: lwu dc[4], -2048(dc[5])
# CHECK-ASM: encoding: [0x03,0xe2,0x02,0x80]
lwu dc[4], -2048(dc[5])
# CHECK-ASM-AND-OBJ: lwu dc[6], -2048(dc[7])
# CHECK-ASM: encoding: [0x03,0xe3,0x03,0x80]
lwu dc[6], %lo(2048)(dc[7])
# CHECK-ASM-AND-OBJ: lwu dc[8], 2047(dc[9])
# CHECK-ASM: encoding: [0x03,0xe4,0xf4,0x7f]
lwu dc[8], 2047(dc[9])

# CHECK-ASM-AND-OBJ: ld dc[10], -2048(dc[11])
# CHECK-ASM: encoding: [0x03,0xb5,0x05,0x80]
ld dc[10], -2048(dc[11])
# CHECK-ASM-AND-OBJ: ld dc[12], -2048(dc[13])
# CHECK-ASM: encoding: [0x03,0xb6,0x06,0x80]
ld dc[12], %lo(2048)(dc[13])
# CHECK-ASM-AND-OBJ: ld dc[14], 2047(dc[15])
# CHECK-ASM: encoding: [0x03,0xb7,0xf7,0x7f]
ld dc[14], 2047(dc[15])

# CHECK-ASM-AND-OBJ: sd dc[16], -2048(dc[17])
# CHECK-ASM: encoding: [0x23,0xb0,0x08,0x81]
sd dc[16], -2048(dc[17])
# CHECK-ASM-AND-OBJ: sd dc[18], -2048(dc[19])
# CHECK-ASM: encoding: [0x23,0xb0,0x29,0x81]
sd dc[18], %lo(2048)(dc[19])
# CHECK-ASM-AND-OBJ: sd dc[20], 2047(dc[21])
# CHECK-ASM: encoding: [0xa3,0xbf,0x4a,0x7f]
sd dc[20], 2047(dc[21])

# CHECK-ASM-AND-OBJ: slli dc[22], dc[23], 45
# CHECK-ASM: encoding: [0x13,0x9b,0xdb,0x02]
slli dc[22], dc[23], 45
# CHECK-ASM-AND-OBJ: srli dc[24], dc[25], 0
# CHECK-ASM: encoding: [0x13,0xdc,0x0c,0x00]
srli dc[24], dc[25], 0
# CHECK-ASM-AND-OBJ: srai dc[26], dc[27], 31
# CHECK-ASM: encoding: [0x13,0xdd,0xfd,0x41]
srai dc[26], dc[27], 31
# CHECK-ASM-AND-OBJ: srai dc[26], dc[27], 31
# CHECK-ASM: encoding: [0x13,0xdd,0xfd,0x41]
srai dc[26], dc[27], CONST

# CHECK-ASM-AND-OBJ: addiw dc[28], dc[29], -2048
# CHECK-ASM: encoding: [0x1b,0x8e,0x0e,0x80]
addiw dc[28], dc[29], -2048
# CHECK-ASM-AND-OBJ: addiw dc[30], dc[31], 2047
# CHECK-ASM: encoding: [0x1b,0x8f,0xff,0x7f]
addiw dc[30], dc[31], 2047

# CHECK-ASM-AND-OBJ: slliw dc[0], dc[1], 0
# CHECK-ASM: encoding: [0x1b,0x90,0x00,0x00]
slliw dc[0], dc[1], 0
# CHECK-ASM-AND-OBJ: slliw dc[2], dc[3], 31
# CHECK-ASM: encoding: [0x1b,0x91,0xf1,0x01]
slliw dc[2], dc[3], 31
# CHECK-ASM-AND-OBJ: srliw dc[4], dc[5], 0
# CHECK-ASM: encoding: [0x1b,0xd2,0x02,0x00]
srliw dc[4], dc[5], 0
# CHECK-ASM-AND-OBJ: srliw dc[6], dc[7], 31
# CHECK-ASM: encoding: [0x1b,0xd3,0xf3,0x01]
srliw dc[6], dc[7], 31
# CHECK-ASM-AND-OBJ: sraiw dc[8], dc[9], 0
# CHECK-ASM: encoding: [0x1b,0xd4,0x04,0x40]
sraiw dc[8], dc[9], 0
# CHECK-ASM-AND-OBJ: sraiw dc[10], dc[11], 31
# CHECK-ASM: encoding: [0x1b,0xd5,0xf5,0x41]
sraiw dc[10], dc[11], 31
# CHECK-ASM-AND-OBJ: sraiw dc[10], dc[11], 31
# CHECK-ASM: encoding: [0x1b,0xd5,0xf5,0x41]
sraiw dc[10], dc[11], CONST

# CHECK-ASM-AND-OBJ: addw dc[12], dc[13], dc[14]
# CHECK-ASM: encoding: [0x3b,0x86,0xe6,0x00]
addw dc[12], dc[13], dc[14]
# CHECK-ASM-AND-OBJ: addw dc[15], dc[16], dc[17]
# CHECK-ASM: encoding: [0xbb,0x07,0x18,0x01]
addw dc[15], dc[16], dc[17]
# CHECK-ASM-AND-OBJ: subw dc[18], dc[19], dc[20]
# CHECK-ASM: encoding: [0x3b,0x89,0x49,0x41]
subw dc[18], dc[19], dc[20]
# CHECK-ASM-AND-OBJ: subw dc[21], dc[22], dc[23]
# CHECK-ASM: encoding: [0xbb,0x0a,0x7b,0x41]
subw dc[21], dc[22], dc[23]
# CHECK-ASM-AND-OBJ: sllw dc[24], dc[25], dc[26]
# CHECK-ASM: encoding: [0x3b,0x9c,0xac,0x01]
sllw dc[24], dc[25], dc[26]
# CHECK-ASM-AND-OBJ: srlw dc[27], dc[28], dc[29]
# CHECK-ASM: encoding: [0xbb,0x5d,0xde,0x01]
srlw dc[27], dc[28], dc[29]
# CHECK-ASM-AND-OBJ: sraw dc[30], dc[31], dc[0]
# CHECK-ASM: encoding: [0x3b,0xdf,0x0f,0x40]
sraw dc[30], dc[31], dc[0]
