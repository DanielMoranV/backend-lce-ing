-- AlterTable
ALTER TABLE "paciente" ALTER COLUMN "eliminado" DROP NOT NULL,
ALTER COLUMN "eliminado" SET DEFAULT false;
