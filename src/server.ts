import express, { Response, Request } from "express";
import mainRoutes from "./routes/routes";
import dotenv from "dotenv";
import cors from "cors";
import path from "path";


dotenv.config();

const server = express();

server.use(cors());
server.use(express.static(path.join(__dirname, "../public")))
server.use(express.urlencoded({ extended: true }))
server.use('/api', mainRoutes);
server.use((req: Request, res: Response) => {
    res.status(404).json({ message: "Página não encontrada!" })
})

server.listen(process.env.PORT);