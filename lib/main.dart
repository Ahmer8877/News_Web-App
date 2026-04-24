import 'package:flutter/material.dart';
import 'package:news_web/data/provider/news_provider.dart';
import 'package:news_web/data/provider/settng-provider/theme_provider.dart';
import 'package:news_web/data/repository/news_repository.dart';
import 'package:news_web/data/source/News_Api.dart';
import 'package:news_web/utils/go_routes.dart';
import 'package:provider/provider.dart';


//scaffold messenger key
final scaffoldMessengerKey=GlobalKey<ScaffoldMessengerState>();

//main func.
void main(){
  runApp(const newsApp());
}

class newsApp extends StatelessWidget {
  const newsApp({super.key});

  @override
  Widget build(BuildContext context) {


    //multi provider
    return MultiProvider(
        providers: [
          Provider(create: (context)=> NewsApi()),
          Provider(create: (context)=> NewsRepository(context.read<NewsApi>())),
          
          ChangeNotifierProvider(create: (context)=> NewsProvider(context.read<NewsRepository>())),
          ChangeNotifierProvider(create: (context)=>ThemeProvider())
        ],
      //MaterialApp with go router
      child: Consumer<ThemeProvider>(
        builder: (context,provider,child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: scaffoldMessengerKey,
            themeMode: provider.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            routerConfig: GoRoutes.goRoutes(),
          );
        }
      ),
    );
  }
}
