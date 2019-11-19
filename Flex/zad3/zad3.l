%{
#include <stdio.h>
#include <stdbool.h>

int yywrap();
int yylex();

bool print_doc = true;
%}

%x MULTI_LINE_COMMENT
%x COMMENT_IN_STRING


open_multiline \/\*(\n)?
open_multiline_doc \/\*(\*|!)(\n)?
close_multiline \*\/(\n)?
single_line \/\/.*(\n)
single_line_doc \/\/(\/|!).*(\n)

%%
#include.* ECHO;
\" {ECHO;BEGIN(COMMENT_IN_STRING);}
\/(\\\n)*\/(.|\\\n)* ;
<COMMENT_IN_STRING>{
\/\/    ECHO;
\"  {ECHO; BEGIN(INITIAL);}
.   ECHO;
}


{open_multiline} BEGIN(MULTI_LINE_COMMENT);
<MULTI_LINE_COMMENT>{
.|\n    ;
{close_multiline}   { BEGIN(INITIAL); }
}

{open_multiline_doc} {if(print_doc) ECHO; else BEGIN(MULTI_LINE_COMMENT);}

{single_line_doc} {if(print_doc) ECHO; }

{single_line} ;
%%

int yywrap() {
    return 1;
}

int main() {
    return yylex();
}