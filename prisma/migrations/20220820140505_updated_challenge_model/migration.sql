/*
  Warnings:

  - You are about to drop the column `description` on the `challenges` table. All the data in the column will be lost.
  - You are about to drop the column `sub_tittle` on the `challenges` table. All the data in the column will be lost.
  - You are about to drop the column `tittle` on the `challenges` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "challenges" DROP COLUMN "description",
DROP COLUMN "sub_tittle",
DROP COLUMN "tittle",
ALTER COLUMN "max_users" DROP NOT NULL;

-- CreateTable
CREATE TABLE "Challenge_Locale" (
    "id_challenge_locales" TEXT NOT NULL,
    "tittle" TEXT NOT NULL,
    "sub_tittle" TEXT,
    "description" TEXT NOT NULL,
    "id_challenge" TEXT NOT NULL,

    CONSTRAINT "Challenge_Locale_pkey" PRIMARY KEY ("id_challenge_locales")
);

-- AddForeignKey
ALTER TABLE "Challenge_Locale" ADD CONSTRAINT "Challenge_Locale_id_challenge_fkey" FOREIGN KEY ("id_challenge") REFERENCES "challenges"("id_challenge") ON DELETE RESTRICT ON UPDATE CASCADE;
