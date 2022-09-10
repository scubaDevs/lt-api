import { prisma } from "../instance/db";
import dayjs from 'dayjs';




const GenerateRefreshToken = {
    execute: async (id_user: string) => {
        const currentRefreshToken = await prisma.refreshToken.findUnique({ where: { id_user: id_user } })
        const expiresIn = dayjs().add(30, "days").unix();
        if (currentRefreshToken) {

            await prisma.refreshToken.delete({ where: { id_refreshToken: currentRefreshToken.id_refreshToken } });


            const newRefreshToken = await prisma.refreshToken.create({
                data: {
                    id_user,
                    expiresIn
                }
            })
            return newRefreshToken.id_refreshToken;

        } else {


            const newRefreshToken = await prisma.refreshToken.create({
                data: {
                    id_user,
                    expiresIn
                }
            })
            return newRefreshToken.id_refreshToken;
        }
    }
}

export { GenerateRefreshToken };