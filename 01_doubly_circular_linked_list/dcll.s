# dcll.s

.equ   success,  0

.equ   failure,  1

.equ   TRUE,     0

.equ   FALSE,    1

.equ   list_data_not_found, 2

.equ   list_empty,   3

#  struct definitions
#
#  struct node
#  {
#      data_t   data;
#      p_node_t prev;
#      p_node_t next;
#  };

.equ  node_data,  0
.equ  node_prev,  4
.equ  node_next,  8
.equ  NODE_SIZE,  12


.section  .rodata
    
     .msg_ovm:
        .string "ERROR:fatal:  out of Virtual memory\n"

     .msg_lnc:
        .string "ERROR: list is not created\n"

     .msg_start:
        .string "[start]<->"
 
     .msg_end:
        .string "[end]\n\n"

     .msg_data:
        .string "[%d]<->"
     
     .msg_insert_start:
        .string "after insert_start\n"

     .msg_insert_end:
        .string "after insert_end\n"
 
     .msg_insert_after:
        .string "after insert_after\n"

     .msg_insert_before:
        .string "after insert_before\n"

     .msg_after_create:
        .string "after creating list\n"

     .msg_get_start:
        .string "after get_start\n"

     .msg_get_end:
        .string "after get_end\n"

     .msg_get_data:
        .string "data = %d\n\n"

     .msg_pop_start:
        .string "after pop_start\n"

     .msg_pop_end:
        .string "after pop_end\n"
     
     .msg_poped:
        .string "poped data = %d\n"

     .msg_remove_start:
        .string "after remove_start\n"

     .msg_remove_end:
        .string "after remove_end\n"
     
     .msg_remove_data:
        .string "after remove_data\n"
     
     .msg_get_length:
        .string "length of the list: %d\n\n"

     .msg_data_found:
        .string "data found in list\n\n"
   
     .msg_data_found_not:
        .string "data not found in list\n\n"

     .msg_list_deleted:
        .string "list deleted successfully\n\n"

     .msg_list_not_deleted:
        .string "list deletion unsuccessful\n\n"

     .msg_end_fault:
        .string "end\n"

.section   .data
     .globl   data
     .type    data, @object
     .size    data, 4
data:
     .long    0
     
     .globl   length
     .type    length, @object
     .size    length, 4
length:
     .long    0

     .globl   status
     .type    status, @object
     .size    status, 4
status:
     .long    0

     .globl   list
     .type    list, @object
     .size    list, 4
list:
     .long    0

     .globl   le
     .type    le, @object
     .size    le, 4
le:
     .long    0

################################################################################################
#                                  MAIN FUNCTION                                               #
################################################################################################

.section   .text
     .globl   _start
     .type    _start, @function
_start:
     #prologue
     pushl    %ebp
     movl     %esp, %ebp

     #main code
     # list = create_list();
     call     create_list   
     movl     %eax, list

     #show_list(list, "after creation\n");
     pushl    $.msg_after_create
     pushl    list
     call     show_list
     addl     $8, %esp

     #insert_start(list, data);
     pushl    $95
     pushl    list
     call     insert_start
     addl     $8, %esp

     #show_list(list,"after insert_start")
     pushl    $.msg_insert_start
     pushl    list
     call     show_list
     addl     $8, %esp

     movl     $0,  le
.loop_list_is:     
     #terminating condition
     #while(le < 50) 
     movl     le, %eax
     cmpl     $80, %eax
     jle      .insert_list_is
     jmp      .end_loop_list_is

.insert_list_is:
     #loop body
     movl     le, %eax
     #
     pushl    %eax
     pushl    list
     call     insert_start
     addl     $8, %esp

     #le = le + 10;
     movl     le, %eax
     addl     $10, %eax
     movl     %eax, le
     jmp      .loop_list_is

