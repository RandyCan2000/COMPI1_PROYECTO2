
//numero que permite sobreponer un textarea hasta arriba
ContadorCapaz=0;
//contador de pestanias
ContadorPestania=0;
//nombre del textArea seleccionado
Seleccionado="";
//texto en textArea
Traduccion="";
//respuesta obtenida en JSON
RESP_JSON=null;
//variable que guarda las etiquetas para generar el arbol
TREE="";
//contador de niveles para el arbol
NG=1;
NGD=1;
CN1=0;
CN2=0;
CN3=0;
//arreglo de reporte errores tokens y analizado que es un arreglo de todos los analisis hecho previamente
ERRORES=null;
TOKENS=null;
ANALIZADO=null;
//listado de clases funciones y variables generales
REPAFUN=[];
REPVAR=[];
REPCLASS=[];
//listado de clases funciones y variables depurado (comparadas)
LST_FUN_COPIA=[];
LST_CLASE_COPIA=[];
LST_VAR_COPIA=[];
function leerArchivo(Direccion) {
    let file;
    file = Direccion[0];
    var reader = new FileReader();
    reader.onload = function (e) {
        div = document.createElement("div");
        CajaTexto = document.createElement("textarea");
        Titulo = document.createElement("button");
        CajaTexto.setAttribute("rows", "25");
        CajaTexto.setAttribute("cols", "100");
        CajaTexto.style.position = "absolute";
        CajaTexto.setAttribute("id", ContadorPestania + ":" + file.name);
        CajaTexto.style.zIndex = ContadorCapaz.toString();
        ContadorCapaz++;
        CajaTexto.style.resize = "none";
        CajaTexto.style.overflow = "scroll";
        CajaTexto.textContent = e.target.result.toString(); //recupera el texto del archivo
        CajaTexto.setAttribute("class", "CajaTexto");
        Titulo.innerHTML = ContadorPestania + ":" + file.name;
        Seleccionado = ContadorPestania + ":" + file.name;
        document.getElementById("NombreSeleccion").innerHTML = ContadorPestania + ":" + file.name;
        Titulo.setAttribute("id", "Boton");
        Titulo.style.outline = "none";
        Titulo.onclick = function () {
            Seleccionado = this.innerHTML;
            document.getElementById("NombreSeleccion").innerHTML = this.innerHTML;
            document.getElementById(this.innerHTML).style.zIndex = ContadorCapaz.toString();
            ContadorCapaz++;
            //tab 
            var el =document.getElementById(this.innerHTML);
            el.onkeydown = function(e) {
            if (e.keyCode === 9) {
                var val = el.value,start = el.selectionStart,end = el.selectionEnd;
                el.value = val.substring(0, start) + '\t' + val.substring(end);
                el.selectionStart = el.selectionEnd = start + 1;
            return false;}};
            //fin tab
          };
          document.getElementById("Botones").appendChild(Titulo);
          div.appendChild(CajaTexto);
          div.style.marginLeft = "20%";
          document.getElementById("CajasTexto").appendChild(div);
          ContadorPestania++;
            //tab 
            var el = document.getElementById(Titulo.innerHTML);
            el.onkeydown = function(e) {
            if (e.keyCode === 9) {
                var val = el.value,start = el.selectionStart,end = el.selectionEnd;
                el.value = val.substring(0, start) + '\t' + val.substring(end);
                el.selectionStart = el.selectionEnd = start + 1;
            return false;}};
            //fin tab
    };
    reader.readAsText(file);
}
function Analizar(){
    var texto=document.getElementById(Seleccionado.toString());    
    var http = new XMLHttpRequest();
    var url = "http://localhost:3000/C1P2";
    http.open("POST", url, true);
    http.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    http.onreadystatechange = function() {
    if(http.readyState == 4 && http.status == 200) { 
        //aqui obtienes la respuesta de tu peticion
        //alert(JSON.parse(http.responseText));
        //alert("hola");
        try {
            let aa=JSON.parse(http.responseText);
            RESP_JSON=aa.ArbolAST[0];
            ERRORES=aa.ERRORES;
            TOKENS=aa.TOKENS;
            ANALIZADO=aa.ANALIZADO;
            ANALIZADO.forEach(element => {
                console.log(element);
            });
            var nom=Seleccionado.split(':');
            var nom2=nom[1].split('.');
            NG=1;
            CN1=1;CN2=1;CN3=1;
            TREE="";
            TREE+="<li><input type=\"checkbox\" name=\"list\" id=\"nivel1-"+NGD+"\"><label for=\"nivel1-"+NGD+"\">ArbolAST "+nom2[0]+"</label>\n";
            TREE+="<ul class=\"interior\">\n";
            NG++;
            RecorrerArbol(RESP_JSON);
            NG++;
            TREE+="</ul>\n";
            TREE+="</li>\n";
            NGD++;
            document.getElementById('menu').innerHTML=TREE;
            CrearHTMLTOKENS();
            if(ERRORES.length>0){CrearHTMLERRORES();}

        } catch (error) {
            console.log("ERROR EN LA PETICION"+error);
        }
    }
}
http.send(JSON.stringify({TEXTO:texto.value,NOMBRE:Seleccionado}));
    /*fetch('http://localhost:3000/C1P2/'+JSON.stringify([texto.value]))
    .then(res=>res.text())
    .then(data=>{
        console.log(data);
    })*/
}
function RecorrerArbol(ASTNode) {
    var ASTNodeAux=ASTNode;
    //NODO IZQUIERDA
    if(ASTNodeAux.ASTNodeI.length==0){
        TREE+="<li><a href=\"#r\">▹"+ASTNodeAux.NodoI+"</a></li>\n";
        CN1++;
    }else{
        TREE+="<li><input type=\"checkbox\" name=\"list\" id=\"nivel"+NG+"-"+CN1+"\" checked><label for=\"nivel"+NG+"-"+CN1+"\">"+ASTNodeAux.NodoI+"</label>\n";
        CN1++;
        TREE+="<ul class=\"interior\">\n";
        NG++;
        RecorrerArbol(ASTNodeAux.ASTNodeI[0]);
        NG--;
        TREE+="</ul>\n";
        TREE+="</li>\n";
    }
    //FIN NODO IZQUIERDA
    //FIN NODO Enmedio
    if(ASTNodeAux.ASTNodeE.length==0){
        TREE+="<li><a href=\"#r\">▹"+ASTNodeAux.NodoE+"</a></li>\n";
        CN2++;
    }else{
        TREE+="<li><input type=\"checkbox\" name=\"list\" id=\"nivel"+NG+"-"+CN2+"\" checked><label for=\"nivel"+NG+"-"+CN2+"\">"+ASTNodeAux.NodoE+"</label>\n";
        CN2++;
        TREE+="<ul class=\"interior\">\n";
        NG++;
        RecorrerArbol(ASTNodeAux.ASTNodeE[0]);
        NG--;
        TREE+="</ul>\n";
        TREE+="</li>\n";
    }
    //FIN NODO Enmedio
    //INICIO NODO DERECHA
    if(ASTNodeAux.ASTNodeD.length==0){
        TREE+="<li><a href=\"#r\">▹"+ASTNodeAux.NodoD+"</a></li>\n";
        CN3++;
    }else{
        TREE+="<li><input type=\"checkbox\" name=\"list\" id=\"nivel"+NG+"-"+CN3+"\" checked><label for=\"nivel"+NG+"-"+CN3+"\">"+ASTNodeAux.NodoD+"</label>\n";
        CN3++;
        TREE+="<ul class=\"interior\">\n";
        NG++;
        RecorrerArbol(ASTNodeAux.ASTNodeD[0]);
        NG--;
        TREE+="</ul>\n";
        TREE+="</li>\n";
    }
    //FIN NODO DERECHA
}

