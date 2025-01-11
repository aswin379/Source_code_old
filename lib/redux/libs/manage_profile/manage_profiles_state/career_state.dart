import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';

class CareerState {
  bool? isLoading;
  var list = <CareerViewModel>[];
  var delIndex;
  bool? isDelete;
  bool? update_changes;
  int? index;
  bool? saveChanges;

  CareerState({
    this.saveChanges,
    this.isDelete,
    this.update_changes,
    this.index,
    this.delIndex,
    this.isLoading,
  });

  CareerState.initialState()
      : isLoading = false,
        update_changes = false,
        saveChanges = false,
        isDelete = false;
}