.end_loop_list_is:
     #show_list(list, "after insert_start");  
     pushl    $.msg_insert_start
     pushl    list
     call     show_list
     addl     $8, %esp

     #insert_end(list, 10)
     pushl    $100
     pushl    list
     call     insert_end
     addl     $8, %esp

     #show_list(list, "after insert_end");
     pushl    $.msg_insert_end
     pushl    list
     call     show_list
     addl     $8, %esp
     
     #insert_after(list, e_data, data);
     pushl    $200
     pushl    $30
     pushl    list
     call     insert_after
     addl     $12, %esp

     #show_list(list, "after insert_after\n");
     pushl    $.msg_insert_after
     pushl    list
     call     show_list
     addl     $8, %esp

     #insert_before(list, e_data, data);
     pushl    $245
     pushl    $30
     pushl    list
     call     insert_before
     addl     $12, %esp

     #show_list(list, "after insert_before\n");
     pushl    $.msg_insert_before
     pushl    list
     call     show_list
     addl     $8, %esp
     
     #get_length(list);
     pushl    list
     call     get_length
     addl     $4, %esp

     movl     %eax, length

     #printf("length of the list:%d", length);
     pushl    length
     pushl    $.msg_get_length
     call     printf
     addl     $8,  %esp     
     
     #printf("after get_start\n");
     pushl    $.msg_get_start
     call     printf
     addl     $4, %esp

     #get_start(list, &data)
     movl     $data, %eax

     pushl    %eax
     pushl    list
     call     get_start
     addl     $8, %esp

     #printf("data = %d\n", data);
     pushl    data
     pushl    $.msg_get_data
     call     printf
     addl     $8, %esp
     
     #printf("after get_end\n");
     pushl    $.msg_get_end
     call     printf
     addl     $4, %esp

     #get_end(list, &data)
     movl     $data, %eax

     pushl    %eax
     pushl    list
     call     get_end
     addl     $8, %esp

     #printf("data = %d\n", data);
     pushl    data
     pushl    $.msg_get_data
     call     printf
     addl     $8, %esp

     #pop_start(list, &data)
     movl     $data, %eax

     pushl    %eax
     pushl    list
     call     pop_start
     addl     $8, %esp

     #printf("poped data = %d\n");
     pushl    data
     pushl    $.msg_poped
     call     printf
     addl     $8, %esp

     #show_list(list, "after pop_start");
     pushl    $.msg_pop_start
     pushl    list
     call     show_list
     addl     $8, %esp
     
     #pop_end(list, &data);
     movl     $data, %eax

     pushl    %eax
     pushl    list
     call     pop_end
     addl     $8, %esp

     #printf("poped data = %d\n");
     pushl    data
     pushl    $.msg_poped
     call     printf
     addl     $8, %esp

     #show_list(list, "after pop_end");
     pushl    $.msg_pop_end
     pushl    list
     call     show_list
     addl     $8, %esp

     #remove_start(list);
     pushl    list
     call     remove_start
     addl     $4, %esp

     #show_list(list, "after remove_start\n");
     pushl    $.msg_remove_start
     pushl    list
     call     show_list
     addl     $8, %esp

     #remove_end(list);
     pushl    list
     call     remove_end
     addl     $4, %esp

     #show_list(list, "after remove_end\n);
     pushl    $.msg_remove_end
     pushl    list
     call     show_list
     addl     $8, %esp

     #find_data(list, 245)
     pushl    $245
     pushl    list
     call     find_data
     addl     $8, %esp

     movl     %eax, data

     #if(data == true)
     movl     $TRUE, %eax
     movl     data, %ebx
     cmpl     %ebx, %eax
     je       .list_find_data
     jmp      .list_not_find
.list_find_data:
     # printf("data found in list\n\n");
     pushl    $.msg_data_found
     call     printf
     addl     $4, %esp
     jmp      .continue

.list_not_find:
     #printf("data not found in list\n\n");
     pushl    $.msg_data_found_not
     call     printf
     addl     $4, %esp
     jmp      .continue

.continue:
     
     #remove_data(list,data)
     pushl    $245
     pushl    list
     call     remove_data
     addl     $8, %esp

     #show_list(list, "after remove_data\n);
     pushl    $.msg_remove_data
     pushl    list
     call     show_list
     addl     $8, %esp
     
     #destroy_list(&list)
     pushl    $list
     call     destroy_list
     addl     $4, %esp

     movl     %eax, status

     #if(list == NULL)
     movl     list, %eax
     cmpl     $0, %eax
     je       .delete_success
     jmp      .not_delete

.delete_success:
     #printf("list deleted\n\n");
     pushl    $.msg_list_deleted
     call     printf
     addl     $4, %esp

     jmp      .continue1

.not_delete:
     #printf("list not deleted");
     pushl     $.msg_list_not_deleted
     call      printf
     addl      $4, %esp
          
.continue1:
     #printf("end\n");
     pushl    $.msg_end_fault
     call     printf
     addl     $4, %esp
     
     #epilogue
     pushl    $0
     call     exit
     

################################################################################################
#                                   HELPER FUNCTION                                            #
################################################################################################


# p_node_t  get_node(data_t data)
     .type    get_node, @function
     .equ     data_gn , 8
     .equ     node_gn , -4
get_node:

     # prologue
     pushl    %ebp
     movl     %esp, %ebp

     subl     $4, %esp

     #main code
     #new_node = malloc(NODE_SIZE)
     pushl    $NODE_SIZE
     call     malloc
     addl     $4, %esp

     movl     %eax, node_gn(%ebp)

     # if(new_node == NULL)
     movl     node_gn(%ebp), %eax
     cmpl     $0,  %eax
     je       .exit_gn
     jmp      .assign_node_gn

