import { prisma } from "../../instance/db"
import { Request, Response } from "express";
import * as s3 from "../../instance/s3";
import { PutObjectCommand } from "@aws-sdk/client-s3";
import { v4 as uuidv4 } from 'uuid';
import { SchadualeType } from "../../types/usercontrollerTypes";






//testing githubrepo

//Falta fazer a validação das informações
export const userController = {
    //create new user on database
    newUser: async (req: Request, res: Response) => {

        console.log(req.body)

        /*      const {
                 name,
                 surname,
                 email,
                 password,
                 fakeName,
                 level,
                 allData,
                 selectedCountry,
                 phone
     
             } = req.body
     
     
     
     
             //Fixing prisma bug.There is a bug on prisma that dosen´t parse body string values to boolean values before save on database.
             /*        let nCustomer = false
                    if (customer === 'true') {
                        nCustomer = true;
                    } else {
                        nCustomer = false;
                    } */
        /* 
                try {
                    const newUser = await prisma.user.create({
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

        res.status(200).json({ message: `Usuário criado com sucesso: ${JSON.stringify(newUser)}` })
    } catch(Error) {
        console.log(Error);
        res.status(500).json({ message: 'Não deu certo!', error: Error })
    }
    */ },
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
