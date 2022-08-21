import { prisma } from "../../instance/db"
import { Request, Response } from "express";




//testing githubrepo

//Falta fazer a validação das informações
export const userController = {
    //create new user on database
    newUser: async (req: Request, res: Response) => {
        const {
            name,
            surname,
            email,
            password,
            age,
            avatar,
            whatsapp,
            eng_level,
            customer,
            native_lang,
            country,
            city,
            role
        } = req.body

        //Fixing prisma bug.There is a bug on prisma that dosen´t parse body string values to boolean values before save on database.
        let nCustomer = false
        if (customer === 'true') {
            nCustomer = true;
        } else {
            nCustomer = false;
        }

        try {
            const newUser = await prisma.user.create({
                data: {
                    name: name,
                    surname: surname,
                    email: email,
                    password: password,
                    age: age,
                    avatar: avatar,
                    whatsapp: whatsapp,
                    eng_level: eng_level,
                    customer: nCustomer,
                    native_lang: native_lang,
                    country: country,
                    city: city,
                    role: role
                }
            })

            res.status(200).json({ message: `Usuário criado com sucesso: ${newUser}` })
        } catch (Error) {
            console.log(Error);
            res.status(500).json({ message: 'Não deu certo!', error: Error })
        }
    },

    getAllUsers: async (req: Request, res: Response) => {
        const allUsers = await prisma.user.findMany()
        if (allUsers) {
            res.status(200).json({ status: true, allUsers })
            return
        }
        res.status(500).json({ status: false })
    },

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
    }
}
