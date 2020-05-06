"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Analizador = require('../Analizador');
class Controladores {
    index(req, res) {
        var TEXTO = req.body.TEXTO.split('\n');
        var TEXTO_INVERTIDO = "";
        for (let i = TEXTO.length - 1; i >= 0; i--) {
            TEXTO_INVERTIDO += TEXTO[i];
        }
        let a = Analizador.parse(req.body.TEXTO);
        console.log(JSON.parse(a));
    }
}
const controladores = new Controladores();
exports.default = controladores;
