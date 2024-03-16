import { ApiProperty } from '@nestjs/swagger';
import {
  IsDateString,
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsObject,
  IsOptional,
  IsString,
} from 'class-validator';
import { documentType, sex, civilStatus } from '../enum/patient.enum';
export class CreatePatientDto {
  @ApiProperty({ enum: documentType })
  @IsString()
  @IsNotEmpty()
  @IsEnum(documentType)
  tipoDocumento: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  dni: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  nombre: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  apellidos: string;

  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  telefono: string;

  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  direccion: string;

  @ApiProperty()
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  foto: string;

  @ApiProperty()
  @IsDateString()
  @IsNotEmpty()
  fechaNacimiento: Date;

  @ApiProperty({ enum: sex })
  @IsEnum(sex)
  @IsString()
  @IsNotEmpty()
  sexo: string;

  @ApiProperty({
    enum: civilStatus,
    required: false,
  })
  @IsEnum(civilStatus)
  @IsString()
  @IsOptional()
  estadoCivil: string;

  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  estado: string;

  @ApiProperty()
  @IsObject()
  auth: {
    username: string;
    password: string;
    roleId: string;
  };
}
