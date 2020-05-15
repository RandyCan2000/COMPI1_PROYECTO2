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
","													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'COMA';}
//"void"											return 'void'
"("													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'PA';}
")"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'PC';}
"["													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'CA';}
"]"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'CC';}
[>|<]												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'COND';}
[ && | || ]											{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'LOGICOS';}
"+"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'MAS';}
[-|/|*|^|%]											{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'Operador';}
"{"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'LLA';}
"}"													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'LLC';}
import("."[a-zA-Z]+)+								{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'import';}//importaciones
class												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'class';}
String												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'String';}
int													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'int';}
boolean												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'boolean';}
double												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'double';}
char												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'char';}
[0-9]+("."[0-9]+)?									{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'Numero';}
(\"([^"]|\"|\n|\t|\r|\\)*\")						{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'TEXTO';}
\'.\'												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'TEXTCHAR';}
false												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'false';}
true												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'true';}
null												{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'null';}
([a-zA-Z]|_)([a-zA-Z]|[0-9]|_)*						{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'IdVar';}
"="													{GLOBALES.Globales.TOK.push(new TOKENS.TOKENS(yytext,yylloc.first_line,yylloc.first_column));return 'Igual';}//IGUAL
<<EOF>>												return 'EOF'
.													{a=new ERRORES.ERRORES(yytext,yylloc.first_column,yylloc.first_line,"LEXICO");GLOBALES.Globales.ERR.push(a);return 'ERRLEX';}
/lex
%start Java

%% /* language grammar */

Java	: Inicio EOF	{return $$}
		;
Inicio	:IMP Clase 	{$$=JSON.stringify({NodoI:"IMP",ASTNodeI:[JSON.parse($1)],NodoE:"Clase",ASTNodeE:[JSON.parse($2)],NodoD:"ε",ASTNodeD:[]})}
		|Clase 	{$$=JSON.stringify({NodoI:"CLASE",ASTNodeI:[JSON.parse($1)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]})}	
		|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
IMP		:IMP import PTC	{$$=JSON.stringify({NodoI:"IMP",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]})}
		|import PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]})}
		|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
Clase	:Clase class IdVar LLA Instrucciones LLC		{$$=JSON.stringify({NodoI:$2+" "+$3+" "+$4,ASTNodeI:[JSON.parse($1)],NodoE:"Instrucciones",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]})}
		|Clase class IdVar LLA LLC		{$$=JSON.stringify({NodoI:$2+" "+$3+" "+$4,ASTNodeI:[JSON.parse($1)],NodoE:"Instrucciones",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]})}
		|class IdVar LLA Instrucciones LLC		{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"Instrucciones",ASTNodeE:[JSON.parse($4)],NodoD:$5,ASTNodeD:[]})}
		|class IdVar LLA LLC		{$$=JSON.stringify({NodoI:$1+" "+$2,ASTNodeI:[],NodoE:$3,ASTNodeE:[],NodoD:$4,ASTNodeD:[]})}
		|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
		;
Instrucciones	:Instrucciones String IdVar VALORSTRING 			{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+""+$3,ASTNodeE:[],NodoD:"VALORSTRING",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones int IdVar VALORNUMERO				{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+""+$3,ASTNodeE:[],NodoD:"VALORNUMERO",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones double IdVar VALORNUMERO				{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+""+$3,ASTNodeE:[],NodoD:"VALORNUMERO",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones char IdVar VALORCHAR					{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+""+$3,ASTNodeE:[],NodoD:"VALORCHAR",ASTNodeD:[JSON.parse($4)]});}
				|Instrucciones boolean IdVar VALORBOOLEAN 			{$$=JSON.stringify({NodoI:"INSTRUCCIONES",ASTNodeI:[JSON.parse($1)],NodoE:$2+""+$3,ASTNodeE:[],NodoD:"VALORBOOLEAN",ASTNodeD:[JSON.parse($4)]});}
				|String IdVar VALORSTRING 							{$$=JSON.stringify({NodoI:$1+""+$2,ASTNodeI:[],NodoE:"VALORSTRING",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|int IdVar VALORNUMERO								{$$=JSON.stringify({NodoI:$1+""+$2,ASTNodeI:[],NodoE:"VALORNUMERO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|double IdVar VALORNUMERO							{$$=JSON.stringify({NodoI:$1+""+$2,ASTNodeI:[],NodoE:"VALORNUMERO",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|char IdVar VALORCHAR								{$$=JSON.stringify({NodoI:$1+""+$2,ASTNodeI:[],NodoE:"VALORCHAR",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|boolean IdVar VALORBOOLEAN 						{$$=JSON.stringify({NodoI:$1+""+$2,ASTNodeI:[],NodoE:"VALORBOOLEAN",ASTNodeE:[JSON.parse($3)],NodoD:"ε",ASTNodeD:[]});}
				|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
				;	
VALORSTRING	:Igual TXT PTC 								{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC									{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PA ListaVarEnFun PC LLA ININSTRUCCIONES LLC	{$$=JSON.stringify({NodoI:$1+" "+$3+" "+$4,ASTNodeI:[JSON.parse($2)],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]});}
			|PA PC LLA ININSTRUCCIONES LLC					{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($4)],NodoD:$5,ASTNodeD:[]});}
			|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;

TXT	:TXT MAS IdVar	{$$=$1+" "+$2+" "+$3;}
	|TXT MAS TEXTO	{$$=$1+" "+$2+" "+$3;}
	|TEXTO			{$$=$1;}
	|IdVar			{$$=$1;}
	;
VALORNUMERO	:Igual Numero PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual OPERACION PTC {$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"OPERACION",ASTNodeE:[JSON.parse($2)],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PA ListaVarEnFun PC LLA ININSTRUCCIONES LLC	{$$=JSON.stringify({NodoI:$1+" "+$3+" "+$4,ASTNodeI:[JSON.parse($2)],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]});}
			|PA PC LLA ININSTRUCCIONES LLC				{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($4)],NodoD:$5,ASTNodeD:[]});}
			|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;
OPERACION	:OPERACION Operador OP	{$$=JSON.stringify({NodoI:"OPERACION",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"OP",ASTNodeD:[JSON.parse($3)]});}
			|OPERACION MAS OP	{$$=JSON.stringify({NodoI:"OPERACION",ASTNodeI:[JSON.parse($1)],NodoE:$2,ASTNodeE:[],NodoD:"OP",ASTNodeD:[JSON.parse($3)]});}
			|OP		{$$=JSON.stringify({NodoI:"OP",ASTNodeI:[JSON.parse($1)],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
			|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;
OP	:PA OPERACION PC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"OPERACION",ASTNodeE:[JSON.parse($2)],NodoD:$3,ASTNodeD:[]});}
	|LLA OPERACION LLC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"OPERACION",ASTNodeE:[JSON.parse($2)],NodoD:$3,ASTNodeD:[]});}
	|CA OPERACION CC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"OPERACION",ASTNodeE:[JSON.parse($2)],NodoD:$3,ASTNodeD:[]});}
	|Numero				{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
	|Operador Numero	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
	|MAS Numero			{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
	|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
	;
VALORCHAR	:Igual TEXTCHAR PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PA ListaVarEnFun PC LLA ININSTRUCCIONES LLC	{$$=JSON.stringify({NodoI:$1+" "+$3+" "+$4,ASTNodeI:[JSON.parse($2)],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]});}
			|PA PC LLA ININSTRUCCIONES LLC				{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($4)],NodoD:$5,ASTNodeD:[]});}
			|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
			;
