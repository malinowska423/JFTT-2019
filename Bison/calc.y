%{
#include <iostream>
#include <sstream>
#include <cmath>

#include "calc.hpp"

extern int yylineno;

bool err = false;
std::ostringstream oss;
const std::string default_err = "blad skladni";
std::string err_msg = default_err;

int yylex();
void yyerror(const char *s);
%}

%token NUM
%token NEWLINE
%token LBRACKET
%token RBRACKET
%left PLUS MINUS
%left MULT MOD DIV
%right PWR
%precedence NEG

%%
input:

    | input line
;

line:
    NEWLINE
    | expr NEWLINE   {
                        if(!err) {
                            oss << "\nWynik: " << $1 << std::endl;
                            std::string s = oss.str();
                            oss.str("");
                            oss.clear();
                            std::cout << s << std::endl;
                        } else {
                            oss.str("");
                            oss.clear();
                            std::cout << std::endl;
                            err = false;
                        }
                    }
    | error NEWLINE
;

expr:
    NUM                         { $$ = $1; oss << $1 << " ";}
    | expr PLUS expr            { $$ = add($1, $3); oss << "+ "; }
    | expr MINUS expr           { $$ = sub($1, $3); oss << "- "; }
    | expr MULT expr            { $$ = mult($1, $3); oss << "* "; }
    | expr DIV expr             {
                                    oss << "/ ";
                                    if($3 == 0) {
                                        err_msg = "dzielenie przez 0 jest niedozwolone";
                                        yyerror("");
                                    } else {
                                        $$ = divide($1, $3);
                                    }
                                }
    | expr MOD expr             {
                                    oss << "% ";
                                    if($3 == 0) {
                                        err_msg = "dzielenie przez 0 jest niedozwolone";
                                        yyerror("");
                                    } else {
                                        $$ = modulo($1, $3);
                                    }
                                }
    | MINUS expr %prec NEG      { $$ = -$2; oss << "~ "; }
    | expr PWR expr             {
                                    oss << "^ ";
                                    if($3 < 0) {
                                        err_msg = "potega musi byc dodatnia";
                                        yyerror("");
                                    } else {
                                        $$ = pwr($1, $3);
                                    }
                                }
    | LBRACKET expr RBRACKET   { $$ = $2; }
;
%%

void yyerror(const char *s) {
    err = true;
    std::cerr << "Blad: " << err_msg << std::endl;
    err_msg = default_err;
    return;
}

int main() {
    return yyparse();
}
