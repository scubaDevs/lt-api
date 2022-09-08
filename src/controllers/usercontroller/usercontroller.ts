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

                return res.status(201).json({ status: true, newUser, token, refreshToken })

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

        const tokenVerification = await VerifyToken.execute(req);

        if (tokenVerification && tokenVerification.tokenData) {
            const token = req.headers.authorization;
            const tokenData: TokenType = JWT.verify(
                token,
                process.env.JWT_SECRET_KEY as string
            );

            console.log(token)
            const user = await prisma.user.findUnique({ where: { id_user: tokenData.id } })
            res.status(200).json({ status: true, expired: false, })
        }

    },/*  else if() {


    } else {


    } */

    /*       console.log(token)
          if(token) {
          let tokenData
          try {
              tokenData = JWT.verify(token, process.env.JWT_SECRET_KEY as string);
  
          } catch (err) {
              if (err) {
                  tokenData = false
              } else {
                  tokenData = true
              }
          }
  
          console.log(tokenData)
          if (tokenData) {
              if (req.body.email && req.body.password) {
                  const email: string = req.body.email;
                  const password: string = req.body.password;
  
                  const user = await prisma.user.findUnique({ where: { email } })
  
                  if (user && user.password === password) {
                      return res.status(200).json({ status: true, Message: "Usuário foi logado com sucesso bl bla ba!" })
                  }
              }
          }
          return res.status(403).json({ status: false, expired: true, message: "Token expirou." })
      }
  
          return res.status(403).json({ status: false, expired: false, message: "Informações de auth inválidas." }); 

},*/
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
