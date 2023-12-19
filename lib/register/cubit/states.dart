
abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates {}

class RegisterChangePasswordvisibilityState extends RegisterStates{}
class RegisterErrorState extends RegisterStates
{
  RegisterErrorState(error);

}



class CreateUserSuccessState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates
{
  CreateUserErrorState(error);

}





