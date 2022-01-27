import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_pups/database/models/pup.dart';
import 'package:my_pups/repository/pups_repository/pups_repository.dart';

part 'pups_overview_event.dart';
part 'pups_overview_state.dart';

class PupsOverviewBloc extends Bloc<PupsOverviewEvent, PupsOverviewState> {
  final PupsRepository _pupsRepository;
  PupsOverviewBloc({required PupsRepository pupsRepository})
      : _pupsRepository = pupsRepository,
        super(PupsOverviewState()) {
    on<LoadPups>(_onLoadPups);
  }

  void _onLoadPups(LoadPups event, Emitter<PupsOverviewState> emit) async {
    List<Pup> pups = await _pupsRepository.loadPups();
    emit(state.copyWith(pups: pups, status: PupsOverviewStatus.success));
  }
}
