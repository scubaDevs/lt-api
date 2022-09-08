import { Router, Request, Response } from "express";
import { userController } from "../controllers/usercontroller/usercontroller";
import { upload } from '../middlewares/multer/multer';
import { Auth } from "../middlewares/auth/auth";


const route = Router();

//CRUD users endpoints

//endpoint that gets all users on database
//If a specific condition to filter all users are needed, use the controller attached to this route.
route.get('/all', userController.getAllUsers)
//endpoint that gets a user on database
route.get('/', userController.getUser)

//Rotas de Login ***********************************************************************************************************************
//Depois envia o token  para o endpoint de Login do usuário, ou então envia as informações a serem validadas para criação de um novo RefreshToken.
route.post('/login', userController.login)

// Solicitar novo RefreshToken

route.post('/rt', userController.newRefreshToken);

//*****************************************************************************************************************************

//endpoint that updates a user on database
route.put('/user', userController.updateUser)
//endpoint that creates a new user on database
route.post('/', userController.newUser)
//endpoint to delete a user on databe
route.delete('/user', userController.delUser)
//endpoint to upload an unique image
route.post('/upload', upload.single('image'), userController.uploadImage)





export default route;

