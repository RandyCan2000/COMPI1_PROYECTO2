ContadorCapazRep=1;
ContadorCapaz=0;
ContadorPestania=0;
Seleccionado="";
Traduccion="";
RESP_JSON=null;
TREE="";
NG=1;
NGD=1;
CN1=0;
CN2=0;
CN3=0;
ERRORES=null;
TOKENS=null;
ANALIZADO=null;
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
            ERRORES.forEach(element => {
                console.log(element);
            });
            TOKENS=aa.TOKENS;
            TOKENS.forEach(element => {
                console.log(element);
            });
            console.log("ANALIZADO");
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
        TREE+="<li><input type=\"checkbox\" name=\"list\" id=\"nivel"+NG+"-"+CN1+"\"><label for=\"nivel"+NG+"-"+CN1+"\">"+ASTNodeAux.NodoI+"</label>\n";
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
        TREE+="<li><input type=\"checkbox\" name=\"list\" id=\"nivel"+NG+"-"+CN2+"\"><label for=\"nivel"+NG+"-"+CN2+"\">"+ASTNodeAux.NodoE+"</label>\n";
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
        TREE+="<li><input type=\"checkbox\" name=\"list\" id=\"nivel"+NG+"-"+CN3+"\"><label for=\"nivel"+NG+"-"+CN3+"\">"+ASTNodeAux.NodoD+"</label>\n";
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
function MostarRep(Reporte) {
    ContadorCapazRep++;
    document.getElementById(Reporte.toString()).style.zIndex=ContadorCapazRep.toString();
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