function CREAR_ARCHIVO(TEXTO,NOMBRE){
    // creas el fichero con la API File
    var file = new File([TEXTO],NOMBRE,{type:"text/plain;charset=utf-8"});
    // obtienes una URL para el fichero que acabas de crear
    var url  = window.URL.createObjectURL(file);
    // creas un enlace y lo añades al documento
    var a = document.createElement("a");
    // actualizas los parámetros del enlace para descargar el fichero creado
    a.href = url;
    a.download = file.name;
    a.click();
}
function CrearHTMLTOKENS(){
    let TEXTO=`
    <html>
    <head>
    <title>TOKENS</title>
    </head>
    <body style="text-align:center">`;
    TEXTO+=`<table class="egt">`;
    TEXTO+=`<tr>
    <th>ID</th>
    <th>TOKEN</th>
    <th>FILA</th>
    <th>COLUMNA</th>
    </tr>`;
    TOKENS.forEach(element => {
        TEXTO+="<tr>";
        TEXTO+=`<th>`+element.Id+`</th>
                <th>`+element.Token+`</th>
                <th>`+element.Fila+`</th>
                <th>`+element.Columna+`</th>`
        TEXTO+="</tr>";
    });
    TEXTO+=`</table>`;
    TEXTO+=`</body>
    </html>`;
    CREAR_ARCHIVO(TEXTO,"TOKENS.html");
}
function CrearHTMLERRORES(){
    let TEXTO=`
    <html>
    <head>
    <title>ERRORES</title>
    </head>
    <body style="text-align:center">`;
    TEXTO+=`<table class="egt">`;
    TEXTO+=`<tr>
    <th>ID</th>
    <th>TIPO</th>
    <th>TOKEN</th>
    <th>FILA</th>
    <th>COLUMNA</th>
    </tr>`;
    ERRORES.forEach(element => {
        TEXTO+="<tr>";
        TEXTO+=`<th>`+element.Id+`</th>
                <th>`+element.Tipo+`</th>
                <th>`+element.Token+`</th>
                <th>`+element.Fila+`</th>
                <th>`+element.Columna+`</th>`
        TEXTO+="</tr>";
    });
    TEXTO+=`</table>`;
    TEXTO+=`</body>
    </html>`;
    CREAR_ARCHIVO(TEXTO,"ERRORES.html");
}

