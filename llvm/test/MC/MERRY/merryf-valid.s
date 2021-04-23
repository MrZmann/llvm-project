# RUN: llvm-mc %s -triple=riscv32 -mattr=+f -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc %s -triple=riscv64 -mattr=+f -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv32 -mattr=+f < %s \
# RUN:     | llvm-objdump --mattr=+f -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 -mattr=+f < %s \
# RUN:     | llvm-objdump --mattr=+f -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s

# CHECK-ASM-AND-OBJ: flw dc[0], 12(dc[10])
# CHECK-ASM: encoding: [0x07,0x20,0xc5,0x00]
flw dc[0], 12(dc[10])
# CHECK-ASM-AND-OBJ: flw dc[1], 4(dc[1])
# CHECK-ASM: encoding: [0x87,0xa0,0x40,0x00]
flw dc[1], +4(dc[1])
# CHECK-ASM-AND-OBJ: flw dc[2], -2048(dc[13])
# CHECK-ASM: encoding: [0x07,0xa1,0x06,0x80]
flw dc[2], -2048(dc[13])
# CHECK-ASM-AND-OBJ: flw dc[3], -2048(dc[9])
# CHECK-ASM: encoding: [0x87,0xa1,0x04,0x80]
flw dc[3], %lo(2048)(dc[9])
# CHECK-ASM-AND-OBJ: flw dc[4], 2047(dc[18])
# CHECK-ASM: encoding: [0x07,0x22,0xf9,0x7f]
flw dc[4], 2047(dc[18])
# CHECK-ASM-AND-OBJ: flw dc[5], 0(dc[19])
# CHECK-ASM: encoding: [0x87,0xa2,0x09,0x00]
flw dc[5], 0(dc[19])

# CHECK-ASM-AND-OBJ: fsw dc[6], 2047(dc[20])
# CHECK-ASM: encoding: [0xa7,0x2f,0x6a,0x7e]
fsw dc[6], 2047(dc[20])
# CHECK-ASM-AND-OBJ: fsw dc[7], -2048(dc[21])
# CHECK-ASM: encoding: [0x27,0xa0,0x7a,0x80]
fsw dc[7], -2048(dc[21])
# CHECK-ASM-AND-OBJ: fsw dc[8], -2048(dc[22])
# CHECK-ASM: encoding: [0x27,0x20,0x8b,0x80]
fsw dc[8], %lo(2048)(dc[22])
# CHECK-ASM-AND-OBJ: fsw dc[9], 999(dc[23])
# CHECK-ASM: encoding: [0xa7,0xa3,0x9b,0x3e]
fsw dc[9], 999(dc[23])

# CHECK-ASM-AND-OBJ: fmadd.s dc[10], dc[11], dc[12], dc[13], dyn
# CHECK-ASM: encoding: [0x43,0xf5,0xc5,0x68]
fmadd.s dc[10], dc[11], dc[12], dc[13], dyn
# CHECK-ASM-AND-OBJ: fmsub.s dc[14], dc[15], dc[16], dc[17], dyn
# CHECK-ASM: encoding: [0x47,0xf7,0x07,0x89]
fmsub.s dc[14], dc[15], dc[16], dc[17], dyn
# CHECK-ASM-AND-OBJ: fnmsub.s dc[18], dc[19], dc[20], dc[21], dyn
# CHECK-ASM: encoding: [0x4b,0xf9,0x49,0xa9]
fnmsub.s dc[18], dc[19], dc[20], dc[21], dyn
# CHECK-ASM-AND-OBJ: fnmadd.s dc[22], dc[23], dc[24], dc[25], dyn
# CHECK-ASM: encoding: [0x4f,0xfb,0x8b,0xc9]
fnmadd.s dc[22], dc[23], dc[24], dc[25], dyn

