%{
#include "y.tab.h"
#include<string.h>
%}

%%

[A-Za-z]+([0-9]*[a-zA-Z]*)* { yylval = strdup(yytext); return ID; }
[0-9]+	{ yylval = strdup(yytext); return INTEGER; }
[0-9]+"."[0-9]+	{ yylval = strdup(yytext); return REAL; }

"+"	{ return PLUS; }
"-"	{ return MINUS; }
"*"	{ return MUL; }
"/"	{ return DIV; }
":="	{ return EQUAL; }
","	{ return COMMA; }
";"	{ return SEMICOLON; }
"("     { return OPEN; }
")"     { return CLOSE; }
"true"  { return T; }
"false" { return F; }

[ \t\n]   { /* White space and new line will be ignore */ }
 
%%
