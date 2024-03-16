-- CreateTable
CREATE TABLE "colaborador" (
    "colaborador_id" SERIAL NOT NULL,
    "tipo_documento" TEXT NOT NULL,
    "dni" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellidos" TEXT NOT NULL,
    "cargo_id" INTEGER NOT NULL,
    "telefono" TEXT,
    "direccion" TEXT,
    "email" TEXT,
    "foto" TEXT,
    "fecha_nacimiento" TIMESTAMP(3),
    "sexo" TEXT,
    "estado_civil" TEXT,

    CONSTRAINT "colaborador_pkey" PRIMARY KEY ("colaborador_id")
);

-- CreateTable
CREATE TABLE "area_empresa" (
    "area_id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "area_empresa_pkey" PRIMARY KEY ("area_id")
);

-- CreateTable
CREATE TABLE "cargo_empresa" (
    "cargo_id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "areaId" INTEGER NOT NULL,

    CONSTRAINT "cargo_empresa_pkey" PRIMARY KEY ("cargo_id")
);

-- CreateTable
CREATE TABLE "acceso_colaborador" (
    "acceso_colaborador_id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "status" TEXT,
    "active" BOOLEAN DEFAULT true,
    "last_session" TIMESTAMP(3),
    "create_at" TIMESTAMP(3),
    "colaborador_id" INTEGER NOT NULL,
    "rol_id" INTEGER NOT NULL,

    CONSTRAINT "acceso_colaborador_pkey" PRIMARY KEY ("acceso_colaborador_id")
);

-- CreateTable
CREATE TABLE "rol" (
    "rol_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "estado" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "rol_pkey" PRIMARY KEY ("rol_id")
);

-- CreateTable
CREATE TABLE "grupos_modulos" (
    "grupo_id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "estado" BOOLEAN NOT NULL DEFAULT true,
    "icono" TEXT NOT NULL,

    CONSTRAINT "grupos_modulos_pkey" PRIMARY KEY ("grupo_id")
);

-- CreateTable
CREATE TABLE "modulo" (
    "modulo_id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "estado" BOOLEAN NOT NULL DEFAULT true,
    "icono" TEXT NOT NULL,
    "grupos_id" INTEGER,

    CONSTRAINT "modulo_pkey" PRIMARY KEY ("modulo_id")
);

-- CreateTable
CREATE TABLE "rol_por_modulo" (
    "rol_id" INTEGER NOT NULL,
    "grupo_id" INTEGER NOT NULL,

    CONSTRAINT "rol_por_modulo_pkey" PRIMARY KEY ("rol_id","grupo_id")
);

-- CreateTable
CREATE TABLE "paciente" (
    "paciente_id" SERIAL NOT NULL,
    "tipo_documento" TEXT NOT NULL,
    "dni" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellidos" TEXT NOT NULL,
    "telefono" TEXT,
    "direccion" TEXT,
    "email" TEXT,
    "foto" TEXT,
    "fecha_nacimiento" TIMESTAMP(3),
    "sexo" TEXT,
    "estado_civil" TEXT,

    CONSTRAINT "paciente_pkey" PRIMARY KEY ("paciente_id")
);

-- CreateTable
CREATE TABLE "dependiente" (
    "dependiente_id" SERIAL NOT NULL,
    "tipo_documento" TEXT NOT NULL,
    "dni" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellidos" TEXT NOT NULL,
    "telefono" TEXT,
    "direccion" TEXT,
    "email" TEXT,
    "foto" TEXT,
    "fecha_nacimiento" TIMESTAMP(3),
    "sexo" TEXT,
    "estado_civil" TEXT,
    "paciente_id" INTEGER NOT NULL,

    CONSTRAINT "dependiente_pkey" PRIMARY KEY ("dependiente_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "colaborador_dni_key" ON "colaborador"("dni");

-- CreateIndex
CREATE UNIQUE INDEX "area_empresa_nombre_key" ON "area_empresa"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "cargo_empresa_nombre_key" ON "cargo_empresa"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "acceso_colaborador_username_key" ON "acceso_colaborador"("username");

-- CreateIndex
CREATE UNIQUE INDEX "rol_name_key" ON "rol"("name");

-- CreateIndex
CREATE UNIQUE INDEX "grupos_modulos_nombre_key" ON "grupos_modulos"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "modulo_nombre_key" ON "modulo"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "paciente_dni_key" ON "paciente"("dni");

-- CreateIndex
CREATE UNIQUE INDEX "dependiente_dni_key" ON "dependiente"("dni");

-- AddForeignKey
ALTER TABLE "colaborador" ADD CONSTRAINT "colaborador_cargo_id_fkey" FOREIGN KEY ("cargo_id") REFERENCES "cargo_empresa"("cargo_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cargo_empresa" ADD CONSTRAINT "cargo_empresa_areaId_fkey" FOREIGN KEY ("areaId") REFERENCES "area_empresa"("area_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "acceso_colaborador" ADD CONSTRAINT "acceso_colaborador_colaborador_id_fkey" FOREIGN KEY ("colaborador_id") REFERENCES "colaborador"("colaborador_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "acceso_colaborador" ADD CONSTRAINT "acceso_colaborador_rol_id_fkey" FOREIGN KEY ("rol_id") REFERENCES "rol"("rol_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "modulo" ADD CONSTRAINT "modulo_grupos_id_fkey" FOREIGN KEY ("grupos_id") REFERENCES "grupos_modulos"("grupo_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "rol_por_modulo" ADD CONSTRAINT "rol_por_modulo_rol_id_fkey" FOREIGN KEY ("rol_id") REFERENCES "rol"("rol_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "rol_por_modulo" ADD CONSTRAINT "rol_por_modulo_grupo_id_fkey" FOREIGN KEY ("grupo_id") REFERENCES "modulo"("modulo_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dependiente" ADD CONSTRAINT "dependiente_paciente_id_fkey" FOREIGN KEY ("paciente_id") REFERENCES "paciente"("paciente_id") ON DELETE RESTRICT ON UPDATE CASCADE;
