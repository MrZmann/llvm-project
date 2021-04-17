# RUN: llvm-mc %s -triple=riscv32 -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc %s -triple riscv64 -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv32 < %s \
# RUN:     | llvm-objdump -M no-aliases -d -r - \
# RUN:     | FileCheck -check-prefixes=CHECK-OBJ,CHECK-OBJ32,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 < %s \
# RUN:     | llvm-objdump -M no-aliases -d -r - \
# RUN:     | FileCheck -check-prefixes=CHECK-OBJ,CHECK-OBJ64,CHECK-ASM-AND-OBJ %s

.equ CONST, 30

# Needed for testing valid %pcrel_lo expressions
.Lpcrel_hi0: auipc dc[10], %pcrel_hi(foo)

# CHECK-ASM-AND-OBJ: lui dc[10], 2
# CHECK-ASM: encoding: [0x37,0x25,0x00,0x00]
lui dc[10], 2
# CHECK-ASM-AND-OBJ: lui dc[27], 552960
# CHECK-ASM: encoding: [0xb7,0x0d,0x00,0x87]
lui dc[27], (0x87000000>>12)
# CHECK-ASM-AND-OBJ: lui dc[10], 0
# CHECK-ASM: encoding: [0x37,0x05,0x00,0x00]
lui dc[10], %hi(2)
# CHECK-ASM-AND-OBJ: lui dc[27], 552960
# CHECK-ASM: encoding: [0xb7,0x0d,0x00,0x87]
lui dc[27], (0x87000000>>12)
# CHECK-ASM-AND-OBJ: lui dc[27], 552960
# CHECK-ASM: encoding: [0xb7,0x0d,0x00,0x87]
lui dc[27], %hi(0x87000000)
# CHECK-ASM-AND-OBJ: lui dc[5], 1048575
# CHECK-ASM: encoding: [0xb7,0xf2,0xff,0xff]
lui dc[5], 1048575
# CHECK-ASM-AND-OBJ: lui dc[3], 0
# CHECK-ASM: encoding: [0xb7,0x01,0x00,0x00]
lui dc[3], 0
# CHECK-ASM: lui dc[10], %hi(foo)
# CHECK-ASM: encoding: [0x37,0bAAAA0101,A,A]
# CHECK-OBJ: lui dc[10], 0
# CHECK-OBJ: R_RISCV_HI20 foo
lui dc[10], %hi(foo)
# CHECK-ASM-AND-OBJ: lui dc[10], 30
# CHECK-ASM: encoding: [0x37,0xe5,0x01,0x00]
lui dc[10], CONST
# CHECK-ASM-AND-OBJ: lui dc[10], 31
# CHECK-ASM: encoding: [0x37,0xf5,0x01,0x00]
lui dc[10], CONST+1

# CHECK-ASM-AND-OBJ: auipc dc[10], 2
# CHECK-ASM: encoding: [0x17,0x25,0x00,0x00]
auipc dc[10], 2
# CHECK-ASM-AND-OBJ: auipc dc[27], 552960
# CHECK-ASM: encoding: [0x97,0x0d,0x00,0x87]
auipc dc[27], (0x87000000>>12)
# CHECK-ASM-AND-OBJ: auipc dc[5], 1048575
# CHECK-ASM: encoding: [0x97,0xf2,0xff,0xff]
auipc dc[5], 1048575
# CHECK-ASM-AND-OBJ: auipc dc[3], 0
# CHECK-ASM: encoding: [0x97,0x01,0x00,0x00]
auipc dc[3], 0
# CHECK-ASM: auipc dc[10], %pcrel_hi(foo)
# CHECK-ASM: encoding: [0x17,0bAAAA0101,A,A]
# CHECK-OBJ: auipc dc[10], 0
# CHECK-OBJ: R_RISCV_PCREL_HI20 foo
auipc dc[10], %pcrel_hi(foo)
# CHECK-ASM-AND-OBJ: auipc dc[10], 30
# CHECK-ASM: encoding: [0x17,0xe5,0x01,0x00]
auipc dc[10], CONST