.exit_gn:

     #fprintf(stderr, "ERROR:fatal: out of virtual memory");
     pushl    $.msg_ovm
     pushl    stderr
     call     fprintf
     addl     $8, %esp
     
     #epilogue
     addl     $4, %esp

     #return(NULL)
     movl     $0, %eax

     movl     %ebp, %esp
     popl     %ebp
     ret

.assign_node_gn:
    #new_node->data = data;
    movl      node_gn(%ebp), %eax   #new_node
    movl      data_gn(%ebp), %ebx   #data
    movl      %ebx,  node_data(%eax)
    
    #new_node->prev = NULL;
    movl      $0,  node_prev(%eax)
  
    #new_node->next = NULL;
    movl      $0,  node_next(%eax)


    #return(new_node)
    movl      node_gn(%ebp), %eax

    #epilogue
    addl      $4,   %esp

    movl      %ebp, %esp
    popl      %ebp
    ret


#  void generic_insert(p_node_t p_start, p_node_t p_mid, p_node_t p_end);
    .type     generic_insert, @function
    .equ      p_start_gi, 8
    .equ      p_mid_gi,   12
    .equ      p_end_gi,   16
generic_insert:
    
    # prologue
    pushl     %ebp
    movl      %esp, %ebp

    #main code
    #p_mid->prev = p_start
    movl      p_mid_gi(%ebp), %eax     # p_mid
    movl      p_start_gi(%ebp), %ebx   # p_start
    movl      %ebx, node_prev(%eax)
    
    #p_mid->next = p_end;
    movl      p_mid_gi(%ebp), %eax     # p_mid
    movl      p_end_gi(%ebp), %ebx     # p_end
    movl      %ebx,  node_next(%eax)

    #p_end->prev = p_mid;
    movl      p_end_gi(%ebp), %eax     # p_end
    movl      p_mid_gi(%ebp), %ebx     # p_mid
    movl      %ebx, node_prev(%eax) 

    #p_start->next = p_mid;
    movl      p_start_gi(%ebp), %eax   # p_start
    movl      p_mid_gi(%ebp),   %ebx   # p_mid
    movl      %ebx, node_next(%eax)    
  

    # epilogue
    movl      %ebp, %esp
    popl      %ebp
    ret

# p_node_t search_node(list_t list, data_t s_data);
    .type     search_node, @function
    .equ      list_sn,  8
    .equ      data_sn,  12
    .equ      p_run_sn, -4
search_node:
    
    # prologue
    pushl     %ebp
    movl      %esp, %ebp

    #main code

    subl      $4, %esp

    #p_run = list->next;
    movl      list_sn(%ebp), %eax     # address of list
    movl      node_next(%eax), %ebx   # list->next
    
    # Initialization
    movl      %ebx, p_run_sn(%ebp)

    # terminating condition
    # while(p_run != list)
.loop_sn:
    movl      list_sn(%ebp), %eax
    movl      p_run_sn(%ebp),%ebx 
    cmpl      %ebx, %eax
    je        .end_loop_sn
    jmp       .search_sn

.search_sn:
    # if(p_run->data == s_data)
    movl      p_run_sn(%ebp), %eax     #p_run
    movl      node_data(%eax), %ebx    #p_run->data
    movl      data_sn(%ebp),  %edx     #s_data
    cmpl      %ebx, %edx
    je        .data_found_sn
    jmp       .next_node_sn
    
.data_found_sn:
    
    # return(p_run)
    movl      p_run_sn(%ebp), %eax
    
    # epilogue
    addl      $4, %esp     #
    movl      %ebp, %esp
    popl      %ebp
    ret

.next_node_sn:
    # p_run = p_run->next;
    movl      p_run_sn(%ebp), %eax
    movl      node_next(%eax), %ebx
    movl      %ebx,  p_run_sn(%ebp)
    jmp       .loop_sn

.end_loop_sn:
    # return(NULL) 
    # epilogue
    addl     $4,  %esp    #
    movl     $0,  %eax
    movl     %ebp, %esp
    popl     %ebp
    ret


# void  generic_delete(p_node_t p_delete)
    .type    generic_delete, @function
    .equ     p_delete_gd, 8
generic_delete:
    
    # prologue
    pushl    %ebp
    movl     %esp, %ebp

    # main code
    # p_delete->next->prev = p_delete->prev;
    movl     p_delete_gd(%ebp),%eax     # p_delete
    movl     node_prev(%eax), %ebx      # p_delete->prev - ebx
    movl     node_next(%eax), %edx      # p_delete->next
    movl     %ebx,  node_prev(%edx)     # p_delete->next->prev - ebx

    # p_delete->prev->next = p_delete->next;
    movl     p_delete_gd(%ebp), %eax    # p_delete
    movl     node_next(%eax),   %ebx    # p_delete->next - ebx
    movl     node_prev(%eax),   %edx    # node->prev
    movl     %ebx,  node_next(%edx)

    # free(p_delete);
    movl     p_delete_gd(%ebp), %eax
 
    pushl    %eax
    call     free
    addl     $4, %esp

    movl     $0, p_delete_gd(%ebp)
    
    # epilogue
    movl     %ebp, %esp
    popl     %ebp
    ret

