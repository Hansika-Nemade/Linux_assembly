
# pattern_83.s

# section: Read only data
.section  .rodata
   msg_symbol:
              .string "*\t"
  
   msg_newline:
              .string "\n"

   msg_space:
              .string "\t"

# section: Block started with symbol
.section  .bss
    .comm   column, 4, 4
    .comm    row  , 4, 4

# section: text
.section   .text

# Entry point: _start
     .globl    _start
     .type    _start , @function
_start:
   
      # PROLOGUE
      pushl    %ebp
      movl     %esp , %ebp

      # 1. Initialization         (outer loop)
      movl    $1 , column

      # 2. Terminating condition      (outer loop)
.loop:
      movl   column, %eax
      cmpl   $5 , %eax
      jg      .epilogue

      # 3.Loop body          (outer loop)
      
      # Initialization         (inner loop)
      movl    $1 , row

      # Terminating condition         (inner loop)
.inner_loop:
      movl    row, %eax
      cmpl    $5 , %eax
      jg      .outer
  
      # loop body       (inner loop)

      movl    row  , %eax
      movl    column , %ebx
      cmpl    %ebx  , %eax
      jg      .space

      # Printing message 
      pushl    $msg_symbol
      call     printf
      addl     $8  , %esp
      jmp      .out

.space:
      # printing message
      pushl    $msg_space
      call     printf
      addl     $8  , %esp
      jmp      .out

.out:
      # Incrementing steps         (inner loop)
      # row++
      incl    row 
      jmp     .inner_loop

.outer:
      # row=1
      movl    $1 , row

      # Printing message
      pushl   $msg_newline
      call    printf
      addl    $8  , %esp

      # 4. Incrementing steps
      # column++
      incl    column
      jmp      .loop

.epilogue:
      pushl   $0
      call    exit
