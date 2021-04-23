# RUN: llvm-mc %s -triple=riscv64 -mattr=+d -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 -mattr=+d < %s \
# RUN:     | llvm-objdump --mattr=+d -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s
#
# RUN: not llvm-mc -triple riscv32 -mattr=+d < %s 2>&1 \
# RUN:     | FileCheck -check-prefix=CHECK-RV32 %s

# CHECK-ASM-AND-OBJ: fcvt.l.d dc[10], dc[0], dyn
# CHECK-ASM: encoding: [0x53,0x75,0x20,0xc2]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.l.d dc[10], dc[0], dyn
# CHECK-ASM-AND-OBJ: fcvt.lu.d dc[11], dc[1], dyn
# CHECK-ASM: encoding: [0xd3,0xf5,0x30,0xc2]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.lu.d dc[11], dc[1], dyn
# CHECK-ASM-AND-OBJ: fmv.x.d dc[12], dc[2]
# CHECK-ASM: encoding: [0x53,0x06,0x01,0xe2]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fmv.x.d dc[12], dc[2]
# CHECK-ASM-AND-OBJ: fcvt.d.l dc[3], dc[13], dyn
# CHECK-ASM: encoding: [0xd3,0xf1,0x26,0xd2]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.d.l dc[3], dc[13], dyn
# CHECK-ASM-AND-OBJ: fcvt.d.lu dc[4], dc[14], dyn
# CHECK-ASM: encoding: [0x53,0x72,0x37,0xd2]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.d.lu dc[4], dc[14], dyn
# CHECK-ASM-AND-OBJ: fmv.d.x dc[5], dc[15]
# CHECK-ASM: encoding: [0xd3,0x82,0x07,0xf2]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fmv.d.x dc[5], dc[15]

# Rounding modes
# CHECK-ASM-AND-OBJ: fcvt.d.l dc[3], dc[13], rne
# CHECK-ASM: encoding: [0xd3,0x81,0x26,0xd2]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.d.l dc[3], dc[13], rne
# CHECK-ASM-AND-OBJ: fcvt.d.lu dc[4], dc[14], rtz
# CHECK-ASM: encoding: [0x53,0x12,0x37,0xd2]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.d.lu dc[4], dc[14], rtz
# CHECK-ASM-AND-OBJ: fcvt.l.d dc[10], dc[0], rdn
# CHECK-ASM: encoding: [0x53,0x25,0x20,0xc2]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.l.d dc[10], dc[0], rdn
# CHECK-ASM-AND-OBJ: fcvt.lu.d dc[11], dc[1], rup
# CHECK-ASM: encoding: [0xd3,0xb5,0x30,0xc2]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.lu.d dc[11], dc[1], rup
