import 'package:graduation_project/models/user_dm.dart';

import 'data_sources/online_data_source.dart';

class PremiumRepo
{
  OnlineDataSource onlineDataSource;

  PremiumRepo({required this.onlineDataSource});

  void addUserToVIPCollection(UserDM user)
  {
    onlineDataSource.addUserToVIPCollection(user);
  }
}