import { Injectable } from '@nestjs/common';
import { CreatePatientDto } from './dto/create-patient.dto';
import { UpdatePatientDto } from './dto/update-patient.dto';
import { PrismaService } from 'nestjs-prisma';

@Injectable()
export class PatientsService {
  constructor(private prisma: PrismaService) {}
  create(createPatientDto: CreatePatientDto) {
    return this.prisma.paciente.create({ data: createPatientDto });
  }

  findAll() {
    return this.prisma.paciente.findMany({ where: { deleted: false } });
  }

  findOne(pacienteId: number) {
    return this.prisma.paciente.findUnique({ where: { pacienteId } });
  }

  update(pacienteId: number, updatePatientDto: UpdatePatientDto) {
    return this.prisma.paciente.update({
      where: { pacienteId },
      data: updatePatientDto,
    });
  }

  remove(id: number) {
    return `This action removes a #${id} patient`;
  }
}
