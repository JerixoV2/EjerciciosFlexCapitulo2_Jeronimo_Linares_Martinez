%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define NHASH 1000   /* tamaño inicial */

typedef struct symrec {
    char *name;
    struct linelist *lines;
    struct symrec *next;
} symrec;

typedef struct linelist {
    int lineno;
    struct linelist *next;
} linelist;

symrec *symtab[NHASH];
int linenum = 1;

unsigned symhash(char *sym)
{
    unsigned int hash = 0;
    while(*sym)
        hash = hash * 9 ^ tolower(*sym++);
    return hash % NHASH;
}

symrec *lookup(char *sym)
{
    unsigned int hash = symhash(sym);
    symrec *ptr = symtab[hash];

    while(ptr){
        if(strcasecmp(ptr->name, sym) == 0)
            return ptr;
        ptr = ptr->next;
    }

    ptr = malloc(sizeof(symrec));
    ptr->name = strdup(sym);
    ptr->lines = NULL;
    ptr->next = symtab[hash];
    symtab[hash] = ptr;

    return ptr;
}

void add_line(symrec *sym)
{
    linelist *l = sym->lines;

    while(l){
        if(l->lineno == linenum)
            return;
        l = l->next;
    }

    l = malloc(sizeof(linelist));
    l->lineno = linenum;
    l->next = sym->lines;
    sym->lines = l;
}
%}

%%

[a-zA-Z]+ {
    symrec *s = lookup(yytext);
    add_line(s);
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

    for(int i=0;i<NHASH;i++){
        symrec *ptr = symtab[i];
        while(ptr){
            printf("%s:", ptr->name);
            linelist *l = ptr->lines;
            while(l){
                printf(" %d", l->lineno);
                l = l->next;
            }
            printf("\n");
            ptr = ptr->next;
        }
    }

    return 0;
}
