import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  bool value = true;

  final List<String> countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    // ...and so on
  ];
  void sumbitCountery(item, TextEditingController controller) {
    controller.text = item;
    emit(ChangeCountery());
  }

  void changeValues(val) {
    value = val;
    emit(ChangeWays());
  }
}