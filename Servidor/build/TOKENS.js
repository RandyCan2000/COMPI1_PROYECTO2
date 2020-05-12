"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Globales_1 = require("./Globales");
class TOKENS {
    constructor(Token, Fila, Columna) {
        this.Id = Globales_1.Globales.TOK.length;
        this.Token = Token;
        this.Fila = Fila;
        this.Columna = Columna;
    }
}
exports.TOKENS = TOKENS;
