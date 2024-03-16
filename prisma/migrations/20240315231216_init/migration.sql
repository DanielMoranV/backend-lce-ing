/*
  Warnings:

  - You are about to drop the `acceso_colaborador` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `acceso_paciente` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `area_empresa` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `cargo_empresa` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `colaborador` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `dependiente` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `grupos_modulos` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `modulo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `paciente` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `rol` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `rol_por_modulo` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "acceso_colaborador" DROP CONSTRAINT "acceso_colaborador_colaborador_id_fkey";

-- DropForeignKey
ALTER TABLE "acceso_colaborador" DROP CONSTRAINT "acceso_colaborador_rol_id_fkey";

-- DropForeignKey
ALTER TABLE "acceso_paciente" DROP CONSTRAINT "acceso_paciente_paciente_id_fkey";

-- DropForeignKey
ALTER TABLE "cargo_empresa" DROP CONSTRAINT "cargo_empresa_areaId_fkey";

-- DropForeignKey
ALTER TABLE "colaborador" DROP CONSTRAINT "colaborador_cargo_id_fkey";

-- DropForeignKey
ALTER TABLE "dependiente" DROP CONSTRAINT "dependiente_paciente_id_fkey";

-- DropForeignKey
ALTER TABLE "modulo" DROP CONSTRAINT "modulo_grupos_id_fkey";

-- DropForeignKey
ALTER TABLE "rol_por_modulo" DROP CONSTRAINT "rol_por_modulo_grupo_id_fkey";

-- DropForeignKey
ALTER TABLE "rol_por_modulo" DROP CONSTRAINT "rol_por_modulo_rol_id_fkey";

-- DropTable
DROP TABLE "acceso_colaborador";

-- DropTable
DROP TABLE "acceso_paciente";

-- DropTable
DROP TABLE "area_empresa";

-- DropTable
DROP TABLE "cargo_empresa";

-- DropTable
DROP TABLE "colaborador";

-- DropTable
DROP TABLE "dependiente";

-- DropTable
DROP TABLE "grupos_modulos";

-- DropTable
DROP TABLE "modulo";

-- DropTable
DROP TABLE "paciente";

-- DropTable
DROP TABLE "rol";

-- DropTable
DROP TABLE "rol_por_modulo";

-- CreateTable
CREATE TABLE "user" (
    "user_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    " email" TEXT NOT NULL,
    "sex" TEXT NOT NULL,
    "document_type" TEXT NOT NULL,
    "dni" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "profile_photo" TEXT NOT NULL,
    "online" BOOLEAN,
    "deleted" BOOLEAN DEFAULT false,
    "deleted_at" TIMESTAMP(3),
    "positionId" INTEGER,

    CONSTRAINT "user_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "auth" (
    "auth_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "token" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "roleId" INTEGER,

    CONSTRAINT "auth_pkey" PRIMARY KEY ("auth_id")
);

-- CreateTable
CREATE TABLE "role" (
    "rol_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "estado" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "role_pkey" PRIMARY KEY ("rol_id")
);

-- CreateTable
CREATE TABLE "company_position" (
    "position_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "areaId" INTEGER NOT NULL,

    CONSTRAINT "company_position_pkey" PRIMARY KEY ("position_id")
);

-- CreateTable
CREATE TABLE "company_area" (
    "area_id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "company_area_pkey" PRIMARY KEY ("area_id")
);

-- CreateTable
CREATE TABLE "group_of_modules" (
    "group_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "icon" TEXT NOT NULL,

    CONSTRAINT "group_of_modules_pkey" PRIMARY KEY ("group_id")
);

-- CreateTable
CREATE TABLE "module" (
    "module_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "icon" TEXT NOT NULL,
    "grupos_id" INTEGER,

    CONSTRAINT "module_pkey" PRIMARY KEY ("module_id")
);

-- CreateTable
CREATE TABLE "role_by_module" (
    "role_id" INTEGER NOT NULL,
    "module_id" INTEGER NOT NULL,

    CONSTRAINT "role_by_module_pkey" PRIMARY KEY ("role_id","module_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_ email_key" ON "user"(" email");

-- CreateIndex
CREATE UNIQUE INDEX "user_dni_key" ON "user"("dni");

-- CreateIndex
CREATE UNIQUE INDEX "auth_username_key" ON "auth"("username");

-- CreateIndex
CREATE UNIQUE INDEX "role_name_key" ON "role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "company_position_name_key" ON "company_position"("name");

-- CreateIndex
CREATE UNIQUE INDEX "company_area_nombre_key" ON "company_area"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "group_of_modules_name_key" ON "group_of_modules"("name");

-- CreateIndex
CREATE UNIQUE INDEX "module_name_key" ON "module"("name");

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "company_position"("position_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "auth" ADD CONSTRAINT "auth_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "auth" ADD CONSTRAINT "auth_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "role"("rol_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_position" ADD CONSTRAINT "company_position_areaId_fkey" FOREIGN KEY ("areaId") REFERENCES "company_area"("area_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "module" ADD CONSTRAINT "module_grupos_id_fkey" FOREIGN KEY ("grupos_id") REFERENCES "group_of_modules"("group_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_by_module" ADD CONSTRAINT "role_by_module_module_id_fkey" FOREIGN KEY ("module_id") REFERENCES "module"("module_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_by_module" ADD CONSTRAINT "role_by_module_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "role"("rol_id") ON DELETE RESTRICT ON UPDATE CASCADE;
