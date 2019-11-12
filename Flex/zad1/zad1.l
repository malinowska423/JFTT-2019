%{
#include <stdio.h>

int yylex();
int yywrap();
int linesCount = 0;
int wordCount = 0;
%}

%%
^[[:blank:]]*\n*  ;
[[:blank:]]+$     ;
[ \t]+ {printf(" ");}
[a-zA-Z]+   {ECHO; wordCount++;}
\n  {printf("\n"); linesCount++;}
%%

int yywrap() {
    printf("\nlinesCount: %d\nwordCount: %d", linesCount, wordCount);
    return 1;
}

int main() {
    return yylex();
}