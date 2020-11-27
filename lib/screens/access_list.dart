import 'package:flutter/material.dart';
import 'package:lakleko/models/lisa_login_model.dart';
import 'package:lakleko/screens/view_info_access.dart';
import 'package:provider/provider.dart';

class AccessList extends StatefulWidget {
  @override
  _AccessListState createState() => _AccessListState();
}

class _AccessListState extends State<AccessList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LisaLoginModel>(
      builder: (context, lisaLoginModel, child) {
        return ListView.custom(
          childrenDelegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            final access = Provider.of<LisaLoginModel>(context, listen: true)
                .listAccess[index];
            return Card(
              elevation: 1.0,
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
                title: Text(access.siteName ?? 'nothing'),
                subtitle: Text(access.siteUrl ?? 'nothing'),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ViewInfoAccess(
                      accessForDB: access,
                      indexForList: index,
                    );
                  }));
                },
              ),
            );
          }, childCount: lisaLoginModel.listAccessCount),
        );
      },
    );
  }
}
