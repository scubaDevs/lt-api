/*
  Warnings:

  - You are about to drop the column `week_day` on the `meeting_appointments` table. All the data in the column will be lost.
  - Added the required column `name` to the `meeting_appointments` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "meeting_appointments" DROP COLUMN "week_day",
ADD COLUMN     "name" TEXT NOT NULL;
