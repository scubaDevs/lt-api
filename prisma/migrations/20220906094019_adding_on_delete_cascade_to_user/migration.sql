-- DropForeignKey
ALTER TABLE "abandoned_classes" DROP CONSTRAINT "abandoned_classes_id_user_fkey";

-- DropForeignKey
ALTER TABLE "concluded_classes" DROP CONSTRAINT "concluded_classes_id_user_fkey";

-- DropForeignKey
ALTER TABLE "connections" DROP CONSTRAINT "connections_Id_friend_fkey";

-- DropForeignKey
ALTER TABLE "connections" DROP CONSTRAINT "connections_id_user_fkey";

-- DropForeignKey
ALTER TABLE "favorites" DROP CONSTRAINT "favorites_id_user_fkey";

-- DropForeignKey
ALTER TABLE "feedbacks" DROP CONSTRAINT "feedbacks_id_author_fkey";

-- DropForeignKey
ALTER TABLE "feedbacks" DROP CONSTRAINT "feedbacks_id_receiver_fkey";

-- DropForeignKey
ALTER TABLE "likes" DROP CONSTRAINT "likes_id_user_fkey";

-- DropForeignKey
ALTER TABLE "meeting_appointments" DROP CONSTRAINT "meeting_appointments_id_user_fkey";

-- DropForeignKey
ALTER TABLE "payments" DROP CONSTRAINT "payments_id_user_fkey";

-- DropForeignKey
ALTER TABLE "refresh_token" DROP CONSTRAINT "refresh_token_id_user_fkey";

-- DropForeignKey
ALTER TABLE "users_challenges" DROP CONSTRAINT "users_challenges_id_user_fkey";

-- AddForeignKey
ALTER TABLE "refresh_token" ADD CONSTRAINT "refresh_token_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedbacks" ADD CONSTRAINT "feedbacks_id_receiver_fkey" FOREIGN KEY ("id_receiver") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedbacks" ADD CONSTRAINT "feedbacks_id_author_fkey" FOREIGN KEY ("id_author") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "meeting_appointments" ADD CONSTRAINT "meeting_appointments_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "connections" ADD CONSTRAINT "connections_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "connections" ADD CONSTRAINT "connections_Id_friend_fkey" FOREIGN KEY ("Id_friend") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_challenges" ADD CONSTRAINT "users_challenges_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "abandoned_classes" ADD CONSTRAINT "abandoned_classes_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "concluded_classes" ADD CONSTRAINT "concluded_classes_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "likes" ADD CONSTRAINT "likes_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE CASCADE ON UPDATE CASCADE;
