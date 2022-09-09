import { Request } from "express";
import JWT from 'jsonwebtoken';
import dotenv from 'dotenv';
import { prisma } from "../instance/db";

dotenv.config();

export const VerifyToken = {


    execute: async (req: Request) => {

        let access: boolean = false;
        let tokenData: any;
        let expired: boolean;
        let hasToken: boolean = false;

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
                    if (tokenData) {
                        access = true;
                        expired = false;
                        hasToken = true;
                    }

                } catch (err: any) {
                    console.log(1)
                    if (err.name === "TokenExpiredError") {
                        console.log(2)
                        expired = true
                    }
                    console.log(3)
                }
            }
        }
        if (access) {
            console.log(4)
            const user = await prisma.user.findUnique({ where: { email: tokenData.email } })
            return { access, user, tokenData, expired, hasToken };
        } else {
            console.log(5)
            return { access, expired, hasToken }
        }
    }

}