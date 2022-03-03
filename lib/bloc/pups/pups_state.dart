part of 'pups_bloc.dart';

enum PupsStatus { initial, loading, success, error, empty }

class PupsState extends Equatable {
  final PupsStatus status;
  final List<Pup> pups;
  final String? errorMessage;

  const PupsState._({
    required this.status,
    this.pups = const [],
    this.errorMessage,
  });

// copyWith
  PupsState copyWith({List<Pup>? newPups, String? newMessage}) {
    return PupsState._(
      pups: newPups ?? pups,
      status: status,
      errorMessage: newMessage ?? errorMessage,
    );
  }

  // cases
  const PupsState.initial() : this._(status: PupsStatus.initial);
  const PupsState.loading() : this._(status: PupsStatus.loading);
  const PupsState.success({required List<Pup> pups, required String message})
      : this._(errorMessage: message, status: PupsStatus.success, pups: pups);
  const PupsState.error({required String errorMessage})
      : this._(errorMessage: errorMessage, status: PupsStatus.error);
  const PupsState.empty() : this._(status: PupsStatus.empty);

  // props
  @override
  List<Object?> get props => [status, pups, errorMessage];
}
