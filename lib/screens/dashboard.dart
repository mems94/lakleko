import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lakleko/components/drawer_builder.dart';
import 'package:lakleko/components/show_popup_menu.dart';
import 'package:lakleko/components/drawer.dart';
import 'package:lakleko/constants/constants.dart';
import 'package:lakleko/models/lisa_access_item.dart';
import 'package:lakleko/models/lisa_login_model.dart';
import 'package:lakleko/screens/access_list.dart';
import 'package:lakleko/screens/search_item_access.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  LisaLoginModel notifier;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final notifier = Provider.of<LisaLoginModel>(context);
    if (this.notifier != notifier) {
      this.notifier = notifier;
      Future.microtask(() => notifier.updateAccesListView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFFFFFF),
      drawer: LisaDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            color: Color(0xFFFFFFFF),
            height: 150.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: DrawerBuilder(
                    scaffoldKey: _scaffoldKey,
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: kTextInContainerAppBar),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: CircleAvatar(
                    foregroundColor: Color(0xFF426E6D),
                    backgroundColor: Colors.white,
                    child: showPopupMenu(context),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 15.0,
              ),
              decoration: kBoxDecorationForFirstContainer,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 15.0),
                    child: TextField(
                      showCursor: false,
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: SearchAccess(),
                        );
                      },
                      cursorColor: Colors.black38,
                      decoration: kInputDecorationForSearchTextField,
                    ),
                  ),
                  Expanded(
                    child: AccessList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchAccess extends SearchDelegate<LisaAccessItem> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ItemAccess(query);

//    return ListView(
//      children: result.map(
//        (access) {
//          return Card(
//            elevation: 2.0,
//            margin: EdgeInsets.only(bottom: 8.0),
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(20.0),
//            ),
//            child: ListTile(
//              title: Text(
//                access.siteName,
//                style: Theme.of(context).textTheme.subhead.copyWith(
//                      fontSize: 16.0,
//                      fontWeight: FontWeight.w500,
//                    ),
//              ),
//              subtitle: Text(access.siteUrl),
//              onTap: () {
//                print(access.id);
//                Navigator.of(context).push(
//                  MaterialPageRoute(
//                    builder: (context) {
//                      return ViewInfoAccess(
//                        indexForList: access.id,
//                      );
//                    },
//                  ),
//                );
//              },
//            ),
//          );
//        },
//      ).toList(),
//    );
  }
}
