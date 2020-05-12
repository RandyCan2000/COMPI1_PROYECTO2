import {TOKENS} from './TOKENS';
import {ERRORES} from './ERRORES';
import {Globales} from './Globales';
export class Analizado{
    Id:number;
    Nombre:String;
    Texto:String;
    TOKENS:TOKENS[];
    ERRORES:ERRORES[];
    ArbolAST:JSON;

    constructor(Nombre:String,Texto:String,TOKENS:TOKENS[],ArbolAST:JSON,ERRORES:ERRORES[]){
        this.Id=Globales.ANALIZADO.length;
        this.Nombre=Nombre;
        this.Texto=Texto;
        this.TOKENS=TOKENS;
        this.ERRORES=ERRORES;
        this.ArbolAST=ArbolAST;
    }
}