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

/* Definição: seção para código do usuário. */

%%

/* Opções e Declarações: seção para diretivas e macros. */

// Diretivas:
%standalone         // Execução independente do analisador sintático.
%line               // Permite usar yyline.
%column             // Permite usar yycolumn.
%class Scanner      // Troca o nome da classe Yylex para Scanner.

%{
    public String getLexema() {
        return yytext(); // Apenas retorna o valor de yytext().
    }
%}

// Macros:
letra = [a-zA-Z]
numero = [0-9]
digito = {numero}+
identificador = {letra}({letra}|{numero})*

%%

/* Regras e Ações Associadas: seção de instruções para 
 * o analisador léxico. 
 */

{digito}        {System.out.println(" -> Encontrei um <Token: DIGITO, Lexema: "        + getLexema() + ", Tamanho: " + yylength() + ", Linha: " + yyline + ", Coluna: " + yycolumn + ">");}
{identificador} {System.out.println(" -> Encontrei um <Token: IDENTIFICADOR, Lexema: " + getLexema() + ", Tamanho: " + yylength() + ", Linha: " + yyline + ", Coluna: " + yycolumn + ">");}
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