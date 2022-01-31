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
        super(const PupsState.loading()) {
    on<LoadPups>(_onLoadPups);
    on<TogglePup>(_onTogglePup);
  }

  void _onLoadPups(LoadPups event, Emitter<PupsState> emit) async {
    await Future.delayed(const Duration(milliseconds: 1200));

    List<Pup> pups = await _pupsRepository.loadPups();
    emit(PupsState.success(pups: pups));
  }

  void _onTogglePup(TogglePup event, Emitter<PupsState> emit) {
    final newPups = state.pups.map((pup) {
      if (pup == event.pup) {
        return pup.copyWith(isSelected: !event.pup.isSelected);
      } else {
        return pup;
      }
    }).toList();
    final newState = state.copyWith(newPups: newPups);
    emit(newState);
  }
}
