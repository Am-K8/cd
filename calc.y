%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
int result; 
%}

%token NUMBER
%token ID
%left '+' '-'
%left '*' '/'

%%


S:    assignment '\n' { printf("Syntax validated successfully.\n"); printf("Result: %d\n", result); }
    ;

assignment:
        ID '=' expression { result = $3;  }
    ;

expression:
        expression '+' expression { $$ = $1 + $3; }
    |   expression '-' expression { $$ = $1 - $3; }
    |   expression '*' expression { $$ = $1 * $3; }
    |   expression '/' expression { 
            if ($3 == 0)
                yyerror("Division by zero");
            else
                $$ = $1 / $3; 
        }
    |   '(' expression ')' { $$ = $2; }
    |   NUMBER { $$ = $1; }
    ;

%%


void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expression: ");
    yyparse();
    return 0;
}
