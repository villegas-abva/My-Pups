part of 'pups_bloc.dart';

abstract class PupsEvent extends Equatable {
  const PupsEvent();
}

class LoadPups extends PupsEvent {
  @override
  List<Object> get props => [];
}

class UpdatePups extends PupsEvent {
  late final List<Pup> pups;
  UpdatePups({required this.pups});

  @override
  List<Object> get props => [pups];
}

class TogglePup extends PupsEvent {
  final Pup pup;
  const TogglePup({required this.pup});

  @override
  List<Object> get props => [pup];
}

class AddPup extends PupsEvent {
  final Pup pup;
  const AddPup({required this.pup});

  @override
  List<Object> get props => [pup];
}

class DeletePup extends PupsEvent {
  final Pup pup;
  const DeletePup({required this.pup});

  @override
  List<Object> get props => [pup];
}

class EditPup extends PupsEvent {
  final Pup pup;
  const EditPup({required this.pup});

  @override
  List<Object> get props => [pup];
}
