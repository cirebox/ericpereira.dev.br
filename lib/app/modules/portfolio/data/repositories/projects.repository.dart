import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../core/domain/exceptions/exceptions.dart';
import '../../domain/repositories/projetcs.repository.interface.dart';
import '../../domain/entities/project.entity.dart';

part 'projects.repository.g.dart';

class ProjectsRepository implements IProjectsRepository {
  // final IHttpRequest _http;
  // AssinaturaRepository(this._http);
  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjects() async {
    return Right(
      [
        ProjectEntity(
          name: 'Site da Cirebox',
          type: ProjectType.website,
          imageUrl: 'assets/images/cirebox.png',
          launch: '17/07/2024',
          urlDemo: 'https://cirebox.com.br/',
          description:
              'Site institucional com apresentação de serviços e portfólio da empresa de desenvolvimento de software Cirebox.',
          client: 'Cirebox',
          stack: ['React', 'Next.js', 'Tailwind CSS', 'Vercel'],
        ),
        ProjectEntity(
          name: 'Site da Saaetri',
          type: ProjectType.website,
          imageUrl: 'assets/images/saaetri.png',
          launch: '03/07/2024',
          urlDemo: 'http://saaetri.com.br/',
          description:
              'Portal institucional para o Serviço Autônomo de Água e Esgoto de Três Rios, com informações sobre serviços, notícias e portal de transparência.',
          client: 'SAAETRI',
          stack: ['WordPress', 'PHP', 'MySQL', 'Bootstrap'],
        ),
        ProjectEntity(
          name: 'Victor Feitosa Imóveis',
          type: ProjectType.websystem,
          imageUrl: 'assets/images/victorfeitosaimoveis.png',
          launch: '10/06/2023',
          urlDemo: 'https://victorfeitosaimoveis.com.br/',
          description:
              'Plataforma imobiliária para listagem e busca de imóveis, com sistema de filtragem avançada e integração com redes sociais.',
          client: 'Victor Feitosa Imóveis',
          stack: [
            'React',
            'Nodejs',
            'Postgres',
            'Express',
          ],
        ),
        ProjectEntity(
          name: 'CFC Produtivo',
          type: ProjectType.app,
          imageUrl: 'assets/images/cnhbrasil.png',
          launch: '23/05/2023',
          urlDemo:
              'https://play.google.com/store/apps/details?id=br.com.soulsystems.cfcprodutivoapp',
          description:
              'Aplicativo móvel desenvolvido para autoescolas, permitindo a gestão de alunos, aulas práticas e teóricas, com sistema de notificações.',
          client: 'Soul Systems',
          stack: ['Flutter', 'Firebase', 'RESTful API', 'SQLite'],
        ),
        ProjectEntity(
          name: 'EngExata - Simulador de Financiamento',
          type: ProjectType.websystem,
          imageUrl: 'assets/images/engexata-engenharia.png',
          launch: '26/12/2021',
          urlDemo: 'https://engexata.com.br/simulador/',
          description:
              'Simulador de financiamento imobiliário personalizado para construtora, com cálculos de parcelas, juros e condições de pagamento.',
          client: 'EngExata Engenharia',
          stack: ['JavaScript', 'HTML5', 'CSS3', 'Bootstrap'],
        ),
        ProjectEntity(
          name: 'Unifor - Simulador de Financiamento',
          type: ProjectType.website,
          imageUrl: 'assets/images/simulador-unifor.png',
          launch: '26/10/2021',
          description:
              'Simulador de financiamento estudantil para a Universidade de Fortaleza, com diferentes modalidades de pagamento e cálculo de mensalidades.',
          client: 'Universidade de Fortaleza',
          stack: ['Angular', 'TypeScript', 'SCSS'],
        ),
        ProjectEntity(
          name: 'Vai Bem Saúde',
          type: ProjectType.app,
          imageUrl: 'assets/images/vai-bem-saude.png',
          launch: '26/08/2021',
          description:
              'Aplicativo de telemedicina e agendamento de consultas médicas, com integração de pagamentos e prontuário eletrônico.',
          client: 'Vai Bem Saúde',
          stack: ['Flutter', 'Node.js', 'MongoDB', 'WebRTC'],
        ),
        ProjectEntity(
          name: 'Box Transporte',
          type: ProjectType.software,
          imageUrl: 'assets/images/boxtransporte.png',
          launch: '26/12/2017',
          description:
              'Sistema de gestão para empresas de transporte e logística, com controle de frotas, rotas, motoristas e manutenção de veículos.',
          client: 'Box Transporte',
          stack: ['C#', '.NET', 'SQL Server', 'WPF'],
        ),
      ],
    );
  }
}
