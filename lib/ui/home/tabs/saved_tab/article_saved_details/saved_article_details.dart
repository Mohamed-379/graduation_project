import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/data/models/articles_response.dart';
import 'package:url_launcher/url_launcher.dart';

class SavedArticleDetails extends StatefulWidget {
  Articles article;

  SavedArticleDetails({super.key, required this.article});

  @override
  State<SavedArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<SavedArticleDetails> {
  Uri? url;

  @override
  Widget build(BuildContext context) {
    url = Uri.parse(widget.article.url??"");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.article.sources!.name??"", style: const TextStyle(fontFamily: "Exo",fontSize: 30,color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),),
        toolbarHeight: MediaQuery.of(context).size.height * .09,
        iconTheme: IconThemeData(color: Colors.white, size: MediaQuery.of(context).size.height * 0.04),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.check_circle)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: CachedNetworkImage(
                  imageUrl: widget.article.urlToImage??"",
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Text(widget.article.title??"", style: const TextStyle(fontFamily: "Exo", fontWeight: FontWeight.w500,fontSize: 22),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              Text(widget.article.content??"", style: const TextStyle(fontFamily: "Exo", fontWeight: FontWeight.w500,fontSize: 18),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2.23),
                child: TextButton(
                    style: const ButtonStyle(alignment: Alignment.bottomRight),
                    onPressed: () async{
                      _launchUrl(url!);
                    },
                    child: const Text("View Full Article",
                      style: TextStyle(decoration: TextDecoration.underline,color: Colors.black ,fontWeight: FontWeight.bold,fontFamily: "Exo", fontSize: 19),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
}