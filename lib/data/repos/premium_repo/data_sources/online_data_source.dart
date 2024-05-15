import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/user_dm.dart';

class OnlineDataSource
{
  void addUserToVIPCollection(UserDM user) async {
    CollectionReference<UserDM> vipUserCollection = UserDM.getVIPCollection();
    vipUserCollection.doc(user.id).set(user);
  }
}