# CHECK-OBJ: jal  dc[12], 0x100042
# CHECK-ASM: jal  dc[12], 1048574
# CHECK-ASM: encoding: [0x6f,0xf6,0xff,0x7f]
jal  dc[12], 1048574
# CHECK-OBJ: jal dc[13], 0x148
# CHECK-ASM: jal dc[13], 256
# CHECK-ASM: encoding: [0xef,0x06,0x00,0x10]
jal dc[13], 256
# CHECK-ASM: jal dc[10], foo
# CHECK-ASM: encoding: [0x6f,0bAAAA0101,A,A]
# CHECK-OBJ: jal dc[10], 0
# CHECK-OBJ: R_RISCV_JAL foo
jal dc[10], foo
# CHECK-ASM: jal dc[10], a0 
# CHECK-ASM: encoding: [0x6f,0bAAAA0101,A,A]
# CHECK-OBJ: jal dc[10], 0
# CHECK-OBJ: R_RISCV_JAL a0
jal dc[10], a0
# CHECK-OBJ: jal dc[10], 0x72
# CHECK-ASM: jal dc[10], 30
# CHECK-ASM: encoding: [0x6f,0x05,0xe0,0x01]
jal dc[10], CONST
# CHECK-ASM-AND-OBJ: jal dc[8], 0
# CHECK-ASM: encoding: [0x6f,0x04,0x00,0x00]
jal dc[8], (0)
# CHECK-OBJ: jal dc[8], 0xf8
# CHECK-ASM: jal dc[8], 156
# CHECK-ASM: encoding: [0x6f,0x04,0xc0,0x09]
jal dc[8], (0xff-99)
# CHECK-ASM: encoding: [0x6f,0bAAAA0000,A,A]
# CHECK-OBJ: jal dc[0], 0
jal dc[0], .

# CHECK-ASM-AND-OBJ: jalr dc[10], -2048(dc[11])
# CHECK-ASM: encoding: [0x67,0x85,0x05,0x80]
jalr dc[10], -2048(dc[11])
# CHECK-ASM-AND-OBJ: jalr dc[10], -2048(dc[11])
# CHECK-ASM: encoding: [0x67,0x85,0x05,0x80]
jalr dc[10], %lo(2048)(dc[11])
# CHECK-ASM-AND-OBJ: jalr dc[7], 2047(dc[6])
# CHECK-ASM: encoding: [0xe7,0x03,0xf3,0x7f]
jalr dc[7], 2047(dc[6])
# CHECK-ASM-AND-OBJ: jalr dc[2], 256(dc[0])
# CHECK-ASM: encoding: [0x67,0x01,0x00,0x10]
jalr dc[2], dc[0], 256
# CHECK-ASM-AND-OBJ: jalr dc[11], 30(dc[12])
# CHECK-ASM: encoding: [0xe7,0x05,0xe6,0x01]
jalr dc[11], CONST(dc[12])

