import { Router } from 'express';
import controladores from './Controlador'
class Rutas{
    public router:Router=Router();
    constructor(){
        this.config();
    }
    config():void{
        //this.router.get('/:Texto',controladores.index);
        this.router.post('/',controladores.index);
    }
}
const rutas=new Rutas();
export default rutas.router;