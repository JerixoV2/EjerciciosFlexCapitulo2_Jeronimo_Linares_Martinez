%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define NHASH 9997

typedef struct symrec {
    char *name;
    int lineno;
    struct symrec *next;
    struct symrec *nextline;
} symrec;

symrec *symtab[NHASH];

int linenum = 1;

/* HASH usando lowercase */
unsigned symhash(char *sym)
{
    unsigned int hash = 0;
    while(*sym)
        hash = hash * 9 ^ tolower(*sym++);
    return hash;
}

/* lookup con strcasecmp */
symrec *lookup(char *sym)
{
    unsigned int hash = symhash(sym) % NHASH;
    symrec *ptr = symtab[hash];

    while(ptr){
        if(strcasecmp(ptr->name, sym) == 0)
            return ptr;
        ptr = ptr->next;
    }

    ptr = malloc(sizeof(symrec));
    ptr->name = strdup(sym);
    ptr->lineno = linenum;
    ptr->nextline = NULL;
    ptr->next = symtab[hash];
    symtab[hash] = ptr;

    return ptr;
}
%}

%%

[a-zA-Z]+ {
    symrec *s = lookup(yytext);

    /* agregar nueva línea si es distinta */
    if(s->lineno != linenum){
        symrec *newline = malloc(sizeof(symrec));
        newline->name = NULL;
        newline->lineno = linenum;
        newline->nextline = s->nextline;
        s->nextline = newline;
    }
}

\n      { linenum++; }

.       ;

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

    /* imprimir concordancia */
    for(int i=0;i<NHASH;i++){
        symrec *ptr = symtab[i];
        while(ptr){
            printf("%s:", ptr->name);
            symrec *lineptr = ptr;
            while(lineptr){
                printf(" %d", lineptr->lineno);
                lineptr = lineptr->nextline;
            }
            printf("\n");
            ptr = ptr->next;
        }
    }

    return 0;
}
