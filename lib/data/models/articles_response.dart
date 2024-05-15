import 'package:graduation_project/data/models/sources_response.dart';

class ArticlesResponse {
  ArticlesResponse({
      this.status, 
      this.totalResults, 
      this.articles,
      this.code,
      this.message});

  ArticlesResponse.fromJson(dynamic json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(Articles.fromJson(v));
      });
    }
    code = json["code"];
    message = json["message"];
  }
  String? status;
  int? totalResults;
  List<Articles>? articles;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['totalResults'] = totalResults;
    if (articles != null) {
      map['articles'] = articles?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}

class Articles {
  static const String collectionName = "Articles";

  Articles({
    this.sources,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.id,
  });

  Articles.fromJson(dynamic json) {
    sources = json['source'] != null ? Sources.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
    id = json['id'];
  }

  String? id;
  Sources? sources;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (sources != null) {
      map['source'] = sources?.toJson();
    }
    map['author'] = author;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['urlToImage'] = urlToImage;
    map['publishedAt'] = publishedAt;
    map['content'] = content;
    map['id'] = id;
    return map;
  }
}