-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'ADMIN');

-- CreateTable
CREATE TABLE "users" (
    "id_user" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "avatar" TEXT,
    "whatsapp" TEXT NOT NULL,
    "eng_level" TEXT NOT NULL,
    "customer" BOOLEAN NOT NULL DEFAULT false,
    "native_lang" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id_user")
);

-- CreateTable
CREATE TABLE "payments" (
    "id_payments" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id_payments")
);

-- CreateTable
CREATE TABLE "feedbacks" (
    "id_feedback" TEXT NOT NULL,
    "id_receiver" TEXT NOT NULL,
    "id_author" TEXT NOT NULL,
    "feedback" TEXT NOT NULL,
    "reply" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "feedbacks_pkey" PRIMARY KEY ("id_feedback")
);

-- CreateTable
CREATE TABLE "meeting_appointments" (
    "id_meeting" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "start_meeting" TIMETZ NOT NULL,
    "end_meeting" TIMETZ NOT NULL,
    "week_day" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "meeting_appointments_pkey" PRIMARY KEY ("id_meeting")
);

-- CreateTable
CREATE TABLE "connections" (
    "id_connections" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "Id_friend" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "connections_pkey" PRIMARY KEY ("id_connections")
);

-- CreateTable
CREATE TABLE "users_challenges" (
    "id_user_challenge" TEXT NOT NULL,
    "id_challenge" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_challenges_pkey" PRIMARY KEY ("id_user_challenge")
);

-- CreateTable
CREATE TABLE "classes" (
    "id_class" TEXT NOT NULL,
    "id_challenge" TEXT NOT NULL,
    "users_number" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "classes_pkey" PRIMARY KEY ("id_class")
);

-- CreateTable
CREATE TABLE "classes_on_users_on_challenges" (
    "id_class_users_on_challenges" TEXT NOT NULL,
    "id_class" TEXT NOT NULL,
    "id_user_challenge" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "classes_on_users_on_challenges_pkey" PRIMARY KEY ("id_class_users_on_challenges")
);

-- CreateTable
CREATE TABLE "abandoned_classes" (
    "id_abandoned" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "id_class" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "abandoned_classes_pkey" PRIMARY KEY ("id_abandoned")
);

-- CreateTable
CREATE TABLE "concluded_classes" (
    "id_concluded_class" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "id_class" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "concluded_classes_pkey" PRIMARY KEY ("id_concluded_class")
);

-- CreateTable
CREATE TABLE "favorites" (
    "id_favorite" TEXT NOT NULL,
    "id_challenge" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "favorites_pkey" PRIMARY KEY ("id_favorite")
);

-- CreateTable
CREATE TABLE "likes" (
    "id_like" TEXT NOT NULL,
    "id_challenge" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "likes_pkey" PRIMARY KEY ("id_like")
);

-- CreateTable
CREATE TABLE "fake_users" (
    "id_fake_user" TEXT NOT NULL,
    "id_user" TEXT NOT NULL,
    "fake_name" TEXT NOT NULL,
    "have_fake_children" BOOLEAN DEFAULT false,
    "number_fake_children" INTEGER,
    "have_fake_marriage" BOOLEAN NOT NULL DEFAULT false,
    "fake_partner_name" TEXT,
    "have_fake_friends" BOOLEAN NOT NULL DEFAULT false,
    "number_fake_friends" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "fake_users_pkey" PRIMARY KEY ("id_fake_user")
);

-- CreateTable
CREATE TABLE "fake_childrens" (
    "id_fake_chil_names" TEXT NOT NULL,
    "id_fake_user" TEXT NOT NULL,
    "fake_chil_gender" TEXT NOT NULL,
    "fake_chil_name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "fake_childrens_pkey" PRIMARY KEY ("id_fake_chil_names")
);

-- CreateTable
CREATE TABLE "fake_friends" (
    "id_fake_friends" TEXT NOT NULL,
    "id_fake_user" TEXT NOT NULL,
    "fake_friend_gender" TEXT NOT NULL,
    "fake_friend_name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "fake_friends_pkey" PRIMARY KEY ("id_fake_friends")
);

