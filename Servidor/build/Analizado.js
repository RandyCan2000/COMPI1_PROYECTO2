"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Globales_1 = require("./Globales");
class Analizado {
    constructor(Nombre, Texto, TOKENS, ArbolAST, ERRORES) {
        this.Id = Globales_1.Globales.ANALIZADO.length;
        this.Nombre = Nombre;
        this.Texto = Texto;
        this.TOKENS = TOKENS;
        this.ERRORES = ERRORES;
        this.ArbolAST = ArbolAST;
    }
}
exports.Analizado = Analizado;
