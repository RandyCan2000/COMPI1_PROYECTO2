ContadorCapazRep=1;
ContadorCapaz=0;
ContadorPestania=0;
Seleccionado="";
Traduccion="";

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
       alert(http.responseText);
    }
}
http.send(JSON.stringify({TEXTO:texto.value}));
    /*fetch('http://localhost:3000/C1P2/'+JSON.stringify([texto.value]))
    .then(res=>res.text())
    .then(data=>{
        console.log(data);
    })*/
}

