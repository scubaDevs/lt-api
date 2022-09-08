import { JwtPayload } from "jsonwebtoken"

export type SchadualeType = {
    schaduale: { id: number, value: string, name: string }
}

export interface TokenType extends JwtPayload {

    id: string;
    email: string;
    password: string

}