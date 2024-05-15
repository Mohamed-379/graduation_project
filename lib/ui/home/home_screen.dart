import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/cache/cache_helper.dart';
import 'package:graduation_project/models/categories_dm.dart';
import 'package:graduation_project/models/user_dm.dart';
import 'package:graduation_project/ui/auth/login/login.dart';
import 'package:graduation_project/ui/home/home_screen_view_model.dart';
import 'package:graduation_project/ui/home/tabs/about_tab/about_tab.dart';
import 'package:graduation_project/ui/home/tabs/categories_tab/categories_tab.dart';
import 'package:graduation_project/ui/home/tabs/news_tab/news_list/news_list_arabic/news_list_arabic.dart';
import 'package:graduation_project/ui/home/tabs/news_tab/news_list/news_list_with_search/news_list_with_search.dart';
import 'package:graduation_project/ui/home/tabs/news_tab/news_tab.dart';
import 'package:graduation_project/ui/home/tabs/premium_tab/premium_tab.dart';
import 'package:graduation_project/ui/home/tabs/saved_tab/saved_tab.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "Home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  late Widget currentWidget;
  String? categoryName;
  HomeScreenViewModel viewModel = HomeScreenViewModel();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentWidget = CategoriesTab(onCategoryClick);
    CacheHelper.email = CacheHelper.getUserEmail();
    CacheHelper.id = CacheHelper.getUserId();
    CacheHelper.name = CacheHelper.getUserName();
    CacheHelper.isPremium = CacheHelper.getUserIsPremium();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if(currentWidget is! CategoriesTab)
        {
          currentWidget = CategoriesTab(onCategoryClick);
          setState(() {});
          return Future.value(false);
        }
        else
        {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:CacheHelper.isPremium?? UserDM.isExist! ? Text(currentWidget is CategoriesTab ? "Premium" : categoryName??"",
            style: const TextStyle(fontFamily: "Exo",fontSize: 30,color: Colors.white, fontWeight: FontWeight.bold),) :
          Text(currentWidget is CategoriesTab ? "MediaWorld" : categoryName??"",
            style: const TextStyle(fontFamily: "Exo",fontSize: 30,color: Colors.white, fontWeight: FontWeight.bold),),
          centerTitle: true,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
          ),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: animSearchBar(textEditingController)
            ),
          ],
          toolbarHeight: MediaQuery.of(context).size.height * .09,
          iconTheme: IconThemeData(color: Colors.white, size: MediaQuery.of(context).size.height * 0.04),
        ),
         drawer: Drawer(
           clipBehavior: Clip.antiAliasWithSaveLayer,
           child: Column(
             children: [
               Container(
                 padding: const EdgeInsets.all(12),
                 height: MediaQuery.of(context).size.height * 0.25,
                 width: double.infinity,
                 color: Colors.black,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
                     Center(
                       child: Text("Welcome ${CacheHelper.name?.split(' ').first ?? UserDM.currentUser!.username.split(' ').first}!",
                         style: const TextStyle(color: Colors.white, fontSize: 28,fontFamily: "Exo", fontWeight: FontWeight.bold),
                         textAlign: TextAlign.center,
                       ),
                     ),
                     const Spacer(),
                     Text("Username: ${CacheHelper.name??UserDM.currentUser!.username}",
                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white,fontFamily: "Exo"),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                     ),
                     Text("Email: ${CacheHelper.email??UserDM.currentUser!.email}",
                       style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white,fontFamily: "Exo"),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                     ),
                     Spacer()
                   ],
                 ),
               ),
               buildMenuItems(),
             ],
           ),
         ),
         drawerEnableOpenDragGesture: false,
         body: currentWidget
      ),
    );
  }

  onCategoryClick(CategoryDM categoryDM)
  {
    setState(() {
      currentWidget = NewsTab(categoryDM.id);
      categoryName = categoryDM.title;
    });
  }

  buildMenuItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => widgetNavigation(CategoriesTab(onCategoryClick)),
            child: buildRow(imagePath: "assets/images/categories.png", title: "Categories")),
        InkWell(
            onTap: () => widgetNavigation(NewsListArabic("cnn", "ar")),
            child: buildRow(imagePath: "assets/images/arab.png", title: "Arabic Articles")),
        InkWell(
            onTap: () => widgetNavigation(const SavedTab()),
            child: buildRow(imagePath: "assets/images/saved.png", title: "Saved")),
        InkWell(
            onTap: () => widgetNavigation(PremiumTab()),
            child: buildRow(imagePath: "assets/images/premium1.png", title: "Get Premium")),
        InkWell(
            onTap: () => widgetNavigation(AboutTab()),
            child: buildRow(imagePath: "assets/images/about.png", title: "About")),
        const Divider(),
        InkWell(
            onTap: () {
              CacheHelper.deleteUserId();
              CacheHelper.deleteUserEmail();
              CacheHelper.deleteUserName();
              CacheHelper.deleteUserIsPremium();
              Navigator.pushReplacementNamed(context, Login.routeName);
            },
            child: buildRow(imagePath: "assets/images/logout.png", title: "Log Out")),
        InkWell(
            onTap: () => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                title: Center(child: Text("Delete Confirmation", style: TextStyle(color: Colors.white, fontFamily: "Exo"),)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("You are about to delete your account: ", style: TextStyle(fontFamily: "Exo", color: Colors.white),),
                    Text(CacheHelper.email??UserDM.currentUser!.email, style: TextStyle(fontFamily: "Exo", color: Colors.red),),
                    SizedBox(height: 8,),
                    Text("All associated data will also be deleted!", style: TextStyle(fontFamily: "Exo", color: Colors.white),),
                    Row(
                      children: [
                        Text("Are you sure?", style: TextStyle(fontFamily: "Exo", color: Colors.white),),
                        Text("There is no undo", style: TextStyle(fontFamily: "Exo", color: Colors.red),),
                      ],
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("No, keep the account", style: TextStyle(color: Colors.white, fontFamily: "Exo"),)
                  ),
                  TextButton(
                      onPressed: () {
                        viewModel.deleteUser(context);
                      },
                      child: Text("Yes, delete this account", style: TextStyle(color: Colors.red, fontFamily: "Exo"),)
                  ),
                ],

              ),
            ),
            child: buildRow(imagePath: "assets/images/delete_account.png", title: "Delete Account")
        ),
        CacheHelper.isPremium??UserDM.isExist! ? Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
              child: Image(image: const AssetImage("assets/images/premium0.png"),
                height: MediaQuery.of(context).size.height * .040,
                color: Colors.black,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * .03,),
            const Text("Premium Version",
              style: TextStyle(color: Colors.black, fontSize: 28,fontFamily: "Exo", fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ):
        SizedBox(),
      ],
    );
  }

  Widget buildRow({ required String imagePath, required String title})
  {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Image(image: AssetImage(imagePath),
          height: MediaQuery.of(context).size.height * 0.055,
        ),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: "Exo"),),
      ),
    );
  }

  void widgetNavigation(Widget nextWidget)
  {
    setState(() {
      currentWidget = nextWidget;
      if (currentWidget is SavedTab){
        categoryName = "Saved";
      }
      else if (currentWidget is NewsListArabic){
        categoryName = "Arabic Articles";
      }
      else if (currentWidget is PremiumTab){
        categoryName = "Get Premium";
      }
      else if(currentWidget is AboutTab){
        categoryName = "About";
      }
    });
    Navigator.pop(context);
  }

  animSearchBar(TextEditingController textEditingController) {
    return AnimSearchBar(
      width: 300,
      textController: textEditingController,
      onSuffixTap: (_){},
      onSubmitted: (_) {
        if(textEditingController.text.isNotEmpty)
          {
            setState(() {
              categoryName = textEditingController.text;
              currentWidget = NewsListWithSearch(textEditingController.text);
            });
          }
      },
      color: Colors.transparent,
      prefixIcon: Icon(Icons.search, size: MediaQuery.of(context).size.height * 0.04,),
      autoFocus: true,
      style: const TextStyle(fontFamily: "Exo", fontSize: 18, fontWeight: FontWeight.w500),
    );
  }
}