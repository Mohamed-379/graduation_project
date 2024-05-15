class PayTypeDM
{
  String typeOfPayment;
  String price;
  String subscriptionPeriod;

  PayTypeDM({required this.typeOfPayment, required this.price, required this.subscriptionPeriod});

  static List<PayTypeDM> items = [
    PayTypeDM(
        typeOfPayment: "Yearly",
        price: "\$99.99",
        subscriptionPeriod: "1 Year"
    ),
    PayTypeDM(
        typeOfPayment: "Quarterly",
      price: "\$49.99",
      subscriptionPeriod: "6 Months"
    ),
    PayTypeDM(
        typeOfPayment: "Monthly",
      price: "\$9.99",
      subscriptionPeriod: "1 Month"
    ),
  ];
}