%{
const GLOBALES=require('./build/Globales');
const ERRORES=require('./build/ERRORES');
const TOKENS=require('./build/TOKENS');
let a;
let b;
%}
%lex
%options case-sensitive
%%
\s+												/*ESPACIO EN BLANCO*/	
//"\""(.*)"\""									return 'CC'//Cadena En Comillas
//.*"(".*")"";"	 								return 'LLM'//LLAMADA DE METODO O FUNCION 
";"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'PTC';}//PUNTO Y COMA
//"void"											return 'void'
"("													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'PA';}
")"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'PC';}
"["													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'CA';}
"]"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'CC';}
[+|-|/|*]											{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'Operador';}
"{"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'LLA';}
"}"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'LLC';}
import("."[a-zA-Z]+)+								{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'import';}//importaciones
public												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'public';}
class												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'class';}
static												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'static';}
String												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'String';}
int													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'int';}
boolean												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'boolean';}
double												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'double';}
char												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'char';}
[0-9]+("."[0-9]+)?									{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'Numero';}
(\"[^"|"\""|"\t"|"\r"|"\\"|"\n"]*\")				{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'TEXTO';}
(\'.\')												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'TEXTCHAR';}
false												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'false';}
true												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'true';}
null												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'null';}
([a-zA-Z]|_)([a-zA-Z]|[0-9]|_)*						{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'IdVar';}
"="													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'Igual';}//IGUAL
<<EOF>>												return 'EOF'
.													{a=new ERRORES.ERRORES(yytext,yylloc.first_column,yylloc.first_line,"LEXICO");GLOBALES.Globales.ERR.push(a);}
/lex
%start Java

%% /* language grammar */

Java	: Inicio EOF	{return $$}
		|error			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});return $$}
		;
Inicio	:IMP Clase 	{$$=JSON.stringify({NodoI:"IMP",ASTNodeI:[JSON.parse($1)],NodoE:"Clase",ASTNodeE:[JSON.parse($2)],NodoD:"ε",ASTNodeD:[]})}
		|error ERRORES			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
IMP		:IMP import PTC	{$$=JSON.stringify({NodoI:"IMP",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]})}
		|import PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]})}
		|				{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]})}
		|error ERRORES			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
Clase	:Clase public class IdVar LLA Instrucciones LLC	{$$=JSON.stringify({NodoI:$2+" "+$3+" "+$4+" "+$5,ASTNodeI:[JSON.parse($1)],NodoE:"Instrucciones",ASTNodeE:[JSON.parse($6)],NodoD:$7,ASTNodeD:[]})}
		|Clase class IdVar LLA Instrucciones LLC		{$$=JSON.stringify({NodoI:$2+" "+$3+" "+$4,ASTNodeI:[JSON.parse($1)],NodoE:"Instrucciones",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]})}
		|public class IdVar LLA Instrucciones LLC {$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3+" "+$4,ASTNodeI:[],NodoE:"Instrucciones",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]})}
		|class IdVar LLA Instrucciones LLC		{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"Instrucciones",ASTNodeE:[JSON.parse($4)],NodoD:$5,ASTNodeD:[]})}
		|error ERRORES			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
