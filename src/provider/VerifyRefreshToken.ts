import dayjs from "dayjs";
import { prisma } from "../instance/db";

export const VerifyRefreshToken = {
    execute: async (id_refreshToken: string) => {
        const currentRefreshToken = await prisma.refreshToken.findFirst({ where: { id_refreshToken } })
        const expiration = dayjs().unix(); //tempo agora
        if (currentRefreshToken) {
            if (currentRefreshToken.expiresIn > expiration) {
                //refreshToken válido
                return { value: true, dataToken: currentRefreshToken };
            } else {
                //refreshToken não existe no banco
                if (currentRefreshToken === null) {
                    return { value: false, dataToken: null }
                }
                // RefreshToken expirado
                return { value: true, dataToken: currentRefreshToken }
            }
        }
    }

}


