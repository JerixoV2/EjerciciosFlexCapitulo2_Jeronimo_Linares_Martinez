%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

long chars = 0;
long words = 0;
long lines = 0;
%}

%%

[^\n]+    {
              chars += yyleng;

              /* contar palabras dentro del bloque */
              int inword = 0;
              for(int i = 0; i < yyleng; i++){
                  if(!isspace(yytext[i])){
                      if(!inword){
                          words++;
                          inword = 1;
                      }
                  } else {
                      inword = 0;
                  }
              }
          }

\n        {
              chars++;
              lines++;
          }

%%

int main(int argc, char **argv)
{
    if(argc > 1){
        yyin = fopen(argv[1], "r");
        if(!yyin){
            perror(argv[1]);
            return 1;
        }
    }

    yylex();

    printf("Lines: %ld\nWords: %ld\nChars: %ld\n",
            lines, words, chars);

    return 0;
}
