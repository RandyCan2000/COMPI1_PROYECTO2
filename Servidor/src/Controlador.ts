import {Request,Response, text} from 'express';
import {ERRORES} from './ERRORES';
import {Globales} from './Globales';
import {Analizado} from './Analizado';
const Analizador=require('../Analizador');
class Controladores{
    public index(req:Request,res:Response){
        let AGREGAR:Boolean=false;
        Globales.ERR=[];
        Globales.TOK=[];
        let a=Analizador.parse(req.body.TEXTO);
        Globales.ANALIZADO.forEach(element => {
            if(req.body.NOMBRE==element.Nombre){
                element.Texto=req.body.TEXTO;
                element.ArbolAST=JSON.parse(a);
                element.TOKENS=Globales.TOK;
                element.ERRORES=Globales.ERR;
                AGREGAR=true;
                return;
            }
        });
        if(AGREGAR==false){
            Globales.ANALIZADO.push(new Analizado(req.body.NOMBRE,req.body.TEXTO,Globales.TOK,JSON.parse(a),Globales.ERR));
        }
        let SEND_JSON
        try {
            SEND_JSON=JSON.stringify({ArbolAST:[JSON.parse(a)],ERRORES:Globales.ERR,TOKENS:Globales.TOK,ANALIZADO:Globales.ANALIZADO});
        } catch (error) {
            SEND_JSON=JSON.stringify({ArbolAST:[],ERRORES:Globales.ERR,TOKENS:Globales.TOK,ANALIZADO:Globales.ANALIZADO});
        }
        res.json(JSON.parse(SEND_JSON));
    }
}
const controladores=new Controladores();
export default controladores;