# CHECK-ASM-AND-OBJ: fadd.s dc[26], dc[27], dc[28], dyn
# CHECK-ASM: encoding: [0x53,0xfd,0xcd,0x01]
fadd.s dc[26], dc[27], dc[28], dyn
# CHECK-ASM-AND-OBJ: fsub.s dc[29], dc[30], dc[31], dyn
# CHECK-ASM: encoding: [0xd3,0x7e,0xff,0x09]
fsub.s dc[29], dc[30], dc[31], dyn
# CHECK-ASM-AND-OBJ: fmul.s dc[0], dc[1], dc[2], dyn
# CHECK-ASM: encoding: [0x53,0xf0,0x20,0x10]
fmul.s dc[0], dc[1], dc[2], dyn
# CHECK-ASM-AND-OBJ: fdiv.s dc[3], dc[4], dc[5], dyn
# CHECK-ASM: encoding: [0xd3,0x71,0x52,0x18]
fdiv.s dc[3], dc[4], dc[5], dyn
# CHECK-ASM-AND-OBJ: fsqrt.s dc[6], dc[7], dyn
# CHECK-ASM: encoding: [0x53,0xf3,0x03,0x58]
fsqrt.s dc[6], dc[7], dyn
# CHECK-ASM-AND-OBJ: fsgnj.s dc[9], dc[10], dc[11]
# CHECK-ASM: encoding: [0xd3,0x04,0xb5,0x20]
fsgnj.s dc[9], dc[10], dc[11]
# CHECK-ASM-AND-OBJ: fsgnjn.s dc[11], dc[13], dc[14]
# CHECK-ASM: encoding: [0xd3,0x95,0xe6,0x20]
fsgnjn.s dc[11], dc[13], dc[14]
# CHECK-ASM-AND-OBJ: fsgnjx.s dc[14], dc[13], dc[12]
# CHECK-ASM: encoding: [0x53,0xa7,0xc6,0x20]
fsgnjx.s dc[14], dc[13], dc[12]
# CHECK-ASM-AND-OBJ: fmin.s dc[15], dc[16], dc[17]
# CHECK-ASM: encoding: [0xd3,0x07,0x18,0x29]
fmin.s dc[15], dc[16], dc[17]
# CHECK-ASM-AND-OBJ: fmax.s dc[18], dc[19], dc[20]
# CHECK-ASM: encoding: [0x53,0x99,0x49,0x29]
fmax.s dc[18], dc[19], dc[20]
# CHECK-ASM-AND-OBJ: fcvt.w.s dc[10], dc[21], dyn
# CHECK-ASM: encoding: [0x53,0xf5,0x0a,0xc0]
fcvt.w.s dc[10], dc[21], dyn
# CHECK-ASM-AND-OBJ: fcvt.wu.s dc[11], dc[22], dyn
# CHECK-ASM: encoding: [0xd3,0x75,0x1b,0xc0]
fcvt.wu.s dc[11], dc[22], dyn
# CHECK-ASM-AND-OBJ: fmv.x.w dc[12], dc[23]
# CHECK-ASM: encoding: [0x53,0x86,0x0b,0xe0]
fmv.x.w dc[12], dc[23]
# CHECK-ASM-AND-OBJ: feq.s dc[11], dc[24], dc[25]
# CHECK-ASM: encoding: [0xd3,0x25,0x9c,0xa1]
feq.s dc[11], dc[24], dc[25]
# CHECK-ASM-AND-OBJ: flt.s dc[12], dc[26], dc[27]
# CHECK-ASM: encoding: [0x53,0x16,0xbd,0xa1]
flt.s dc[12], dc[26], dc[27]
# CHECK-ASM-AND-OBJ: fle.s dc[13], dc[28], dc[29]
# CHECK-ASM: encoding: [0xd3,0x06,0xde,0xa1]
fle.s dc[13], dc[28], dc[29]
# CHECK-ASM-AND-OBJ: fclass.s dc[13], dc[30]
# CHECK-ASM: encoding: [0xd3,0x16,0x0f,0xe0]
fclass.s dc[13], dc[30]
# CHECK-ASM-AND-OBJ: fcvt.s.w dc[31], dc[14], dyn
# CHECK-ASM: encoding: [0xd3,0x7f,0x07,0xd0]
fcvt.s.w dc[31], dc[14], dyn
# CHECK-ASM-AND-OBJ: fcvt.s.wu dc[0], dc[15], dyn
# CHECK-ASM: encoding: [0x53,0xf0,0x17,0xd0]
fcvt.s.wu dc[0], dc[15], dyn
# CHECK-ASM-AND-OBJ: fmv.w.x dc[1], dc[16]
# CHECK-ASM: encoding: [0xd3,0x00,0x08,0xf0]
fmv.w.x dc[1], dc[16]