##################################################################################################
#                               INTERFACE FUNCTION                                               #
##################################################################################################


# list_t create_list(void)
    .global    create_list
    .type      create_list, @function
    .equ       list_cl, -4
create_list:
    
    # prologue
    pushl      %ebp
    movl       %esp, %ebp

    # main code

    subl       $4, %esp

    # list = get_node(0);
    pushl      $0
    call       get_node
    addl       $4, %esp
    
    movl       %eax, list_cl(%ebp)
    
    # if(list == NULL)
    movl       list_cl(%ebp), %eax
    cmpl       $0,  %eax
    je         .exit_cl
    jmp        .assign_cl

.exit_cl:
    # fprintf(stderr,"ERROR: list not created\n"); 
    pushl      $.msg_lnc
    pushl      stderr
    call       fprintf
    addl       $8,  %esp
 
    # return(NULL)
    movl       $0,  %eax

    #epilogue
    addl       $4,  %esp

    movl       %ebp, %esp
    popl       %ebp
    ret

.assign_cl:
    #list->next = list;
    movl       list_cl(%ebp), %eax
    movl       %eax,  node_next(%eax)
    
    #list->prev = list;
    movl       %eax,  node_prev(%eax)

    # return(list)
    movl       list_cl(%ebp), %eax

    #prologue
    addl      $4, %esp
    movl      %ebp, %esp
    popl      %ebp
    ret


# status_t insert_start(list_t list, data_t data)
    .globl    insert_start
    .type     insert_start, @function
    .equ      list_is,  8
    .equ      data_is,  12
    .equ      node_is, -4
insert_start:
 
    # prologue
    pushl     %ebp
    movl      %esp, %ebp

    #main code
    subl      $4, %esp

    #new_node = NULL;
    movl      $0, node_is(%ebp)

    # new_node = get_node(data);
    movl      data_is(%ebp), %eax   # data
    
    pushl     %eax
    call      get_node
    addl      $4,  %esp

    movl      %eax, node_is(%ebp)
   
    #if(new_node == NULL)
    movl      node_is(%ebp), %eax
    cmpl      $0,  %eax
    je        .failure_is
    jmp       .insert_is

.failure_is:
    
    # epilogue
    addl      $4, %esp

    # return(failure)
    movl      $failure, %eax

    movl      %ebp, %esp
    popl      %ebp
    ret

.insert_is:

    # generic_insert(list, new_node, list->next);
    movl      list_is(%ebp), %eax        # list
    movl      node_next(%eax), %ebx      #list->next
    movl      node_is(%ebp),  %edx       #new_node    

    pushl     %ebx
    pushl     %edx
    pushl     %eax
    call      generic_insert
    addl      $12, %esp

    #epilogue
    addl      $4, %esp

    # return(success)
    movl      $success, %eax
    movl      %ebp, %esp
    popl      %ebp
    ret


#status_t  insert_end(list_t list, data_t data);
    .globl    insert_end
    .type     insert_end, @function
    .equ      list_ie, 8
    .equ      data_ie,  12
    .equ      node_ie,  -4
insert_end:

    #prologue
    pushl     %ebp
    movl      %esp, %ebp

    #main code
    subl      $4, %esp

    #new_node = NULL;
    movl      $0, node_ie(%ebp)

    # new_node = get_node(data)
    movl      data_ie(%ebp), %eax
    
    pushl     %eax
    call      get_node
    addl      $4, %esp

    movl      %eax, node_ie(%ebp)
    
    #if(new_node == NULL)
    cmpl      $0, %eax
    je        .failure_ie
    jmp       .insert_ie

.failure_ie:
    #epilogue
    addl      $4, %esp

    # return(failure)
    movl      $failure, %eax

    movl      %ebp, %esp
    popl      %ebp
    ret

.insert_ie:

    # generic_insert(list->prev, new_node, list)
    movl      list_ie(%ebp), %eax         #list
    movl      node_prev(%eax), %ebx       #list->prev
    movl      node_ie(%ebp),  %edx        #new_node

    pushl     %eax
    pushl     %edx
    pushl     %ebx
    call      generic_insert
    addl      $12, %esp

    #epilogue
    addl      $4, %esp

    # return(success)
    movl      $success, %eax
    movl      %ebp, %esp
    popl      %ebp
    ret


#status_t  insert_after(list_t list, data_t e_data, data_t data);
    .globl    insert_after
    .type     insert_after, @function
    .equ      list_ia, 8
    .equ      e_data_ia, 12
    .equ      data_ia,   16
    .equ      node_ia,   -4
    .equ      p_run_ia,  -8