function REP(){
    REPAFUN=[];
    REPVAR=[];
    REPCLASS=[];
    LST_FUN_COPIA=[];
    LST_CLASE_COPIA=[];
    LST_VAR_COPIA=[];
    GEN_LST_FUN_CLASS_VAR(ANALIZADO);//recupera todas las funciones clases y variables y las guarda en REPFUN REPCLASS y REPVAR Respectivamente
    Comparar_Clases(REPCLASS,REPAFUN);//Busca las clases y funciones Copia las guarda en LST_CLASE_COPIA y LST_FUN_COPIA respectivamente
    Comparar_Varibales_Copia(REPVAR);//BUSCA LAS VARIBALES COPIA y las GUARDA EN LST_VAR_COPIA
    CREAR_REP_COPIAS(LST_CLASE_COPIA,LST_FUN_COPIA,LST_VAR_COPIA);//genera HTML CON EL REPORTE
}
//REPANALIZADO
function GEN_LST_FUN_CLASS_VAR(ANALISIS){
    let ID_CLASES=0;
    ANALISIS.forEach(element => {
        TOK=element.TOKENS;
        let CON_LLAVE_CLASE=0;
        let CON_LLAVE_FUN=0;
        let Nombre_Clase="";
        let Nombre_FUN="";
        let Contador_Metodos=0;
        let Parametros="";
        let PERM_AGG_FUN=false;
        for (let i = 0; i < TOK.length; i++) {
            if(TOK[i].Token=="class"){
                Nombre_Clase="";
                try {
                    if(TOK[i+2].Token=="{"){
                        CON_LLAVE_CLASE=0;
                        Nombre_Clase=TOK[i+1].Token;
                        i=i+1;
                        ID_CLASES++;
                    }
                } catch (error) {}
            }
            else if(TOK[i].Token=="int"||TOK[i].Token=="double"||TOK[i].Token=="char"||
            TOK[i].Token=="String"||TOK[i].Token=="boolean"||TOK[i].Token=="void"){
                try {
                    let VAR="";
                    if(TOK[i+2].Token=="("){
                        Parametros="";
                        Nombre_FUN=TOK[i+1].Token;
                        for(let j = i+3; j < TOK.length; j++){
                            if(TOK[j].Token==")"){
                                if(TOK[j+1].Token=="{"){
                                    CON_LLAVE_FUN=0;
                                }
                                Contador_Metodos++;
                                i=j;
                                break;
                            }
                            else{Parametros+=TOK[j].Token+" ";}
                        }
                    }else if(TOK[i+2].Token==","){
                        for(let j = i+1; j < TOK.length; j++){
                            if(TOK[j].Token=="="||TOK[j].Token==";"){
                                let vars=VAR.split(",");
                                vars.forEach(element => {
                                    REPVAR.push(JSON.stringify({ID:ID_CLASES,Tipo:TOK[i].Token,Nombre:element,Funcion:Nombre_FUN,Clase:Nombre_Clase}));
                                });
                                i=j;
                                break;
                            }else{
                                VAR+=TOK[j].Token;
                            }
                        }
                    }else if(TOK[i+2].Token==";"||TOK[i+2].Token=="="){
                        REPVAR.push(JSON.stringify({ID:ID_CLASES,Tipo:TOK[i].Token,Nombre:TOK[i+1].Token,Funcion:Nombre_FUN,Clase:Nombre_Clase}));
                        i=i+2;
                    }
                } catch (error) {}
            }
            else if(TOK[i].Token=="return"){
                if(TOK[i+1].Token!=";"){
                    REPAFUN.push(JSON.stringify({ID:ID_CLASES,Clase:Nombre_Clase,Funcion:Nombre_FUN,Variables:Parametros,Retorna:TOK[i+1].Token}));
                    i=i+1;
                }else{
                    REPAFUN.push(JSON.stringify({ID:ID_CLASES,Clase:Nombre_Clase,Funcion:Nombre_FUN,Variables:Parametros,Retorna:""}));
                }
                PERM_AGG_FUN=true;
            }
            else if(TOK[i].Token=="{"){
                CON_LLAVE_CLASE++;
                CON_LLAVE_FUN++;
            }
            else if(TOK[i].Token=="}"){
                CON_LLAVE_CLASE--;
                CON_LLAVE_FUN--;
                if(CON_LLAVE_CLASE==0){
                    REPCLASS.push(JSON.stringify({ID:ID_CLASES,Clase:Nombre_Clase,Cantidad_Funciones:Contador_Metodos}));
                    Contador_Metodos=0;
                }
                if(CON_LLAVE_FUN==0){
                    if(PERM_AGG_FUN==false){
                        REPAFUN.push(JSON.stringify({ID:ID_CLASES,Clase:Nombre_Clase,Funcion:Nombre_FUN,Variables:Parametros,Retorna:""}));
                    }
                    Nombre_FUN="";
                    PERM_AGG_FUN=false;
                }
            }
        }
    });
}

