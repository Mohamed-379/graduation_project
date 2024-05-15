import 'package:flutter/cupertino.dart';
import 'package:graduation_project/data/repos/auth_repo/data_sources/online_data_source.dart';

class AuthRepo
{
  OnlineDataSource onlineDataSource;
  AuthRepo({required this.onlineDataSource});

  void login(BuildContext context, String email, String password){
    onlineDataSource.login(context, email, password);
  }

  void register(BuildContext context, String email, String username, String password){
    onlineDataSource.register(context, email, username, password);
  }

  void delete(BuildContext context){
    onlineDataSource.deleteUser(context);
  }
}