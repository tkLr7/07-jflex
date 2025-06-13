/* Alguns métodos e variáveis disponíveis:
 * int yyline: armazena o número da linha atual.
 * int yycolumn: armazena o número da coluna atual na linha atual.
 * String yytext(): método que retorna a sequência de caracteres que foi casada com a regra.
 * int yylength(): método que retorna o comprimento da sequência de caracteres que foi casada com a regra.
 */

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
%class Pascal      // Troca o nome da classe Yylex para Scanner.

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
APOSTROFO = "'"
PONTOEVIRGULA = ";"
ABREPARENTESE = "("
FECHAPARENTESE = ")"
SOMA = "+"
SUBTRACAO = "-"
MULTIPLICACAO = "*"
RAIZQUADRADA = "sqrt"
DIVISAO = "/" 
ATRIBUICAO = ":="
COMPARACAO = "=="
MENOR = "<"
CONCATENAR = ","
INTEIRO = 0|[1-9][0-9]*
ID = [_|a-z|A-Z][a-z|A-Z|0-9|_]*

%%

/*  
 * Regras e Ações Associadas: seção de instruções para
 * o analisador léxico. 
 */
{APOSTROFO}      { imprimir(yyline, yycolumn, yytext(), "Apostrofo"); }
{ABREPARENTESE}  { imprimir(yyline, yycolumn, yytext(), "Abre parêntese"); }
{FECHAPARENTESE} { imprimir(yyline, yycolumn, yytext(), "Fecha parêntese"); }
{PONTOEVIRGULA}  { imprimir(yyline, yycolumn, yytext(), "Ponto e vírgula"); }
{CONCATENAR}     { imprimir(yyline, yycolumn, yytext(), "Concatenacao"); }
{ATRIBUICAO}     { imprimir(yyline, yycolumn, yytext(), "Atribuição"); }
{COMPARACAO}     { imprimir(yyline, yycolumn, yytext(), "Comparação"); } 
{MENOR}          { imprimir(yyline, yycolumn, yytext(), "Menor"); }
"if"             { imprimir(yyline, yycolumn, yytext(), "Palavra reservada if"); }
"then"           { imprimir(yyline, yycolumn, yytext(), "Palavra reservada then"); }
"writeln"        { imprimir(yyline, yycolumn, yytext(), "Palavra reservada writeln"); }
"begin"          { imprimir(yyline, yycolumn, yytext(), "Palavra reservada begin"); }
"else"           { imprimir(yyline, yycolumn, yytext(), "Palavra reservada else"); }
"end"            { imprimir(yyline, yycolumn, yytext(), "Palavra reservada end"); } 
{BRANCO}         { imprimir(yyline, yycolumn, yytext(), "Espaço em branco"); }
{SOMA}           { imprimir(yyline, yycolumn, yytext(), "Operador de soma"); }
{SUBTRACAO}      { imprimir(yyline, yycolumn, yytext(), "Operador de subtração"); }
{MULTIPLICACAO}  { imprimir(yyline, yycolumn, yytext(), "Operador de multiplicacao"); }
{DIVISAO}        { imprimir(yyline, yycolumn, yytext(), "Operador de divisao"); }
{RAIZQUADRADA}   { imprimir(yyline, yycolumn, yytext(), "Operador de Raiz quadrada"); }
{BRANCO}         { imprimir(yyline, yycolumn, yytext(), "Espaço em branco"); }
{ID}             { imprimir(yyline, yycolumn, yytext(), "Identificador"); }
{INTEIRO}        { imprimir(yyline, yycolumn, yytext(), "Número inteiro"); }
.                { dispararExcecao(yyline, yycolumn, yytext(), "Caracter inválido"); }
