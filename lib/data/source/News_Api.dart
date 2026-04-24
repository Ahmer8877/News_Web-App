import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:news_web/data/models/News_Model.dart';
import 'package:news_web/utils/show_successMsg.dart';

class NewsApi {

  //Api url with key
  String baseUrl='https://newsapi.org/v2/everything?q=tesla&from=2026-03-24&sortBy=publishedAt&apiKey=95c636f335c4442a961c164c981f9920';

  //get data func. with exception handling
Future<List<NewsModel>> getNewsData()async{

  try{
    final response=await http.get(Uri.parse(baseUrl));
    final data=jsonDecode(response.body);
    List newsList=data['articles'];
    return  newsList.map((e) => NewsModel.fromJson(e)).toList();

  }catch(e){
    showFailureMsg(e.toString());
  }
  return [];
}
}