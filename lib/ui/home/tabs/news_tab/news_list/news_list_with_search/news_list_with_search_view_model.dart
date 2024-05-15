import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/data/models/articles_response.dart';
import 'package:graduation_project/data/repos/news_repo/data_sources/online_data_sources.dart';
import 'package:graduation_project/data/repos/news_repo/news_repo.dart';

class NewsListWithSearchViewModel extends Cubit<NewsListWithSearchState>
{
 NewsListWithSearchViewModel(): super(NewsListWithSearchLoadingState());
  NewsRepo newsRepo = NewsRepo(onlineDataSources: OnlineDataSources());

  void getArticles(String q) async
  {
    emit(NewsListWithSearchLoadingState());
    try{
      List<Articles> articles = await newsRepo.getArticles(q: q);
      emit(NewsListWithSearchSuccessState(articles: articles));
    }catch(e){
      emit(NewsListWithSearchErrorState(errorText: e.toString()));
    }
  }
}

abstract class NewsListWithSearchState{}
class NewsListWithSearchLoadingState extends NewsListWithSearchState{}
class NewsListWithSearchSuccessState extends NewsListWithSearchState{
  List<Articles> articles;
  NewsListWithSearchSuccessState({required this.articles});
}
class NewsListWithSearchErrorState extends NewsListWithSearchState{
  String errorText;
  NewsListWithSearchErrorState({required this.errorText});
}