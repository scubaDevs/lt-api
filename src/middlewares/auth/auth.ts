import { Request, Response, NextFunction } from "express";
import JWT from 'jsonwebtoken';
import dotenv from 'dotenv';

dotenv.config();

export const Auth = {

    //Private Route Middleware
    private: async (req: Request, res: Response, next: NextFunction) => {

        let sucess = false;

        //Fazer verificação de auth
        if (req.headers.authorization) {

            //Bearer kljdjdjlkd  - Abaixo estamos dividindo o token separando o token do Bearer pelo espaço

            const [authType, token] = req.headers.authorization.split(" ");
            if (authType === 'Bearer') {
                try {
                    const decoded = JWT.verify(
                        token,
                        process.env.JWT_SECRET_KEY as string
                    );
                    sucess = true;
                } catch (error) {

                }

            }


        }

        if (sucess) {
            next();
        } else {
            res.status(403).json({ error: "Não autorizado." })
        }
    }
}