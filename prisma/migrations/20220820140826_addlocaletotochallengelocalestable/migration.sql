/*
  Warnings:

  - Added the required column `locale` to the `Challenge_Locale` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Challenge_Locale" ADD COLUMN     "locale" TEXT NOT NULL;
