import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/data/repos/news_repo/data_sources/online_data_sources.dart';
import 'package:graduation_project/data/models/articles_response.dart';
import 'package:graduation_project/data/repos/news_repo/news_repo.dart';

class NewsListWithSourceViewModel extends Cubit<NewsListWithSourceState>
{
  NewsListWithSourceViewModel(): super(NewsListLoadingState());
  NewsRepo newsRepo = NewsRepo(onlineDataSources: OnlineDataSources());

  void getArticles(String sourceId) async{
    emit(NewsListLoadingState());
    try{
      List<Articles> articles = await newsRepo.getArticles(sourceId: sourceId);
      emit(NewsListSuccessState(articles: articles));
    }catch(e){
      emit(NewsListErrorState(errorText: e.toString()));
    }
  }
}

abstract class NewsListWithSourceState{}
class NewsListLoadingState extends NewsListWithSourceState{}
class NewsListSuccessState extends NewsListWithSourceState{
  List<Articles> articles;
  NewsListSuccessState({required this.articles});
}
class NewsListErrorState extends NewsListWithSourceState{
  String errorText;
  NewsListErrorState({required this.errorText});
}