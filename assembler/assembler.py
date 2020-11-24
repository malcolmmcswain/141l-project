import sys
from isa_map import (
    opcode_dict,  # opcode dictionary
    std_reg_dict, # standard register dictionary
    ext_reg_dict  # extended register dictionary
)

### Reads in a decimal integer n and returns 6-bit binary 
### representation string within unsigned range
def toBinary(n):
    if n >= 64 or n < 0: return "######"
    else: return bin(n).replace("0b", "").zfill(6)

### Assembler thread
### - istream represents the input file passed by cmd line arg
### - ostream represents the output file "machinecode.txt"
with open(sys.argv[1]) as istream:
    for line in istream: # read each line of assembly

        # opens output file in append mode
        ostream = open("machinecode.txt", "a")

        # write opcode
        ostream.write(opcode_dict[line[0:3]].get("opcode", "###"))

        # decode r-type instruction (standard registers only)
        if opcode_dict[line[0:3]]["type"] == "r":
            ostream.write(std_reg_dict.get(line[4:6], "##"))
            ostream.write(std_reg_dict.get(line[7:9], "##"))
            ostream.write(std_reg_dict.get(line[10:12], "##"))

        # decode x-type instruction (standard & extended registers)
        elif opcode_dict[line[0:3]]["type"] == "x":
            ostream.write(std_reg_dict.get(line[4:6], "##"))
            ostream.write(ext_reg_dict.get(line[7:10], "####"))
        
        # decode i-type instruction (immediate)
        elif opcode_dict[line[0:3]]["type"] == "i":
            immediate = int(line[4:])
            ostream.write(toBinary(immediate))

        else:
            ostream.write("######")
        
        ostream.write('\n')
        ostream.close()