insert_after:
 
    #prologue
    pushl     %ebp
    movl      %esp, %ebp   

    # main code

    subl      $8, %esp

    #new_node = NULL;
    movl      $0, node_ia(%ebp)

    #p_run = NULL;
    movl      $0, p_run_ia(%ebp)

    #new_node = get_node(data)
    movl      data_ia(%ebp), %eax     #data
    
    pushl     %eax
    call      get_node
    addl      $4, %esp

    movl      %eax, node_ia(%ebp)

    # if(new_node == NULL)
    movl      node_ia(%ebp), %eax
    cmpl      $0,  %eax
    je        .failure_ia
    jmp       .search_node_ia

.failure_ia:

    # epilogue
    addl      $8, %esp

    movl      $failure, %eax
    movl      %ebp, %esp
    popl      %ebp
    ret

.search_node_ia:

    # p_run = search_node(list, e_data);
    movl      e_data_ia(%ebp), %eax
    movl      list_ia(%ebp), %ebx

    pushl     %eax
    pushl     %ebx
    call      search_node
    addl      $8, %esp

    movl      %eax, p_run_ia(%ebp)
    
    #if(p_run == NULL)
    movl      p_run_ia(%ebp), %eax
    cmpl      $0,  %eax
    je        .data_not_found_ia
    jmp       .insert_ia

.data_not_found_ia:

    # epilogue
    addl      $8, %esp 
    #return(list_data_not_found);
    movl     $list_data_not_found, %eax
    movl     %ebp, %esp
    popl     %ebp

.insert_ia:
   
    # generic_insert(p_run, new_node, p_run->next);
    movl      p_run_ia(%ebp), %eax        # p_run
    movl      node_next(%eax), %ebx       # p_run->next
    movl      node_ia(%ebp),   %edx       # new_node
    
    pushl     %ebx
    pushl     %edx
    pushl     %eax
    call      generic_insert
    addl      $12,  %esp

    # return(success)
    #prologue
    addl      $8, %esp

    movl      $success, %eax
    
    movl      %ebp, %esp
    popl      %ebp
    ret

# status_t  insert_before(list_t list, data_t e_data, data_t data);
    .globl    insert_before
    .type     insert_before, @function
    .equ      list_ib,  8
    .equ      e_data_ib, 12
    .equ      data_ib,  16
    .equ      node_ib,  -4
    .equ      p_run_ib, -8
insert_before:
 
    # prologue
    pushl     %ebp
    movl      %esp, %ebp

    # main code
    subl      $8, %esp

    #new_node = NULL;
    movl      $0, node_ib(%ebp)

    #p_run = NULL;
    movl      $0, p_run_ib(%ebp)
   
    #new_node = get_node(data);
    movl      data_ib(%ebp), %eax
   
    pushl     %eax
    call      get_node
    addl      $4, %esp

    movl      %eax, node_ib(%ebp)

    #if(new_node == NULL);
    movl      node_ib(%ebp), %eax
    cmpl      $0,   %eax
    je        .failure_ib
    jmp       .search_node_ib

.failure_ib:
    # epilogue
    addl      $8, %esp

    #return(failure)
    movl      $failure, %eax
    movl      %ebp, %esp
    popl      %ebp
    ret

.search_node_ib:
    #p_run = search_node(list, e_data);

    movl      list_ib(%ebp), %eax        # list
    movl      e_data_ib(%ebp), %ebx      # e_data

    pushl     %ebx
    pushl     %eax
    call      search_node
    addl      $8,  %esp

    movl      %eax, p_run_ib(%ebp)

    #if(p_run == NULL)
    movl      p_run_ib(%ebp), %eax
    cmpl      $0  , %eax
    je        .data_not_found_ib
    jmp       .insert_ib

.data_not_found_ib:
    # epilogue
    addl      $8,  %esp

    #return(list_data_not_found);
    movl      $list_data_not_found, %eax
    movl      %ebp, %esp
    popl      %ebp
    ret

.insert_ib:

    # generic_insert(p_run->prev, new_node, p_run);
    movl      p_run_ib(%ebp), %eax        # p_run
    movl      node_prev(%eax), %ebx       # p_run->prev
    movl      node_ib(%ebp),  %edx        # new_node

    pushl     %eax
    pushl     %edx
    pushl     %ebx
    call      generic_insert
    addl      $12,  %esp

    #epilogue
    addl      $8, %esp
    #return(success)
    movl      $success, %eax
    movl      %ebp,  %esp
    popl      %ebp
    ret

#status_t get_start(list_t list, data_t* p_data)
    .globl    get_start
    .type     get_start, @function
    .equ      list_gs,   8
    .equ      p_data_gs, 12 
