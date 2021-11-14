import 'package:eigital_sample_app/models/news.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final News news;
  const NewsCard({ Key? key, required this.news }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.network(news.urlToImage ?? 'https://mpama.com/wp-content/uploads/2017/04/default-image.jpg',width: 150,height: 150,fit: BoxFit.fitWidth,)),
          Expanded(
            child: Column(
              children: [
                Text(news.title ?? 'No Title',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                SizedBox(height: 10),
                Text(news.description ?? 'No Description',style: TextStyle(
                  fontSize: 10
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}