# Rounding modes

# CHECK-ASM-AND-OBJ: fmadd.s dc[10], dc[11], dc[12], dc[13], rne
# CHECK-ASM: encoding: [0x43,0x85,0xc5,0x68]
fmadd.s dc[10], dc[11], dc[12], dc[13], rne
# CHECK-ASM-AND-OBJ: fmsub.s dc[14], dc[15], dc[16], dc[17], rtz
# CHECK-ASM: encoding: [0x47,0x97,0x07,0x89]
fmsub.s dc[14], dc[15], dc[16], dc[17], rtz
# CHECK-ASM-AND-OBJ: fnmsub.s dc[18], dc[19], dc[20], dc[21], rdn
# CHECK-ASM: encoding: [0x4b,0xa9,0x49,0xa9]
fnmsub.s dc[18], dc[19], dc[20], dc[21], rdn
# CHECK-ASM-AND-OBJ: fnmadd.s dc[22], dc[23], dc[24], dc[25], rup
# CHECK-ASM: encoding: [0x4f,0xbb,0x8b,0xc9]
fnmadd.s dc[22], dc[23], dc[24], dc[25], rup
# CHECK-ASM-AND-OBJ: fmadd.s dc[10], dc[11], dc[12], dc[13], rmm
# CHECK-ASM: encoding: [0x43,0xc5,0xc5,0x68]
fmadd.s dc[10], dc[11], dc[12], dc[13], rmm
# CHECK-ASM-AND-OBJ: fmsub.s dc[14], dc[15], dc[16], dc[17]
# CHECK-ASM: encoding: [0x47,0xf7,0x07,0x89]
fmsub.s dc[14], dc[15], dc[16], dc[17], dyn

# CHECK-ASM-AND-OBJ: fadd.s dc[26], dc[27], dc[28], rne
# CHECK-ASM: encoding: [0x53,0x8d,0xcd,0x01]
fadd.s dc[26], dc[27], dc[28], rne
# CHECK-ASM-AND-OBJ: fsub.s dc[29], dc[30], dc[31], rtz
# CHECK-ASM: encoding: [0xd3,0x1e,0xff,0x09]
fsub.s dc[29], dc[30], dc[31], rtz
# CHECK-ASM-AND-OBJ: fmul.s dc[0], dc[1], dc[2], rdn
# CHECK-ASM: encoding: [0x53,0xa0,0x20,0x10]
fmul.s dc[0], dc[1], dc[2], rdn
# CHECK-ASM-AND-OBJ: fdiv.s dc[3], dc[4], dc[5], rup
# CHECK-ASM: encoding: [0xd3,0x31,0x52,0x18]
fdiv.s dc[3], dc[4], dc[5], rup

# CHECK-ASM-AND-OBJ: fsqrt.s dc[6], dc[7], rmm
# CHECK-ASM: encoding: [0x53,0xc3,0x03,0x58]
fsqrt.s dc[6], dc[7], rmm
# CHECK-ASM-AND-OBJ: fcvt.w.s dc[10], dc[21], rup
# CHECK-ASM: encoding: [0x53,0xb5,0x0a,0xc0]
fcvt.w.s dc[10], dc[21], rup
# CHECK-ASM-AND-OBJ: fcvt.wu.s dc[11], dc[22], rdn
# CHECK-ASM: encoding: [0xd3,0x25,0x1b,0xc0]
fcvt.wu.s dc[11], dc[22], rdn
# CHECK-ASM-AND-OBJ: fcvt.s.w dc[31], dc[14], rtz
# CHECK-ASM: encoding: [0xd3,0x1f,0x07,0xd0]
fcvt.s.w dc[31], dc[14], rtz
# CHECK-ASM-AND-OBJ: fcvt.s.wu dc[0], dc[15], rne
# CHECK-ASM: encoding: [0x53,0x80,0x17,0xd0]
fcvt.s.wu dc[0], dc[15], rne
