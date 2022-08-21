/*
  Warnings:

  - You are about to drop the `Challenge_Locale` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Challenge_Locale" DROP CONSTRAINT "Challenge_Locale_id_challenge_fkey";

-- DropTable
DROP TABLE "Challenge_Locale";

-- CreateTable
CREATE TABLE "challenge_locales" (
    "id_challenge_locales" TEXT NOT NULL,
    "locale" TEXT NOT NULL,
    "tittle" TEXT NOT NULL,
    "sub_tittle" TEXT,
    "description" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "id_challenge" TEXT NOT NULL,

    CONSTRAINT "challenge_locales_pkey" PRIMARY KEY ("id_challenge_locales")
);

-- AddForeignKey
ALTER TABLE "challenge_locales" ADD CONSTRAINT "challenge_locales_id_challenge_fkey" FOREIGN KEY ("id_challenge") REFERENCES "challenges"("id_challenge") ON DELETE RESTRICT ON UPDATE CASCADE;
