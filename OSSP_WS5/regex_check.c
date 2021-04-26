#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <regex.h>
#define ARRAY_SIZE(arr) (sizeof((arr)) / sizeof((arr)[0]))

//***************************************************************************************//
//                                                                                       //
//                            Created by olegm on 02.04.2021.                            //
//                                                                                       //
// The program finds all occurrences of the regular expression in the text and replaces  //
// all of them with the specified replacement string. The updated text is stored in a    //
// separate buffer and printed to the console in the end.                                //
//***************************************************************************************//

char* str_replace(const char* init, const char* toReplace, const char* replaceBy)
{
	int replaced_cnt = 0;
	char* resulting = NULL;
	const int replaced_wordlen = strlen(toReplace);
	const int replacing_wordlen = strlen(replaceBy);

	int i = 0;
	while (init[i] != '\0')
	{
		if (strstr(&init[i], toReplace) == &init[i])
		{
			replaced_cnt++;
			i += replaced_wordlen - 1;
		}
		i++;
	}

	resulting = (char*)malloc(strlen(init) + 1 + replaced_cnt * (replacing_wordlen - replaced_wordlen));

	i = 0;
	while (*init)
	{
		if (strstr(init, toReplace) == init)
		{
			strcpy(&resulting[i], replaceBy);
			i += replacing_wordlen;
			init += replaced_wordlen;
		}
		else
		{
			resulting[i++] = *init++;
		}
	}
	resulting[i] = '\0';
	return resulting;
}

int main(int argc, char* argv[])
{
	const char* re = argv[1];
	const char* str = argv[2];
	char* s = str;
	const char* replace = argv[3];
	char* temp = (char*)malloc(strlen(s) * sizeof(char));
	char* res = s;
	regex_t     regex;
	regmatch_t  pmatch[1];
	regoff_t    off, len;

	if (regcomp(&regex, re, REG_NEWLINE))
	{
		exit(EXIT_FAILURE);
	}

	for (int i = 0; ; i++) 
	{
		if (regexec(&regex, s, ARRAY_SIZE(pmatch), pmatch, 0))
		{
			break;
		}

		off = pmatch[0].rm_so + (s - str);
		len = pmatch[0].rm_eo - pmatch[0].rm_so;
		sprintf(temp, "%.*s", len, s + pmatch[0].rm_so);
		res = str_replace(res, temp, replace);
		s += pmatch[0].rm_eo;
	}
	printf("%s", res);
	
	free(res);
	free(temp);
	regfree(&regex);
	
	exit(EXIT_SUCCESS);
}