Instrucciones	:public static String IdVar VALORSTRING {$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:$4,ASTNodeE:[],NodoD:"VALORSTRING",ASTNodeD:[JSON.parse($5)]});}
				|public static int IdVar VALORNUMERO	{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:$4,ASTNodeE:[],NodoD:"VALORNUMERO",ASTNodeD:[JSON.parse($5)]});}
				|public static double IdVar VALORNUMERO	{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:$4,ASTNodeE:[],NodoD:"VALORNUMERO",ASTNodeD:[JSON.parse($5)]});}
				|public static char IdVar VALORCHAR	{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:$4,ASTNodeE:[],NodoD:"VALORCHAR",ASTNodeD:[JSON.parse($5)]});}
				|public static boolean IdVar VALORBOOLEAN 	{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:$4,ASTNodeE:[],NodoD:"VALORBOOLEAN",ASTNodeD:[JSON.parse($5)]});}
				|public String IdVar VALORSTRING {$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:$3,ASTNodeE:[],NodoD:"VALORSTRING",ASTNodeD:[JSON.parse($4)]});}
				|public int IdVar VALORNUMERO	{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:$3,ASTNodeE:[],NodoD:"VALORNUMERO",ASTNodeD:[JSON.parse($4)]});}
				|public double IdVar VALORNUMERO	{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:$3,ASTNodeE:[],NodoD:"VALORNUMERO",ASTNodeD:[JSON.parse($4)]});}
				|public char IdVar VALORCHAR	{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:$3,ASTNodeE:[],NodoD:"VALORCHAR",ASTNodeD:[JSON.parse($4)]});}
				|public boolean IdVar VALORBOOLEAN 	{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:$3,ASTNodeE:[],NodoD:"VALORBOOLEAN",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones Instrucciones	{$$=JSON.stringify({NodoI:"Instrucciones",ASTNodeI:[JSON.parse($1)],NodoE:"Instrucciones",ASTNodeE:[JSON.parse($2)],NodoD:"ε",ASTNodeD:[]});}
				|		{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]})}
				|error ERRORES			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
				;	
VALORSTRING	:Igual TEXTO PTC 	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
			|error ERRORES			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;
VALORNUMERO	:Igual Numero PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual OPERACION PTC {$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"OPERACION",ASTNodeE:[JSON.parse($2)],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PTC			{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
			|error ERRORES			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;
OPERACION	:OPERACION Operador OP	{$$=JSON.stringify({NodoI:"OPERACION",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"OP",ASTNodeD:[JSON.parse($3)]});}
			|OP		{$$=JSON.stringify({NodoI:"OP",ASTNodeI:[JSON.parse($1)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
			|error ERRORES			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;
OP	:PA OPERACION PC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"OPERACION",ASTNodeE:[JSON.parse($2)],NodoD:$3,ASTNodeD:[]});}
	|LLA OPERACION LLC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"OPERACION",ASTNodeE:[JSON.parse($2)],NodoD:$3,ASTNodeD:[]});}
	|CA OPERACION CC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"OPERACION",ASTNodeE:[JSON.parse($2)],NodoD:$3,ASTNodeD:[]});}
	|Numero		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
	|Operador Numero		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
	|error ERRORES			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
	;
VALORCHAR	:Igual TEXTCHAR PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PTC				{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
			|error ERRORES			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;
VALORBOOLEAN:Igual true PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual false PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PTC				{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
			|error ERRORES			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;

ERRORES	:PA	ERRORES			{$$=$1+" "+$2;}
		|PC	ERRORES			{$$=$1+" "+$2;}
		|CA	ERRORES			{$$=$1+" "+$2;}
		|CC	ERRORES			{$$=$1+" "+$2;}
		|Operador ERRORES	{$$=$1+" "+$2;}
		|LLA				{$$=$1;}
		|LLC				{$$=$1;}
		|import	ERRORES		{$$=$1+" "+$2;}
		|public	ERRORES		{$$=$1+" "+$2;}
		|class ERRORES		{$$=$1+" "+$2;}
		|static	ERRORES		{$$=$1+" "+$2;}
		|String	ERRORES		{$$=$1+" "+$2;}
		|int ERRORES		{$$=$1+" "+$2;}
		|boolean ERRORES	{$$=$1+" "+$2;}
		|double	ERRORES		{$$=$1+" "+$2;}
		|char ERRORES		{$$=$1+" "+$2;}
		|Numero	ERRORES 	{$$=$1+" "+$2;}
		|TEXTO ERRORES		{$$=$1+" "+$2;}
		|TEXTCHAR ERRORES	{$$=$1+" "+$2;}
		|false ERRORES		{$$=$1+" "+$2;}
		|true ERRORES		{$$=$1+" "+$2;}
		|null ERRORES		{$$=$1+" "+$2;}
		|IdVar ERRORES		{$$=$1+" "+$2;}
		|Igual ERRORES		{$$=$1+" "+$2;}
		|PTC				{$$=$1;}
		;