import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/webview_screen.dart';

class BuildArticleItem extends StatelessWidget {
  final Map lst;

  BuildArticleItem({@required this.lst});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebviewScreen(lst['url']),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          '${lst['title']}',
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Text(
                      '${lst['publishedAt']}',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${lst['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Article extends StatelessWidget {
  final List list;

  const Article({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => BuildArticleItem(
          lst: list[index],
        ),
        separatorBuilder: (context, index) => Divider(
          height: 0,
        ),
        itemCount: list.length,
      ),
      fallback: (context) => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.yellowAccent,
        ),
      ),
    );
  }
}
