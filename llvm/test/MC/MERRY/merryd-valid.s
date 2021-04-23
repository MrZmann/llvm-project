# RUN: llvm-mc %s -triple=riscv32 -mattr=+d -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv32 -mattr=+d < %s \
# RUN:     | llvm-objdump --mattr=+d -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc %s -triple=riscv64 -mattr=+d -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 -mattr=+d < %s \
# RUN:     | llvm-objdump --mattr=+d -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s

# Support for the 'D' extension implies support for 'F'
# CHECK-ASM-AND-OBJ: fadd.s dc[26], dc[27], dc[28]
# CHECK-ASM: encoding: [0x53,0xfd,0xcd,0x01]
fadd.s dc[26], dc[27], dc[28]

# CHECK-ASM-AND-OBJ: fld dc[0], 12(dc[10])
# CHECK-ASM: encoding: [0x07,0x30,0xc5,0x00]
fld dc[0], 12(dc[10])
# CHECK-ASM-AND-OBJ: fld dc[1], 4(dc[1])
# CHECK-ASM: encoding: [0x87,0xb0,0x40,0x00]
fld dc[1], +4(dc[1])
# CHECK-ASM-AND-OBJ: fld dc[2], -2048(dc[13])
# CHECK-ASM: encoding: [0x07,0xb1,0x06,0x80]
fld dc[2], -2048(dc[13])
# CHECK-ASM-AND-OBJ: fld dc[3], -2048(dc[9])
# CHECK-ASM: encoding: [0x87,0xb1,0x04,0x80]
fld dc[3], %lo(2048)(dc[9])
# CHECK-ASM-AND-OBJ: fld dc[4], 2047(dc[18])
# CHECK-ASM: encoding: [0x07,0x32,0xf9,0x7f]
fld dc[4], 2047(dc[18])
# CHECK-ASM-AND-OBJ: fld dc[5], 0(dc[19])
# CHECK-ASM: encoding: [0x87,0xb2,0x09,0x00]
fld dc[5], 0(dc[19])

# CHECK-ASM-AND-OBJ: fsd dc[6], 2047(dc[20])
# CHECK-ASM: encoding: [0xa7,0x3f,0x6a,0x7e]
fsd dc[6], 2047(dc[20])
# CHECK-ASM-AND-OBJ: fsd dc[7], -2048(dc[21])
# CHECK-ASM: encoding: [0x27,0xb0,0x7a,0x80]
fsd dc[7], -2048(dc[21])
# CHECK-ASM-AND-OBJ: fsd dc[8], -2048(dc[22])
# CHECK-ASM: encoding: [0x27,0x30,0x8b,0x80]
fsd dc[8], %lo(2048)(dc[22])
# CHECK-ASM-AND-OBJ: fsd dc[9], 999(dc[23])
# CHECK-ASM: encoding: [0xa7,0xb3,0x9b,0x3e]
fsd dc[9], 999(dc[23])

# CHECK-ASM-AND-OBJ: fmadd.d dc[10], dc[11], dc[12], dc[13], dyn
# CHECK-ASM: encoding: [0x43,0xf5,0xc5,0x6a]
fmadd.d dc[10], dc[11], dc[12], dc[13], dyn
# CHECK-ASM-AND-OBJ: fmsub.d dc[14], dc[15], dc[16], dc[17], dyn
# CHECK-ASM: encoding: [0x47,0xf7,0x07,0x8b]
fmsub.d dc[14], dc[15], dc[16], dc[17], dyn
# CHECK-ASM-AND-OBJ: fnmsub.d dc[18], dc[19], dc[20], dc[21], dyn
# CHECK-ASM: encoding: [0x4b,0xf9,0x49,0xab]
fnmsub.d dc[18], dc[19], dc[20], dc[21], dyn
# CHECK-ASM-AND-OBJ: fnmadd.d dc[22], dc[23], dc[24], dc[25], dyn
# CHECK-ASM: encoding: [0x4f,0xfb,0x8b,0xcb]
fnmadd.d dc[22], dc[23], dc[24], dc[25], dyn

