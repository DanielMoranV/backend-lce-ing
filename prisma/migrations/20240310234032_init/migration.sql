/*
  Warnings:

  - Added the required column `eliminado` to the `paciente` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "paciente" ADD COLUMN     "eliminado" BOOLEAN NOT NULL,
ADD COLUMN     "eliminado_en" TIMESTAMP(3),
ADD COLUMN     "estado" TEXT NOT NULL DEFAULT 'activo';
