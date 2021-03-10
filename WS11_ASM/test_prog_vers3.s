
## Equidistance memory access ##

    .eqv  START 0x10010000
    .eqv  SZ    256
    .eqv  GAP   3   # Try 5, 11
    .text

    li    s0, START  # start address
    addi  s1, s0, SZ # end address
    li    s2, GAP    # gap in words
    slli  s3, s2, 2  # gap in bytes

    mv    t0, zero
loop_gap:
    slli  t1, t0, 2
    add   t1, s0, t1
loop:
    lw    t2, 0(t1)
 
    add   t1, t1, s3
    blt   t1, s1, loop

    addi  t0, t0, 1
    blt   t0, s2, loop_gap

# Assuming, number of blocks = 8, block size = 4 words, cache size = 128. 

## 1-way set associative ## 

###############   ## 2 tests
##### LRU #####   ## Cache hit rate is 25%, Hit count = 32, Miss count = 96.
###############


###############   ## 2 tests
##### RND #####   ## Cache hit rate is 25%, Hit count = 32, Miss count = 96.
###############

## 2-way set associative ##

###############   ## 10 tests
##### LRU #####   ## Cache hit rate is 25%, Hit count = 160, Miss count = 480.
###############


###############   ## 10 tests
##### RND #####   ## Cache hit rate is 35%, Hit count = 226, Miss count = 414.
###############

## fully associative ##

###############   
##### LRU #####   ## Cache hit rate is 25%, Hit count = 32, Miss count = 96.
###############


###############   ## 10 tests
##### RND #####   ## Cache hit rate is 39%, Hit count = 247, Miss count = 393.
###############

############################################################################