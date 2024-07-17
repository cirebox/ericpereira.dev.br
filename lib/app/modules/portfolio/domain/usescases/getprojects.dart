import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../core/domain/exceptions/exceptions.dart';
import '../entities/project.entity.dart';
import '../repositories/projetcs.repository.interface.dart';

part 'getprojects.g.dart';

mixin IGetProjects {
  Future<Either<Failure, List<ProjectEntity>>> call();
}

class GetProjects implements IGetProjects {
  final IProjectsRepository _repository;
  GetProjects(this._repository);

  @override
  Future<Either<Failure, List<ProjectEntity>>> call() async {
    try {
      final result = await _repository.getProjects();
      return result.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
