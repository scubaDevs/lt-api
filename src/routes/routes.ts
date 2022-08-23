import { Router, Request, Response } from "express";
import { userController } from "../controllers/usercontroller/usercontroller";
import { upload } from '../middlewares/multer/multer';


const route = Router();

//CRUD users endpoints

//endpoint that gets all users on database
//If a specific condition to filter all users are needed, use the controller attached to this route.
route.get('/all', userController.getAllUsers)
//endpoint that gets a user on database
route.get('/', userController.getUser)
//endpoint that updates a user on database
route.put('/user', userController.updateUser)
//endpoint that creates a new user on database
route.post('/', userController.newUser)
//endpoint to delete a user on databe
route.delete('/user', userController.delUser)
//endpoint to upload an unique image
route.post('/upload', upload.single('image'), userController.uploadImage)





export default route;

