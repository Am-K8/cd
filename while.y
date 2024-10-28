%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex(void);
    void yyerror(char*);
%}

%token ID
%token WHILE
%token LTE
%token GTE

%%

S : WHILE '(' cond ')' '{'  '}' '\n' { printf("Valid Statement\n");}
;
cond : ID relop ID { printf("Condition Checked\n"); }
;
relop : '<' | '>' | LTE | GTE { printf(" Relational Op Used\n"); }
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