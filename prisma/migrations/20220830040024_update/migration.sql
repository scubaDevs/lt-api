/*
  Warnings:

  - Added the required column `id` to the `meeting_appointments` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "meeting_appointments" ADD COLUMN     "id" INTEGER NOT NULL;
