
``` console
acos@acos-vm:~/Desktop/acos_materials/OSSP_BONUS_2_REGEX$ ./send /newlink a...e
The message was sent successfully
acos@acos-vm:~/Desktop/acos_materials/OSSP_BONUS_2_REGEX$ ./send /newlink Jo.*n
Failed to initialize the message queue: File exists
The message was sent successfully
acos@acos-vm:~/Desktop/acos_materials/OSSP_BONUS_2_REGEX$ ./send /newlink m.*n
Failed to initialize the message queue: File exists
The message was sent successfully
acos@acos-vm:~/Desktop/acos_materials/OSSP_BONUS_2_REGEX$ ./search /newlink test.txt
/newlink opened successfully

In the given file, regular exression "a...e" matches the following substrings:
0. "argne" (5 characters)
1. "at he" (5 characters)

In the given file, regular exression "Jo.*n" matches the following substrings:
0. "John" (4 characters)
1. "Joe Bahn" (8 characters)

In the given file, regular exression "m.*n" matches the following substrings:
0. "man has fallen down, yet the madrigalian" (40 characters)
1. "make the decisions. (c) John" (28 characters)
2. "me Joe Bahn" (11 characters)

There are no more messages in the queue
acos@acos-vm:~/Desktop/acos_materials/OSSP_BONUS_2_REGEX$ 
acos@acos-vm:~/Desktop/acos_materials/OSSP_BONUS_2_REGEX$ 
acos@acos-vm:~/Desktop/acos_materials/OSSP_BONUS_2_REGEX$ 
acos@acos-vm:~/Desktop/acos_materials/OSSP_BONUS_2_REGEX$ ^C
acos@acos-vm:~/Desktop/acos_materials/OSSP_BONUS_2_REGEX$ exit
