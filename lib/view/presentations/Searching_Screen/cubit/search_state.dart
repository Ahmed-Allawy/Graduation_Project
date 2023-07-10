part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class ChangeCountery extends SearchState {}

class ChangePeople extends SearchState {}

class ChangeCountry extends SearchState {}

class ChangeWays extends SearchState {}

class ChangeGender extends SearchState {}

class ChangeClass extends SearchState {}

class ChangeDate extends SearchState {}

class ChangeFlexable extends SearchState {}

class AddPersonField extends SearchState {}

class RemovePersonField extends SearchState {}

class GenderStateChanger extends SearchState {}

class ImageCameraSuccessful extends SearchState {}

class ImageCameraError extends SearchState {
  final String error;
  ImageCameraError(this.error);
}

class GetAllFligthSuccssful extends SearchState {}

class GetAllFligtherror extends SearchState {
  final String error;

  GetAllFligtherror(this.error);
}

class GetAllFligthCustomeSuccssful extends SearchState {}

class GetAllFligthCustomeerror extends SearchState {
  final String error;

  GetAllFligthCustomeerror(this.error);
}
