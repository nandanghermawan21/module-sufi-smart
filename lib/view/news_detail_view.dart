import 'package:flutter/material.dart';
import 'package:sufismart/component/basic_component.dart';
import 'package:sufismart/model/news_model.dart';
import 'package:sufismart/util/system.dart';

class NewsDetailView extends StatefulWidget {
  final NewsModel newsModel;

  const NewsDetailView({
    Key? key,
    required this.newsModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewsDetailViewState();
  }
}

class _NewsDetailViewState extends State<NewsDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicComponent.appBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BasicComponent.newsImageContainer(widget.newsModel),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                widget.newsModel.title ?? "",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: System.data.color!.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                widget.newsModel.newsContent ?? "",
              ),
            )
          ],
        ),
      ),
    );
  }
}
