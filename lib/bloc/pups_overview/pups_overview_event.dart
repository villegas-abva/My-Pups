part of 'pups_overview_bloc.dart';

abstract class PupsOverviewEvent extends Equatable {
  const PupsOverviewEvent();

  @override
  List<Object> get props => [];
}

class LoadPups extends PupsOverviewEvent {}
