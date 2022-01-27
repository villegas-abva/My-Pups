part of 'pups_overview_bloc.dart';

enum PupsOverviewStatus { initial, loading, success, failure }

class PupsOverviewState extends Equatable {
  const PupsOverviewState({
    this.status = PupsOverviewStatus.initial,
    this.pups = const [],
  });

  final PupsOverviewStatus status;
  final List<Pup> pups;

// copyWith
  PupsOverviewState copyWith({
    PupsOverviewStatus? status,
    List<Pup>? pups,
  }) {
    return PupsOverviewState(
      status: status ?? this.status,
      pups: pups ?? this.pups,
    );
  }

  // props
  @override
  List<Object?> get props => [status, pups];
}
