-- CreateTable
CREATE TABLE "refresh_token" (
    "id_refreshToken" TEXT NOT NULL,
    "expiresIn" INTEGER NOT NULL,
    "id_user" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "refresh_token_pkey" PRIMARY KEY ("id_refreshToken")
);

-- CreateIndex
CREATE UNIQUE INDEX "refresh_token_id_user_key" ON "refresh_token"("id_user");

-- AddForeignKey
ALTER TABLE "refresh_token" ADD CONSTRAINT "refresh_token_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;