-- CreateTable
CREATE TABLE "challenges" (
    "id_challenge" TEXT NOT NULL,
    "image_cover" TEXT NOT NULL,
    "tittle" TEXT NOT NULL,
    "sub_tittle" TEXT,
    "language" TEXT,
    "level" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "premium" BOOLEAN NOT NULL DEFAULT true,
    "min_users" INTEGER NOT NULL,
    "max_users" INTEGER NOT NULL,
    "expected_duration" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "challenges_pkey" PRIMARY KEY ("id_challenge")
);

-- CreateTable
CREATE TABLE "ty_sugestions" (
    "id_ty_sugestion" TEXT NOT NULL,
    "sugestion" TEXT NOT NULL,
    "id_challenge" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ty_sugestions_pkey" PRIMARY KEY ("id_ty_sugestion")
);

-- CreateTable
CREATE TABLE "subjects" (
    "id_subject" TEXT NOT NULL,
    "subject" TEXT NOT NULL,
    "id_challenge" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "subjects_pkey" PRIMARY KEY ("id_subject")
);

-- CreateTable
CREATE TABLE "tasks" (
    "id_task" TEXT NOT NULL,
    "id_challenge" TEXT NOT NULL,
    "skill" TEXT NOT NULL,
    "task_title" TEXT NOT NULL,
    "task_description" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tasks_pkey" PRIMARY KEY ("id_task")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "fake_users_id_user_key" ON "fake_users"("id_user");

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedbacks" ADD CONSTRAINT "feedbacks_id_receiver_fkey" FOREIGN KEY ("id_receiver") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedbacks" ADD CONSTRAINT "feedbacks_id_author_fkey" FOREIGN KEY ("id_author") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "meeting_appointments" ADD CONSTRAINT "meeting_appointments_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "connections" ADD CONSTRAINT "connections_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "connections" ADD CONSTRAINT "connections_Id_friend_fkey" FOREIGN KEY ("Id_friend") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_challenges" ADD CONSTRAINT "users_challenges_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_challenges" ADD CONSTRAINT "users_challenges_id_challenge_fkey" FOREIGN KEY ("id_challenge") REFERENCES "challenges"("id_challenge") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "classes" ADD CONSTRAINT "classes_id_challenge_fkey" FOREIGN KEY ("id_challenge") REFERENCES "challenges"("id_challenge") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "classes_on_users_on_challenges" ADD CONSTRAINT "classes_on_users_on_challenges_id_class_fkey" FOREIGN KEY ("id_class") REFERENCES "classes"("id_class") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "classes_on_users_on_challenges" ADD CONSTRAINT "classes_on_users_on_challenges_id_user_challenge_fkey" FOREIGN KEY ("id_user_challenge") REFERENCES "users_challenges"("id_user_challenge") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "abandoned_classes" ADD CONSTRAINT "abandoned_classes_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "abandoned_classes" ADD CONSTRAINT "abandoned_classes_id_class_fkey" FOREIGN KEY ("id_class") REFERENCES "classes"("id_class") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "concluded_classes" ADD CONSTRAINT "concluded_classes_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "concluded_classes" ADD CONSTRAINT "concluded_classes_id_class_fkey" FOREIGN KEY ("id_class") REFERENCES "classes"("id_class") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorites" ADD CONSTRAINT "favorites_id_challenge_fkey" FOREIGN KEY ("id_challenge") REFERENCES "challenges"("id_challenge") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "likes" ADD CONSTRAINT "likes_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "likes" ADD CONSTRAINT "likes_id_challenge_fkey" FOREIGN KEY ("id_challenge") REFERENCES "challenges"("id_challenge") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fake_users" ADD CONSTRAINT "fake_users_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fake_childrens" ADD CONSTRAINT "fake_childrens_id_fake_user_fkey" FOREIGN KEY ("id_fake_user") REFERENCES "fake_users"("id_fake_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fake_friends" ADD CONSTRAINT "fake_friends_id_fake_user_fkey" FOREIGN KEY ("id_fake_user") REFERENCES "fake_users"("id_fake_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ty_sugestions" ADD CONSTRAINT "ty_sugestions_id_challenge_fkey" FOREIGN KEY ("id_challenge") REFERENCES "challenges"("id_challenge") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subjects" ADD CONSTRAINT "subjects_id_challenge_fkey" FOREIGN KEY ("id_challenge") REFERENCES "challenges"("id_challenge") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_id_challenge_fkey" FOREIGN KEY ("id_challenge") REFERENCES "challenges"("id_challenge") ON DELETE RESTRICT ON UPDATE CASCADE;
