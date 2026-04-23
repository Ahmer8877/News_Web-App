import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_web/Screens/widgets/newsScreen_widget/newsScreen_Widget.dart';
import 'package:news_web/data/models/News_Model.dart';
import 'package:news_web/data/provider/news_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('APNI', style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
            Text('WAVES', style: TextStyle(color: Colors.brown,fontSize: 25,fontWeight: FontWeight.bold),),
          ],
        ),

        leading: Image.asset('assets/images/news.png'),

        //actions
        actions: [
          PopupMenuButton(
              itemBuilder: (context) =>[
                PopupMenuItem(
                  onTap: (){
                    context.goNamed('setting');
                  },
                    child: Row(children: [
                      Icon(CupertinoIcons.settings,size:20,color: Colors.black,),
                      Text('Settings'),
                    ],
                    )
                ),
              ]
          )
        ],
        centerTitle: true,
      ),
      
      body:
      Consumer<NewsProvider>(
          builder: (context,provider,child){

            return provider.loading? Center(child: CircularProgressIndicator(),) : ListView(
              children: [

                for(NewsModel model in provider.newsData)

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
                    child: Card(
                      shadowColor: CupertinoColors.inactiveGray,
                      child: NewsscreenWidget(news: model,)
                    ),
                  ),
              ],
            );
          }
      ),
    );
  }
}
