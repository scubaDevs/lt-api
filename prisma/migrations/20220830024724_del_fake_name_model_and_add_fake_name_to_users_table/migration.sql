/*
  Warnings:

  - You are about to drop the `fake_childrens` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `fake_friends` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `fake_users` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `fake_name` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "fake_childrens" DROP CONSTRAINT "fake_childrens_id_fake_user_fkey";

-- DropForeignKey
ALTER TABLE "fake_friends" DROP CONSTRAINT "fake_friends_id_fake_user_fkey";

-- DropForeignKey
ALTER TABLE "fake_users" DROP CONSTRAINT "fake_users_id_user_fkey";

-- AlterTable
ALTER TABLE "users" ADD COLUMN     "fake_name" TEXT NOT NULL;

-- DropTable
DROP TABLE "fake_childrens";

-- DropTable
DROP TABLE "fake_friends";

-- DropTable
DROP TABLE "fake_users";
