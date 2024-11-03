import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/search_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc({required this.searchRepository}) : super(SearchInitial()) {
    on<SearchTextChanged>(_onSearchTextChanged);
  }

  Future<void> _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    try {
      final suggestions =
          await searchRepository.fetchPlaceSuggestions(event.searchText);
      print(suggestions.predictions[0].description);
      emit(SearchLoaded(suggestions));
    } catch (e) {
      emit(SearchError('Failed to load suggestions'));
    }
  }
}
