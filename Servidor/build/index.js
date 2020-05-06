"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const Rutas_1 = __importDefault(require("./Rutas"));
const morgan_1 = __importDefault(require("morgan"));
const cors_1 = __importDefault(require("cors"));
class Servidor {
    constructor() {
        this.app = express_1.default();
        this.config();
        this.routes();
    }
    config() {
        this.app.set('port', 3000);
        this.app.use(morgan_1.default('dev'));
        this.app.use(cors_1.default());
        this.app.use(express_1.default.json());
    }
    routes() {
        this.app.use('/C1P2', Rutas_1.default);
        //Puedo tener mas rutas de otras clases
    }
    inicio() {
        this.app.listen(this.app.get('port'), () => {
            console.log("SE INICIO EL SERVIDOR EN PUERTO " + this.app.get('port'));
        });
    }
}
const Server = new Servidor();
Server.inicio();
