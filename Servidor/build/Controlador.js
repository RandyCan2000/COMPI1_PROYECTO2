"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Globales_1 = require("./Globales");
const Analizado_1 = require("./Analizado");
const Analizador = require('../Analizador');
class Controladores {
    index(req, res) {
        let AGREGAR = false;
        Globales_1.Globales.ERR = [];
        Globales_1.Globales.TOK = [];
        let a = Analizador.parse(req.body.TEXTO);
        Globales_1.Globales.ANALIZADO.forEach(element => {
            if (req.body.NOMBRE == element.Nombre) {
                if (req.body.TEXTO != element.Texto) {
                    element.Texto = req.body.TEXTO;
                    element.ArbolAST = JSON.parse(a);
                    element.TOKENS = Globales_1.Globales.TOK;
                    element.ERRORES = Globales_1.Globales.ERR;
                    AGREGAR = true;
                    return;
                }
                AGREGAR = true;
            }
        });
        if (AGREGAR == false) {
            Globales_1.Globales.ANALIZADO.push(new Analizado_1.Analizado(req.body.NOMBRE, req.body.TEXTO, Globales_1.Globales.TOK, JSON.parse(a), Globales_1.Globales.ERR));
        }
        let SEND_JSON = JSON.stringify({ ArbolAST: [JSON.parse(a)], ERRORES: Globales_1.Globales.ERR, TOKENS: Globales_1.Globales.TOK, ANALIZADO: Globales_1.Globales.ANALIZADO });
        res.json(JSON.parse(SEND_JSON));
    }
}
const controladores = new Controladores();
exports.default = controladores;
