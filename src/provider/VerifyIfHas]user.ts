import { prisma } from "../instance/db"
import { GenerateRefreshToken } from "./GenerateRefreshToken";
import { GenerateToken } from "./GenerateToken";

export const VerifyIfHasUser = {
    execute: async (email: string, password: string) => {
        const user = await prisma.user.findUnique({ where: { email } });
        if (user && (password === user.password)) {
            const refreshToken = await GenerateRefreshToken.execute(user.id_user);
            const token = await GenerateToken.execute(user.id_user);
            return { status: true, user: user, refreshToken, token };
        }

        return { status: false }
    }
}