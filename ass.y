%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define YYSTYPE char*

int token_no=1;
void print_temp();
char left[100][100];
char right[100][100];
int left_index=0;
int right_index=0;
void print_comma_exprs(); 
%}

%token INTEGER REAL
%token PLUS MINUS MUL DIV
%token OPEN CLOSE
%token EQUAL ID SEMICOLON COMMA
%token T F

%%

//printf("%s = %s\n",$1, $3);
assignment:  vars EQUAL exprs SEMICOLON {  
						if(left_index!=right_index){
						printf("Invalid input\n");	
						}
						else{
							print_comma_exprs();
							}						
						 }
;

expr: sum { $$ = $1; }
;


vars:ID { strcpy(left[left_index],$1); left_index++; }
|vars COMMA ID { strcpy(left[left_index],$3); left_index++; }

exprs: expr { strcpy(right[right_index],$1); right_index++; }
|exprs COMMA expr { strcpy(right[right_index],$3); right_index++; }


sum: term	{ $$ = $1; }
| MINUS term { char str[50]="-";strcat(str,$2); printf("%s",$2); $$ = str; }
| sum PLUS term { char str[50]; print_temp(str); printf("%s = %s + %s \n", str, $1, $3); $$ = strdup(str); } 
| sum MINUS term { char str[50]; print_temp(str); printf("%s = %s - %s \n", str, $1, $3); $$ = strdup(str); } 
;

term: factor { $$ = $1; }
| term MUL factor { char str[50]; print_temp(str); printf("%s = %s * %s \n", str, $1, $3); $$ = strdup(str); }
| term DIV factor { char str[50]; print_temp(str); printf("%s = %s / %s \n", str, $1, $3); $$ = strdup(str); }
; 


factor: INTEGER { $$ = $1; }
| REAL { $$ = $1; }
| ID { $$ = $1; }
| OPEN expr CLOSE { $$ = $2; }
| T { $$="true"; printf("true\n"); }
| F { $$="false"; printf("false\n"); }
;

%%
void print_temp(char str[])
{
	str[0]='t';
	str[1]=token_no+'0';
	str[2]='\0';
	token_no++;
	
}

void print_comma_exprs()
{
	int in=0;
	for(in=0;in<left_index;in++)
	{
	 printf("%s = %s\n",left[in],right[in]);
	}


}
 
int main()
{
	printf("Enter the expression\n");
  	yyparse();
	
  return 0;
}

yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
