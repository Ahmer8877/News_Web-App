import 'package:flutter/cupertino.dart';
import 'package:news_web/data/models/News_Model.dart';
import 'package:news_web/data/repository/news_repository.dart';
import 'package:news_web/utils/show_successMsg.dart';

class NewsProvider with ChangeNotifier{

  //NewsRepository
  NewsRepository repo;
  //news data empty list
  List<NewsModel> newsData=[];
  //use for loading
  bool loading=false;

  //dependency injection for NewsRepository
  NewsProvider(this.repo ){
    getNews();
  }

  //get news func. with exception handling
  Future<void> getNews()async{
    try{
      loading=true;
      notifyListeners();
       newsData=await repo.getNews();
    }catch(e){
      showFailureMsg(e.toString());
    }finally{
      loading=false;
      notifyListeners();
    }
  }
}