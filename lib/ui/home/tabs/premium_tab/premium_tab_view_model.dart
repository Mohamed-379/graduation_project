import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/data/repos/premium_repo/data_sources/online_data_source.dart';
import 'package:graduation_project/data/repos/premium_repo/premium_repo.dart';
import 'package:graduation_project/models/user_dm.dart';

class PremiumTabViewModel extends Cubit<PremiumState> {

  PremiumRepo premiumRepo = PremiumRepo(onlineDataSource: OnlineDataSource());

  PremiumTabViewModel(): super(ExistState());

  void addUserToVIPCollection(UserDM user) {
    emit(AddingState());
    try{
      premiumRepo.addUserToVIPCollection(user);
      emit(AddedState());
    }catch(e){
      emit(ExistState());
    }
  }
}

abstract class PremiumState{}
class AddingState extends PremiumState{}
class AddedState extends PremiumState{}
class ExistState extends PremiumState{}