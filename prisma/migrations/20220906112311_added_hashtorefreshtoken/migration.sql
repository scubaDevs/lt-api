/*
  Warnings:

  - Added the required column `hash` to the `refresh_token` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "refresh_token" ADD COLUMN     "hash" TEXT NOT NULL;
