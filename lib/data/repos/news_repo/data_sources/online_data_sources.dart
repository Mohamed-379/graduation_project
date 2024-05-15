import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/cache/cache_helper.dart';
import 'package:graduation_project/data/models/articles_response.dart';
import 'package:graduation_project/data/models/sources_response.dart';
import 'package:graduation_project/models/user_dm.dart';
import 'package:http/http.dart';

class OnlineDataSources
{
  static const String baseUrl = "newsapi.org";
  static const String sourcesEndPointName = "/v2/top-headlines/sources";
  static const String articlesEndPointName = "/v2/everything";
  static const String apiKey = "faf82f8c8199487ba373e64d67d5463b";
  static List<Articles> articles = [];

  Future<List<Sources>>getSources(String category) async
  {
    //todo: parse the data type from "String" to object of "Uri"
    Uri url = Uri.parse("https://$baseUrl$sourcesEndPointName?apiKey=$apiKey&category=$category");
    //todo: Make a request
    Response response = await get(url);
    Map json = jsonDecode(response.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
    if(response.statusCode >= 200 && response.statusCode < 300 && sourcesResponse.sources?.isNotEmpty == true)
      {
        return sourcesResponse.sources!;
      }

    throw sourcesResponse.message??"Something went wrong please tru again later";
  }

  Future<List<Articles>>getArticles({String? sourceId, String? q, String? lan}) async
  {
    Uri url = Uri.https(baseUrl, articlesEndPointName, {
      "apiKey": apiKey,
      "sources": sourceId,
      "q": q,
      "language": lan
    });

   Response response = await get(url);
   Map json = jsonDecode(response.body);
   ArticlesResponse articlesResponse = ArticlesResponse.fromJson(json);
   if(response.statusCode >= 200 && response.statusCode < 300 && articlesResponse.articles?.isNotEmpty == true)
     {
       return articlesResponse.articles!;
     }
   throw articlesResponse.message??"Something went wrong please try again later";
  }

  Future<List<Articles>> getArticlesFromFirestore() async
  {
    CollectionReference<Articles> articlesCollectionReference =
    UserDM.getCollection().doc(CacheHelper.id??UserDM.currentUser!.id).collection(Articles.collectionName).
    withConverter(
        fromFirestore: (snapshot, options) {
          Map json = snapshot.data() as Map;
          Articles articles = Articles.fromJson(json);
          return articles;
        },
        toFirestore: (value, options) {
          return value.toJson();
        },
    );

   QuerySnapshot<Articles> querySnapshot =  await articlesCollectionReference.get();
   List<QueryDocumentSnapshot<Articles>> docs = querySnapshot.docs;
   articles = docs.map((article) {
     return article.data();
   }).toList();
   if(articles.isNotEmpty)
     {
       return articles;
     }
   throw "Something went wrong please try again later";
  }

  void addArticleToFirestore(Articles articles) {
    CollectionReference articlesCollectionReference = UserDM.getCollection().doc(CacheHelper.id??UserDM.currentUser!.id).collection(Articles.collectionName);
    DocumentReference documentReference = articlesCollectionReference.doc();
    articles.id = documentReference.id;
    documentReference.set(articles.toJson());
  }

  void deleteArticleFromFirestore(Articles articles) {
    CollectionReference articlesCollectionReference = UserDM.getCollection().doc(CacheHelper.id??UserDM.currentUser!.id).collection(Articles.collectionName);
    DocumentReference documentReference = articlesCollectionReference.doc(articles.id);
    documentReference.delete();
  }
}