# CHECK-OBJ: beq dc[9], dc[9], 0xde
# CHECK-ASM: beq dc[9], dc[9], 102
# CHECK-ASM: encoding: [0x63,0x83,0x94,0x06]
beq dc[9], dc[9], 102
# CHECK-OBJ32: bne dc[14], dc[15], 0xfffff07c
# CHECK-OBJ64: bne dc[14], dc[15], 0xfffffffffffff07c
# CHECK-ASM: bne dc[14], dc[15], -4096
# CHECK-ASM: encoding: [0x63,0x10,0xf7,0x80]
bne dc[14], dc[15], -4096
# CHECK-OBJ: blt dc[2], dc[3], 0x107e
# CHECK-ASM: blt dc[2], dc[3], 4094
# CHECK-ASM: encoding: [0xe3,0x4f,0x31,0x7e]
blt dc[2], dc[3], 4094
# CHECK-OBJ32: bge  dc[18], dc[1], 0xffffffa4
# CHECK-OBJ64: bge  dc[18], dc[1], 0xffffffffffffffa4
# CHECK-ASM: bge  dc[18], dc[1], -224
# CHECK-ASM: encoding: [0xe3,0x50,0x19,0xf2]
bge  dc[18], dc[1], -224
# CHECK-ASM-AND-OBJ: bltu dc[0], dc[0], 0
# CHECK-ASM: encoding: [0x63,0x60,0x00,0x00]
bltu dc[0], dc[0], 0
# CHECK-OBJ: bgeu dc[24], dc[2], 0x28c
# CHECK-ASM: bgeu dc[24], dc[2], 512
# CHECK-ASM: encoding: [0x63,0x70,0x2c,0x20]
bgeu dc[24], dc[2], 512
# CHECK-OBJ: bgeu dc[5], dc[6], 0xae
# CHECK-ASM: bgeu dc[5], dc[6], 30
# CHECK-ASM: encoding: [0x63,0xff,0x62,0x00]
bgeu dc[5], dc[6], CONST

# CHECK-ASM-AND-OBJ: lb dc[19], 4(dc[1])
# CHECK-ASM: encoding: [0x83,0x89,0x40,0x00]
lb dc[19], 4(dc[1])
# CHECK-ASM-AND-OBJ: lb dc[19], 4(dc[1])
# CHECK-ASM: encoding: [0x83,0x89,0x40,0x00]
lb dc[19], +4(dc[1])
# CHECK-ASM-AND-OBJ: lh dc[6], -2048(dc[0])
# CHECK-ASM: encoding: [0x03,0x13,0x00,0x80]
lh dc[6], -2048(dc[0])
# CHECK-ASM-AND-OBJ: lh dc[6], -2048(dc[0])
# CHECK-ASM: encoding: [0x03,0x13,0x00,0x80]
lh dc[6], ~2047(dc[0])
# CHECK-ASM-AND-OBJ: lh dc[6], 0(dc[0])
# CHECK-ASM: encoding: [0x03,0x13,0x00,0x00]
lh dc[6], !1(dc[0])
# CHECK-ASM-AND-OBJ: lh dc[6], -2048(dc[0])
# CHECK-ASM: encoding: [0x03,0x13,0x00,0x80]
lh dc[6], %lo(2048)(dc[0])
# CHECK-ASM-AND-OBJ: lh dc[2], 2047(dc[10])
# CHECK-ASM: encoding: [0x03,0x11,0xf5,0x7f]
lh dc[2], 2047(dc[10])
# CHECK-ASM-AND-OBJ: lw dc[10], 97(dc[12])
# CHECK-ASM: encoding: [0x03,0x25,0x16,0x06]
lw dc[10], 97(dc[12])
# CHECK-ASM: lbu dc[21], %lo(foo)(dc[22])
# CHECK-ASM: encoding: [0x83,0x4a,0bAAAA1011,A]
# CHECK-OBJ: lbu dc[21], 0(dc[22])
# CHECK-OBJ: R_RISCV_LO12
lbu dc[21], %lo(foo)(dc[22])
# CHECK-ASM: lhu dc[28], %pcrel_lo(.Lpcrel_hi0)(dc[28])
# CHECK-ASM: encoding: [0x03,0x5e,0bAAAA1110,A]
# CHECK-OBJ: lhu dc[28], 0(dc[28])
# CHECK-OBJ: R_RISCV_PCREL_LO12
lhu dc[28], %pcrel_lo(.Lpcrel_hi0)(dc[28])
# CHECK-ASM-AND-OBJ: lb dc[5], 30(dc[6])
# CHECK-ASM: encoding: [0x83,0x02,0xe3,0x01]
lb dc[5], CONST(dc[6])
# CHECK-ASM-AND-OBJ: lb dc[8], 0(dc[9])
# CHECK-ASM: encoding: [0x03,0x84,0x04,0x00]
lb dc[8], (0)(dc[9])
# CHECK-ASM-AND-OBJ: lb dc[8], 156(dc[9])
# CHECK-ASM: encoding: [0x03,0x84,0xc4,0x09]
lb dc[8], (0xff-99)(dc[9])