get_start:

     # prologue
     pushl    %ebp
     movl     %esp, %ebp

     #main code
     #if(list->next == list)
     movl     list_gs(%ebp), %eax       #list
     movl     node_next(%eax), %ebx     #list->next
     cmpl     %ebx, %eax
     je       .list_empty_gs
     jmp      .assign_start_gs

.list_empty_gs:
     # epilogue
     movl     $list_empty, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

.assign_start_gs:
     movl     list_gs(%ebp), %eax        #list
     movl     node_next(%eax), %ebx      #list->next
     movl     node_data(%ebx), %edx      #list->next->data   

     # *p_data = list->next->data;
     movl     p_data_gs(%ebp),  %eax
     movl     %edx,  (%eax) 

     #prologue
     movl     $success, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

# status_t get_end(list_t list, data_t* p_data)
     .globl   get_end
     .type    get_end, @function
     .equ     list_ge, 8
     .equ     p_data_ge, 12
get_end:
     
     #prologue
     pushl    %ebp
     movl     %esp, %ebp

     #main code
     #if(list->next == list)
     movl     list_ge(%ebp), %eax
     movl     node_next(%eax), %ebx
     cmpl     %ebx, %eax
     je       .list_empty_ge
     jmp      .assign_end_ge

.list_empty_ge:
     #epilogue
     movl     $list_empty, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

.assign_end_ge:
     # *p_data = list->prev->data;
     movl     list_ge(%ebp), %eax   #list
     movl     node_prev(%eax), %ebx #list->prev
     movl     node_data(%ebx), %edx #list->prev->data

     movl     p_data_ge(%ebp), %eax
     movl     %edx, (%eax)

     #return(success)
     movl     $success, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

# status_t  pop_start(list_t list, data_t* p_data)
     .globl   pop_start
     .type    pop_start, @function
     .equ     list_ps, 8
     .equ     p_data_ps, 12
pop_start:
     #prologue
     pushl    %ebp
     movl     %esp, %ebp

     #main code
     #if(list->next == list)
     movl     list_ps(%ebp),   %eax      #list
     movl     node_next(%eax), %ebx      #list->next

     cmpl     %ebx, %eax
     je       .list_empty_ps
     jmp      .delete_ps

.list_empty_ps:
     #epilogue
     movl     $list_empty, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

.delete_ps:
     #*p_data = list->next->data
     movl     list_ps(%ebp), %eax     #list
     movl     node_next(%eax), %ebx   #list->next
     movl     node_data(%ebx), %edx   #list->next->data

     movl     p_data_ps(%ebp), %eax
     movl     %edx, (%eax)

     #generic_delete(list->next)
     pushl    %ebx
     call     generic_delete
     addl     $4, %esp

     #epilogue
     movl     $success, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

# status_t pop_end(list_t list, data_t* p_data);
     .globl   pop_end
     .type    pop_end, @function
     .equ     list_pe, 8
     .equ     p_data_pe, 12
pop_end:
     #prologue
     pushl    %ebp
     movl     %esp, %ebp

     #main code
     #if(list->next == list)
     movl     list_pe(%ebp), %eax      #list
     movl     node_next(%eax), %ebx    #list->next
     cmpl     %ebx, %eax
     je       .list_empty_pe
     jmp      .delete_pe

.list_empty_pe:
     # prologue
     movl     $list_empty, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

.delete_pe:
     #*p_data = list->prev->data;
     movl     list_pe(%ebp), %eax      #list
     movl     node_prev(%eax), %ebx    #list->prev
     movl     node_data(%ebx), %edx    #list->prev->data

     movl     p_data_pe(%ebp), %eax
     movl     %edx, (%eax)

     #generic_delete(list->prev)
     pushl    %ebx
     call     generic_delete
     addl     $4, %esp
     
     #return(success)
     movl     $success, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

# status_t remove_start(list_t list);
     .globl   remove_start
     .type    remove_start, @function
     .equ     list_rs, 8
remove_start:

     #prologue
     pushl    %ebp
     movl     %esp, %ebp

     #main code
     #if(list->next == list)
     movl     list_rs(%ebp), %eax        #list
     movl     node_next(%eax), %ebx      #list->next
     cmpl     %ebx, %eax
     je       .list_empty_rs
     jmp      .delete_rs

.list_empty_rs:
     #epilogue
     movl     $list_empty, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

.delete_rs:
     #generic_delete(list->next)
     movl     list_rs(%ebp), %eax        #list
     movl     node_next(%eax), %ebx      #list->next

     pushl    %ebx
     call     generic_delete
     addl     $4, %esp

     #epilogue
     movl     $success, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

# status_t  remove_end(list_t list);
     .globl   remove_end
     .type    remove_end, @function
     .equ     list_re, 8
remove_end:
     #prologue
     pushl    %ebp
     movl     %esp, %ebp

     # main code
     #if(list->next == list);
     movl     list_re(%ebp), %eax        #list
     movl     node_next(%eax), %ebx      #list->next
     cmpl     %ebx, %eax
     je       .list_empty_re
     jmp      .delete_re

