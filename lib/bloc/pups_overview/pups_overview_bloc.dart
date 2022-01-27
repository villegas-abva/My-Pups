import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pups_overview_event.dart';
part 'pups_overview_state.dart';

class PupsOverviewBloc extends Bloc<PupsOverviewEvent, PupsOverviewState> {
  PupsOverviewBloc() : super(PupsOverviewInitial()) {
    on<PupsOverviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
