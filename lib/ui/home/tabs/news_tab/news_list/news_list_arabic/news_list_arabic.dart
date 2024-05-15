import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/data/models/articles_response.dart';
import 'package:graduation_project/ui/home/tabs/news_tab/news_list/news_list_arabic/news_list_arabic_view_model.dart';
import 'package:graduation_project/ui/widgets/error_dialog.dart';
import '../../../../../widgets/article_widget.dart';

class NewsListArabic extends StatefulWidget {
  String source;
  String lang;

  NewsListArabic(this.source, this.lang, {super.key});

  @override
  State<NewsListArabic> createState() => _NewsListArabicState();
}

class _NewsListArabicState extends State<NewsListArabic> {
  NewsListArabicViewModel viewModel = NewsListArabicViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getArticles(widget.source, widget.lang);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsListArabicViewModel, NewsListArabicState>(
      bloc: viewModel,
      builder: (context, state) {
        Widget currentWidget;
        if(state is NewsListArabicErrorState){
          currentWidget = ErrorDialog(message: state.errorText);
        }
        else if(state is NewsListArabicSuccessState){
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