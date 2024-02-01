abstract class FavoritesStates {}

class InitialFavoritesState extends FavoritesStates {}

class GetFavoritesSuccessState extends FavoritesStates {}

class GetFavoritesFailureState extends FavoritesStates {}

class GetFavoritesLoadingState extends FavoritesStates {}

class ChangeFaveLoadingState extends FavoritesStates {}

class ChangeFaveSuccessState extends FavoritesStates {}

class ChangeFaveFailureState extends FavoritesStates {}

class ChangeFaveLocalState extends FavoritesStates {}
