import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:graduation_project/data/models/articles_response.dart';
import 'package:graduation_project/data/repos/news_repo/data_sources/online_data_sources.dart';
import 'package:graduation_project/data/repos/news_repo/news_repo.dart';

class ArticleDetailsViewModel extends Cubit<ArticlesDetailsState>
{
  List<Articles> articles = [];
  NewsRepo newsRepo = NewsRepo(onlineDataSources: OnlineDataSources());

  ArticleDetailsViewModel(): super(ArticlesDetailsLoadingState());

  void getArticlesFromFirestore() async
  {
    emit(ArticlesDetailsLoadingState());
    try{
      articles = await newsRepo.getArticlesFromFirestore();
      if(articles.isNotEmpty){
        emit(ArticlesDetailsSuccessState(articles: articles));
      }
    }catch(e){
      emit(ArticlesDetailsNotFoundState());
    }
  }

  void addArticleToFireStore(Articles article)
  {
      newsRepo.addArticleToFireStore(article);
      EasyLoading.showToast("Saved Article Successfully", toastPosition: EasyLoadingToastPosition.bottom);

  }

  void deleteArticleFromFireStore(Articles article) async
  {
      newsRepo.deleteArticleFromFireStore(article);
      getArticlesFromFirestore();
      emit(ArticlesDetailsSuccessState(articles: articles));
      EasyLoading.showToast("Delete Article Successfully", toastPosition: EasyLoadingToastPosition.bottom);
  }
}

abstract class ArticlesDetailsState{}
class ArticlesDetailsLoadingState extends ArticlesDetailsState{}
class ArticlesDetailsSuccessState extends ArticlesDetailsState{
  List<Articles> articles;
  ArticlesDetailsSuccessState({required this.articles});
}
class ArticlesDetailsNotFoundState extends ArticlesDetailsState{}