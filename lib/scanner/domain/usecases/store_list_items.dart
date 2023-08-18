import 'package:document_scanner/core/lib/optional.dart';
import 'package:document_scanner/core/service_locator/service_locator.dart';
import 'package:document_scanner/scanner/domain/repositories/key_values.dart';
import 'package:document_scanner/scanner/domain/usecases/usecase.dart';

class StoreListItemsParam {
  final List<String> items;
  final KeyValueNames key;

  StoreListItemsParam(this.key, this.items);
}

typedef Result = bool;

class StoreListItemsUseCase implements UseCase<Result, StoreListItemsParam> {
  @override
  Future<Optional<Result>> call(StoreListItemsParam param) async {
    try {
      sl<KeyValues>().setItems(param.key, param.items);
      return Optional.newValue(true);
    } on Exception catch (e, st) {
      return Optional.newError(e, st);
    }
  }
}
