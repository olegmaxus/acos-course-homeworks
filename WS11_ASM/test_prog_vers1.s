
## Linear memory access ##

    .eqv  START 0x10010000
    .eqv  SZ    512
    .text
    li    s0, START
    addi  s1, s0, SZ
loop:
    lw    t0, 0(s0)
    addi  s0, s0, 4
    blt   s0, s1, loop

# Assuming, number of blocks = 8, block size = 4 words, cache size = 128. 

## 1-way set associative ## 

###############
##### LRU #####   ## Cache hit rate is 75%, Hit count = 96, Miss count = 32.
###############


###############
##### RND #####   ## Cache hit rate is 75%, Hit count = 96, Miss count = 32.
###############

## 2-way set associative ##

###############
##### LRU #####   ## Cache hit rate is 75%, Hit count = 96, Miss count = 32.
###############


###############
##### RND #####   ## Cache hit rate is 75%, Hit count = 96, Miss count = 32.
###############

## fully associative ##

###############
##### LRU #####   ## Cache hit rate is 75%, Hit count = 96, Miss count = 32.
###############


###############
##### RND #####   ## Cache hit rate is 75%, Hit count = 96, Miss count = 32.
###############

############################################################################