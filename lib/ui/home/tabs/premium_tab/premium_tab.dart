import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:graduation_project/cache/cache_helper.dart';
import 'package:graduation_project/models/pay_type_dm.dart';
import 'package:graduation_project/models/payment_method_dm.dart';
import 'package:graduation_project/models/user_dm.dart';
import 'package:graduation_project/ui/home/tabs/premium_tab/premium_tab_view_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PremiumTab extends StatefulWidget {
  PremiumTab({super.key});

  @override
  State<PremiumTab> createState() => _PremiumTabState();
}

class _PremiumTabState extends State<PremiumTab> {
  int currentIndex = 0;
  PremiumTabViewModel viewModel = PremiumTabViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CacheHelper.email = CacheHelper.getUserEmail();
    CacheHelper.id = CacheHelper.getUserId();
    CacheHelper.name = CacheHelper.getUserName();
    CacheHelper.isPremium = CacheHelper.getUserIsPremium();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Go to Premium",
            style: TextStyle(
                fontSize: 30, fontFamily: "Exo", fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          ListTile(
            leading: Image(
              image: const AssetImage("assets/images/live.png"),
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            title: const Text(
              "New articles available in real time.",
              style: TextStyle(fontSize: 18, fontFamily: "Exo"),
            ),
          ),
          ListTile(
            leading: Image(
              image: const AssetImage("assets/images/5.png"),
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            title: const Text(
              "Search articles up to 5 years old.",
              style: TextStyle(fontSize: 18, fontFamily: "Exo"),
            ),
          ),
          ListTile(
            leading: Image(
              image: const AssetImage("assets/images/unlimited.png"),
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            title: const Text(
              "Unlimited Requests.",
              style: TextStyle(fontSize: 18, fontFamily: "Exo"),
            ),
          ),
          ListTile(
            leading: Image(
              image: const AssetImage("assets/images/access-control.png"),
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            title: const Text(
              "Access to extra articles and an extended source library.",
              style: TextStyle(fontSize: 18, fontFamily: "Exo"),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          const Text(
            "Our Plans: ",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "Exo"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          GridView.builder(
            itemCount: PayTypeDM.items.length,
            padding: const EdgeInsets.all(12),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.2 / 2),
            itemBuilder: (context, index) {
              return buildItemWidget(PayTypeDM.items[index], context);
            },
          )
        ],
      ),
    );
  }

  buildItemWidget(PayTypeDM item, BuildContext context) {
    return InkWell(
      onTap: () => showPayBottomSheet(item, context),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black, width: 2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.typeOfPayment,
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Exo",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                item.price,
                style: const TextStyle(fontFamily: "Poppins", fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Text(
                item.subscriptionPeriod,
                style: const TextStyle(fontFamily: "Poppins", fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }

  showPayBottomSheet(PayTypeDM item, BuildContext context) {
    currentIndex = 0;
    return showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(12),
            height: MediaQuery.of(context).size.height * 0.40,
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .08,
                    ),
                    const Text(
                      "Select Payment Method",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: "Exo",
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                buildPaymentMethodList(
                    PaymentMethodsDM.paymentMethodList, item, setState),
              ],
            ),
          );
        },
      ),
    );
  }

  buildPaymentMethodList(List<PaymentMethodsDM> paymentMethodList,
      PayTypeDM payTypeDM, void Function(void Function()) setState) {
    return DefaultTabController(
        animationDuration: Duration.zero,
        length: paymentMethodList.length,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.29,
          child: Column(
            children: [
              TabBar(
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.black,
                labelColor: Colors.transparent,
                tabs: paymentMethodList
                    .map((method) => buildPaymentMethodWidget(method,
                        currentIndex == paymentMethodList.indexOf(method)))
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: paymentMethodList
                      .map((methodView) =>
                          buildTabBarViewWidget(methodView, payTypeDM))
                      .toList(),
                ),
              )
            ],
          ),
        ));
  }

  Widget buildPaymentMethodWidget(PaymentMethodsDM method, bool isSelected) {
    return Container(
      width: 90,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          image: DecorationImage(
              image: AssetImage(method.image), fit: BoxFit.fitWidth),
          color: method.color,
          border: Border.all(
              width: isSelected ? 3.5 : 1.5,
              color: isSelected
                  ? const Color.fromARGB(255, 4, 134, 37)
                  : Colors.white)),
    );
  }

  Widget buildTabBarViewWidget(
      PaymentMethodsDM methodView, PayTypeDM payTypeDM) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        children: [
          const Spacer(),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "Pay ",
                style: const TextStyle(fontSize: 19, fontFamily: "Exo"),
                children: <TextSpan>[
                  TextSpan(
                    text: "${payTypeDM.price} ",
                    style:
                        const TextStyle(color: Color.fromARGB(255, 4, 134, 37)),
                  ),
                  const TextSpan(
                    text: "Using ",
                  ),
                  TextSpan(
                    text: "${methodView.title} ",
                    style:
                        const TextStyle(color: Color.fromARGB(255, 4, 134, 37)),
                  ),
                  TextSpan(
                    text: payTypeDM.typeOfPayment,
                  ),
                ]),
          ),
          const Spacer(),
          ElevatedButton(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 70)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))))),
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const Icon(
                      Icons.warning,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.black,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    // title: const Text("Warning..!",
                    //   style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Exo"),),
                    content: Text(
                      "Your ${methodView.title} will be used to subscribe in ${payTypeDM.typeOfPayment} subscription.",
                      style: const TextStyle(
                          color: Colors.white, fontSize: 18, fontFamily: "Exo"),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                      Navigator.pop(context);
                                      EasyLoading.show(
                                        status: 'Loading...',
                                      );
                                      UserDM.checkDocExist(UserDM(
                                          id: CacheHelper.id ??
                                              UserDM.currentUser!.id,
                                          email: CacheHelper.email ??
                                              UserDM.currentUser!.email,
                                          username: CacheHelper.name ??
                                              UserDM.currentUser!.username));
                                      Future.delayed(Duration(seconds: 3), (){
                                        if (CacheHelper.isPremium == false) {
                                          viewModel.addUserToVIPCollection(UserDM(
                                              id: CacheHelper.id ??
                                                  UserDM.currentUser!.id,
                                              email: CacheHelper.email ??
                                                  UserDM.currentUser!.email,
                                              username: CacheHelper.name ??
                                                  UserDM.currentUser!.username));
                                          EasyLoading.showSuccess(
                                              'Success!\n Welcome, Now you are on ${payTypeDM.typeOfPayment} subscription.');
                                          Future.delayed(const Duration(seconds: 3),
                                                  () {
                                                EasyLoading.showInfo(
                                                    'You should to restart app to update.');
                                              });
                                        } else {
                                          EasyLoading.showInfo(
                                              "Your are already a subscriber");
                                        }
                                      });
                              },
                              child: const Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Exo"),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Exo"),
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                "Continue",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Exo",
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}