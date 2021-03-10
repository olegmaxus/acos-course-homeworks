
## Gapped memory access ##

    .eqv  START 0x10010000
    .eqv  HSZ   256
    # Direct mapping burns out
    # Associative captures
    .text
    li    s0, START
    addi  s1, s0, HSZ
    mv    s2, s1
loop:
    lw    t0, 0(s0)
    lw    t1, 0(s1)
    addi  s0, s0, 4
    addi  s1, s1, 4
    blt   s0, s2, loop

# Assuming, number of blocks = 8, block size = 4 words, cache size = 128. 

## 1-way set associative ## 

###############
##### LRU #####   ## Cache hit rate is 0%, Hit count = 0, Miss count = 128.
###############


###############
##### RND #####   ## Cache hit rate is 0%, Hit count = 0, Miss count = 128.
###############

## 2-way set associative ##

###############
##### LRU #####   ## Cache hit rate is 75%, Hit count = 96, Miss count = 32.
###############


###############   ## several tests, due to different hit rate, 10 tests conducted. # Memory access count is 1280.
##### RND #####   ## Cache hit rate is 63%, Hit count = 801, Miss count = 479.
###############

## fully associative ##

###############
##### LRU #####   ## Cache hit rate is 75%, Hit count = 96, Miss count = 32.
###############


###############   ## several tests, due to different hit rate, 10 tests conducted. # Memory access count is 1280.
##### RND #####   ## Cache hit rate is 74%, Hit count = 943, Miss count = 337.
###############

############################################################################