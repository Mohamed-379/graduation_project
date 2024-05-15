import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/data/repos/news_repo/data_sources/online_data_sources.dart';
import 'package:graduation_project/data/repos/news_repo/news_repo.dart';
import '../../../../data/models/sources_response.dart';

class NewsTabViewModel extends Cubit<NewsTabState>
{
  NewsRepo newsRepo = NewsRepo(onlineDataSources: OnlineDataSources());

  NewsTabViewModel(): super(NewsTabLoadingState());

  void getSources(String categoryId) async{
    emit(NewsTabLoadingState());
    try{
      List<Sources> sources = await newsRepo.getSources(categoryId);
      emit(NewsTabSuccessState(sources: sources));
    }catch(e){
      emit(NewsTabErrorState(errorText: e.toString()));
    }
  }
}

abstract class NewsTabState{}
class NewsTabLoadingState extends NewsTabState{}
class NewsTabSuccessState extends NewsTabState{
  List<Sources> sources = [];
  NewsTabSuccessState({required this.sources});
}
class NewsTabErrorState extends NewsTabState{
  String errorText;
  NewsTabErrorState({required this.errorText});
}