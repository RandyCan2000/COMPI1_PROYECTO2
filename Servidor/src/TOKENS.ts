import {Globales} from './Globales'; 
export class TOKENS{
    Id:number;
    Token:String;
    Fila:number;
    Columna:number;
    constructor(Token:String,Fila:number,Columna:number){
        this.Id=Globales.TOK.length;
        this.Token=Token;
        this.Fila=Fila;
        this.Columna=Columna;
    }
}