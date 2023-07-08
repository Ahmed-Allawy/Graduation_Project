part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class ScurityState extends AuthState {}

class ChangeCountry extends AuthState {}
