import 'package:dartz/dartz.dart';

import '../../../../core/domain/exceptions/exceptions.dart';
import '../../domain/entities/project.entity.dart';
import '../../domain/repositories/projetcs.repository.interface.dart';

class ProjectsRepository implements IProjectsRepository {
  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjects() async {
    try {
      final projects = [
        ProjectEntity(
          id: '1',
          nameByLang: {
            'pt': 'Cirebox Sistema de Gestão',
            'en': 'Cirebox Management System',
            'es': 'Cirebox Sistema de Gestión'
          },
          descriptionByLang: {
            'pt':
                'Sistema completo de gestão empresarial com módulos de finanças, estoque, vendas e CRM.',
            'en':
                'Complete business management system with finance, inventory, sales and CRM modules.',
            'es':
                'Sistema completo de gestión empresarial con módulos de finanzas, inventario, ventas y CRM.'
          },
          clientByLang: {
            'pt': 'Cirebox Tecnologia',
            'en': 'Cirebox Technology',
            'es': 'Cirebox Tecnología'
          },
          image: 'assets/images/cirebox.png',
          url: 'https://cirebox.com',
          year: 2021,
          technologies: ['Flutter', 'Node.js', 'PostgreSQL', 'Docker'],
          type: ProjectType.websystem,
          isHighlighted: true,
        ),
        ProjectEntity(
          id: '2',
          nameByLang: {
            'pt': 'SAAE Sobral',
            'en': 'SAAE Sobral',
            'es': 'SAAE Sobral'
          },
          descriptionByLang: {
            'pt':
                'Sistema para gestão de serviços de água e esgoto para a cidade de Sobral.',
            'en':
                'System for water and sewage service management for the city of Sobral.',
            'es':
                'Sistema para la gestión de servicios de agua y alcantarillado para la ciudad de Sobral.'
          },
          clientByLang: {
            'pt': 'SAAE Sobral',
            'en': 'SAAE Sobral',
            'es': 'SAAE Sobral'
          },
          image: 'assets/images/saaetri.png',
          url: 'https://saaesobral.com.br',
          year: 2020,
          technologies: ['React', 'Node.js', 'MySQL', 'AWS'],
          type: ProjectType.websystem,
          isHighlighted: false,
        ),
        ProjectEntity(
          id: '3',
          nameByLang: {
            'pt': 'Simulador ENADE Unifor',
            'en': 'Unifor ENADE Simulator',
            'es': 'Simulador ENADE Unifor'
          },
          descriptionByLang: {
            'pt':
                'Plataforma de simulados para preparação dos alunos para o ENADE.',
            'en': 'Mock test platform to prepare students for ENADE.',
            'es':
                'Plataforma de simulacros para preparar a los estudiantes para ENADE.'
          },
          clientByLang: {
            'pt': 'Universidade de Fortaleza',
            'en': 'University of Fortaleza',
            'es': 'Universidad de Fortaleza'
          },
          image: 'assets/images/simulador-unifor.png',
          year: 2019,
          technologies: ['Angular', 'Java Spring', 'Oracle', 'Docker'],
          type: ProjectType.websystem,
          isHighlighted: true,
        ),
        ProjectEntity(
          id: '4',
          nameByLang: {
            'pt': 'CNH Brasil App',
            'en': 'CNH Brasil App',
            'es': 'CNH Brasil App'
          },
          descriptionByLang: {
            'pt':
                'Aplicativo móvel para consulta e gerenciamento de CNH digital.',
            'en':
                'Mobile app for querying and managing digital driver\'s license.',
            'es':
                'Aplicación móvil para consultar y gestionar la licencia de conducir digital.'
          },
          clientByLang: {
            'pt': 'Departamento de Trânsito',
            'en': 'Department of Transit',
            'es': 'Departamento de Tránsito'
          },
          image: 'assets/images/cnhbrasil.png',
          url: 'https://play.google.com/store',
          year: 2020,
          technologies: ['Flutter', 'Firebase', 'Node.js'],
          type: ProjectType.app,
          isHighlighted: true,
        ),
        ProjectEntity(
          id: '5',
          nameByLang: {
            'pt': 'Vai Bem Saúde',
            'en': 'Vai Bem Health',
            'es': 'Vai Bem Salud'
          },
          descriptionByLang: {
            'pt':
                'Plataforma de telemedicina para consultas online e monitoramento de pacientes.',
            'en':
                'Telemedicine platform for online consultations and patient monitoring.',
            'es':
                'Plataforma de telemedicina para consultas online y monitoreo de pacientes.'
          },
          clientByLang: {
            'pt': 'Vai Bem Saúde',
            'en': 'Vai Bem Health',
            'es': 'Vai Bem Salud'
          },
          image: 'assets/images/vai-bem-saude.png',
          url: 'https://vaibemsaude.com.br',
          year: 2022,
          technologies: ['React', 'Node.js', 'MongoDB', 'AWS'],
          type: ProjectType.websystem,
          isHighlighted: true,
        ),
      ];

      return Right(projects);
    } catch (e) {
      return Left(UnknownError(errorMessage: e.toString()));
    }
  }
}
