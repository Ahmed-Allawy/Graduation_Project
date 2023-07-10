import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/view/shared/network/payment/cubit/paypal_state.dart';

class PaypalPaymentCubit extends Cubit<PaypalPaymentState> {
  PaypalPaymentCubit() : super(PaypalPaymentStateInitial());

  static PaypalPaymentCubit get(BuildContext context) =>
      BlocProvider.of(context);

  bool isPayed = false;

  void isPayedFunc(bool value) {
    isPayed = value;
    emit(PaypalPaymentStateChange());
  }
}
