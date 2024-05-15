import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/data/repos/auth_repo/auth_repo.dart';
import 'package:graduation_project/data/repos/auth_repo/data_sources/online_data_source.dart';

class HomeScreenViewModel extends Cubit<DeleteState>
{
  HomeScreenViewModel(): super(DeleteLoadingState());
  AuthRepo authRepo = AuthRepo(onlineDataSource: OnlineDataSource());

  void deleteUser(BuildContext context){
    emit(DeleteLoadingState());
    try{
      authRepo.delete(context);
      emit(DeleteSuccessState());
    }catch(e){
      emit(DeleteErrorState());
    }
  }
}

abstract class DeleteState{}
class DeleteLoadingState extends DeleteState{}
class DeleteSuccessState extends DeleteState{}
class DeleteErrorState extends DeleteState{}