"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Globales_1 = require("./Globales");
class ERRORES {
    constructor(Token, Columna, Fila, Tipo) {
        this.Id = Globales_1.Globales.ERR.length;
        this.Token = Token;
        this.Columna = Columna;
        this.Fila = Fila;
        this.Tipo = Tipo;
    }
}
exports.ERRORES = ERRORES;
