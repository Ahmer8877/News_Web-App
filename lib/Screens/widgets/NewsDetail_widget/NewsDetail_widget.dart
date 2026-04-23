import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_web/data/models/News_Model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsdetailWidget extends StatelessWidget {
  
  final NewsModel newses;
  const NewsdetailWidget({super.key, required this.newses});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(newses.urlToImage?? '',fit: BoxFit.cover,height: 250,width: double.infinity,
          errorBuilder: (_,_,_)=>
          SizedBox(
            height: 145,
            width: double.infinity,
            child: Icon(CupertinoIcons.photo,color: CupertinoColors.inactiveGray,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child:
              //title and sources
          Column(
            children: [
              Text(newses.title?? '',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
              Text('${newses.source}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: CupertinoColors.inactiveGray),),

              SizedBox(height: 5,),


              //content and des

              Column(
                children: [
                  Text(newses.description?? '',style: TextStyle(fontWeight: FontWeight.bold)),

                  SizedBox(height: 5,),

                  Text('${newses.content}',style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),

              SizedBox(height: 5,),

              //url launcher

              InkWell(
                onTap: () async {
                  final url = newses.url ?? '';
                  if (url.isNotEmpty) {
                    await launchUrl(
                      Uri.parse(url),
                      mode: LaunchMode.externalApplication,
                    );
                  }
                },
                child: Text(newses.url ?? '',style: TextStyle(color: CupertinoColors.inactiveGray),),
              ),

              SizedBox(height: 5,),

              Column(
                children: [

                  Row(
                    children: [
                      Icon(CupertinoIcons.person_alt_circle,color: Colors.orange,),
                      Text(newses.author?? '',style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(CupertinoIcons.calendar_circle_fill,color: Colors.orange,),
                      Text(newses.publishedAt?? '',maxLines: 1,overflow: TextOverflow.ellipsis,)
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
