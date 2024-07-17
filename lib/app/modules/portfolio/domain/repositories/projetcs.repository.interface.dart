import 'package:dartz/dartz.dart';

import '../../../../core/domain/exceptions/exceptions.dart';
import '../entities/project.entity.dart';

abstract class IProjectsRepository {
  Future<Either<Failure, List<ProjectEntity>>> getProjects();
}
