import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graduation_project/data/models/articles_response.dart';
import '../news_tab/details/article_details_view_model.dart';
import 'article_saved_details/saved_article_details.dart';

class SavedTab extends StatefulWidget {
  const SavedTab({super.key});

  @override
  State<SavedTab> createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {

  ArticleDetailsViewModel viewModel = ArticleDetailsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getArticlesFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleDetailsViewModel, ArticlesDetailsState>(
        bloc: viewModel,
        builder: (context, state) {
          Widget currentWidget = SizedBox();
          if(state is ArticlesDetailsLoadingState){
            currentWidget = Center(child: CircularProgressIndicator());
          }
          else if(state is ArticlesDetailsSuccessState){
            currentWidget = buildArticlesList(state.articles);
          }
          else if(state is ArticlesDetailsNotFoundState){
            currentWidget = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: const AssetImage("assets/images/not_found.png"),
                    height: MediaQuery.of(context).size.height * .2,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  const Text("No articles saved yet",
                    style: TextStyle(fontSize: 35, fontFamily: "Exo", fontWeight: FontWeight.bold),)
                ],
              ),
            );
          }
          return currentWidget;
        },
    );
  }

  Widget buildArticlesList(List<Articles>? list) {
    return ListView.builder(
      itemCount: list!.length,
      itemBuilder: (context, index) => buildArticleWidget(list[index]),
    );
  }

  buildArticleWidget(Articles article) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => SavedArticleDetails(article: article))
          );
        },
        child: Slidable(
          endActionPane: ActionPane(
              extentRatio: 0.30,
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    viewModel.deleteArticleFromFireStore(article);
                  },
                  icon: Icons.delete,
                  label: "Delete",
                  backgroundColor: Colors.black,
                  //borderRadius: const BorderRadius.horizontal(right: Radius.circular(15)),
                ),
              ]),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage??"",
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: MediaQuery.of(context).size.height * 0.2,
                  placeholder: (context, url) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.height * 0.2,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: const Color.fromARGB(203, 162, 162, 162),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.height * 0.2,
                    child: const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(article.title??"", style: const TextStyle(fontSize: 14, fontFamily: "Exo"),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3,),
                    Text(article.sources!.name??"", style: const TextStyle(fontSize: 14, fontFamily: "Exo",fontWeight: FontWeight.bold),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}