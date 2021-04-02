//
// Created by olegm on 02.04.2021.
//
#ifndef LINKEDLIST_H
#define LINKEDLIST_H
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

typedef struct Node
{
    int src;
    struct Node *next_node;
} node_t;

node_t* create_list()
{
    node_t* start_node = NULL;
    return start_node;
}

void push_back(node_t** last_node, int src)
{
    node_t* new_node = (node_t*)malloc(sizeof(node_t));
    new_node->src = src;
    new_node->next_node = *last_node;
    *last_node = new_node;
}

void reverse_list(node_t** main_node)
{
    node_t* prev_node = NULL;
    node_t* curr_node = *main_node;
    node_t* next_node = NULL;
    while(curr_node != NULL)
    {
        next_node = curr_node->next_node;
        curr_node->next_node = prev_node;
        prev_node = curr_node;
        curr_node = next_node;
    }
    *main_node = prev_node;
}

void print_list(node_t* curr_main_node)
{
    while(curr_main_node != NULL)
    {
        printf("%d ", curr_main_node->src);
        curr_main_node = curr_main_node->next_node;
    }
}

void delete_list(node_t* main_node)
{
    while (main_node != NULL)
    {
        node_t* curr_node = main_node;
        main_node = curr_node->next_node;
        free(curr_node);
    }
}

#endif //LINKEDLIST_H
