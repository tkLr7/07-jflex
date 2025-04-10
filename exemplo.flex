/* 
 * Definição: seção para código do usuário. 
 */

%%

/* 
 * Opções e Declarações: seção para diretivas e macros. 
 */

// Diretivas:
%standalone         // Execução independente do analisador sintático.
%line               // Permite usar yyline.
%column             // Permite usar yycolumn.
%class Scanner      // Troca o nome da classe Yylex para Scanner.

%{

  public void imprimir(int linha, int coluna, String lexema, String descricao) {
    System.out.println("[" + linha + "]" + "[" + coluna + "] " + lexema + ": " + descricao + ".");
  }

  public void dispararExcecao(int linha, int coluna, String lexema, String descricao) {
    imprimir(linha, coluna, lexema, descricao);
    throw new RuntimeException(descricao + ": " + yytext() + "");
  }

%}

// Macros:
BRANCO = [\n| |\t|\r]
PONTOEVIRGULA = ";"
SOMA = "+"
ATRIBUICAO = "="
COMPARACAO = "=="
INTEIRO = 0|[1-9][0-9]*
ID = [_|a-z|A-Z][a-z|A-Z|0-9|_]*

%%

/*  
 * Regras e Ações Associadas: seção de instruções para
 * o analisador léxico. 
 */
{PONTOEVIRGULA} { imprimir(yyline, yycolumn, yytext(), "Ponto e vírgula"); }
{ATRIBUICAO}    { imprimir(yyline, yycolumn, yytext(), "Atribuição"); }
{COMPARACAO}    { imprimir(yyline, yycolumn, yytext(), "Comparação"); }   
"if"            { imprimir(yyline, yycolumn, yytext(), "Palavra reservada if"); }
"then"          { imprimir(yyline, yycolumn, yytext(), "Palavra reservada then"); }
{BRANCO}        { imprimir(yyline, yycolumn, yytext(), "Espaço em branco"); }
{ID}            { imprimir(yyline, yycolumn, yytext(), "Identificador"); }
{SOMA}          { imprimir(yyline, yycolumn, yytext(), "Operador de soma"); }
{INTEIRO}       { imprimir(yyline, yycolumn, yytext(), "Número Inteiro"); }
.               { dispararExcecao(yyline, yycolumn, yytext(), "Caracter inválido"); }