.list_empty_re:
     #return(list_empty);
     movl     $list_empty, %eax

     #epilogue
     movl     %ebp, %esp
     popl     %ebp
     ret

.delete_re:
     #generic_delete(list->prev);
     movl     list_re(%ebp), %eax      #list
     movl     node_prev(%eax), %ebx    #list->prev

     pushl    %ebx
     call     generic_delete
     addl     $4, %esp

     #return(success)
     movl     $success, %eax
     
     #epilogue
     movl     %ebp, %esp
     popl     %ebp
     ret

#  status_t  remove_data(list_t list, data_t data)
     .globl   remove_data
     .type    remove_data, @function
     .equ     list_rd, 8
     .equ     data_rd, 12
     .equ     e_node_rd, -4
remove_data:
     # prologue
     pushl    %ebp
     movl     %esp, %ebp

     #main code
     subl     $4, %esp

     #e_node_rd = NULL
     movl     $0, e_node_rd(%ebp)

     #if(list->next == list)
     movl     list_rd(%ebp), %eax        # list
     movl     node_next(%eax), %ebx      # list->next
     cmpl     %ebx, %eax
     je       .list_empty_rd
     jmp      .search_node_rd

.list_empty_rd:
     #epilogue
     addl     $4, %esp

     #return(list_empty);
     movl     $list_empty, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

.search_node_rd:
     #e_node = search_node(list, s_data)
     movl     list_rd(%ebp), %eax          #list
     movl     data_rd(%ebp), %ebx          #s_data

     pushl    %ebx
     pushl    %eax
     call     search_node
     addl     $8, %esp

     movl     %eax, e_node_rd(%ebp)

     #if(e_node == NULL)
     movl     e_node_rd(%ebp), %eax
     cmpl     $0, %eax
     je       .data_not_found_rd
     jmp      .delete_rd

.data_not_found_rd:
     #epilogue
     addl     $4,  %esp

     #return(list_data_not_found)
     movl     $list_data_not_found, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

.delete_rd:
     # generic_delete(e_node)
     movl     e_node_rd(%ebp), %eax      #e_node

     pushl    %eax
     call     generic_delete
     addl     $4, %esp

     #prologue
     addl     $4, %esp
   
     #return(success)
     movl     $success, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

# bool  is_list_empty(list_t list)
     .globl   is_list_empty
     .type    is_list_empty, @function
     .equ     list_ile, 8
is_list_empty:
     #prologue
     pushl    %ebp
     movl     %esp, %ebp
  
     # main code
     # if(list->next == list)
     movl     list_ile(%ebp), %eax
     movl     node_next(%eax), %ebx
     cmpl     %ebx, %eax
     je       .list_empty_ile
     jmp      .not_empty_ile

.list_empty_ile:
     #epilogue
     #return(list_empty)
     movl     $FALSE, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret

.not_empty_ile:
     #epilogue
     movl     $TRUE, %eax
     movl     %ebp, %esp
     popl     %ebp
     ret


#len_t  get_length(list_t list);
     .globl   get_length
     .type    get_length, @function
     .equ     list_gl, 8
     .equ     length_gl, -4
     .equ     p_run_gl, -8
get_length:
     # prologue
     pushl    %ebp
     movl     %esp, %ebp

     #main code
     subl     $8, %esp

     #length = 0;
     movl     $0, length_gl(%ebp)
     #p_run = NULL:
     movl     $0, p_run_gl(%ebp)

     #p_run = list->next
     movl     list_gl(%ebp), %eax      #list
     movl     node_next(%eax), %ebx    #list->next
     movl     %ebx, p_run_gl(%ebp) 
 
     #while(p_run != list);
.loop_gl:
     movl     p_run_gl(%ebp), %eax
     movl     list_gl(%ebp),  %ebx
     cmpl     %eax , %ebx
     je       .end_loop_gl
     jmp      .length_gl

.length_gl:
     
     #length++
     movl     length_gl(%ebp), %eax
     addl     $1   , %eax
     movl     %eax , length_gl(%ebp)

     #p_run = p_run->next;
     movl     p_run_gl(%ebp), %eax
     movl     node_next(%eax), %ebx
     movl     %ebx  , p_run_gl(%ebp)
     jmp      .loop_gl

.end_loop_gl:
     #return(length)
     movl     length_gl(%ebp), %eax
     
     #epilogue
     addl     $8, %esp

     movl     %ebp, %esp
     popl     %ebp
     ret

# bool  find_data(list_t list, data_t data);
     .globl   find_data
     .type    find_data, @function
     .equ     list_fd, 8
     .equ     data_fd, 12
     .equ     search_fd, -4
