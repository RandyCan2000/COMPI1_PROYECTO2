import {Globales} from './Globales';
export class ERRORES{
    Id:number;
    Token:String;
    Columna:number;
    Fila:number;
    Tipo:String;

    constructor(Token:String,Columna:number,Fila:number,Tipo:String){
        this.Id=Globales.ERR.length;
        this.Token=Token;
        this.Columna=Columna;
        this.Fila=Fila;
        this.Tipo=Tipo;
    }
}