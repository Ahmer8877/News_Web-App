import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_web/data/models/News_Model.dart';

class NewsscreenWidget extends StatelessWidget {
  final NewsModel news;
  const NewsscreenWidget({super.key, required this.news});

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: (){
        context.goNamed('newsViewer',extra: news);
      },
      child: Column(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(news.urlToImage?? '',
              height: 200,width: double.infinity,fit: BoxFit.cover,
              errorBuilder: (_,_,_)=>
                  SizedBox(
                    height: 145,
                    width: double.infinity,
                    child: Icon(CupertinoIcons.photo,color: CupertinoColors.inactiveGray,),
              ),
            ),
          ),

          //title and des..

          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              spacing: 5,
              children: [
                Text(news.title?? '',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'MyFont'),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text(news.description?? '',style: TextStyle(overflow: TextOverflow.ellipsis),maxLines: 3,)
              ],
            ),
          ),

          SizedBox(height: 10,),

          //author and created at

          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              spacing: 3,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.person_alt_circle,color: Colors.orange,),
                    Text(news.author?? '',style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),)
                  ],
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.calendar_circle_fill,color: Colors.orange,),
                    Text(news.publishedAt?? '',maxLines: 1,overflow: TextOverflow.ellipsis,)
                ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
