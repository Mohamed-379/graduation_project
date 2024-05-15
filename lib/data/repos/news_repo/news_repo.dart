import 'package:graduation_project/data/repos/news_repo/data_sources/online_data_sources.dart';
import '../../models/articles_response.dart';
import '../../models/sources_response.dart';

class NewsRepo
{
  OnlineDataSources onlineDataSources;
  List<Sources> sources = [];
  List<Articles> articles = [];
  List<Articles> articlesFromFirestore = [];

  NewsRepo({required this.onlineDataSources});

  Future<List<Sources>> getSources(String categoryId) async{
    sources = await onlineDataSources.getSources(categoryId);
    if(sources.isNotEmpty){
      return sources;
    }
    throw Exception("Something went wrong please try again later");
  }

  Future<List<Articles>> getArticles({String? sourceId, String? q, String? lan}) async{
    articles = await onlineDataSources.getArticles(sourceId: sourceId, lan: lan, q: q);
    if(articles.isNotEmpty){
      return articles;
    }
    throw Exception("Something went wrong please try again later");
  }

  Future<List<Articles>> getArticlesFromFirestore() async{
    articlesFromFirestore = await onlineDataSources.getArticlesFromFirestore();
    if(articlesFromFirestore.isNotEmpty){
      return articlesFromFirestore;
    }
    throw Exception("Something went wrong please try again later");
  }

  void addArticleToFireStore(Articles article){
    onlineDataSources.addArticleToFirestore(article);
  }

  void deleteArticleFromFireStore(Articles article){
    onlineDataSources.deleteArticleFromFirestore(article);
  }
}