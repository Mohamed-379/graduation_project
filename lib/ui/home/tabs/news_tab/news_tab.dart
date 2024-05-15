import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/data/models/sources_response.dart';
import 'package:graduation_project/ui/home/tabs/news_tab/news_tab_view_model.dart';
import 'package:graduation_project/ui/widgets/error_dialog.dart';
import 'news_list/news_list_with_source/news_list_with_source.dart';

class NewsTab extends StatefulWidget {
  String categoryId;
  NewsTab(this.categoryId ,{super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentIndex = 0;
  NewsTabViewModel viewModel = NewsTabViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getSources(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsTabViewModel, NewsTabState>(
      bloc: viewModel,
      builder: (context, state) {
        Widget currentWidget;
        if(state is NewsTabErrorState){
          currentWidget = ErrorDialog(message: state.errorText);
        }
        else if(state is NewsTabSuccessState){
          currentWidget = buildTabs(state.sources);
        }
        else{
          currentWidget = Center(child: CircularProgressIndicator());
        }
        return currentWidget;
      },
    );
  }

  Widget buildTabs(List<Sources>? list) {
    return DefaultTabController(
      length: list!.length,
      child: Column(
        children: [
          TabBar(onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
            padding: const EdgeInsets.all(5),
            tabAlignment: TabAlignment.start,
            tabs: list.map((source) => sourceTabWidget(source.name??"", currentIndex == list.indexOf(source))).toList(),
            isScrollable: true,
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,),
          Expanded(child:
            TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: list.map((source) => NewsListWithCategory(source.id!)).toList(),
          ))
        ],
      ),
    );
  }

  Widget sourceTabWidget(String? name, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2,color: Colors.black),
        color: isSelected ? Colors.black : Colors.white,
      ),
      child: Text(name!,
        style: TextStyle(fontFamily: "Exo",fontSize: 16, color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold),),
    );
  }
}