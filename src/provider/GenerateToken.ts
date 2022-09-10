import { prisma } from "../instance/db";
import JWT from "jsonwebtoken";

const GenerateToken = {
    execute: async (id: string, email?: string, pass?: string) => {
        const user = await prisma.user.findUnique({ where: { id_user: id } })
        if (user != null) {

            const newToken = JWT.sign(
                {
                    id: user.id_user,
                    email: user.email,
                    password: user.password
                },
                process.env.JWT_SECRET_KEY as string,
                { expiresIn: '2h' }
            );
            return newToken;
        } else {

            const newToken = JWT.sign(
                {
                    id: id,
                    email: email,
                    password: pass
                },
                process.env.JWT_SECRET_KEY as string,
                { expiresIn: '2h' }
            );
            return newToken;
        }
    }
}
export { GenerateToken };