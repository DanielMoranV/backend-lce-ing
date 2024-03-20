// import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
// import { Reflector } from '@nestjs/core';
// import { Role } from '../../common/enums/rol.enum';
// import { JwtStrategy } from '../jwt.strategy';

// @Injectable()
// export class RolesGuard implements CanActivate {
//   constructor(
//     private reflector: Reflector,
//     private jwtStrategy: JwtStrategy,
//   ) {}

//   async canActivate(context: ExecutionContext): Promise<boolean> {
//     const requiredRoles = this.reflector.get<Role[]>(
//       'roles',
//       context.getHandler(),
//     );
//     console.log(requiredRoles);
//     if (!requiredRoles || requiredRoles.length === 0) {
//       return true; // No roles required for this route
//     }

//     const request = context.switchToHttp().getRequest();
//     const user = await this.jwtStrategy.validate(request.user);

//     // Verifica si el usuario tiene al menos uno de los roles necesarios
//     return user && requiredRoles.some((role) => user.roleId === role);
//   }
// }
import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Role } from '../../common/enums/rol.enum';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private jwtService: JwtService,
  ) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredRoles = this.reflector.get<Role[]>(
      'roles',
      context.getHandler(),
    );
    if (!requiredRoles || requiredRoles.length === 0) {
      return true; // No roles required for this route
    }

    const request = context.switchToHttp().getRequest();
    const token = request.headers.authorization.split(' ')[1]; // Obtén el token de autorización

    try {
      const decodedToken = this.jwtService.verify(token);
      const user = decodedToken.userId;
      const roleId = decodedToken.roleId;
      console.log(decodedToken);
      // Verifica si el usuario tiene al menos uno de los roles necesarios
      return user && roleId && requiredRoles.some((role) => roleId === role);
    } catch (error) {
      return false; // Error al verificar el token o falta de usuario/roleId
    }
  }
}
