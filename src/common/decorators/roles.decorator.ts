// roles.decorator.ts
import { SetMetadata } from '@nestjs/common';
import { Role } from '../enums/rol.enum'; // Importa el enum Role

export const Roles = (...roles: Role[]) => SetMetadata('roles', roles);
