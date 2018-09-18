import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nhkeasynews/models/NewsList.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedProductsModel extends Model {
  bool _isLoading = false;
  List<NewsList> _newsList = [];
}

class NewsListModel extends ConnectedProductsModel {
  List<NewsList> get allNewsList {
    return List.from(_newsList);
  }

  Future<Null> startGetAllNewsList() {
    _isLoading = true;
    http.get("http://localhost:8080/api/news").then((http.Response response) {
      final List<NewsList> fetchNewsList = [];
      List<dynamic> newslistData = json.decode(response.body);
      if (newslistData == null) {
        return;
      }
      newslistData.forEach((dynamic newsdata) {
        final NewsList newsList = NewsList(
            news_id: newsdata["news_id"],
            title: newsdata["title"],
            title_with_ruby: newsdata["title_with_ruby"],
            news_prearranged_time: newsdata["news_prearranged_time"],
            news_web_url: newsdata["news_web_url"]);
        fetchNewsList.add(newsList);
      });
      _isLoading = false;
      _newsList = fetchNewsList;
      notifyListeners();
    }).catchError((error){
      _isLoading = false;
      print(error);
      return;
    });
  }
}