/*
  Warnings:

  - Made the column `age` on table `users` required. This step will fail if there are existing NULL values in that column.
  - Made the column `customer` on table `users` required. This step will fail if there are existing NULL values in that column.
  - Made the column `role` on table `users` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "users" ALTER COLUMN "age" SET NOT NULL,
ALTER COLUMN "customer" SET NOT NULL,
ALTER COLUMN "role" SET NOT NULL;