# CHECK-ASM-AND-OBJ: sb dc[10], 2047(dc[12])
# CHECK-ASM: encoding: [0xa3,0x0f,0xa6,0x7e]
sb dc[10], 2047(dc[12])
# CHECK-ASM-AND-OBJ: sh dc[28], -2048(dc[30])
# CHECK-ASM: encoding: [0x23,0x10,0xcf,0x81]
sh dc[28], -2048(dc[30])
# CHECK-ASM-AND-OBJ: sh dc[28], -2048(dc[30])
# CHECK-ASM: encoding: [0x23,0x10,0xcf,0x81]
sh dc[28], ~2047(dc[30])
# CHECK-ASM-AND-OBJ: sh dc[28], 0(dc[30])
# CHECK-ASM: encoding: [0x23,0x10,0xcf,0x01]
sh dc[28], !1(dc[30])
# CHECK-ASM-AND-OBJ: sh dc[28], -2048(dc[30])
# CHECK-ASM: encoding: [0x23,0x10,0xcf,0x81]
sh dc[28], %lo(2048)(dc[30])
# CHECK-ASM-AND-OBJ: sw dc[1], 999(dc[0])
# CHECK-ASM: encoding: [0xa3,0x23,0x10,0x3e]
sw dc[1], 999(dc[0])
# CHECK-ASM-AND-OBJ: sw dc[10], 30(dc[5])
# CHECK-ASM: encoding: [0x23,0xaf,0xa2,0x00]
sw dc[10], CONST(dc[5])
# CHECK-ASM-AND-OBJ: sw dc[8], 0(dc[9])
# CHECK-ASM: encoding: [0x23,0xa0,0x84,0x00]
sw dc[8], (0)(dc[9])
# CHECK-ASM-AND-OBJ: sw dc[8], 156(dc[9])
# CHECK-ASM: encoding: [0x23,0xae,0x84,0x08]
sw dc[8], (0xff-99)(dc[9])

# CHECK-ASM-AND-OBJ: addi dc[1], dc[2], 2
# CHECK-ASM: encoding: [0x93,0x00,0x21,0x00]
addi dc[1], dc[2], 2
# CHECK-ASM-AND-OBJ: addi dc[1], dc[2], 30
# CHECK-ASM: encoding: [0x93,0x00,0xe1,0x01]
addi dc[1], dc[2], CONST
# CHECK-ASM-AND-OBJ: addi dc[1], dc[2], 0
# CHECK-ASM: encoding: [0x93,0x00,0x01,0x00]
addi dc[1], dc[2], (0)
# CHECK-ASM-AND-OBJ: addi dc[1], dc[2], 156
# CHECK-ASM: encoding: [0x93,0x00,0xc1,0x09]
addi dc[1], dc[2], (0xff-99)
# CHECK-ASM-AND-OBJ: slti dc[10],  dc[12], -20
# CHECK-ASM: encoding: [0x13,0x25,0xc6,0xfe]
slti dc[10],  dc[12], -20
# CHECK-ASM-AND-OBJ: sltiu  dc[18], dc[19], 80
# CHECK-ASM: encoding: [0x13,0xb9,0x09,0x05]
sltiu  dc[18], dc[19], 0x50
# CHECK-ASM-AND-OBJ: xori dc[4], dc[6], -99
# CHECK-ASM: encoding: [0x13,0x42,0xd3,0xf9]
xori dc[4], dc[6], -99
# CHECK-ASM-AND-OBJ: ori dc[10], dc[11], -2048
# CHECK-ASM: encoding: [0x13,0xe5,0x05,0x80]
ori dc[10], dc[11], -2048
# CHECK-ASM-AND-OBJ: ori dc[10], dc[11], -2048
# CHECK-ASM: encoding: [0x13,0xe5,0x05,0x80]
ori dc[10], dc[11], ~2047
# CHECK-ASM-AND-OBJ: ori dc[10], dc[11], 0
# CHECK-ASM: encoding: [0x13,0xe5,0x05,0x00]
ori dc[10], dc[11], !1
# CHECK-ASM-AND-OBJ: ori dc[10], dc[11], -2048
# CHECK-ASM: encoding: [0x13,0xe5,0x05,0x80]
ori dc[10], dc[11], %lo(2048)
# CHECK-ASM-AND-OBJ: andi dc[1], dc[2], 2047
# CHECK-ASM: encoding: [0x93,0x70,0xf1,0x7f]
andi dc[1], dc[2], 2047
# CHECK-ASM-AND-OBJ: andi dc[1], dc[2], 2047
# CHECK-ASM: encoding: [0x93,0x70,0xf1,0x7f]
andi dc[1], dc[2], 2047

