// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:graduation/view/shared/component/components.dart';

import 'package:graduation/view/shared/network/payment/cubit/paypal_cubit.dart';
import 'package:graduation/view/shared/network/payment/cubit/paypal_state.dart';

import '../../../presentations/ticket/ticket.dart';
import '../../component/constants.dart';

import '../../component/helperfunctions.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {super.key,
      required this.quantity,
      required this.price,
      required this.superUserId});
  final int quantity;
  final double price;
  final String superUserId;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xc61859ba),
      appBar: AppBar(
        backgroundColor: const Color(0xc61859ba),
        title: const Text(
          "PayPal Checkout",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocBuilder<PaypalPaymentCubit, PaypalPaymentState>(
        builder: (context, state) {
          if (PaypalPaymentCubit.get(context).isPayed) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset('assets/images/correct.png')),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'successfuly!',
                          style: Styles.headLinestyle1,
                        ),
                      ),
                      Text(
                        'Your payment was done successfuly!',
                        style: Styles.headLinestyle3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: defaultButton(
                            text: "Show tickets",
                            onPressed: () => nextScreen(
                                context,
                                Ticket(
                                  superSuerID: widget.superUserId,
                                ))),
                      )
                    ]),
              ),
            ));
          } else {
            return Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset('assets/images/paypalIcon.png')),
                      defaultButton(
                        text: 'Checkout',
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => PaypalCheckout(
                              sandboxMode: true,
                              clientId:
                                  "AfdmXP-SBeraaptT86qIb7ESmiEgzr3_ebuSYRpipYbyhgAWOkfZH88BlHCkmIvIH50kNXO4VhmZblHm",
                              secretKey:
                                  "EOp0ntYJ7W6dW9127SZJQYeDGbgetSgkc95y9G0gAI4cr8oc9xon20zwN5zG7sX05MkNB7Hulc-9IlYK",
                              returnURL: "success.snippetcoder.com",
                              cancelURL: "cancel.snippetcoder.com",
                              transactions: [
                                {
                                  "amount": {
                                    "total": (widget.quantity * widget.price)
                                        .toString(),
                                    "currency": "USD",
                                    "details": {
                                      "subtotal":
                                          (widget.quantity * widget.price)
                                              .toString(),
                                      "shipping": '0',
                                      "shipping_discount": 0
                                    }
                                  },
                                  "description":
                                      "The payment transaction description.",
                                  // "payment_options": {
                                  //   "allowed_payment_method":
                                  //       "INSTANT_FUNDING_SOURCE"
                                  // },
                                  "item_list": {
                                    "items": [
                                      {
                                        "name": "FlyGate_Ticket",
                                        "quantity":
                                            (widget.quantity).toString(),
                                        "price": (widget.price).toString(),
                                        "currency": "USD"
                                      },
                                    ],

                                    // shipping address is not required though
                                    //   "shipping_address": {
                                    //     "recipient_name": "Raman Singh",
                                    //     "line1": "Delhi",
                                    //     "line2": "",
                                    //     "city": "Delhi",
                                    //     "country_code": "IN",
                                    //     "postal_code": "11001",
                                    //     "phone": "+00000000",
                                    //     "state": "Texas"
                                    //  },
                                  }
                                }
                              ],
                              note:
                                  "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                PaypalPaymentCubit.get(context)
                                    .isPayedFunc(true);
                              },
                              onError: (error) {
                                Navigator.pop(context);
                              },
                              onCancel: () {},
                            ),
                          ));
                        },
                      ),
                    ]),
              ),
            ));
            //
          }
        },
      ),
    );
  }
}
