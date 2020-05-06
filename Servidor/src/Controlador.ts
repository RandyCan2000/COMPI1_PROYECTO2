import {Request,Response, text} from 'express';
const Analizador=require('../Analizador');
class Controladores{
    public index(req:Request,res:Response){
        var TEXTO:string[]=req.body.TEXTO.split('\n');
        var TEXTO_INVERTIDO:string="";
        for(let i=TEXTO.length-1;i>=0;i--){
            TEXTO_INVERTIDO+=TEXTO[i];
        }
        let a=Analizador.parse(req.body.TEXTO);
        console.log(JSON.parse(a));
    }
}
const controladores=new Controladores();
export default controladores;