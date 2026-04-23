class NewsModel {

  //News data mdodel
  Map<String,dynamic> source;
  String? author,title,description,url,urlToImage,publishedAt,content;

  NewsModel(this.source,this.title,this.description,this.author,this.content,this.publishedAt,this.url,this.urlToImage);

  //factory constructor
  factory NewsModel.fromJson(json) => NewsModel(
      json['source'],
      json['title'],
      json['description'],
      json['author'],
      json['content'],
      json['publishedAt'],
      json['url'],
      json['urlToImage']
  );
}