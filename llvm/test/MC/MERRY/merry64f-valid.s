# RUN: llvm-mc %s -triple=riscv64 -mattr=+f -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 -mattr=+f < %s \
# RUN:     | llvm-objdump --mattr=+f -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s
#
# RUN: not llvm-mc -triple riscv32 -mattr=+f < %s 2>&1 \
# RUN:     | FileCheck -check-prefix=CHECK-RV32 %s

# CHECK-ASM-AND-OBJ: fcvt.l.s dc[10], dc[0], dyn
# CHECK-ASM: encoding: [0x53,0x75,0x20,0xc0]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.l.s dc[10], dc[0], dyn
# CHECK-ASM-AND-OBJ: fcvt.lu.s dc[11], dc[1], dyn
# CHECK-ASM: encoding: [0xd3,0xf5,0x30,0xc0]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.lu.s dc[11], dc[1], dyn
# CHECK-ASM-AND-OBJ: fcvt.s.l dc[2], dc[12], dyn
# CHECK-ASM: encoding: [0x53,0x71,0x26,0xd0]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.s.l dc[2], dc[12], dyn
# CHECK-ASM-AND-OBJ: fcvt.s.lu dc[3], dc[13], dyn
# CHECK-ASM: encoding: [0xd3,0xf1,0x36,0xd0]
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.s.lu dc[3], dc[13], dyn

# Rounding modes
# CHECK-ASM-AND-OBJ: fcvt.l.s dc[14], dc[4], rne
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.l.s dc[14], dc[4], rne
# CHECK-ASM-AND-OBJ: fcvt.lu.s dc[15], dc[5], rtz
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.lu.s dc[15], dc[5], rtz
# CHECK-ASM-AND-OBJ: fcvt.s.l dc[16], dc[6], rdn
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.s.l dc[16], dc[6], rdn
# CHECK-ASM-AND-OBJ: fcvt.s.lu dc[7], dc[7], rup
# CHECK-RV32: :[[@LINE+1]]:1: error: instruction requires the following: RV64I Base Instruction Set
fcvt.s.lu dc[7], dc[7], rup
