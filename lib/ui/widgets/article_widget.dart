import 'package:flutter/material.dart';
import 'package:graduation_project/data/models/articles_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../home/tabs/news_tab/details/article_details.dart';

class ArticleWidget extends StatelessWidget {
  final Articles article;
  const ArticleWidget({super.key, required this.article});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleDetails(article: article))
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage??"",
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.265,
                placeholder: (context, url) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.265,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: const Color.fromARGB(203, 162, 162, 162),
                  height: MediaQuery.of(context).size.height * 0.265,
                  child: const Center(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(article.sources?.name ?? "",
                        style: const TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(218, 64, 64, 64))),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(article.title ?? "",
                        style: const TextStyle(
                          fontFamily: "Exo",
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("${DateTime.parse(article.publishedAt ?? "").day.toString()}-"
                        "${DateTime.parse(article.publishedAt ?? "").month.toString()}-"
                        "${DateTime.parse(article.publishedAt ?? "").year.toString()}",
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "Exo"),
                      textAlign: TextAlign.end,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}