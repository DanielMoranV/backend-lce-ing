import {
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { PrismaService } from 'nestjs-prisma';
import { JwtService } from '@nestjs/jwt';
import { AuthEntity } from './entity/auth.entity';
import { CreateAuthDto } from './dto/create-auth.dto';
import { UpdateAuthDto } from './dto/update-auth.dto';
import * as bcrypt from 'bcrypt';

export const roundsOfHashing = 10;
@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
  ) {}

  async login(username: string, password: string): Promise<AuthEntity> {
    // Step 1: Fetch a user with the given username
    const user = await this.prisma.auth.findUnique({
      where: { username },
    });

    // If no user is found, throw an error
    if (!user) {
      throw new NotFoundException(`No user found for username: ${username}`);
    }

    // Step 2: Check if the password is correct
    const isPasswordValid = await bcrypt.compare(password, user.password);
    console.log(password);

    // If password does not match, throw an error
    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid password');
    }

    // Step 3: Generate a JWT containing the user's ID and return it
    return {
      accessToken: this.jwtService.sign({
        userId: user.userId,
        roleId: user.roleId,
      }),
    };
  }

  async signup(createAuthDto: CreateAuthDto) {
    const hashedPassword = await bcrypt.hash(
      createAuthDto.password,
      roundsOfHashing,
    );

    createAuthDto.password = hashedPassword;
    return await this.prisma.auth.create({ data: createAuthDto });
  }

  async findOne(username: string) {
    return await this.prisma.auth.findUnique({ where: { username } });
  }
  async update(username: string, updateAuthDto: UpdateAuthDto) {
    if (updateAuthDto.password) {
      updateAuthDto.password = await bcrypt.hash(
        updateAuthDto.password,
        roundsOfHashing,
      );
    }
    return await this.prisma.auth.update({
      where: { username },
      data: updateAuthDto,
    });
  }
}
