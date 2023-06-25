part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class ChangeCountery extends SearchState {}

class ChangeWays extends SearchState {}

class ChangeDate extends SearchState {}