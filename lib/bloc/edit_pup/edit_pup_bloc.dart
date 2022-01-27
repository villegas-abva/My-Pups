import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_pup_event.dart';
part 'edit_pup_state.dart';

class EditPupBloc extends Bloc<EditPupEvent, EditPupState> {
  EditPupBloc() : super(EditPupInitial()) {
    on<EditPupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