function Comparar_Clases(LST_CLASES,LST_FUN){
    for (let i = 0; i < LST_CLASES.length; i++) {
        let CLASE1=JSON.parse(LST_CLASES[i]);
        for (let j = i+1; j < LST_CLASES.length; j++) {
            let CLASE2=JSON.parse(LST_CLASES[j]);
            if(CLASE1.Clase==CLASE2.Clase){
                let LST_FUN_AUX=[];
                LST_FUN.forEach(element => {
                    let FUN=JSON.parse(element);
                    if(FUN.ID==CLASE1.ID||FUN.ID==CLASE2.ID){
                        LST_FUN_AUX.push(FUN);
                    }
                });
                let CONTADOR_ACIERTOS_COPIA=0;
                for (let K = 0; K < LST_FUN_AUX.length; K++) {
                    let FUN1=LST_FUN_AUX[K];
                    for (let L = K+1; L < LST_FUN_AUX.length; L++) {
                        let FUN2=LST_FUN_AUX[L];
                        if(FUN1.Funcion==FUN2.Funcion && FUN1.ID!=FUN2.ID &&
                        FUN1.Variables==FUN2.Variables && FUN1.Retorna==FUN2.Retorna){
                            LST_FUN_COPIA.push(FUN1);
                            CONTADOR_ACIERTOS_COPIA++;
                        }
                    } 
                }
                let PORCENTAJE_COPIA=(CONTADOR_ACIERTOS_COPIA/CLASE1.Cantidad_Funciones)*100;
                LST_CLASE_COPIA.push(JSON.parse(JSON.stringify({ID:CLASE1.ID,Clase:CLASE1.Clase,Cantidad_Funciones:CLASE1.Cantidad_Funciones,Porcentaje:PORCENTAJE_COPIA})));
            }
        }
    }
}