# CHECK-ASM-AND-OBJ: fadd.d dc[26], dc[27], dc[28], dyn
# CHECK-ASM: encoding: [0x53,0xfd,0xcd,0x03]
fadd.d dc[26], dc[27], dc[28], dyn
# CHECK-ASM-AND-OBJ: fsub.d dc[29], dc[30], dc[31], dyn
# CHECK-ASM: encoding: [0xd3,0x7e,0xff,0x0b]
fsub.d dc[29], dc[30], dc[31], dyn
# CHECK-ASM-AND-OBJ: fmul.d dc[0], dc[1], dc[2], dyn
# CHECK-ASM: encoding: [0x53,0xf0,0x20,0x12]
fmul.d dc[0], dc[1], dc[2], dyn
# CHECK-ASM-AND-OBJ: fdiv.d dc[3], dc[4], dc[5], dyn
# CHECK-ASM: encoding: [0xd3,0x71,0x52,0x1a]
fdiv.d dc[3], dc[4], dc[5], dyn
# CHECK-ASM-AND-OBJ: fsqrt.d dc[6], dc[7], dyn
# CHECK-ASM: encoding: [0x53,0xf3,0x03,0x5a]
fsqrt.d dc[6], dc[7], dyn
# CHECK-ASM-AND-OBJ: fsgnj.d dc[9], dc[10], dc[11]
# CHECK-ASM: encoding: [0xd3,0x04,0xb5,0x22]
fsgnj.d dc[9], dc[10], dc[11]
# CHECK-ASM-AND-OBJ: fsgnjn.d dc[11], dc[13], dc[14]
# CHECK-ASM: encoding: [0xd3,0x95,0xe6,0x22]
fsgnjn.d dc[11], dc[13], dc[14]
# CHECK-ASM-AND-OBJ: fsgnjx.d dc[13], dc[12], dc[11]
# CHECK-ASM: encoding: [0xd3,0x26,0xb6,0x22]
fsgnjx.d dc[13], dc[12], dc[11]
# CHECK-ASM-AND-OBJ: fmin.d dc[15], dc[16], dc[17]
# CHECK-ASM: encoding: [0xd3,0x07,0x18,0x2b]
fmin.d dc[15], dc[16], dc[17]
# CHECK-ASM-AND-OBJ: fmax.d dc[18], dc[19], dc[20]
# CHECK-ASM: encoding: [0x53,0x99,0x49,0x2b]
fmax.d dc[18], dc[19], dc[20]

# CHECK-ASM-AND-OBJ: fcvt.s.d dc[21], dc[22], dyn
# CHECK-ASM: encoding: [0xd3,0x7a,0x1b,0x40]
fcvt.s.d dc[21], dc[22], dyn
# CHECK-ASM-AND-OBJ: fcvt.d.s dc[23], dc[24]
# CHECK-ASM: encoding: [0xd3,0x0b,0x0c,0x42]
fcvt.d.s dc[23], dc[24]
# CHECK-ASM-AND-OBJ: feq.d dc[11], dc[24], dc[25]
# CHECK-ASM: encoding: [0xd3,0x25,0x9c,0xa3]
feq.d dc[11], dc[24], dc[25]
# CHECK-ASM-AND-OBJ: flt.d dc[12], dc[26], dc[27]
# CHECK-ASM: encoding: [0x53,0x16,0xbd,0xa3]
flt.d dc[12], dc[26], dc[27]
# CHECK-ASM-AND-OBJ: fle.d dc[13], dc[28], dc[29]
# CHECK-ASM: encoding: [0xd3,0x06,0xde,0xa3]
fle.d dc[13], dc[28], dc[29]
# CHECK-ASM-AND-OBJ: fclass.d dc[13], dc[30]
# CHECK-ASM: encoding: [0xd3,0x16,0x0f,0xe2]
fclass.d dc[13], dc[30]

