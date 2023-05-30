abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSucsesfulState extends LoginStates {
  final String uid;

  LoginSucsesfulState(this.uid);
}

class LoginChangePassState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}
