%{
#include <stdio.h>

int yylex();
int yywrap();
%}

%x TAG
%x ATTR

%%


\<!--([^-]*|(-[^-]))*--\>  ;

\<                  {ECHO; BEGIN(TAG);}

<TAG>{
    =\"|=\'         {ECHO;BEGIN(ATTR);}
    .               ECHO;
    \n              ECHO;
    .>             {ECHO; BEGIN(INITIAL);}
}

<ATTR>{
    .   ECHO;
    \n  ECHO;
    .\"|.\'   {ECHO; BEGIN(TAG);}
}

%%

int yywrap() {
    return 1;
}

int main() {
    return yylex();
}
