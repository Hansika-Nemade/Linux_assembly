
# Read only data
.section   .rodata
     msg_digit:
     .string "%d\t\t"

     msg_space:
     .string "\t"

     msg_newline:
     .string "\n"

# Block started with symbol
.section   .bss
     .comm     column, 4, 4
     .comm     row   , 4, 4

# Data section
.section   .data
     .globl    num1
     .align    4
     .type     num1 , @object
     .size     num1 , 4
num1:
     .long     1
     .globl    space
     .align    4
     .type     space , @object
     .size     space , 4
space:
     .long     4
     
# Text section
.section   .text

# Entry point : _start
     .globl    _start
     .type     _start , @function
_start:

      #PROLOGUE
      pushl    %ebp
      movl     %esp , %ebp

      # MAIN CODE
      # 1. Initialization   (outer loop)
      movl     $1   , column

      # 2. Terminating condition  (outer loop)
.loop:
      movl     column, %eax
      movl     $5    , %ebx
      cmpl     %ebx  , %eax
      jg       .epilogue

      # 3. Loop body (outer loop)
      
      # Initialization    (inner loop)
      movl     $1    , row

      # Terminating condition   (inner loop)
.inner_loop:
      movl     row   , %eax
      movl     $5    , %ebx      
      cmpl     %ebx  , %eax
      jg       .outer

      # Loop body   (inner loop)
      movl     row   , %eax
      movl     space , %ebx
      cmpl     %ebx  , %eax
      jg       .greater

      # Printing message
      pushl    $msg_space
      call     printf
      addl     $8    , %esp
      jmp      .continue

.greater:
      # Printing message
      pushl    num1
      pushl    $msg_digit
      call     printf
      addl     $8    , %esp
      jmp      .continue

.continue:
      # Incrementing steps   (inner loop)
      # row++
      movl     row   , %eax
      movl     $1    , %ebx
      addl     %ebx  , %eax
      movl     %eax  , row
      jmp      .inner_loop

.outer:
      #row=1
      movl     $1    , row
      #num1++
      movl     num1  , %eax
      movl     $1    , %ebx
      addl     %ebx  , %eax
      movl     %eax  , num1
      #space--
      movl     space , %eax
      movl     $1    , %ebx
      subl     %ebx  , %eax
      movl     %eax  , space
      # printing message
      pushl    $msg_newline
      call     printf
      addl     $8    , %esp

      # 4. Incrementing  steps (outer loop)
      # column++
      movl     column , %eax
      movl     $1     , %ebx
      addl     %ebx   , %eax
      movl     %eax   , column
      jmp      .loop

.epilogue:
      pushl    $0
      call     exit







































































































