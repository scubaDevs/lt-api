import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3';
import dotenv from 'dotenv';

dotenv.config()

export const s3BucketName = process.env.BUCKET_NAME as string;
export const s3BucketRegion = process.env.BUCKET_REGION;
export const s3AccessKey = process.env.ACESS_KEY;
export const s3SecretAccessKey = process.env.SECRET_ACESS_KEY;

export const s3Instance = new S3Client({
    credentials: {

        accessKeyId: s3AccessKey as string,
        secretAccessKey: s3SecretAccessKey as string

    },
    region: s3BucketRegion as string
});

