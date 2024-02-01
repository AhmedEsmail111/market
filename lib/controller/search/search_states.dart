abstract class SearchStates {}

class InitialSearchState extends SearchStates {}

class LoadingSearchState extends SearchStates {}

class SuccessSearchState extends SearchStates {}

class FailureSearchState extends SearchStates {
  final String errorMessage;

  FailureSearchState({required this.errorMessage});
}
