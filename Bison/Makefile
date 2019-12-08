all: lexer parser
	g++ -std=c++11 calc.tab.c lex.yy.c calc.cpp  -o calc

lexer: 
	flex calc.l

parser:
	win_bison -d calc.y

clean:
	del calc.tab.h calc.tab.c lex.yy.c calc.exe