import 'package:document_scanner/core/lib/optional.dart';
import 'package:document_scanner/core/service_locator/service_locator.dart';
import 'package:document_scanner/scanner/domain/repositories/file_repos.dart';
import 'package:document_scanner/scanner/domain/usecases/usecase.dart';
import 'package:flutter/foundation.dart';

export 'call.dart';

class ReadFilesParam {
  final List<String> path;

  ReadFilesParam(this.path);
}

class ReadFileEntity {
  final String name;
  final Uint8List data;

  ReadFileEntity(this.name, this.data);
}

typedef ReadFilesResult = List<ReadFileEntity>;
typedef ReadFiles = UseCase<ReadFilesResult, ReadFilesParam>;

class ReadFilesUseCase implements ReadFiles {
  @override
  Future<Optional<ReadFilesResult>> call(ReadFilesParam param) async {
    try {
      return Optional.newValue(
          sl<FileRepos>().readFiles(param.path).map((e) => ReadFileEntity(e.name, e.data)).toList());
    } on Exception catch (e, st) {
      return Optional.newError(e, st);
    }
  }
}
