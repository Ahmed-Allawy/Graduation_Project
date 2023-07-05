import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mytirps_state.dart';

class PersonTripsCubit extends Cubit<PersonTripsState> {
  PersonTripsCubit() : super(PersonTripsStateInitial());

  static PersonTripsCubit get(BuildContext context) => BlocProvider.of(context);
}
