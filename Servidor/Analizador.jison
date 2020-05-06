%{

%}
%lex
%options case-sensitive
%%
\s+												/*ESPACIO EN BLANCO*/	
//[0-9]+("."[0-9]+)?								return 'Numero'
//"\""(.*)"\""									return 'CC'//Cadena En Comillas
//.*"(".*")"";"	 								return 'LLM'//LLAMADA DE METODO O FUNCION 
";"												return 'PTC'//PUNTO Y COMA
//"String"|"int"|"boolean"|"char"|"double"		return 'Var'
//"void"											return 'void'
"{"													return 'LLA'
"}"													return 'LLC'
"import"("."[a-zA-Z]+)+								return 'import'//importaciones
"public"									return 'public'
"class"										return 'class'


([a-zA-Z]|"_")([a-zA-Z]|[0-9]|"_")*					return 'IdVar'
//"="												return 'Igual'//IGUAL


<<EOF>>											return 'EOF'
.												{console.log('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column);}
/lex
%start Java

%% /* language grammar */

Java	: Inicio EOF
		;
Inicio	:Inicio Clase
		|IMP
		|
		;
IMP		:IMP import PTC
		|import PTC
		;
Clase	:public class IdVar LLA Instrucciones LLC
		;
Instrucciones	:PTC
				;	

