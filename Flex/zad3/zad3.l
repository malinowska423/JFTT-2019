%{
#include <stdio.h>
#include <stdbool.h>

int yywrap();
int yylex();

bool print_doc = false;
%}

%x SINGLE_LINE_COMMENT
%x MULTI_LINE_COMMENT
%x SINGLE_LINE_DOC_COMMENT
%x MULTI_LINE_DOC_COMMENT
%x STRING_COMMENT
%x INCLUDE_COMMENT

%%
\"                              {ECHO;BEGIN(STRING_COMMENT);  }
\<  {ECHO; BEGIN(INCLUDE_COMMENT);}

<STRING_COMMENT>{
.   ECHO;
\n  ECHO;
.\"                          {ECHO; BEGIN(INITIAL);}
}

<INCLUDE_COMMENT>{
.   ECHO;
\n  ECHO;
.\>                          {ECHO; BEGIN(INITIAL);}
}


\/(\\|\n)*\/                 {BEGIN(SINGLE_LINE_COMMENT);}

<SINGLE_LINE_COMMENT>{
.*\\\n                      ;
.                           ;
[^\\]\n                        {printf("\n"); BEGIN(INITIAL);}
}

\/(\\|\n)*\*                 BEGIN(MULTI_LINE_COMMENT);

<MULTI_LINE_COMMENT>{
.|\n                        ;
\*(\\|\n)*\/             BEGIN(INITIAL);
}

\/(\\|\n)*\/(\\|\n)*\/    {BEGIN(SINGLE_LINE_DOC_COMMENT); if(print_doc) ECHO;}
<SINGLE_LINE_DOC_COMMENT>{
.                           {if(print_doc) ECHO;}
.*\\\n                      {if(print_doc) ECHO;}
.?\n                     {if(print_doc) printf("\n"); BEGIN(INITIAL);}
}

\/(\\|\n)*\*(\\|\n)*\*    {BEGIN(MULTI_LINE_DOC_COMMENT); if(print_doc) ECHO;}
<MULTI_LINE_DOC_COMMENT>{
.|\n                        {if(print_doc) ECHO;}
\*(\\|\n)*\/             {printf("\n"); if(print_doc) ECHO; BEGIN(INITIAL);}
}

%%

int yywrap() {
    return 1;
}

int main() {
    return yylex();
}