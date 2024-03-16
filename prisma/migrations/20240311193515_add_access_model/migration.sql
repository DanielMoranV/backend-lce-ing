/*
  Warnings:

  - You are about to drop the column `active` on the `acceso_colaborador` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `acceso_colaborador` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "acceso_colaborador" DROP COLUMN "active",
DROP COLUMN "status",
ADD COLUMN     "activo" BOOLEAN DEFAULT true,
ADD COLUMN     "estado" TEXT;

-- CreateTable
CREATE TABLE "acceso_paciente" (
    "acceso_colaborador_id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "estado" TEXT,
    "activo" BOOLEAN DEFAULT true,
    "last_session" TIMESTAMP(3),
    "create_at" TIMESTAMP(3),
    "paciente_id" INTEGER NOT NULL,

    CONSTRAINT "acceso_paciente_pkey" PRIMARY KEY ("acceso_colaborador_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "acceso_paciente_username_key" ON "acceso_paciente"("username");

-- CreateIndex
CREATE UNIQUE INDEX "acceso_paciente_paciente_id_key" ON "acceso_paciente"("paciente_id");

-- AddForeignKey
ALTER TABLE "acceso_paciente" ADD CONSTRAINT "acceso_paciente_paciente_id_fkey" FOREIGN KEY ("paciente_id") REFERENCES "paciente"("paciente_id") ON DELETE RESTRICT ON UPDATE CASCADE;
