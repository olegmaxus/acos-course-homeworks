#include "LinkedList.h"

//***************************************************************************************//
//                                                                                       //
//                            Created by olegm on 02.04.2021.                            //
//                                                                                       //
// • Write a program in C, which does the following:                                     //
// • creates a singly-linked list;                                                       //
// • add to the list numbers from the standard input until user inputs 0;                //
// • reverses the list;                                                                  //
// • prints the resulting list;                                                          //
// • deallocates the list.                                                               //
// • Note: use malloc and free to allocate and deallocate list entries respectively.     //
//***************************************************************************************//

int main()
{
    node_t* main_node = create_list();
    int data;
    printf("Please, enter the list elements one by one:\n");
    while(scanf("%d", &data))
    {
        if(data == 0)
        {
            break;
        }
        push_back(&main_node, data);
    }
    printf("Original list is:\nlast_node -> ");
    print_list(main_node);
    printf("<-first_node\n\nThe new reversed list is:\nlast_node-> ");
    reverse_list(&main_node);
    print_list(main_node);
    printf("<-first_node\n");
    delete_list(main_node);
    return 0;
}