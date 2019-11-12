%{
#include <stdio.h>
#include <math.h>
#include <stdbool.h>

#define STACK_SIZE 1000

int yylex();
int yywrap();

int ptr = -1;
int stack[STACK_SIZE];
int err = false;
int a, b;

void push(int num) {
    ptr++;
    if (ptr < STACK_SIZE) {
        stack[ptr] = num;
    } else {
        printf("Error: too much elements\n");
        err = true;
    }
}


int pop()  {
    if (ptr >= 0) {
        ptr--;
        return stack[ptr + 1];
    } else {
        err = true;
        printf("Error: too few arguments\n");
        return 0;
    }
}

%}

%x ERROR

%%
-?[0-9]+                    push(atoi(yytext));

\+                          {
                            a = pop();
                            b = pop();
                            if(err) {
                                BEGIN(ERROR);}
                            push(a + b);
}

\-                          {
                            a = pop();
                            b = pop();
                            if(err) {BEGIN(ERROR);}
                            push(b - a);
}

\*                          {
                            a = pop();
                            b = pop();
                            if(err) {BEGIN(ERROR);}
                            push(a * b);
}

\/                          {
                            a = pop();
                            if (a == 0) {
                                printf("Error: division by 0 is not permitted\n");
                                BEGIN(ERROR);
                            } else {
                                b = pop();
                                if(err) {BEGIN(ERROR);}
                                push(b / a);
                            }
}

\%                          {
                            a = pop();
                            if (a == 0) {
                                printf("Error: division by 0 is not permitted\n");
                                BEGIN(ERROR);
                            } else {
                                b = pop();
                                push(b % a);
                            }
}
\^                          {
                            a = pop();
                            b = pop();
                            push( (int) pow((double) b, (double) a));
}

[ \t]                       ;

[\n]                        {
                            if(ptr != 0) {
                                printf("Error: too few operators\n");
                                ptr = -1;
                                err = false;
                                BEGIN(INITIAL);
                            } else {
                                int result = pop();
                                if(!err) {
                                    printf("= %d\n", result);
                                } else {
                                    printf("Error: too few arguments\n");
                                }
                                err = false;
                                ptr = -1;
                                BEGIN(INITIAL);
                            }
}

.                           {
                            printf("Error: unknown character: \"%s\"\n", yytext);
                            ptr = -1;
                            BEGIN(ERROR);
}

<ERROR>{
    .                       ;
    \n                      {err = false; ptr = -1; BEGIN(INITIAL);}
}

%%

int yywrap() {
    return 1;
}

int main() {
    return yylex();
}