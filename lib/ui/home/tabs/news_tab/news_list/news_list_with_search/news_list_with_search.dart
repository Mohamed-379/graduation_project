import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/data/models/articles_response.dart';
import 'package:graduation_project/ui/home/tabs/news_tab/news_list/news_list_with_search/news_list_with_search_view_model.dart';
import 'package:graduation_project/ui/widgets/error_dialog.dart';
import '../../../../../widgets/article_widget.dart';

class NewsListWithSearch extends StatefulWidget {
  String q;

  NewsListWithSearch(this.q, {super.key});

  @override
  State<NewsListWithSearch> createState() => _NewsListWithSearchState();
}

class _NewsListWithSearchState extends State<NewsListWithSearch> {
  NewsListWithSearchViewModel viewModel = NewsListWithSearchViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getArticles(widget.q);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsListWithSearchViewModel, NewsListWithSearchState>(
      bloc: viewModel,
      builder: (context, state) {
        Widget currentWidget;
        if(state is NewsListWithSearchErrorState){
          currentWidget = ErrorDialog(message: state.errorText);
        }
        else if(state is NewsListWithSearchSuccessState){
          currentWidget = buildArticleList(state.articles);
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