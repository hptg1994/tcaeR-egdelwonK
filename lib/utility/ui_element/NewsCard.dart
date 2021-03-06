import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nhkeasynews/store/main.dart';
import 'package:scoped_model/scoped_model.dart';
class NewsCard extends StatelessWidget {
  final int selectItemCardIndex;
  final MainModel model;
  NewsCard(this.selectItemCardIndex, this.model);
  bool flag = false;


  Widget _buildItemInfo(BuildContext context, String title, String date) {
    return Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(left: 10.0, bottom: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(
              title,
              style: new TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 3.0, right: 10.0),
              child: new Text(
                date,
                style: new TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[300]),
              ),
            )
          ],
        ));
  }

  Image _buildImage(imageData) {
    if (imageData == null) {
      flag = true;
      return Image.network("https://www3.nhk.or.jp/news/easy/images/banner_newsweb_pc.png");
    }

    return Image.memory(Base64Codec().decode(imageData), fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    var title = model.allNewsList[selectItemCardIndex].title;
    String date = model.allNewsList[selectItemCardIndex].news_prearranged_time;
    var img = _buildImage(model.allNewsList[selectItemCardIndex].news_photo);
    return new Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.0,offset: Offset(0.0, 5.0)) ]),
      child: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          new Hero(
            tag:"image-id:$selectItemCardIndex",
            child: new Material(
              child: new Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: flag  ? DecorationImage( image: img.image, ) : DecorationImage(image: img.image, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          new Container(
            decoration: new BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10.0)),
          ),
          _buildItemInfo(context, title, date),
          new InkWell(
            radius: 20.0,
            onTap: () {
              Navigator.of(context).pushNamed("/home/" + selectItemCardIndex.toString());
            },
          ),
        ],
      ),
    );
  }
}
