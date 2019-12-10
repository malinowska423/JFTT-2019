%{
#include <iostream>
#include <sstream>
#include <cmath>

extern int yylineno;

std::ostringstream oss;
const std::string default_err = "blad skladni";

int yylex();
void yyerror(const char *s);
%}

%token NUM
%token NEWLINE
%token LEFTBRAC
%token RIGHTBRAC
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
                            oss << "\nWynik: " << $1 << std::endl;
                            std::string s = oss.str();
                            oss.str("");
                            oss.clear();
                            std::cout << s << std::endl;
                    }
    | error NEWLINE
;

expr:
    NUM                         { $$ = $1; oss << $1 << " ";}
    | expr PLUS expr            { $$ = $1 + $3; oss << "+ "; }
    | expr MINUS expr           { $$ = $1 - $3; oss << "- "; }
    | expr MULT expr            { $$ = $1 * $3; oss << "* "; }
    | expr DIV expr             {
                                    oss << "/ ";
                                    if($3 == 0) {
                                        yyerror("dzielenie przez 0 jest niedozwolone");
                                    } else {
                                        $$ = floor((double) $1 / (double) $3);
                                    }
                                }
    | expr MOD expr             {
                                    oss << "% ";
                                    if($3 == 0) {
                                        yyerror("dzielenie przez 0 jest niedozwolone");
                                    } else {
                                        int mod = $1 % $3;
                                        if(mod * $3 < 0) {
                                            mod = $3 + mod;
                                        }
                                        $$ = mod;
                                    }
                                }
    | MINUS expr %prec NEG      { $$ = -$2; oss << "~ "; }
    | expr PWR expr             {
                                    oss << "^ ";
                                    if($3 < 0) {
                                        yyerror("potega musi byc dodatnia");
                                    } else {
                                        $$ = pow($1, $3);
                                    }
                                }
    | LEFTBRAC expr RIGHTBRAC   { $$ = $2; }
;
%%

void yyerror(const char *s) {
    std::string err_msg;
    if(s == "" || s == "syntax error") {
        err_msg = default_err;
    } else {
        err_msg = s;
    }
    std::cerr << "Blad: " << err_msg << std::endl;
    oss.str("");
    oss.clear();
    return;
}

int main() {
    return yyparse();
}
