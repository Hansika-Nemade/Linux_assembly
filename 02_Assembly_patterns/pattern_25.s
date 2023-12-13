
# Pattern15.s

# Section : read only data
.section   .rodata
    msg_char:
    .string "%c\t"
    
    msg_space:
    .string "\t"
  
    msg_newline:
    .string "\n"

#  Block Started with symbol
.section   .bss
    .comm    column, 4, 4
    .comm    row   , 4, 4

# section: data
.section   .data
    .globl   asciiA
    .align   4
    .type    asciiA , @object
    .size    asciiA , 4
asciiA:
    .long    65
    .globl   ascii
    .align   4
    .type    ascii , @object
    .size    ascii , 4
ascii:
    .long    65
    .globl   space
    .align   4
    .type    space , @object
    .size    space , 4
space:
    .long    4
    .globl   i
    .align   4
    .type    i , @object
    .size    i , 4
i:
    .long    5


# section: text
.section   .text

# Entry point: _start
    .globl     _start
    .type      _start , @function
_start:
    
    # PROLOGUE
    pushl    %ebp
    movl     %esp , %ebp

    #MAIN CODE
   
    # 1. Initialization     (outer loop)
    movl     $1   , column

    # 2. Terminating condition     (outer loop)
.loop:
    movl    column, %eax
    cmpl    $5    , %eax
    jg      .epilogue

    # 3. Loop body     (outer loop)
    
    # Initialization    (inner loop)
    movl    $1   , row

    # Terminating condition   (inner loop)
.inner_loop:
    movl    row , %eax
    movl    i   , %ebx
    cmpl    %ebx, %eax
    jg      .outer

    # Loop body     (inner loop)
    movl    row   , %eax
    movl    space , %ebx
    cmpl    %ebx  , %eax
    jg      .false_block
    jmp     .true_block

.true_block:
    # Printing message
    pushl   $msg_space
    call    printf
    addl    $8   , %esp
    jmp     .out

.false_block:
    # Printing Message
    pushl   asciiA
    pushl   $msg_char
    call    printf
    addl    $8   , %esp

    # asciiA--
    movl    asciiA , %eax
    subl    $1     , %eax
    movl    %eax   , asciiA
    jmp     .out

.out:
    #Incrementing steps     (inner loop)
    #row++
    movl    row  , %eax
    addl    $1   , %eax
    movl    %eax , row
    jmp     .inner_loop

.outer:
    # ascii=ascii+2
    movl   ascii, %eax
    addl   $2   , %eax
    movl   %eax , ascii

    # asciiA=ascii
    movl   ascii , %eax
    movl   %eax  , asciiA
  
    #row=1
    movl   $1  , row
    
    # space--
    movl   space, %eax
    subl   $1   , %eax
    movl   %eax , space

    #i++
    movl   i  , %eax
    addl   $1 , %eax
    movl   %eax, i

    # Printing Message
    pushl  $msg_newline
    call   printf
    addl   $8  , %esp

    # 4. Incrementing steps      (outer loop)
    # column++
    movl   column, %eax
    addl   $1    , %eax
    movl   %eax  , column
    jmp    .loop


.epilogue:
    pushl  $0
    call   exit



















