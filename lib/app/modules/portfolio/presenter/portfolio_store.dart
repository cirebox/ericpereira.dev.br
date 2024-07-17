import 'package:flutter/foundation.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../core/domain/exceptions/exceptions.dart';
import '../../../core/either_adapter/dartz_either_adapter.dart';
import '../domain/entities/project.entity.dart';
import '../domain/usescases/getprojects.dart';

class PortfolioStore extends NotifierStore<Failure, List<ProjectEntity>> {
  final IGetProjects _getProjects;
  PortfolioStore(this._getProjects) : super([]) {
    debugPrint(
      'PortfolioStore => ${hashCode.toString()}',
    );
  }

  Future<void> getProjects() async => executeEither(
        () => DartzEitherAdapter.adapter(
          _getProjects(),
        ),
      );
}