# CHECK-ASM-AND-OBJ: slli dc[28], dc[28], 31
# CHECK-ASM: encoding: [0x13,0x1e,0xfe,0x01]
slli dc[28], dc[28], 31
# CHECK-ASM-AND-OBJ: srli dc[10], dc[14], 0
# CHECK-ASM: encoding: [0x13,0x55,0x07,0x00]
srli dc[10], dc[14], 0
# CHECK-ASM-AND-OBJ: srai  dc[12], dc[2], 15
# CHECK-ASM: encoding: [0x13,0x56,0xf1,0x40]
srai  dc[12], dc[2], 15
# CHECK-ASM-AND-OBJ: slli dc[28], dc[28], 30
# CHECK-ASM: encoding: [0x13,0x1e,0xee,0x01]
slli dc[28], dc[28], CONST

# CHECK-ASM-AND-OBJ: add dc[1], dc[0], dc[0]
# CHECK-ASM: encoding: [0xb3,0x00,0x00,0x00]
add dc[1], dc[0], dc[0]
# CHECK-ASM-AND-OBJ: add dc[1], dc[0], dc[0]
# CHECK-ASM: encoding: [0xb3,0x00,0x00,0x00]
add dc[1], dc[0], dc[0]
# CHECK-ASM-AND-OBJ: sub dc[5], dc[7], dc[6]
# CHECK-ASM: encoding: [0xb3,0x82,0x63,0x40]
sub dc[5], dc[7], dc[6]
# CHECK-ASM-AND-OBJ: sll dc[15], dc[14], dc[13]
# CHECK-ASM: encoding: [0xb3,0x17,0xd7,0x00]
sll dc[15], dc[14], dc[13]
# CHECK-ASM-AND-OBJ: slt dc[8], dc[8], dc[8]
# CHECK-ASM: encoding: [0x33,0x24,0x84,0x00]
slt dc[8], dc[8], dc[8]
# CHECK-ASM-AND-OBJ: sltu dc[3], dc[10], dc[11]
# CHECK-ASM: encoding: [0xb3,0x31,0xb5,0x00]
sltu dc[3], dc[10], dc[11]
# CHECK-ASM-AND-OBJ: xor  dc[18],  dc[18], dc[24]
# CHECK-ASM: encoding: [0x33,0x49,0x89,0x01]
xor  dc[18],  dc[18], dc[24]
# CHECK-ASM-AND-OBJ: srl dc[10], dc[8], dc[5]
# CHECK-ASM: encoding: [0x33,0x55,0x54,0x00]
srl dc[10], dc[8], dc[5]
# CHECK-ASM-AND-OBJ: sra dc[5],  dc[18], dc[0]
# CHECK-ASM: encoding: [0xb3,0x52,0x09,0x40]
sra dc[5],  dc[18], dc[0]
# CHECK-ASM-AND-OBJ: or dc[26], dc[6], dc[1]
# CHECK-ASM: encoding: [0x33,0x6d,0x13,0x00]
or dc[26], dc[6], dc[1]
# CHECK-ASM-AND-OBJ: and dc[10],  dc[18], dc[19]
# CHECK-ASM: encoding: [0x33,0x75,0x39,0x01]
and dc[10],  dc[18], dc[19]

