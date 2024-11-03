part of 'salons_bloc.dart';

@immutable
sealed class SalonsState {}

final class SalonsInitial extends SalonsState {}

final class SalonsLoading extends SalonsState {}

final class SalonsLoaded extends SalonsState {
  final SalonsModel salons;

  SalonsLoaded(this.salons);
}

final class SalonsError extends SalonsState {
  final String message;

  SalonsError(this.message);
}
