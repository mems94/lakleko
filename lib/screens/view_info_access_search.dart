import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lakleko/components/show_popup_menu.dart';
import 'package:lakleko/constants/constants.dart';
import 'package:lakleko/models/lisa_access_item.dart';
import 'package:list_group/list_group.dart';
import 'package:list_group/list_group_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewInfoAccessSearch extends StatelessWidget {
  final LisaAccessItem accessForDB;
  final bool stateSearch = false;
  ViewInfoAccessSearch({this.accessForDB});

  @override
  Widget build(BuildContext context) {
    print('ID FROM LISTVIEW FOR DB : ${accessForDB.id}');
    String urlForSite = accessForDB.siteUrl;
    return Scaffold(
      backgroundColor: Color(0xFF426E6D),
      body: Column(
        children: <Widget>[
          Container(
            color: Color(0xFF426E6D),
            height: 150.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Access info for',
                        style: TextStyle(
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${accessForDB.siteName}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF426E6D),
                    child: showPopupMenuForSearch(context, accessForDB),
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
              child: SingleChildScrollView(
                child: ListGroup(
                  borderColor: Colors.grey,
                  borderRadius: 3.0,
                  borderWidth: 0.2,
                  items: [
                    ListGroupItem(
                      leading: FaIcon(
                        FontAwesomeIcons.firefox,
                      ),
                      title: Text(
                        'Site name : ${accessForDB.siteName}',
                      ),
                    ),
                    ListGroupItem(
                      onTap: () async {
                        if (await canLaunch(urlForSite)) {
                          await launch(
                            urlForSite,
                            forceSafariVC: false,
                            forceWebView: false,
                          );
                        } else {
                          throw 'Could not launch $urlForSite';
                        }
                      },
                      leading: Icon(Icons.open_in_browser),
                      title: Text(
                        'Site URL : ${accessForDB.siteUrl}',
                      ),
                    ),
                    ListGroupItem(
                      leading: Icon(Icons.person_outline),
                      title: Text(
                        'Username : ${accessForDB.username}',
                      ),
                    ),
                    ListGroupItem(
                      leading: FaIcon(FontAwesomeIcons.key),
                      title: Text(
                        'Password : ${accessForDB.password}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
