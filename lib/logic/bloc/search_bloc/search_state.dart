import 'package:salons/models/map_suggetion_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final MapSuggestionModel suggestions;
  
  SearchLoaded(this.suggestions);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
