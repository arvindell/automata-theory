package lexer;
import static lexer.Token.*;

%%
%class Lexer
%type Token
%line
%unicode
%ignorecase

L=[a-zA-Z]+
D=[0-9]+
LU=[a-zA-Z]
DU=[0-9]
espacio=[ \t\r\n]+
CA="\""[^\"\n]*"\"" | "\"""\""
LorD = {LU}|{DU}



%{
    public int getLine() {
    return yyline;
    }
%}

%{
    public String lexeme;
%}
%%

ENTERO {lexeme=yytext(); return Entero;}
REAL {lexeme=yytext(); return Real;}
AND {lexeme=yytext(); return And;}
OR {lexeme=yytext(); return Or;}
IF {lexeme=yytext(); return If;}
THEN {lexeme=yytext(); return Then;}
ELSE {lexeme=yytext(); return Else;}
BEGIN {/*Ignore*/}
END {lexeme=yytext(); return End;}
WHILE {lexeme=yytext(); return While;}
DO {lexeme=yytext(); return Do;}
WRITE {lexeme=yytext(); return Write;}
READ {lexeme=yytext(); return Read;}
{espacio} {/*Ignore*/}
"//".* {/*Ignore*/}
"\\".* {lexeme=yytext(); return Comentario;}
" . " {/*Ignore*/}
". " {/*Ignore*/}
" ." {/*Ignore*/}
"+" {lexeme=yytext(); return Suma;}
"-" {lexeme=yytext(); return Resta;}
"*" {lexeme=yytext(); return Multiplicacion;}
"/" {lexeme=yytext(); return Division;}
"=" {lexeme=yytext(); return Igual;}
"==" {lexeme=yytext(); return IgualIgual;}
">=" {lexeme=yytext(); return MayorIgual;}
">" {lexeme=yytext(); return Mayor;}
"<=" {lexeme=yytext(); return MenorIgual;}
"<" {lexeme=yytext(); return Menor;}
"<>" {lexeme=yytext(); return Diferente;}
";" {lexeme=yytext(); return PuntoYComa;}
"," {lexeme=yytext(); return Coma;}
"." {/* Ignore */}
"\"" {/* Ignore */}
":" {lexeme=yytext(); return DosPuntos;}
")" {lexeme=yytext(); return CierraParentesis;}
"(" {lexeme=yytext(); return AbreParentesis;}
"&&" {lexeme=yytext(); return LogicoAND;}
"||" {lexeme=yytext(); return LogicoOR;}
"!" {lexeme=yytext(); return Negacion;}

{LU}({LorD})* {lexeme=yytext(); return Identificador;}
{D}+ {lexeme=yytext(); return Enteros;}
({D}+"."{D}+) {lexeme=yytext(); return Reales;}
{CA}+ {lexeme=yytext(); return Cadena;}
"\""([^\"\n]|"\\""\"")*"\"" {lexeme=yytext(); return Cadena;}
".""."+({L}|{D}|".")* {lexeme=yytext(); return ERROR;}
"."+({L}|{D}|".")+ {lexeme=yytext(); return ERROR;}
"+""+"+ {lexeme=yytext(); return ERROR;}
"-""-"+ {lexeme=yytext(); return ERROR;}
"/""/"+ {lexeme=yytext(); return ERROR;}
"*""*"+ {lexeme=yytext(); return ERROR;}
"|" {lexeme=yytext(); return ERROR;}
"&" {lexeme=yytext(); return ERROR;}
"|" {lexeme=yytext(); return ERROR;}
 . {lexeme=yytext(); return ERROR;}