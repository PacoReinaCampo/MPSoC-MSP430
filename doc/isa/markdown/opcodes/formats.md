## DISASSEMBLY FORMATS

Format of a line in the table:

`<format> <format description>`

| format                  |
|:------------------------|
| `none`                  |
| `rs1`                   |
| `pred,succ`             |
| `offset`                |
| `rs1,rs2`               |
| `rd,imm`                |
| `rd,offset`             |
| `rd,rs1,rs2`            |
| `frd,rs1`               |
| `rd,frs1`               |
| `rd,frs1,frs2`          |
| `frd,frs1,frs2`         |
| `rm,frd,frs1`           |
| `rm,frd,rs1`            |
| `rm,rd,frs1`            |
| `rm,frd,frs1,frs2`      |
| `rm,frd,frs1,frs2,frs3` |
| `rd,rs1,imm`            |
| `rd,rs1,offset`         |
| `rd,offset(rs1)`        |
| `frd,offset(rs1)`       |
| `rd,csr,rs1`            |
| `rd,csr,zimm`           |
| `rs2,offset(rs1)`       |
| `frs2,offset(rs1)`      |
| `rs1,rs2,offset`        |
| `rs2,rs1,offset`        |
| `aqrl,rd,rs2,(rs1)`     |
| `aqrl,rd,(rs1)`         |

:Base Opcode Formats

| format                  |
|:------------------------|
| `rd`                    |
| `rd,zimm`               |
| `rd,rs1`                |
| `rd,rs2`                |
| `rs1,offset`            |
| `rs2,offset`            |

:Pseudo Opcode Formats
