
abstract class NewsStates {}

class NewsInitialStates extends NewsStates{}

class NewsBottomNavStates extends NewsStates{}

class NewGetBusinessLoadingState extends NewsStates {}

class NewGetBusinessSuccessState extends NewsStates {}

class NewGetBusinessErrorState extends NewsStates {
  final String error;

  NewGetBusinessErrorState(this.error);
}
class NewGetScienceLoadingState extends NewsStates {}

class NewGetScienceSuccessState extends NewsStates {}

class NewGetScienceErrorState extends NewsStates {
  final String error;
  NewGetScienceErrorState(this.error);
}


class NewGetSportLoadingState extends NewsStates {}

class NewGetSportSuccessState extends NewsStates {}

class NewGetSportErrorState extends NewsStates {
  final String error;
  NewGetSportErrorState(this.error);


}class NewGetSearchLoadingState extends NewsStates {}

class NewGetSearchSuccessState extends NewsStates {}

class NewGetSearchErrorState extends NewsStates {
  final String error;
  NewGetSearchErrorState(this.error);
}

class AppChangeModeState extends NewsStates {}