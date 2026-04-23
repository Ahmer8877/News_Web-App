import 'package:flutter/material.dart';
import 'package:news_web/Screens/widgets/NewsDetail_widget/NewsDetail_widget.dart';
import 'package:news_web/data/models/News_Model.dart';

class NewsviewerScreen extends StatelessWidget {

  final NewsModel model;
  const NewsviewerScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  ListView(
        children: [
          NewsdetailWidget(newses: model,)
        ],
      ),
    );
  }
}
