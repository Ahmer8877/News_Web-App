import 'package:news_web/data/models/News_Model.dart';
import 'package:news_web/data/source/News_Api.dart';
import 'package:news_web/utils/show_successMsg.dart';

class NewsRepository {

  //News Api
NewsApi api;

//inject NewsApi with dependency
NewsRepository(this.api);

//get news data with exception handling

Future<List<NewsModel>> getNews()async{

  try{
    return await api.getNewsData();
  }catch(e){
    showFailureMsg(e.toString());
  }
  return [];
}
}