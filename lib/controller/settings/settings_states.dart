abstract class SettingsStates {}

class InitialSettingsState extends SettingsStates {}

class GetProfileLoadingState extends SettingsStates {}

class GetProfileSuccessState extends SettingsStates {}

class GetProfileFailureState extends SettingsStates {}

class UpdateUserLoadingState extends SettingsStates {}

class UpdateUserSuccessState extends SettingsStates {}

class UpdateUserFailureState extends SettingsStates {
  final String errorMessage;

  UpdateUserFailureState({required this.errorMessage});
}

class UpdateUserPasswordLoadingState extends SettingsStates {}

class UpdateUserPasswordSuccessState extends SettingsStates {}

class UpdateUserPasswordFailureState extends SettingsStates {
  final String errorMessage;

  UpdateUserPasswordFailureState({required this.errorMessage});
}

class ChangePasswordVisibility extends SettingsStates {}
