import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/cache/cache_helper.dart';

class UserDM{
  static UserDM? currentUser;
  static bool? isExist;
  static const String collectionName = "Users";
  static const String collectionNameVIP = "VIPUsers";
  late String id;
  late String email;
  late String username;

  UserDM({required this.id, required this.email, required this.username});

  UserDM.fromJson(Map json){
    id = json["id"];
    email = json["email"];
    username = json["user_name"];
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "email" : email,
      "user_name" : username
    };
  }

  static CollectionReference<UserDM> getCollection()
  {
    return FirebaseFirestore.instance.collection(UserDM.collectionName).
    withConverter<UserDM>(
      fromFirestore: (snapshot, _) {
        return UserDM.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  static CollectionReference<UserDM> getVIPCollection()
  {
    return FirebaseFirestore.instance.collection(UserDM.collectionNameVIP).
    withConverter<UserDM>(
      fromFirestore: (snapshot, _) {
        return UserDM.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }


  static void checkDocExist(UserDM user) async
  {
    CollectionReference<UserDM> vipUserCollection = UserDM.getVIPCollection();
    var docRef = await vipUserCollection.doc(user.id).get();
    if(docRef.exists)
    {
      UserDM.isExist = true;
      CacheHelper.setUserIsPremium(true);
      CacheHelper.isPremium = CacheHelper.getUserIsPremium();
    }
    else
    {
      UserDM.isExist = false;
      CacheHelper.setUserIsPremium(false);
      CacheHelper.isPremium = CacheHelper.getUserIsPremium();
    }
  }
}