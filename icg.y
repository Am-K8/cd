%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char*);
void Gen(char*);
char temp2[50];
int yylex(void);
int i, j=0;
%}

%union {
   char *string_value;
}

%type <string_value> exp 
%type <string_value> s 
%token <string_value> ID OP
%type <string_value> COND 
%type <string_value> stmt stmt_list
%token IF ob1 cb1 ob2 cb2 EQ SC

%left '+' '-'
%left '*' 

%% 

s       : IF '(' COND ')' '{' stmt_list '}' 
          { sprintf(temp2, "\nt%d=if(%s){%s}",i, $3, $6); $$ = strdup("t"); i++;Gen(temp2); }
        ;

stmt_list
        : stmt
        | stmt stmt_list
        ;

stmt    : ID '=' exp ';'
          { sprintf(temp2, "\nt%d=%s=%s",j, $1, $3); sprintf($$, "t%d", j);j++; Gen(temp2); }
        | IF '(' COND ')' '{' stmt_list '}'  
          { sprintf(temp2, "\nt%d=if(%s){%s}",j, $3, $6); sprintf($$, "t%d", j);j++; Gen(temp2); }  
        ;

exp     : exp '+' exp
          { sprintf(temp2, "\nt%d=%s+%s",j, $1, $3); sprintf($$, "t%d", j);j++; Gen(temp2); }
        | exp '-' exp
          { sprintf(temp2, "\nt%d=%s-%s",j, $1, $3); sprintf($$, "t%d", j);j++; Gen(temp2); }
        | exp '*' exp
          { sprintf(temp2, "\nt%d=%s*%s", j,$1, $3); sprintf($$, "t%d", j);j++; Gen(temp2); }
        | ID
          { $$ = strdup($1); }  
        ;        

COND    : ID OP ID
          { sprintf(temp2, "\nt%d=%s %s %s",j, $1, $2, $3); sprintf($$, "t%d", j);j++; Gen(temp2); }
        ;        

%% 

void Gen(char *val) {
    FILE *f = fopen("output.txt", "a");
    if (f) {
        fputs(val, f);
        fclose(f);
    }
}

int yywrap() { return 1; }

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    yyparse();
    return 0;  // Return 0 for successful completion
}
