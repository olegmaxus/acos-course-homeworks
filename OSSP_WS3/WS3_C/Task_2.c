#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>


///////////////////////////////////////////// TASK DESCRIPTION /////////////////////////////////////////////
///Read documentation on the open system call.                                                           ///
///Take notice of flags, which are used to indicate how the file is opened.                              ///
///Flags are bits and can be combined with bitwise OR (|).                                               ///
///The O_RDONLY flag is used to open a file for reading.                                                 ///
///The O_WRONLY|O_CREAT|O_TRUNC combination is used for open a file for writing.                         ///
///The mode parameter is required when creating the file. It specifies file access rights.               ///
///For example, the S_IRUSR flag means that user has read permission,                                    ///
///the S_IRGRP means that group has read permission, the S_IROTH flag means others have read permission. ///
///Write a program that reads 100 words from stdin and writes them to a file named outfile.              ///
///Do not forget to close the file.                                                                      ///
////////////////////////////////////////////////////////////////////////////////////////////////////////////

int fscript(const char *fpath)
{
    return open(fpath, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR);
}

int main()
{
    char write_word[256], fpath[256]; //max
    printf("Hello! Please, input the path to the destination folder.\nExample (Windows: C:\\\\Users\\\\user\\\\Desktop\\\\):\nYour folder path: ");
    scanf("%s", fpath);
    int FSCRIPT = fscript(strcat(fpath, "outfile.txt"));

    if(FSCRIPT < 0)
    {
        perror("\nERROR while opening trial");
        exit(EXIT_FAILURE);
    }
    for (size_t i = 0; i < 100; i++)
    {
        scanf("%s", write_word); //user word input
        write(FSCRIPT, write_word, strlen(write_word));
        if (i < 99)
        {
            write(FSCRIPT, " ", strlen(" "));
        }
        else
        {
            write(FSCRIPT, "\0", strlen("\0"));
        }

    }
    close(FSCRIPT);
}

