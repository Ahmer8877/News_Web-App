import 'package:go_router/go_router.dart';
import 'package:news_web/Screens/Main_Screen/Main_Screen.dart';
import 'package:news_web/Screens/NewsViewer_Screen/NewsViewer_Screen.dart';
import 'package:news_web/Screens/Setting_screen/Setting_Screen.dart';
import 'package:news_web/Screens/Splash_Screen/Splash_Screen.dart';
import 'package:news_web/data/models/News_Model.dart';

class GoRoutes {

  //Set all Go Routers
  static GoRouter goRoutes() => GoRouter(
    routes: [

      // Splash Screen
      GoRoute(
        path: '/',
        builder: (context, state) => SplashScreen(
          onFinished: () => context.go('/news'),
        ),
        routes: [

          // News Viewer
          GoRoute(path: 'newsViewer',name: 'newsViewer', builder: (context, state) => NewsviewerScreen(model: state.extra as NewsModel),),
          //setting route
          GoRoute(path: 'setting',name: 'setting',builder: (context,state)=> SettingScreen())
        ]
      ),
      // Main Screen
      GoRoute(path: '/news', builder: (context, state) => MainScreen(),),
    ],
  );
}