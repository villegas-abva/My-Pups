import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_pups/database/models/pup.dart';
import 'package:my_pups/repository/pups_repository/pups_repository.dart';

part 'pups_event.dart';
part 'pups_state.dart';

class PupsBloc extends Bloc<PupsEvent, PupsState> {
  final PupsRepository _pupsRepository;
  PupsBloc({required PupsRepository pupsRepository})
      : _pupsRepository = pupsRepository,
        super(const PupsState.initial()) {
    on<LoadPups>(_onLoadPups);
    on<TogglePup>(_onTogglePup);
    on<AddPup>(_onAddPup);
    on<DeletePup>(_onDeletePup);
  }
  late final List<Pup> pups;

  /// Loads List<Pup> from Firebase collection
  // TODO: make these specific to user
  void _onLoadPups(LoadPups event, Emitter<PupsState> emit) async {
    if (state.status == PupsStatus.initial) {
      emit(const PupsState.loading());

      await Future.delayed(const Duration(milliseconds: 2400));
      pups = await _pupsRepository.loadPups();
      emit(PupsState.success(pups: pups, message: ''));
    } else if (state.status == PupsStatus.success) {
      emit(PupsState.success(pups: pups, message: ''));
    }
  }

  void _onTogglePup(TogglePup event, Emitter<PupsState> emit) async {
    final newPups = state.pups.map((pup) {
      if (pup == event.pup) {
        return pup.copyWith(isSelected: !event.pup.isSelected);
      } else {
        return pup;
      }
    }).toList();
    emit(state.copyWith(newPups: newPups));
  }

  void _onAddPup(AddPup event, Emitter<PupsState> emit) async {
    await _pupsRepository.addPup();
    emit(state.copyWith());
  }

  void _onDeletePup(DeletePup event, Emitter<PupsState> emit) async {
    // await _pupsRepository.deletePup(event.pup.id);
    // emit(PupsState.success(pups: pups, message: ''));
  }
}
