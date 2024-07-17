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
        ),
        ProjectEntity(
          name: 'Site da Saaetri',
          type: ProjectType.website,
          imageUrl: 'assets/images/saaetri.png',
          launch: '03/07/2024',
          urlDemo: 'http://saaetri.com.br/',
        ),
        ProjectEntity(
          name: 'Victor Feitosa Imóveis',
          type: ProjectType.website,
          imageUrl: 'assets/images/victorfeitosaimoveis.png',
          launch: '10/06/2023',
          urlDemo: 'https://victorfeitosaimoveis.com.br/',
        ),
        ProjectEntity(
          name: 'CFC Produtivo',
          type: ProjectType.app,
          imageUrl: 'assets/images/cnhbrasil.png',
          launch: '23/05/2023',
          urlDemo:
              'https://play.google.com/store/apps/details?id=br.com.soulsystems.cfcprodutivoapp',
        ),
        ProjectEntity(
          name: 'EngExata - Financiamento',
          type: ProjectType.website,
          imageUrl: 'assets/images/engexata-engenharia.png',
          launch: '26/12/2021',
          urlDemo: 'https://engexata.com.br/simulador/',
        ),
        ProjectEntity(
          name: 'Unifor - Financiamento',
          type: ProjectType.website,
          imageUrl: 'assets/images/simulador-unifor.png',
          launch: '26/10/2021',
        ),
        ProjectEntity(
          name: 'Vai Bem Saúde',
          type: ProjectType.app,
          imageUrl: 'assets/images/vai-bem-saude.png',
          launch: '26/08/2021',
        ),
        ProjectEntity(
          name: 'Box Transporte',
          type: ProjectType.software,
          imageUrl: 'assets/images/boxtransporte.png',
          launch: '26/12/2017',
        ),
      ],
    );
  }
}
