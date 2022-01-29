part of 'pups_bloc.dart';

abstract class PupsEvent extends Equatable {
  const PupsEvent();
}

class LoadPups extends PupsEvent {
  @override
  List<Object> get props => [];
}

class TogglePup extends PupsEvent {
  final Pup pup;
  const TogglePup({required this.pup});

  @override
  List<Object> get props => [pup];
}