function Comparar_Varibales_Copia(LST_VAR){
    for (let i = 0; i < LST_VAR.length; i++) {
        let VAR1=JSON.parse(LST_VAR[i]);
        for (let j = i+1; j < LST_VAR.length; j++) {
            let VAR2=JSON.parse(LST_VAR[j]);
            if(VAR1.Clase==VAR2.Clase && VAR1.ID!=VAR2.ID && 
                VAR1.Tipo==VAR2.Tipo && VAR1.Nombre==VAR2.Nombre &&
                VAR1.Funcion==VAR2.Funcion){
                    LST_VAR_COPIA.push(VAR1);
                }
        }
    }
}

function CREAR_REP_COPIAS(LST_CLASES,LST_FUN,LST_VAR){
    let TEXTO=`
    <html>
    <head>
    <title>REPORTE</title>
    </head>
    <body style="text-align:center">`;
    TEXTO+=`<table border="1">
        <caption>CLASES COPIA</caption>
        <tbody>`;
    TEXTO+="<tr>"
    TEXTO+="<th>CLASE</th>";
    TEXTO+="<th>CANTIDAD DE FUNCIONES</th>";
    TEXTO+="<th>PORCENTAJE COPIA</th>";
    TEXTO+="</tr>";
    LST_CLASES.forEach(element => {
        TEXTO+="<tr>"
        TEXTO+="<td>"+element.Clase+"</td>";
        TEXTO+="<td>"+element.Cantidad_Funciones+"</td>";
        TEXTO+="<td>"+element.Porcentaje+"</td>";
        TEXTO+="</tr>";
    });
    TEXTO+=`</tbody>
    </table>`;
    TEXTO+="<br><br>";


    TEXTO+=`<table border="1">
        <caption>FUNCIONES COPIA</caption>
        <tbody>`;
    TEXTO+="<tr>"
    TEXTO+="<th>FUNCION</th>";
    TEXTO+="<th>CLASE</th>";
    TEXTO+="<th>PARAMETROS</th>";
    TEXTO+="<th>RETORNA</th>";
    TEXTO+="</tr>";
    LST_FUN.forEach(element => {
        TEXTO+="<tr>"
        TEXTO+="<td>"+element.Funcion+"</td>";
        TEXTO+="<td>"+element.Clase+"</td>";
        TEXTO+="<td>"+element.Variables+"</td>";
        TEXTO+="<td>"+element.Retorna+"</td>";
        TEXTO+="</tr>";
    });

    TEXTO+=`</tbody>
    </table>`;

    TEXTO+="<br><br>";


    TEXTO+=`<table border="1">
        <caption>VARIABLES COPIA</caption>
        <tbody>`;
    TEXTO+="<tr>"
    TEXTO+="<th>NOMBRE</th>";
    TEXTO+="<th>TIPO</th>";
    TEXTO+="<th>FUNCION</th>";
    TEXTO+="<th>CLASE</th>";
    TEXTO+="</tr>";
    LST_VAR.forEach(element => {
        TEXTO+="<tr>"
        TEXTO+="<td>"+element.Nombre+"</td>";
        TEXTO+="<td>"+element.Tipo+"</td>";
        TEXTO+="<td>"+element.Funcion+"</td>";
        TEXTO+="<td>"+element.Clase+"</td>";
        TEXTO+="</tr>";
    });


    TEXTO+=`</body>
    </html>`;
    CREAR_ARCHIVO(TEXTO,"REPORTE_COPIA.html");
}