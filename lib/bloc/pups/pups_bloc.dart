import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_pups/database/models/pup/pup.dart';
import 'package:my_pups/repository/pups_repository/pups_repository.dart';

part 'pups_event.dart';
part 'pups_state.dart';

class PupsBloc extends Bloc<PupsEvent, PupsState> {
  final PupsRepository _pupsRepository;
  StreamSubscription? _pupsSubscription;

  PupsBloc({required PupsRepository pupsRepository})
      : _pupsRepository = pupsRepository,
        super(const PupsState.initial()) {
    on<LoadPups>(_onLoadPups);
    on<UpdatePups>(_onUpdatePups);
    // on<TogglePup>(_onTogglePup);
    on<AddPup>(_onAddPup);
    on<DeletePup>(_onDeletePup);
    on<EditPup>(_onEditPup);
  }
  late final List<Pup> pups;

  /// Loads a Stream: List<Pup> from Firebase collection
  /// This method passes the List<Pup> to UPDATE PUPS
  // TODO: make these specific to user
  void _onLoadPups(LoadPups event, Emitter<PupsState> emit) async {
    // emit(const PupsState.loading());
    // await Future.delayed(const Duration(milliseconds: 2400));
    _pupsSubscription?.cancel();
    _pupsSubscription = _pupsRepository.getAllPups().listen((data) {
      add((UpdatePups(pups: data)));
    });
  }

  /// Receives the Stream of List<Pup> from Load Pups event
  /// Emits the state with the updated list
  void _onUpdatePups(UpdatePups event, Emitter<PupsState> emit) async {
    emit(PupsState.success(pups: event.pups, message: ''));
  }

  // void _onTogglePup(TogglePup event, Emitter<PupsState> emit) async {
  //   final newPups = state.pups.map((pup) {
  //     if (pup == event.pup) {
  //       return pup.copyWith(isSelected: !event.pup.isSelected);
  //     } else {
  //       return pup;
  //     }
  //   }).toList();
  //   emit(state.copyWith(newPups: newPups));
  // }

  void _onAddPup(AddPup event, Emitter<PupsState> emit) async {
    await _pupsRepository.addPup(pup: event.pup);
    // emit(PupsState.success(pups: pups, message: ''));
  }

  void _onDeletePup(DeletePup event, Emitter<PupsState> emit) async {
    await _pupsRepository.deletePup(event.pup.id);
    // emit(state.copyWith(newPups: pups));
  }

  void _onEditPup(EditPup event, Emitter<PupsState> emit) async {
    await _pupsRepository.editPup(pup: event.pup);
    // emit(state.copyWith(newPups: pups));
  }
}
