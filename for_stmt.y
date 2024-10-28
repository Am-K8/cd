%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex(void);
    void yyerror(char*);
%}

%token ID
%token FLOAT INT
%token FOR 
%token PLUS 
%token MINUS 
%token MUL
%token LTE 
%token GTE 

%%

// Grammar rules for validating the for loop
S : FOR '(' init ';' cond ';' inc ')' '{' statement_list '}' '\n' { printf("Valid for loop with at least two statements\n"); }
  ;

init : ID '=' ID { printf("Initialization done\n"); }
     ;

cond : ID relop ID { printf("Condition checked\n"); }
     ;

relop : '<' | '>' | LTE | GTE { printf("Relational operator used\n"); }
      ;

inc : OP ID | ID OP { printf("Increment done\n"); }
    ;

OP : PLUS | MINUS { printf("Increment operator used\n"); }
   ;

statement_list : statement statement 
               | statement statement_list
               ;

statement : ID '=' Exp ';' { printf("Assignment statement\n"); }
          ;

Exp : ID '*' ID { printf("Multiplication operation\n"); }
    | ID '+' ID { printf("Addition operation\n"); }
    | ID '-' ID { printf("Subtraction operation\n"); }
    | ID       
    ;

%%

// Error handling function
void yyerror(char* s)
{
    fprintf(stderr, "Error: %s\n", s);
}

int main()
{
    printf("Enter a for loop:\n");
    yyparse();
    return 0;
}
