
# DCLL in Assembly

A doubly circular linked list in Linux 32-bit assembly is a data structure where each node contains two pointers: one pointing to the next node and another pointing to the previous node. Additionally, the first node's previous pointer points to the last node, and the last node's next pointer points to the first node, forming a circular structure.  


## Features

- Circular Structure : The list forms a loop where the last node points back to the first node, and the first node points to the last node. This allows for efficient traversal without the need to check for null pointers at the end of the list.

- Bidirectional Traversal: Each node contains pointers to both the next and previous nodes, allowing for traversal in both forward and backward directions. This feature is useful for operations like iterating the list in reverse.

- Dynamic Memory Allocation : Nodes are dynamically allocated in memory, typically using system calls like malloc or memory allocation functions. This allows for flexibility in managing memory and accommodating variable-sized data elements.
- Insertion and Deletion : Nodes can be efficiently inserted and deleted anywhere in the list by updating the pointers of neighboring nodes. Insertion and deletion operations can be performed at the beginning, end, or middle of the list
- Data Storage: Each node in the list can store data elements of any desired type. This makes the doubly circular linked list a versatile data structure suitable for various applications.
- Traversal and Search: Traversing the list involves following the next or previous pointers from one node to another until the entire list is traversed. Searching for a specific element in the list can be done by iterating through the nodes and comparing the stored data with the target element.



## Acknowledgements

 - [Marshalling Void](https://www.youtube.com/@marshallingvoid/videos) played a crucial role in Learning Assembly Language. I am so greatful to my Sir, he is the one who introduce Assembly to us.Under the guidance and teachings of him i am able to Implement the DCLL in Assembly Language.

 - [Professional assembly language](http://library.bagrintsev.me/ASM/Professional%20Assembly%20Language.2005.pdf) by Richard Blum, This book helped a lot for understanding about Assembly Language.

 - [IA-32 Assembly Language](https://docs.oracle.com/cd/E19455-01/806-3773/index.html) This Reference Manual is used understand the concepts of Assembly languages.

