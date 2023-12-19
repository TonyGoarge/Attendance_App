abstract class HomeStates{}
class HomeIntialState extends HomeStates{}
class HomeChangeBottomNavState extends HomeStates{}
class GetUserLoadinglState extends HomeStates{}
class GetUserSuccessState extends HomeStates{}
class CheckinSuccessState extends HomeStates{}
class UserUpdateSuccessState extends HomeStates{}
class CheckinErrorState extends HomeStates
{
  final String error;

  CheckinErrorState(this.error);

}
class GetUserErrorState extends HomeStates {
  final String error;

  GetUserErrorState(this.error);

}
