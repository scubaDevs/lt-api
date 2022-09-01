/*
  Warnings:

  - You are about to drop the column `end_meeting` on the `meeting_appointments` table. All the data in the column will be lost.
  - You are about to drop the column `start_meeting` on the `meeting_appointments` table. All the data in the column will be lost.
  - Added the required column `value` to the `meeting_appointments` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "meeting_appointments" DROP COLUMN "end_meeting",
DROP COLUMN "start_meeting",
ADD COLUMN     "value" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "age" DROP NOT NULL,
ALTER COLUMN "native_lang" DROP NOT NULL,
ALTER COLUMN "city" DROP NOT NULL;
