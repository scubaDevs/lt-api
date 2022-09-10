import { prisma } from "../../instance/db"
import { Request, Response } from "express";
import * as s3 from "../../instance/s3";
import { PutObjectCommand } from "@aws-sdk/client-s3";
import { v4 as uuidv4 } from 'uuid';
import dotenv from "dotenv";
import { GenerateRefreshToken } from '../../provider/GenerateRefreshToken';
import { GenerateToken } from "../../provider/GenerateToken";
import { VerifyRefreshToken } from "../../provider/VerifyRefreshToken";
import JWT, { JwtPayload } from "jsonwebtoken";
import { VerifyToken } from "../../provider/VerifyToken";
import { TokenType } from "../../types/usercontrollerTypes";
import { VerifyIfHasUser } from "../../provider/VerifyIfHas]user";







dotenv.config();






//testing githubrepo

//Falta fazer a validação das informações
export const userController = {
    //create new user on database
    newUser: async (req: Request, res: Response) => {


        if (req.body.email && req.body.password) {
            let { name, surname, email, password, fakeName, level, selectedCountry, phone, allData } = req.body;
            let hasUser = await prisma.user.findUnique({ where: { email } })

            if (!hasUser) {

                let newUser = await prisma.user.create({
                    data: {
                        name: name,
                        surname: surname,
                        email: email,
                        password: password,
                        whatsapp: phone,
                        eng_level: level,
                        country: selectedCountry,
                        fake_name: fakeName,
                        MeetingAppointments: {
                            createMany: {
                                data: allData,
                            }
                        }
                    }
                })
                // create a newToken for the newUser
                const token: string = await GenerateToken.execute(newUser.id_user, newUser.email, newUser.password)
                // create a newRefreshToken for the newUser
                const refreshToken: string = await GenerateRefreshToken.execute(newUser.id_user)

                return res.status(201).json({ status: true, userId: newUser.id_user, token, refreshToken })

            } else {
                return res.status(409).json({ status: false, error: "Usuário já cadastrado!" })
            }
        }
    },
    //Getting all users on database
    getAllUsers: async (req: Request, res: Response) => {
        const allUsers = await prisma.user.findMany()
        if (allUsers) {
            res.status(200).json({ status: true, allUsers })
            return
        }
        res.status(500).json({ status: false })
    },
    //Getting one user on database
    getUser: async (req: Request, res: Response) => {
        const { id } = req.query

        const getUser = await prisma.user.findUnique({
            where: {
                id_user: id as string
            }
        })
        if (getUser) {
            res.status(200).json({ Message: 'Usuário foi encontrado!', getUser })
            return
        }

        res.status(500).json({ Message: 'Usuário não encontrado!', error: Error })

    },
    login: async (req: Request, res: Response) => {
        const authData = await VerifyToken.execute(req);
        const email: string = req.body.email;
        const password: string = req.body.password;
        console.log(6)
        console.log(authData)
        if (authData.hasToken === true && (!email || !password)) {
            console.log(7)
            if (authData.access === true && authData) {
                console.log(8)
                return res.status(200).json({ status: true, userId: authData.user.id_user })
            }
            if ((authData.access === false) && (authData.expired)) {
                console.log(9)
                return res.status(403).json({ status: false, tokenExpired: authData.expired, msg: "Token Expirado" })
            } else {
                console.log(10)
                return res.status(403).json({ status: false, tokenExpired: authData.expired, invalidToken: true, msg: "Token inválido" })
            }
        }
        if (authData.hasToken && req.body.email && req.body.password) {

            const hasUser = await VerifyIfHasUser.execute(email, password);
            if (hasUser.status === true && hasUser.user) {
                return res.status(200).json({ status: true, userId: hasUser.user.id_user, refreshToken: hasUser.refreshToken, token: hasUser.token });
            }
        }
        return res.status(403).json({ status: false, msg: "Informações de Auth inválidas." })
    },
    //Renovação do RefreshToken
    newRefreshToken: async (req: Request, res: Response) => {
        const refreshToken: string = req.body.refreshToken;

        if (refreshToken) {
            console.log(refreshToken)
            const verification = await VerifyRefreshToken.execute(refreshToken);
            if (verification && verification.value) {
                if (verification.value === true) {
                    if (verification.dataToken !== null) {
                        const newRefreshToken: string = await GenerateRefreshToken.execute(verification.dataToken.id_user)
                        const newToken: string = await GenerateToken.execute(verification.dataToken.id_user)
                        return res.status(200).json({ wasValid: true, newRefreshToken, newToken })
                    }
                    return res.status(403).json({ wasValid: false, msg: "Invalid RefreshToken" })
                } else {
                    if (verification.value === null) {
                        return res.status(403).json({ wasValid: false, msg: "Invalid RefreshToken" })
                    }
                    if (verification.dataToken !== null) {
                        const newRefreshToken: string = await GenerateRefreshToken.execute(verification.dataToken.id_user)
                        const newToken: string = await GenerateToken.execute(verification.dataToken.id_user)
                        return res.status(200).json({ wasValid: true, newRefreshToken, newToken })
                    }
                }


            }
        }
        return res.status(403).json({ wasValid: false, msg: "Invalid RefreshToken bla" })
    },
    //Updating one user on database
    updateUser: async (req: Request, res: Response) => {
        const { email } = req.body
        const { id } = req.query


        try {
            const updatedUser = await prisma.user.update({
                where: {
                    id_user: id as string
                },
                data: {
                    email: email as string
                }

            })
            if (updatedUser) {
                res.status(200).json({ status: true, updatedUser })
                return
            }

        } catch (Error) {
            res.status(500).json({ status: false, error: Error })
        }




    },
    //Deleting one user from database
    delUser: async (req: Request, res: Response) => {
        const { id } = req.query
        try {
            const deletedUser = await prisma.user.delete({
                where: {
                    id_user: id as string
                }
            })
            if (deletedUser) {
                res.status(200).json({ status: true, deletedUser })
                return
            }
        } catch (Error) {
            res.status(500).json({ msg: 'User was note deleted', error: Error })
        }
    },
    //Uploading for the first time an image
    uploadImage: async (req: Request, res: Response) => {

        if (req.file) {
            console.log('req.body', req.body)
            console.log('req.file', req.file)

            console.log('req.file.buffer', req.file.buffer)
            const randomImageName = uuidv4()
            const params = {
                Bucket: s3.s3BucketName as string,
                Key: randomImageName as string,
                Body: req.file.buffer,
                ContentType: req.file.mimetype as string,
            }
            const command = new PutObjectCommand(params)
            try {
                await s3.s3Instance.send(command)

            } catch (Error) {
                console.log("O erro é este: ", Error)
            }



            res.send({})
        } else {
            res.status(500).json({ message: 'req.file is undifined.', Error: Error })
        }


    }
}
