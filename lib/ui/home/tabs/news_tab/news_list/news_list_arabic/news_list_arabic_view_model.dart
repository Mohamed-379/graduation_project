import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/data/repos/news_repo/data_sources/online_data_sources.dart';
import 'package:graduation_project/data/repos/news_repo/news_repo.dart';
import '../../../../../../data/models/articles_response.dart';

class NewsListArabicViewModel extends Cubit<NewsListArabicState>
{
  NewsListArabicViewModel(): super(NewsListArabicLoadingState());
  NewsRepo newsRepo = NewsRepo(onlineDataSources: OnlineDataSources());
  void getArticles(String sourceId, String lang) async{
    emit(NewsListArabicLoadingState());
    try{
      List<Articles> articles = await newsRepo.getArticles(sourceId: sourceId, lan: lang);
      emit(NewsListArabicSuccessState(articles: articles));
    }catch(e){
      emit(NewsListArabicErrorState(errorText: e.toString()));
    }
  }
}

abstract class NewsListArabicState{}
class NewsListArabicLoadingState extends NewsListArabicState{}
class NewsListArabicSuccessState extends NewsListArabicState{
  List<Articles> articles;
  NewsListArabicSuccessState({required this.articles});
}
class NewsListArabicErrorState extends NewsListArabicState{
  String errorText;
  NewsListArabicErrorState({required this.errorText});
}