import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';
// initialize Prisma Client
const prisma = new PrismaClient();

const roundsOfHashing = 10;

async function main() {
  const passwordAdmin = await bcrypt.hash('admin3264', roundsOfHashing);
  // creacion de roles
  const roleDev = await prisma.role.upsert({
    where: { roleId: 1 },
    update: {},
    create: {
      nombre: 'Developer',
    },
  });
  //  creacion de area
  const areaSistemas = await prisma.companyArea.upsert({
    where: { areaId: 1 },
    update: {},
    create: {
      name: 'Sistemas',
    },
  });
  // creacion de cargo
  const cargoDev = await prisma.companyPosition.upsert({
    where: { positionId: 1 },
    update: {},
    create: {
      name: 'Developer',
      areaId: 1,
    },
  });
  // creacion de usuario
  const userDev = await prisma.user.upsert({
    where: { userId: 1 },
    update: {},
    create: {
      name: 'Daniel',
      surname: 'Morán Vilchez',
      documentType: 'DNI',
      dni: '70315050',
      email: 'daniel.moranv@gmail.com',
      phoneNumber: '948860381',
      positionId: 1,
    },
  });

  const userAuth = await prisma.auth.upsert({
    where: { authId: 1 },
    update: {},
    create: {
      username: '70315050',
      password: passwordAdmin,
      userId: 1,
      roleId: 1,
    },
  });

  console.log({ userDev, roleDev, cargoDev, areaSistemas, userAuth });
}

// execute the main function
main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    // close Prisma Client at the end
    await prisma.$disconnect();
  });
