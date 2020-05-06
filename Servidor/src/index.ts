import express,{Application} from 'express';
import rutas from './Rutas';
import morgan from 'morgan';
import cors from 'cors';
class Servidor{
    public app:Application;
    
    constructor(){
        this.app=express();
        this.config();
        this.routes();
    }
    config(){
        this.app.set('port',3000);
        this.app.use(morgan('dev'));
        this.app.use(cors());
        this.app.use(express.json());
    }
    routes(){
        this.app.use('/C1P2',rutas);
        //Puedo tener mas rutas de otras clases
    }
    inicio(){
        this.app.listen(this.app.get('port'),()=>{
            console.log("SE INICIO EL SERVIDOR EN PUERTO "+this.app.get('port'));
        });
    }
}
const Server=new Servidor();
Server.inicio();