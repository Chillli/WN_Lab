# Wireless Networking Lab Assignment

[Kangqi Li](https://github.com/Chillli) & [Chengxin Ma](https://github.com/MaChengxin)

The Encode.m file is the source code which can generate the decoding result. (Another approach is included in the _Separated\_Approach_ folder.)

The binary results are:
* The first signal from Reader to Tag (RT1) is:011111111111111111 
* The first signal from Tag to Reader (TR1) is:1010v100110100000000000000000000110100101100000000011100010000101011011110001100000000000000000000000000000000000000001111000101100101 
* The second signal from Reader to Tag (RT2) is:1100000111111111111111110011111110101011 
* The second signal from Tag to Reader (TR2) is:1010v111111111111111111111111111111111 

RT1 starts with "01", which represents an ACK command, and the entire length should be 18 bits.
This is a mandatory command that the Reader sends to acknowledge a single Tag.
ACK echoes the Tag’s backscattered RN16 which is shown as the last 16 bits in RT1.
However, the reply from the Tag, TR1, starting with "001", is an invalid message.

RT2 is the second signal sent by the Reader.
It is a Req\_RN command because it starts with "11000001".
Hence, its length should be 40 bits and it uses CRC-16 for protection, which instructs the Tag to backscatter a new RN16.
The reply of this command is TR2.
Despite of the "1010v1" prefix, it is a 32-bit string as an immediate reply to RT2.
The Tag's reply to a Reg\_RN command is comprised with a 16-bit handle (or RN16) and a 16-bit CRC checker.
