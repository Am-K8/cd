%{
#include "calc.tab.h"
%}

digit   [0-9]
letter  [a-zA-Z]

%%

"="           { return '='; }
"+"           { return '+'; }
"-"           { return '-'; }
"*"           { return '*'; }
"/"           { return '/'; }
"("           { return '('; }
")"           { return ')'; }

{digit}+      { yylval = atoi(yytext); return NUMBER; }
{letter}+     { return ID; }

[ \t]         { /* Ignore whitespace */ }

\n            { return '\n'; }

.             { printf("Invalid character: %s\n", yytext); return yytext[0]; }

%%

int yywrap(void) {
    return 1;
}
