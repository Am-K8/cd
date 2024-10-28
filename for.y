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
%token LTE 
%token GTE 


%%

S : FOR '(' init ';' cond ';' inc ')' '{'  '}' '\n' { printf("Valid statement\n");}
;
init  : ID '=' ID { printf("Initialization done\n"); }
;
cond  : ID relop ID { printf("Condition checked\n"); }
;
relop : '<'  | '>' | LTE | GTE { printf("Relational operator used\n"); }
;
inc  : OP ID | ID OP { printf("Increment done\n"); }
;
OP : PLUS | MINUS { printf("Increment operator used\n"); }
;



%%

void yyerror(char* s)
{
 fprintf(stderr,"%s",s);
}

int main()
{
yyparse();
return 0;
}