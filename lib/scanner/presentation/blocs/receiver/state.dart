part of "bloc.dart";

typedef ItemStateBloc = TextFieldBloc<dynamic>;

class ItemState extends GroupFieldBloc<FieldBloc, dynamic> {
  ListFieldBloc<ItemStateBloc, dynamic> get receivers =>
      state.fieldBlocs["receivers"] as ListFieldBloc<ItemStateBloc, dynamic>;

  ItemState()
      : super(name: "main", fieldBlocs: [
          ListFieldBloc<ItemStateBloc, String>(name: "receivers"),
        ]) {
    usecase<LoadListItemsResult, LoadListItemsParam>(LoadListItemsParam(KeyValueNames.receiverNames)).then((value) {
      for (var element in value) {
        createItem(initialValue: element);
      }
    });
  }

  void createItem({String? initialValue}) {
    receivers.addFieldBloc(
      TextFieldBloc(
        initialValue: initialValue ?? "",
        validators: [
          FieldBlocValidators.required,
        ],
      ),
    );
  }

  void removeItem(int index) {
    receivers.removeFieldBlocAt(index);
  }
}
