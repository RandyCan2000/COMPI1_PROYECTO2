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
[/][*]([^"])*[*][/]									{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'CML';}//si
[/][/].*											{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'CL';}//si
\s+													{}	
[\t|\r|\n|\f] 										{}
";"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'PTC';}//PUNTO Y COMA //si
","													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'COMA';}//si
"("													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'PA';}//si
")"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'PC';}//si
"["													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'CA';}//si
"]"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'CC';}//si
">"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'MAQ';}//si
"<"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'MEQ';}//si
"&"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'Y';}//si
"|"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'O';}//si
"+"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'MAS';}//si
"-"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'MENOS';}//si
[/|*|\\^]											{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'Operador';}//si
"%"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'PORC';}//si
"{"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'LLA';}//si
"}"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'LLC';}//si
":"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'DP';}//si
import("."[a-zA-Z]+)+								{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'import';}//importaciones//si
class												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'class';}//si
void												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'void';}//si
String												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'String';}//si
int													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'int';}//si
boolean												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'boolean';}//si
double												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'double';}//si
char												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'char';}//si
[0-9]+("."[0-9]+)?									{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'Numero';}//si
\"([^"]|[\.])*\"									{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'TEXTO';}//si
\'.\'												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'TEXTCHAR';}//si
"/" 		                           				{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'slash';}//si
false												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'false';}//si
true												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'true';}//si
null												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'null';}//si
if													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'if';}//si
else												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'else';}//si
while												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'while';}//si
do													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'do';}//si
for													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'for';}//si
switch												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'switch';}//si
case												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'case';}//si
default												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'default';}
break												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'break';}//si
return												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'return';}//si
continue											{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'continue';}//si
([a-zA-Z]|_)([a-zA-Z]|[0-9]|_)*						{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'IdVar';}//si
"="													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'Igual';}//IGUAL//si
"!"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'dif';}//si
<<EOF>>												return 'EOF'
.													{a=new ERRORES.ERRORES(yytext,yylloc.first_column,yylloc.first_line,"LEXICO");GLOBALES.Globales.ERR.push(a);return 'ERRLEX';}
/lex
%start Java

%% /* language grammar */

Java	: Inicio EOF	{return $$}
		;
Inicio	:Inicio Clase 	{$$=JSON.stringify({NodoI:"INICIO",ASTNodeI:[JSON.parse($1)],NodoE:"Clase",ASTNodeE:[JSON.parse($2)],NodoD:"ε",ASTNodeD:[]})}
		|Inicio CML 	{$$=JSON.stringify({NodoI:"INICIO",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]})}
		|Inicio CL 		{$$=JSON.stringify({NodoI:"INICIO",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]})}
		|CML			{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
		|CL				{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
		|Clase 			{$$=JSON.stringify({NodoI:"CLASE",ASTNodeI:[JSON.parse($1)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]})}	
		|IMP Clase 		{$$=JSON.stringify({NodoI:"IMP",ASTNodeI:[JSON.parse($1)],NodoE:"Clase",ASTNodeE:[JSON.parse($2)],NodoD:"ε",ASTNodeD:[]})}
		|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
IMP		:IMP import PTC	{$$=JSON.stringify({NodoI:"IMP",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]})}
		|IMP CML 		{$$=JSON.stringify({NodoI:"IMP",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]})}
		|IMP CL 		{$$=JSON.stringify({NodoI:"IMP",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]})}
		|CML			{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
		|CL				{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
		|import PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]})}
		|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
