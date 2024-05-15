import 'package:flutter/material.dart';

class PaymentMethodsDM
{
  String image;
  String title;
  Color? color;
  PaymentMethodsDM({required this.color ,required this.image, required this.title});

  static List<PaymentMethodsDM> paymentMethodList = [
    PaymentMethodsDM(color: Colors.white, image: "assets/images/visa.png", title: "Visa"),
    PaymentMethodsDM(color:  Colors.transparent, image: "assets/images/master_card.jpg", title: "Master Card"),
    PaymentMethodsDM(color:  Colors.transparent, image: "assets/images/vodafone_cash.png", title: "Vodafone Cash"),
    PaymentMethodsDM(color:  const Color.fromARGB(255, 76, 9, 109), image: "assets/images/instaPay.png", title: "InstaPay"),
  ];
}