# CHECK-ASM-AND-OBJ: fence iorw, iorw
# CHECK-ASM: encoding: [0x0f,0x00,0xf0,0x0f]
fence iorw, iorw
# CHECK-ASM-AND-OBJ: fence io, rw
# CHECK-ASM: encoding: [0x0f,0x00,0x30,0x0c]
fence io, rw
# CHECK-ASM-AND-OBJ: fence r, w
# CHECK-ASM: encoding: [0x0f,0x00,0x10,0x02]
fence r,w
# CHECK-ASM-AND-OBJ: fence w, ir
# CHECK-ASM: encoding: [0x0f,0x00,0xa0,0x01]
fence w,ir
# CHECK-ASM-AND-OBJ: fence.tso
# CHECK-ASM: encoding: [0x0f,0x00,0x30,0x83]
fence.tso

# CHECK-ASM-AND-OBJ: fence.i
# CHECK-ASM: encoding: [0x0f,0x10,0x00,0x00]
fence.i

# CHECK-ASM-AND-OBJ: ecall
# CHECK-ASM: encoding: [0x73,0x00,0x00,0x00]
ecall
# CHECK-ASM-AND-OBJ: ebreak
# CHECK-ASM: encoding: [0x73,0x00,0x10,0x00]
ebreak
# CHECK-ASM-AND-OBJ: unimp
# CHECK-ASM: encoding: [0x73,0x10,0x00,0xc0]
unimp

.equ CONST, 16

# CHECK-ASM-AND-OBJ: csrrw dc[5], 4095, dc[6]
# CHECK-ASM: encoding: [0xf3,0x12,0xf3,0xff]
csrrw dc[5], 0xfff, dc[6]
# CHECK-ASM-AND-OBJ: csrrw dc[8], 4095, dc[9]
# CHECK-ASM: encoding: [0x73,0x94,0xf4,0xff]
csrrw dc[8], ~(-4096), dc[9]
# CHECK-ASM-AND-OBJ: csrrw dc[8], fflags, dc[9]
# CHECK-ASM: encoding: [0x73,0x94,0x14,0x00]
csrrw dc[8], !0, dc[9]
# CHECK-ASM-AND-OBJ: csrrs dc[8], cycle, dc[0]
# CHECK-ASM: encoding: [0x73,0x24,0x00,0xc0]
csrrs dc[8], 0xc00, dc[0]
# CHECK-ASM-AND-OBJ: csrrs dc[19], fflags, dc[21]
# CHECK-ASM: encoding: [0xf3,0xa9,0x1a,0x00]
csrrs dc[19], 0x001, dc[21]
# CHECK-ASM-AND-OBJ: csrrc dc[2], ustatus, dc[1]
# CHECK-ASM: encoding: [0x73,0xb1,0x00,0x00]
csrrc dc[2], 0x000, dc[1]
# CHECK-ASM-AND-OBJ: csrrwi dc[15], ustatus, 0
# CHECK-ASM: encoding: [0xf3,0x57,0x00,0x00]
csrrwi dc[15], 0x000, 0
# CHECK-ASM-AND-OBJ: csrrsi dc[7], 4095, 31
# CHECK-ASM: encoding: [0xf3,0xe3,0xff,0xff]
csrrsi dc[7], 0xfff, 31
# CHECK-ASM-AND-OBJ: csrrci dc[6], sscratch, 5
# CHECK-ASM: encoding: [0x73,0xf3,0x02,0x14]
csrrci dc[6], 0x140, 5