# CHECK-ASM-AND-OBJ: fcvt.w.d dc[14], dc[31], dyn
# CHECK-ASM: encoding: [0x53,0xf7,0x0f,0xc2]
fcvt.w.d dc[14], dc[31], dyn
# CHECK-ASM-AND-OBJ: fcvt.d.w dc[0], dc[15]
# CHECK-ASM: encoding: [0x53,0x80,0x07,0xd2]
fcvt.d.w dc[0], dc[15]
# CHECK-ASM-AND-OBJ: fcvt.d.wu dc[1], dc[16]
# CHECK-ASM: encoding: [0xd3,0x00,0x18,0xd2]
fcvt.d.wu dc[1], dc[16]

# Rounding modes

# CHECK-ASM-AND-OBJ: fmadd.d dc[10], dc[11], dc[12], dc[13], rne
# CHECK-ASM: encoding: [0x43,0x85,0xc5,0x6a]
fmadd.d dc[10], dc[11], dc[12], dc[13], rne
# CHECK-ASM-AND-OBJ: fmsub.d dc[14], dc[15], dc[16], dc[17], rtz
# CHECK-ASM: encoding: [0x47,0x97,0x07,0x8b]
fmsub.d dc[14], dc[15], dc[16], dc[17], rtz
# CHECK-ASM-AND-OBJ: fnmsub.d dc[18], dc[19], dc[20], dc[21], rdn
# CHECK-ASM: encoding: [0x4b,0xa9,0x49,0xab]
fnmsub.d dc[18], dc[19], dc[20], dc[21], rdn
# CHECK-ASM-AND-OBJ: fnmadd.d dc[22], dc[23], dc[24], dc[25], rup
# CHECK-ASM: encoding: [0x4f,0xbb,0x8b,0xcb]
fnmadd.d dc[22], dc[23], dc[24], dc[25], rup

# CHECK-ASM-AND-OBJ: fadd.d dc[26], dc[27], dc[28], rmm
# CHECK-ASM: encoding: [0x53,0xcd,0xcd,0x03]
fadd.d dc[26], dc[27], dc[28], rmm
# CHECK-ASM-AND-OBJ: fsub.d dc[29], dc[30], dc[31]
# CHECK-ASM: encoding: [0xd3,0x7e,0xff,0x0b]
fsub.d dc[29], dc[30], dc[31], dyn
# CHECK-ASM-AND-OBJ: fmul.d dc[0], dc[1], dc[2], rne
# CHECK-ASM: encoding: [0x53,0x80,0x20,0x12]
fmul.d dc[0], dc[1], dc[2], rne
# CHECK-ASM-AND-OBJ: fdiv.d dc[3], dc[4], dc[5], rtz
# CHECK-ASM: encoding: [0xd3,0x11,0x52,0x1a]
fdiv.d dc[3], dc[4], dc[5], rtz

# CHECK-ASM-AND-OBJ: fsqrt.d dc[6], dc[7], rdn
# CHECK-ASM: encoding: [0x53,0xa3,0x03,0x5a]
fsqrt.d dc[6], dc[7], rdn
# CHECK-ASM-AND-OBJ: fcvt.s.d dc[21], dc[22], rup
# CHECK-ASM: encoding: [0xd3,0x3a,0x1b,0x40]
fcvt.s.d dc[21], dc[22], rup
# CHECK-ASM-AND-OBJ: fcvt.w.d dc[14], dc[31], rmm
# CHECK-ASM: encoding: [0x53,0xc7,0x0f,0xc2]
fcvt.w.d dc[14], dc[31], rmm
# CHECK-ASM-AND-OBJ: fcvt.wu.d dc[15], dc[30], dyn
# CHECK-ASM: encoding: [0xd3,0x77,0x1f,0xc2]
fcvt.wu.d dc[15], dc[30], dyn
