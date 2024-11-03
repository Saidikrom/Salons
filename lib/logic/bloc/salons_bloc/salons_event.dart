part of 'salons_bloc.dart';

@immutable
sealed class SalonsEvent {}

final class GetNearSalons extends SalonsEvent {
  final double lat;
  final double lon;

  GetNearSalons(this.lat, this.lon);
}
