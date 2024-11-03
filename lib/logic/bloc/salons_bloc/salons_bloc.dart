import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salons/models/salon_model.dart';

import '../../repositories/salons_repository.dart';

part 'salons_event.dart';
part 'salons_state.dart';

class SalonsBloc extends Bloc<SalonsEvent, SalonsState> {
  final SalonsRepository salonsRepository;

  SalonsBloc({required this.salonsRepository}) : super(SalonsInitial()) {
    on<GetNearSalons>(_getNearSalons);
    
  }

  Future<void> _getNearSalons(
    GetNearSalons event,
    Emitter<SalonsState> emit,
  ) async {
    emit(SalonsLoading());
    try {
      final salons = await salonsRepository.fetchPlaceSuggestions(
        event.lat,
        event.lon,
      );
      emit(SalonsLoaded(salons));
    } catch (e) {
      emit(SalonsError('Failed to load salons'));
    }
  }
}
