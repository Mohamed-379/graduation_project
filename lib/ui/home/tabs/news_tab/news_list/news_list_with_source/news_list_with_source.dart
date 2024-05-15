import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/data/models/articles_response.dart';
import 'package:graduation_project/ui/widgets/error_dialog.dart';
import '../../../../../widgets/article_widget.dart';
import 'news_list_with_source_view_model.dart';

class NewsListWithCategory extends StatefulWidget {
  String? source;
  NewsListWithCategory(this.source, {super.key});

  @override
  State<NewsListWithCategory> createState() => _NewsListWithCategoryState();
}

class _NewsListWithCategoryState extends State<NewsListWithCategory> {
  NewsListWithSourceViewModel viewModel = NewsListWithSourceViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getArticles(widget.source!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsListWithSourceViewModel, NewsListWithSourceState>(
        bloc: viewModel,
        builder: (context, state) {
          Widget currentWidget;
          if(state is NewsListErrorState){
            currentWidget = ErrorDialog(message: state.errorText);
          }
          else if(state is NewsListSuccessState){
            currentWidget =  buildArticleList(state.articles);
          }
          else{
            currentWidget = Center(child: CircularProgressIndicator());
          }
          return currentWidget;
        },
    );
  }
}

Widget buildArticleList(List<Articles>? articlesList) {
  return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: articlesList!.length,
      itemBuilder: (context, index) => ArticleWidget(article: articlesList[index],),
  );
}