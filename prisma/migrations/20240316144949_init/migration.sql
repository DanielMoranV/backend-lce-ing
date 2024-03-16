/*
  Warnings:

  - Made the column `positionId` on table `user` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "user" DROP CONSTRAINT "user_positionId_fkey";

-- AlterTable
ALTER TABLE "user" ALTER COLUMN "positionId" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "company_position"("position_id") ON DELETE RESTRICT ON UPDATE CASCADE;