VALORBOOLEAN:Igual true PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual false PTC	{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|Igual null PTC		{$$=JSON.stringify({NodoI:$1,ASTNodeI:[],NodoE:$2,ASTNodeE:[],NodoD:$3,ASTNodeD:[]});}
			|PA ListaVarEnFun PC LLA ININSTRUCCIONES LLC	{$$=JSON.stringify({NodoI:$1+" "+$3+" "+$4,ASTNodeI:[JSON.parse($2)],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($5)],NodoD:$6,ASTNodeD:[]});}
			|PA PC LLA ININSTRUCCIONES LLC				{$$=JSON.stringify({NodoI:$1+" "+$2+" "+$3,ASTNodeI:[],NodoE:"ININSTRUCCIONES",ASTNodeE:[JSON.parse($4)],NodoD:$5,ASTNodeD:[]});}
			|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
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

ININSTRUCCIONES	:				{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}
				|error ERRORES	{$$=JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]}); a=new ERRORES.ERRORES($2,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);}
				;


CONDICIONES	:CONDICIONES LOGICOS InCondiciones			{$$=$1+" "+$2+" "+$3;}
			|CONDICIONES LOGICOS InCondiciones			{$$=$1+" "+$2+" "+$3;}
			|CONDICIONES LOGICOS PA InCondiciones PC	{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5;}
			|CONDICIONES LOGICOS PA InCondiciones PC	{$$=$1+" "+$2+" "+$3+" "+$4+" "+$5;}
			|InCondiciones								{$$=$1;}
			;
InCondiciones	:VALC COND Igual VALC		{$$=$1+" "+$2+" "+$3+" "+$4;}
				|VALC Igual Igual VALC		{$$=$1+" "+$2+" "+$3+" "+$4;}
				|VALC "!" Igual VALC		{$$=$1+" "+$2+" "+$3+" "+$4;}
				|VALC COND VALC		{$$=$1+" "+$2+" "+$3;}
				|VALC				{$$=$1;}
				;
VALC:OPERACION	{$$=$1;}
	|Numero		{$$=$1;}
	|TEXTO		{$$=$1;}
	|TEXTCHAR	{$$=$1;}
	|true		{$$=$1;}
	|false		{$$=$1;}
	|"!" true	{$$=$1+" "+$2;}
	|"!" false	{$$=$1+" "+$2;}
	;


ERRORES	:PTC				{$$=$1;}
		|LLA				{$$=$1;}
		|LLC 				{$$=$1;}
		|COND ERRORES		{$$=$1+" "+$2;}
		|LOGICOS ERRORES	{$$=$1+" "+$2;}
		|PA	ERRORES			{$$=$1+" "+$2;}
		|PC	ERRORES			{$$=$1+" "+$2;}
		|CA	ERRORES			{$$=$1+" "+$2;}
		|CC	ERRORES			{$$=$1+" "+$2;}
		|Operador ERRORES	{$$=$1+" "+$2;}
		|import	ERRORES		{$$=$1+" "+$2;}
		|class ERRORES		{$$=$1+" "+$2;}
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
		|COMA ERRORES		{$$=$1+" "+$2;}
		|ERRLEX	ERRORES		{$$=$1+" "+$2;}
		|MAS ERRORES		{$$=$1+" "+$2;}
		|EOF				{a=new ERRORES.ERRORES($$,this._$.first_column,this._$.first_line,"SINTACTICO");GLOBALES.Globales.ERR.push(a);return JSON.stringify({NodoI:"ε",ASTNodeI:[],NodoE:"ε",ASTNodeE:[],NodoD:"ε",ASTNodeD:[]});}	
		;

