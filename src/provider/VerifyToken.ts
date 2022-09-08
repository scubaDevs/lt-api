import { Request } from "express";
import JWT from 'jsonwebtoken';
import dotenv from 'dotenv';

dotenv.config();

export const VerifyToken = {


    execute: async (req: Request) => {

        let sucess: boolean | undefined = false;
        let tokenData;

        //Fazer verificação do token
        if (req.headers.authorization) {

            //Bearer token  - Abaixo estamos dividindo o token separando o token do Bearer pelo espaço

            const [authType, token] = req.headers.authorization.split(" ");

            if (authType === 'Bearer') {

                try {
                    tokenData = JWT.verify(
                        token,
                        process.env.JWT_SECRET_KEY as string
                    );
                    sucess = true;
                } catch (err: any) {
                    if (err.name === 'jwt expired') {
                        sucess = false
                    } else {
                        sucess = undefined
                    }
                }
            }
        }
        if (sucess) {
            return { sucess, tokenData };
        } else {
            return sucess
        }
    }

}