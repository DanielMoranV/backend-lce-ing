//src/auth/jwt.strategy.ts
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { jwtSecret } from './auth.module';
import { UsersService } from 'src/users/users.service';
import { UserWithRoleId } from '../common/interfaces/user-with-role-id.interface';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy, 'jwt') {
  constructor(private usersService: UsersService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: jwtSecret,
    });
  }

  async validate(payload: { userId: number; roleId: number }) {
    const user = await this.usersService.findOne(payload.userId);

    if (!user) {
      throw new UnauthorizedException();
    }
    const userWithRoleId: UserWithRoleId = {
      name: user.name,
      surname: user.surname,
      userId: user.userId,
      roleId: payload.roleId,
    };

    // Attach roleId to the user object
    //user.roleId = payload.roleId;
    return userWithRoleId;
  }
}
