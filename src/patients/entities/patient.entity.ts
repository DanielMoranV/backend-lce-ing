import { Paciente } from '@prisma/client';
import { ApiProperty } from '@nestjs/swagger';
export class PatientEntity implements Paciente {
  @ApiProperty()
  pacienteId: number;

  @ApiProperty()
  nombre: string;

  @ApiProperty()
  apellidos: string;

  @ApiProperty()
  tipoDocumento: string;

  @ApiProperty()
  dni: string;

  @ApiProperty()
  foto: string;

  @ApiProperty()
  direccion: string;

  @ApiProperty()
  email: string;

  @ApiProperty()
  telefono: string;

  @ApiProperty()
  fechaNacimiento: Date;

  @ApiProperty()
  sexo: string;

  @ApiProperty()
  estadoCivil: string;

  @ApiProperty()
  estado: string;

  @ApiProperty()
  deleted: boolean;

  @ApiProperty()
  deletedAt: Date;
}
