# 07-jflex

## Instalação:
`sudo apt update`

`sudo apt install jflex`

# Alguns métodos e variáveis disponíveis:
 * **int yyline**: armazena o número da linha atual.
 * **int yycolumn**: armazena o número da coluna atual na linha atual.
 * **String yytext()**: método que retorna a sequência de caracteres que foi casada com a regra.
 * **int yylength()**: método que retorna o comprimento da sequência de caracteres que foi casada com a regra.

 Para se usar esses métodos e variáveis, é necessário incluir as diretivas abaixo na seção 2:
 * **%line**: permite usar yyline.
 * **%column**: permite usar yycolumn.

 **OBS**: a diretiva "%class" permite alterar o nome padrão da classe Yylex.java.
 
 Exemplo:
 
 * **%class AnalisadorLexico**
 
 ou
 
 * **%class Scanner**

# Exemplo: 

## Arquivo: exemplo.flex

<pre>
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
ABREPARENTESE = "("
FECHAPARENTESE = ")"
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
{ABREPARENTESE}  { imprimir(yyline, yycolumn, yytext(), "Abre parêntese"); }
{FECHAPARENTESE} { imprimir(yyline, yycolumn, yytext(), "Fecha parêntese"); }
{PONTOEVIRGULA}  { imprimir(yyline, yycolumn, yytext(), "Ponto e vírgula"); }
{ATRIBUICAO}     { imprimir(yyline, yycolumn, yytext(), "Atribuição"); }
{COMPARACAO}     { imprimir(yyline, yycolumn, yytext(), "Comparação"); }   
"if"             { imprimir(yyline, yycolumn, yytext(), "Palavra reservada if"); }
"then"           { imprimir(yyline, yycolumn, yytext(), "Palavra reservada then"); }
{BRANCO}         { imprimir(yyline, yycolumn, yytext(), "Espaço em branco"); }
{ID}             { imprimir(yyline, yycolumn, yytext(), "Identificador"); }
{SOMA}           { imprimir(yyline, yycolumn, yytext(), "Operador de soma"); }
{INTEIRO}        { imprimir(yyline, yycolumn, yytext(), "Número inteiro"); }
.                { dispararExcecao(yyline, yycolumn, yytext(), "Caracter inválido"); }
</pre>

## Arquivo: entrada01.txt:
<pre>
soma = num1 + num2;
if(soma == 7) then
  soma = soma + 3;
<
</pre>

## Arquivo: entrada02.txt:

<pre>
<
soma = num1 + num2;
if(soma == 7) then
  soma = soma + 3;
</pre>

## Execução:
`jflex exemplo.flex`

`javac Scanner.java`

`java Scanner entrada01.txt`

`java Scanner entrada02.txt`

## Jogando a saída num arquivo:
`java Scanner entrada01.txt > saida01.txt`

`java Scanner entrada02.txt > saida02.txt`

# Git
`git add .`

`git commit -m "Exemplo"`

`git push`