Clase	:Clase class IdVar LLA Instrucciones LLC	{$$=JSON.stringify({NodoI:$2+" "+$3+" "+$4,ASTNodeI:[JSON.parse($1)],NodoE:"Instrucciones",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]})}
		|Clase class IdVar LLA LLC					{$$=JSON.stringify({NodoI:$2+" "+$3+" "+$4,ASTNodeI:[JSON.parse($1)],NodoE:"Instrucciones",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]})}
		|class IdVar LLA Instrucciones LLC			{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"Instrucciones",ASTNodeE:[JSON.parse($4)],NodoD:$5,ASTNodeD:[]})}
		|class IdVar LLA LLC						{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:$3,ASTNodeE:[],NodoD:$4,ASTNodeD:[]})}
		|error ERRORES								{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
Instrucciones	:Instrucciones IdVar VALORVAR 				{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"VALORVAR",ASTNodeD:[JSON.parse($3)]});}
				|Instrucciones String VARS VALORSTRING 		{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"VALORSTRING",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones int VARS VALORNUMERO			{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"VALORNUMERO",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones double VARS VALORNUMERO		{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"VALORNUMERO",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones char VARS VALORCHAR			{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"VALORCHAR",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones boolean VARS VALORBOOLEAN 	{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"VALORBOOLEAN",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones String IdVar METODO 			{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"METODO",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones int IdVar METODO				{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"METODO",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones double IdVar METODO			{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"METODO",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones char IdVar METODO			{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"METODO",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones boolean IdVar METODO 		{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"METODO",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones void IdVar METODO 			{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"METODO",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones CML							{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|Instrucciones CL							{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|IdVar VALORVAR								{$$=JSON.stringify({NodoI:$1,ASTNodeI:[JSON.parse($2)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|void IdVar METODO 							{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"METODO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|String IdVar METODO 						{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"METODO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|int IdVar METODO							{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"METODO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|double IdVar METODO						{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"METODO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|char IdVar METODO							{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"METODO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|boolean IdVar METODO 						{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"METODO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|String VARS VALORSTRING 					{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"VALORSTRING",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|int VARS VALORNUMERO						{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"VALORNUMERO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|double VARS VALORNUMERO					{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"VALORNUMERO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|char VARS VALORCHAR						{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"VALORCHAR",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|boolean VARS VALORBOOLEAN 					{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"VALORBOOLEAN",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|CML										{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|CL											{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|error ERRORES								{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
				;

METODO	:PA ListaVarEnFun PC LLA ININSTRUCCIONES LLC	{$$=JSON.stringify({NodoI:$1+" "+$3+" "+$4,ASTNodeI:[JSON.parse($2)],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]});}
		|PA PC LLA ININSTRUCCIONES LLC					{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($4)],NodoD:$5,ASTNodeD:[]});}
		|PA PC LLA  LLC									{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[],NodoD:$4,ASTNodeD:[]});}
		;

VARS:VARS COMA IdVar	{$$=$1+" "+$2+" "+$3;}
	|IdVar				{$$=$1;}
	;
VALORSTRING	:Igual TXT PTC 		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PTC				{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
			|error ERRORES		{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;

TXT	:TXT MAS IdVar	{$$=$1+" "+$2+" "+$3;}
	|TXT MAS TEXTO	{$$=$1+" "+$2+" "+$3;}
	|TEXTO			{$$=$1;}
	|IdVar			{$$=$1;}
	;

VALORNUMERO	:Igual Numero PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual OPERACION PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC			{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PTC					{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
			|error ERRORES			{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;
OPERACION	:OPERACION Operador OP	{$$=$1+" "+$2+" "+$3;}
			|OPERACION MAS OP		{$$=$1+" "+$2+" "+$3;}
			|OPERACION MENOS OP		{$$=$1+" "+$2+" "+$3;}
			|OPERACION OP PORC		{$$=$1+" "+$2+" "+$3;}
			|OP						{$$=$1;}
			;
OP	:PA OPERACION PC			{$$=$1+" "+$2+" "+$3;}
	|LLA OPERACION LLC			{$$=$1+" "+$2+" "+$3;}
	|CA OPERACION CC			{$$=$1+" "+$2+" "+$3;}
	|MAS PA OPERACION PC		{$$=$1+" "+$2+" "+$3+" "+$4;}
	|MAS LLA OPERACION LLC		{$$=$1+" "+$2+" "+$3+" "+$4;}
	|MAS CA OPERACION CC		{$$=$1+" "+$2+" "+$3+" "+$4;}
	|MENOS PA OPERACION PC		{$$=$1+" "+$2+" "+$3+" "+$4;}
	|MENOS LLA OPERACION LLC	{$$=$1+" "+$2+" "+$3+" "+$4;}
	|MENOS CA OPERACION CC		{$$=$1+" "+$2+" "+$3+" "+$4;}
	|Operador PA OPERACION PC	{$$=$1+" "+$2+" "+$3+" "+$4;}
	|Operador LLA OPERACION LLC	{$$=$1+" "+$2+" "+$3+" "+$4;}
	|Operador CA OPERACION CC	{$$=$1+" "+$2+" "+$3+" "+$4;}
	|Numero						{$$=$1;}
	|IdVar						{$$=$1;}
	|Numero PORC				{$$=$1+" "+$2;}
	|IdVar PORC					{$$=$1+" "+$2;}
	|Operador Numero			{$$=$1+" "+$2;}
	|MAS Numero					{$$=$1+" "+$2;}
	|MENOS Numero				{$$=$1+" "+$2;}
	|Operador IdVar				{$$=$1+" "+$2;}
	|MAS IdVar					{$$=$1+" "+$2;}
	|MENOS IdVar				{$$=$1+" "+$2;}
	;
VALORCHAR	:Igual TEXTCHAR PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PTC				{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
			|error ERRORES		{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;
VALORBOOLEAN:Igual true PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual false PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PTC				{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
			|error ERRORES		{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;

ListaVarEnFun	:ListaVarEnFun COMA String IdVar	{$$=JSON.stringify({NodoI:"LISTAVARFUN",ASTNodeI:[JSON.parse($1)],NodoE:$3,ASTNodeE:[],NodoD:$4,ASTNodeD:[]});}
				|ListaVarEnFun COMA int IdVar		{$$=JSON.stringify({NodoI:"LISTAVARFUN",ASTNodeI:[JSON.parse($1)],NodoE:$3,ASTNodeE:[],NodoD:$4,ASTNodeD:[]});}
				|ListaVarEnFun COMA boolean IdVar	{$$=JSON.stringify({NodoI:"LISTAVARFUN",ASTNodeI:[JSON.parse($1)],NodoE:$3,ASTNodeE:[],NodoD:$4,ASTNodeD:[]});}
				|ListaVarEnFun COMA char IdVar		{$$=JSON.stringify({NodoI:"LISTAVARFUN",ASTNodeI:[JSON.parse($1)],NodoE:$3,ASTNodeE:[],NodoD:$4,ASTNodeD:[]});}
				|ListaVarEnFun COMA double IdVar	{$$=JSON.stringify({NodoI:"LISTAVARFUN",ASTNodeI:[JSON.parse($1)],NodoE:$3,ASTNodeE:[],NodoD:$4,ASTNodeD:[]});}
				|String IdVar						{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|int IdVar							{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|boolean IdVar						{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|char IdVar							{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|double IdVar						{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|error ERRORES						{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
				;

ININSTRUCCIONES	:ININSTRUCCIONES IdVar VALORVAR 				{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"VALORVAR",ASTNodeD:[JSON.parse($3)]});}
				|ININSTRUCCIONES String VARS VALORSTRING 		{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"VALORSTRING",ASTNodeD:[JSON.parse($4)]});}
				|ININSTRUCCIONES int VARS VALORNUMERO			{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"VALORNUMERO",ASTNodeD:[JSON.parse($4)]});}
				|ININSTRUCCIONES double VARS VALORNUMERO		{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"VALORNUMERO",ASTNodeD:[JSON.parse($4)]});}
				|ININSTRUCCIONES char VARS VALORCHAR			{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"VALORCHAR",ASTNodeD:[JSON.parse($4)]});}
				|ININSTRUCCIONES boolean VARS VALORBOOLEAN 		{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"VALORBOOLEAN",ASTNodeD:[JSON.parse($4)]});}
				|ININSTRUCCIONES if IF							{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:"IF",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|ININSTRUCCIONES while	WHILE					{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:"WHILE",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|ININSTRUCCIONES do	DO							{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:"DO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|ININSTRUCCIONES for FOR						{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:"FOR",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|ININSTRUCCIONES switch SWITCH					{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:"SWITCH",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|ININSTRUCCIONES CML							{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|ININSTRUCCIONES CL								{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|ININSTRUCCIONES continue PTC					{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|ININSTRUCCIONES break PTC						{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|ININSTRUCCIONES return EXPRESION PTC			{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3+" "+$4,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|ININSTRUCCIONES return PTC						{$$=JSON.stringify({NodoI:"ININSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|IdVar VALORVAR									{$$=JSON.stringify({NodoI:$1,ASTNodeI:[JSON.parse($2)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|String VARS VALORSTRING 						{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"VALORSTRING",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|int VARS VALORNUMERO							{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"VALORNUMERO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|double VARS VALORNUMERO						{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"VALORNUMERO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|char VARS VALORCHAR							{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"VALORCHAR",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|boolean VARS VALORBOOLEAN 						{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"VALORBOOLEAN",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|if IF											{$$=JSON.stringify({NodoI:"IF",ASTNodeI:[JSON.parse($2)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|while	WHILE									{$$=JSON.stringify({NodoI:"WHILE",ASTNodeI:[JSON.parse($2)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|do DO											{$$=JSON.stringify({NodoI:"DO",ASTNodeI:[JSON.parse($2)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|for FOR										{$$=JSON.stringify({NodoI:"FOR",ASTNodeI:[JSON.parse($2)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|switch SWITCH									{$$=JSON.stringify({NodoI:"SWITCH",ASTNodeI:[JSON.parse($2)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|CML											{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|CL												{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|return EXPRESION PTC							{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|return PTC										{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|break PTC										{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|continue PTC									{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|												{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|error ERRORES									{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
				;
VALORVAR	:VALORSTRING				{$$=$1;}
			|VALORNUMERO				{$$=$1;}
			|VALORCHAR					{$$=$1;}
			|VALORBOOLEAN				{$$=$1;}
			|VALFUN						{$$=$1;}
			|PA LstVarCallFun PC PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3+" "+$4,ASTNodeD:[]});}	
			|PA PC PTC					{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:$2+" "+$3,ASTNodeD:[]});}	
			|error ERRORES				{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;
LstVarCallFun	:LstVarCallFun COMA EXPRESION	{$$=$1+" "+$2+" "+$3;}
				|EXPRESION						{$$=$1;}
				;
VALFUN	:Igual IdVar PA LstVarCallFun PC PTC	{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:$4,ASTNodeE:[],NodoD:$5+" "+$6,ASTNodeD:[]});}
		|Igual IdVar PA PC PTC					{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"",ASTNodeE:[],NodoD:$4+" "+$5,ASTNodeD:[]});}
		|error ERRORES							{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;

IF	:PA CONDICIONES PC LLA ININSTRUCCIONES LLC ELSEIF	{$$=JSON.stringify({NodoI:"if "+$1+" "+$2+" "+$3+" "+$4+" "+$5,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($6)],NodoD:$7,ASTNodeD:[JSON.parse($8)]});}
	|PA CONDICIONES PC LLA ININSTRUCCIONES LLC			{$$=JSON.stringify({NodoI:"if "+$1+" "+$2+" "+$3+" "+$4+" "+$5,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($6)],NodoD:$7,ASTNodeD:[]});}
	|error ERRORES										{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
	;

ELSEIF	:else if PA CONDICIONES PC LLA ININSTRUCCIONES LLC ELSEIF	{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($7)],NodoD:$8,ASTNodeD:[JSON.parse($9)]});}
		|else LLA ININSTRUCCIONES LLC								{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($3)],NodoD:$4,ASTNodeD:[]});}						
		|															{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
		|error ERRORES												{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;

WHILE	:PA CONDICIONES PC LLA ININSTRUCCIONES LLC	{$$=JSON.stringify({NodoI:"while "+$1+" "+$2+" "+$3+" "+$4,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]});}
		|PA CONDICIONES PC LLA  LLC					{$$=JSON.stringify({NodoI:"while "+$1+" "+$2+" "+$3+" "+$4,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[],NodoD:$5,ASTNodeD:[]});}
		|error ERRORES								{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
DO	:LLA ININSTRUCCIONES LLC while PA CONDICIONES PC PTC	{$$=JSON.stringify({NodoI:"do {",ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($2)],NodoD:$3+" "+$4+" "+$5+" "+$6+" "+$7+" "+$8,ASTNodeD:[]});}
	|LLA  LLC while PA CONDICIONES PC PTC					{$$=JSON.stringify({NodoI:"do {",ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[],NodoD:$2+" "+$3+" "+$4+" "+$5+" "+$6+" "+$7,ASTNodeD:[]});}
	|error ERRORES											{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
	;
FOR	:PA INSFOR PC LLA ININSTRUCCIONES LLC	{$$=JSON.stringify({NodoI:"for "+$1+" "+$2+" "+$3+" "+$4,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]});}
	|PA INSFOR PC LLA  LLC					{$$=JSON.stringify({NodoI:"for "+$1+" "+$2+" "+$3+" "+$4,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[],NodoD:$5,ASTNodeD:[]});}
	|error ERRORES							{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
	;
INSFOR	:int IdVar Igual Numero PTC CONDICIONES PTC IdVar MAS MAS			{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6+" "+$7+" "+$8+" "+$9+" "+$10;}
		|IdVar Igual Numero PTC CONDICIONES PTC IdVar MAS MAS				{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6+" "+$7+" "+$8+" "+$9;}
		|int IdVar Igual Numero PTC CONDICIONES PTC IdVar MENOS MENOS		{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6+" "+$7+" "+$8+" "+$9+" "+$10;}
		|IdVar Igual Numero PTC CONDICIONES PTC IdVar MENOS MENOS			{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6+" "+$7+" "+$8+" "+$9;}
		|int IdVar Igual Numero PTC CONDICIONES PTC IdVar Igual OPERACION	{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6+" "+$7+" "+$8+" "+$9+" "+$10;}
		|IdVar Igual Numero PTC CONDICIONES PTC IdVar Igual OPERACION		{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6+" "+$7+" "+$8+" "+$9;}
		|error ERRORES														{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;

SWITCH	:PA EXPRESION PC LLA CASES LLC	{$$=JSON.stringify({NodoI:"switch "+$1+" "+$2+" "+$3+" "+$4,ASTNodeI:[],NodoE:"CASES",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]});}
		|PA EXPRESION PC LLA  LLC		{$$=JSON.stringify({NodoI:"switch "+$1+" "+$2+" "+$3+" "+$4,ASTNodeI:[],NodoE:"CASES",ASTNodeE:[],NodoD:$5,ASTNodeD:[]});}
		|error ERRORES					{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
CASES	:MCASES default DP ININSTRUCCIONES break PTC	{$$=JSON.stringify({NodoI:"MCASES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[JSON.parse($4)],NodoD:$5+" "+$6,ASTNodeD:[]});}	
		|MCASES default DP break PTC					{$$=JSON.stringify({NodoI:"MCASES",ASTNodeI:[JSON.parse($1)],NodoE:$2+" "+$3,ASTNodeE:[],NodoD:$4+" "+$5,ASTNodeD:[]});}	
		|MCASES											{$$=JSON.stringify({NodoI:"MCASES",ASTNodeI:[JSON.parse($1)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
		|error ERRORES									{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
MCASES	:MCASES case EXPRESION DP ININSTRUCCIONES break PTC	{$$=JSON.stringify({NodoI:$2+" "+$3+" "+$4,ASTNodeI:[JSON.parse($1)],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($5)],NodoD:$6+" "+$7,ASTNodeD:[]});}
		|case EXPRESION DP ININSTRUCCIONES break PTC		{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($4)],NodoD:$5+" "+$6,ASTNodeD:[]});}
		|case EXPRESION DP break PTC						{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[],NodoD:$4+" "+$5,ASTNodeD:[]});}
		|error ERRORES										{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
EXPRESION	:Numero		{$$=$1;}
			|OPERACION	{$$=$1;}
			|TXT		{$$=$1;}
			|TEXTCHAR	{$$=$1;}
			|IdVar		{$$=$1;}
			;

CONDICIONES	:CONDICIONES Y Y InCondiciones			{$$=$1+" "+$2+" "+$3+" "+$4;}
			|CONDICIONES Y Y PA InCondiciones PC	{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6;}
			|CONDICIONES Y Y CA InCondiciones CC	{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6;}
			|CONDICIONES Y Y LLA InCondiciones LLC	{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6;}
			|CONDICIONES O O PA InCondiciones PC	{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6;}
			|CONDICIONES O O CA InCondiciones CC	{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6;}
			|CONDICIONES O O LLA InCondiciones LLC	{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5+" "+$6;}
			|CONDICIONES O O InCondiciones			{$$=$1+" "+$2+" "+$3+" "+$4;}
			|InCondiciones							{$$=$1;}
			;
InCondiciones	:VALC MAQ Igual VALC		{$$=$1+" "+$2+" "+$3+" "+$4;}
				|VALC MEQ Igual VALC		{$$=$1+" "+$2+" "+$3+" "+$4;}
				|VALC Igual Igual VALC		{$$=$1+" "+$2+" "+$3+" "+$4;}
				|VALC dif Igual VALC		{$$=$1+" "+$2+" "+$3+" "+$4;}
				|VALC MEQ VALC				{$$=$1+" "+$2+" "+$3;}
				|VALC MAQ VALC				{$$=$1+" "+$2+" "+$3;}
				|VALC						{$$=$1;}
				;	
VALC:TEXTCHAR	{$$=$1;}
	|Numero		{$$=$1;}
	|OPERACION	{$$=$1;}
	|IdVar		{$$=$1;}
	|true		{$$=$1;}
	|false		{$$=$1;}
	|dif true	{$$=$1+" "+$2;}
	|dif false	{$$=$1+" "+$2;}
	;


ERRORES	:PTC				{$$=$1;}
		|LLA				{$$=$1;}
		|LLC 				{$$=$1;}
		|CML ERRORES		{$$=$1+" "+$2;}
		|CL ERRORES			{$$=$1+" "+$2;}
		|MAQ ERRORES		{$$=$1+" "+$2;}
		|if ERRORES			{$$=$1+" "+$2}
		|else ERRORES		{$$=$1+" "+$2;}
		|MEQ ERRORES		{$$=$1+" "+$2;}
		|MENOS ERRORES		{$$=$1+" "+$2;}
		|for ERRORES		{$$=$1+" "+$2;}
		|Y ERRORES			{$$=$1+" "+$2;}
		|O ERRORES			{$$=$1+" "+$2;}
		|dif ERRORES		{$$=$1+" "+$2;}
		|PA	ERRORES			{$$=$1+" "+$2;}
		|PC	ERRORES			{$$=$1+" "+$2;}
		|CA	ERRORES			{$$=$1+" "+$2;}
		|while ERRORES		{$$=$1+" "+$2;}
		|CC	ERRORES			{$$=$1+" "+$2;}
		|Operador ERRORES	{$$=$1+" "+$2;}
		|import	ERRORES		{$$=$1+" "+$2;}
		|class ERRORES		{$$=$1+" "+$2;}
		|String	ERRORES		{$$=$1+" "+$2;}
		|int ERRORES		{$$=$1+" "+$2;}
		|boolean ERRORES	{$$=$1+" "+$2;}
		|double	ERRORES		{$$=$1+" "+$2;}
		|do	ERRORES			{$$=$1+" "+$2;}
		|char ERRORES		{$$=$1+" "+$2;}
		|Numero	ERRORES 	{$$=$1+" "+$2;}
		|TEXTO ERRORES		{$$=$1+" "+$2;}
		|TEXTCHAR ERRORES	{$$=$1+" "+$2;}
		|false ERRORES		{$$=$1+" "+$2;}
		|true ERRORES		{$$=$1+" "+$2;}
		|null ERRORES		{$$=$1+" "+$2;}
		|IdVar ERRORES		{$$=$1+" "+$2;}
		|Igual ERRORES		{$$=$1+" "+$2;}
		|COMA ERRORES		{$$=$1+" "+$2;}
		|switch ERRORES		{$$=$1+" "+$2;}
		|case ERRORES		{$$=$1+" "+$2;}
		|break ERRORES		{$$=$1+" "+$2;}
		|default ERRORES	{$$=$1+" "+$2;}
		|continue ERRORES	{$$=$1+" "+$2;}
		|DP ERRORES			{$$=$1+" "+$2;}
		|MAS ERRORES		{$$=$1+" "+$2;}
		|slash ERRORES		{$$=$1+" "+$2;}
		|return ERRORES		{$$=$1+" "+$2;}
		|void ERRORES		{$$=$1+" "+$2;}
		|PORC ERRORES		{$$=$1+" "+$2;}
		|EOF				{a=new ERRORES.ERRORES($$,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);return JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}	
		;

