abstract class SearchEvent {}

class SearchTextChanged extends SearchEvent {
  final String searchText;

  SearchTextChanged(this.searchText);
}