find_data:
     # prologue
     pushl    %ebp
     movl     %esp, %ebp
     
     # main code
     subl     $4, %esp

     # search = NULL;
     movl     $0, search_fd(%ebp)
     
     #search = search_node(list, data);
     movl     list_fd(%ebp), %eax       #list
     movl     data_fd(%ebp), %ebx       #data
 
     pushl    %ebx
     pushl    %eax
     call     search_node
     addl     $8, %esp

     movl     %eax, search_fd(%ebp)

     #if(search == NULL)
     movl     search_fd(%ebp), %eax
     cmpl     $0  , %eax
     je       .data_not_found_fd
     jmp      .data_found_fd

.data_not_found_fd:
     # epilogue
     addl     $4, %esp

     #return(false)
     movl     $FALSE, %eax

     movl     %ebp, %esp
     popl     %ebp
     ret

.data_found_fd:
     #epilogue
     addl     $4, %esp
    
     #return(true)
     movl     $TRUE, %eax
     
     movl     %ebp, %esp
     popl     %ebp
     ret

#void show_list(list_t list, const char* msg)
     .globl   show_list   
     .type    show_list, @function
     .equ     list_sl, 8
     .equ     msg_sl, 12
     .equ     p_run_sl, -4
show_list:
     # epilogue
     pushl    %ebp
     movl     %esp, %ebp

     # main code
     subl     $4, %esp

     #puts(msg)
     movl     msg_sl(%ebp), %eax
     
     pushl    %eax
     call     printf
     addl     $4, %esp

     #p_run = list->next;
     movl     list_sl(%ebp), %eax    #list
     movl     node_next(%eax), %ebx  #list->next
     movl     %ebx, p_run_sl(%ebp)

     # printf("[start]<->");
     pushl    $.msg_start
     call     printf
     addl     $4 , %esp

     #while(p_run != list)
.loop_sl:
     #terminating condition
     movl     p_run_sl(%ebp), %eax
     movl     list_sl(%ebp),  %ebx
     cmpl     %ebx , %eax
     je       .end_loop_sl
     jmp      .print_data_sl

.print_data_sl:
     #loop body
     #printf("[%d]<->", p_run->data);
     movl      p_run_sl(%ebp), %eax      #p_run
     movl      node_data(%eax),%ebx      #p_run->data

     pushl     %ebx
     pushl     $.msg_data
     call      printf
     addl      $8, %esp

     #p_run = p_run->next;
     movl      p_run_sl(%ebp), %eax
     movl      node_next(%eax),%ebx
     movl      %ebx,  p_run_sl(%ebp)
     jmp       .loop_sl

.end_loop_sl:
     #printf("[end]\n\n");
     pushl     $.msg_end
     call      printf
     addl      $4, %esp

     #epilogue
     addl      $4, %esp
 
     #return;
     movl      %ebp , %esp
     popl      %ebp
     ret

# status_t destroy_list(p_list_t p_list)
     .globl    destroy_list
     .type     destroy_list, @function
     .equ      p_list_dl, 8
     .equ      p_run_dl,  -4
     .equ      list_dl, -8
     .equ      delete_dl, -12
destroy_list:
     #prologue
     pushl     %ebp
     movl      %esp, %ebp

     # main_code
     subl      $12 , %esp

     # list = *p_list;
     movl      p_list_dl(%ebp), %eax    #p_list
     movl      (%eax),    %ebx
     movl      %ebx, list_dl(%ebp)    #list

     #p_run = list->next
     movl      list_dl(%ebp), %eax      #list
     movl      node_next(%eax), %ebx    #list->next
     movl      %ebx, p_run_dl(%ebp)

     #while(p_run != list)
.loop_dl:
     #terminating condition
     movl      p_run_dl(%ebp), %eax
     movl      list_dl(%ebp), %ebx
     cmpl      %ebx, %eax
     je        .end_loop_dl
     jmp       .destroy_dl

.destroy_dl:
     #delete = p_run;
     movl      p_run_dl(%ebp),  %eax
     movl      %eax, delete_dl(%ebp)

     #p_run = p_run->next
     movl      p_run_dl(%ebp), %eax    #p_run
     movl      node_next(%eax), %ebx   #p_run->next
     movl      %ebx, p_run_dl(%ebp)

     # free(delete)
     pushl     delete_dl(%ebp)
     call      free
     addl      $4, %esp

     jmp       .loop_dl

.end_loop_dl:
     # free(list)
     pushl     list_dl(%ebp)
     call      free
     addl      $4, %esp

     # list = NULL
     movl      $0,  list_dl(%ebp)

     # *p_list = NULL;
     movl      p_list_dl(%ebp), %eax
     movl      $0     , (%eax)

     #epilogue
     addl      $12, %esp

     #return(success)
     movl      $success,  %eax

     movl      %ebp, %esp
     popl      %ebp
     ret

     
