
#Read only data
.section  .rodata
       msg_digit:
       .string "%d\t"

       msg_space:
       .string "\t"

       msg_newline:
       .string "\n"

#Section : Block started with symbol
.section  .bss
          .comm   column , 4 , 4
          .comm   row    , 4 , 4

#  Data Section
.section  .data
          .global   num1
          .align    4
          .type     num1 , @object
          .size     num1 , 4
num1:
          .long     5
          .global   space
          .align    4
          .type     space , @object
          .size     space , 4
space:  
          .long     5
          .globl    space2
          .align    4
          .type     space2 , @object
          .size     space2 , 4
space2:
          .long     5
#  Text Section
.section  .text

# Entry point : _start
          .globl    _start
          .type     _start , @function
_start:
          #PROLOGUE
          pushl     %ebp
          movl      %esp , %ebp

          # Main code
          # 1. Initialization    (outer loop)
          movl     $1   , column

          # 2. Terminating condition   (outer loop)
.loop:
          movl     column , %eax
          movl     $5     , %ebx
          cmpl     %ebx   , %eax
          jg       .epilogue
          
          # 3. Loop body (outer loop)
          # Initialization (inner loop)
          movl     $1     , row

          # Terminating condition
.inner_loop:
          movl     row    , %eax
          movl     $9     , %ebx
          cmpl     %ebx   , %eax
          jg       .outer

          # Loop body  (inner loop)
          movl     row    , %eax
          movl     space  , %ebx
          cmpl     %ebx   , %eax
          je       .equal

          movl     row    , %eax
          movl     space2 , %ebx
          cmpl     %ebx   , %eax
          je       .equal
     
          # Printing message
          pushl    $msg_space
          call     printf
          addl     $8     , %esp
          jmp      .continue

.equal:
          # Printing message
          pushl    num1
          pushl    $msg_digit
          call     printf
          addl     $8     , %esp
          jmp      .continue

.continue:
          # Incrementing condition    (inner loop)
          # row++
          movl     row    , %eax
          movl     $1     , %ebx
          addl     %ebx   , %eax
          movl     %eax   , row
          jmp      .inner_loop

.outer:
          #row=1
          movl     $1     , row
          #space2++
          movl     space2 , %eax
          movl     $1     , %ebx
          addl     %ebx   , %eax
          movl     %eax   , space2
          #space--
          movl     space  , %eax
          movl     $1     , %ebx
          subl     %ebx   , %eax
          movl     %eax   , space
          #num1--
          movl     num1   , %eax
          movl     $1     , %ebx
          subl     %ebx   , %eax
          movl     %eax   , num1
          # Printing message
          pushl    $msg_newline
          call     printf
          addl     $8     , %esp

          # 4. Incrementing condition
          # column++
          movl     column , %eax
          movl     $1     , %ebx
          addl     %ebx   , %eax
          movl     %eax   , column
          jmp      .loop

.epilogue:
          pushl    $0
          call     exit
 





















    































