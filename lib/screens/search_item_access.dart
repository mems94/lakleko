import 'package:flutter/material.dart';
import 'package:lakleko/models/lisa_access_item.dart';
import 'package:lakleko/models/lisa_login_model.dart';
import 'package:lakleko/screens/view_info_access_search.dart';
import 'package:provider/provider.dart';

class ItemAccess extends StatefulWidget {
  final query;

  ItemAccess(this.query);

  @override
  _ItemAccessState createState() => _ItemAccessState();
}

class _ItemAccessState extends State<ItemAccess> {
  List<LisaAccessItem> actualListAccess;

  @override
  Widget build(BuildContext context) {
    actualListAccess =
        Provider.of<LisaLoginModel>(context, listen: false).listAccess;

    final List<LisaAccessItem> result = actualListAccess
        .where((access) => access.siteName.toLowerCase().contains(widget.query))
        .toList();

    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int position) {
        var access = result[position];
        return Card(
          elevation: 2.0,
          margin: EdgeInsets.only(bottom: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF426E6D),
              child: Text(
                '${access.siteName.substring(0, 1).toUpperCase()}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color(0xFF426E6D),
                ),
              ),
            ),
            title: Text(
              access.siteName,
              style: Theme.of(context).textTheme.subhead.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            subtitle: Text(access.siteUrl),
            onTap: () {
              print(access.id);
//              var allItem = Provider.of<LisaLoginModel>(context).listAccess;

              print(access.siteName);
              print(position);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ViewInfoAccessSearch(
                      accessForDB: access,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
