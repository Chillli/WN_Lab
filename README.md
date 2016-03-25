# Wireless Networking Lab Assignment

Kangqi Li & Chengxin Ma

The Encode.m file is the source could which can generate the decoding result.
The binary results are:
* The first signal from Reader to Tag (RT1) is:011111111111111111 
* The first signal from Tag to Reader (TR1) is:1010v100110100000000000000000000110100101100000000011100010000101011011110001100000000000000000000000000000000000000001111000101100101 
* The second signal from Reader to Tag (RT2) is:1100000111111111111111110011111110101011 
* The second signal from Tag to Reader (TR2) is:1010v111111111111111111111111111111111 
* 
RT1 starts with "01", which represents ACK command and the entire length should be 18 bits. This is a mandatory command that the interrogator sent an ACK to acknowledge a single Tag. ACK echoes the Tag’s backscattered RN16 which shows as the last 16 bits in RT1. However, the reply from the tag, TR1, starts with "001", and this is not allowed. 
RT2 is the second signal sent by Reader. It is a Req_RN command because it starts with "11000001". Hence, its length should be 40 bits and uses CRC-16 for protection, which instructs the Tag to backscatter a new RN16. The reply of this command is TR2. Despite the "1010v1" prefix, it is a 32-bit string as an immediate reply to RT2. The Tag reply to a Reg_RN command is comprised with a 16-bit handle or RN16 and a 16-bit CRC checker.
