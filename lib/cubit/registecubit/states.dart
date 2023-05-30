abstract class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSucessfulState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {}

class CreateUserSucessfulState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates {
  final String error;

  CreateUserErrorState(this.error);
}
