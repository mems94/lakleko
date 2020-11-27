import 'package:flutter/material.dart';
import 'package:lakleko/constants/constants.dart';
import 'package:lakleko/components/item_popup_menu.dart';
import 'package:lakleko/models/lisa_access_item.dart';
import 'package:lakleko/models/lisa_login_model.dart';
import 'package:lakleko/screens/dashboard.dart';
import 'package:lakleko/screens/login_screen.dart';
import 'package:lakleko/screens/update_or_add_access.dart';
import 'package:lakleko/screens/update_or_add_access_search.dart';
import 'package:lakleko/utils/sign_out.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget showPopupMenu(BuildContext context) => PopupMenuButton(
      onSelected: (ActionsPopupButton action) {
        print(action);
        if (action == ActionsPopupButton.add) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return UpdateOrAddAccess(-1, 'Add');
              },
            ),
          );
        } else if (action == ActionsPopupButton.logout) {
          signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ),
          );
        }
      },
      itemBuilder: (context) => [
        itemPopupMenu(
          ActionsPopupButton.logout,
          Icons.exit_to_app,
          'Log out',
        ),
        itemPopupMenu(
          ActionsPopupButton.add,
          Icons.add,
          'Add new access',
        ),
      ],
    );

Widget showPopupMenuForView(BuildContext context, LisaAccessItem accessForDB,
    [int indexForList]) {
  backPreviousScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Dashboard();
        },
      ),
    );
//    Navigator.pop(context, true);
  }

  void showToast(String notification) {
    Fluttertoast.showToast(
      msg: notification,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xFFEEEEF2),
      textColor: Color(0xFF426E6D),
      fontSize: 16.0,
    );
  }

  return PopupMenuButton(
    onSelected: (ActionsPopupButton action) {
      print(action);
      if (action == ActionsPopupButton.update) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return UpdateOrAddAccess(indexForList, 'Update', accessForDB);
            },
          ),
        );
      } else if (action == ActionsPopupButton.delete) {
        var alert = AlertDialog(
          title: Text(
            'DELETE THIS ACCESS ?',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          content: Text(
            'This action is irrevesible and delete this access from database.',
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineButton(
                borderSide: BorderSide.none,
                highlightElevation: 5.0,
                child: Text(
                  'DELETE',
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  backPreviousScreen();
                  print('Id to delete : id');
                  var provider =
                      Provider.of<LisaLoginModel>(context, listen: false);
                  int feedback = await provider.deleteAccessItem(
                    accessForDB.id,
                    indexForList,
                  );
                  print('Access delete from showPop ');
                  showToast("Access deleted");
                  print('Feedback : $feedback');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineButton(
                borderSide: BorderSide.none,
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );

        showDialog(
          context: context,
          builder: (_) => alert,
        );
      }
    },
    itemBuilder: (context) => [
      itemPopupMenu(
        ActionsPopupButton.update,
        Icons.update,
        'Update this access',
      ),
      itemPopupMenu(
        ActionsPopupButton.delete,
        Icons.delete,
        'Delete this access',
      ),
    ],
  );
}

//Showpopup used by serch
Widget showPopupMenuForSearch(BuildContext context, LisaAccessItem accessForDB,
    [int indexForList]) {
  backPreviousScreen() {
    Navigator.pop(context, true);
  }

  void showToast(String notification) {
    Fluttertoast.showToast(
      msg: notification,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xFFEEEEF2),
      textColor: Color(0xFF426E6D),
      fontSize: 16.0,
    );
  }

  return PopupMenuButton(
    onSelected: (ActionsPopupButton action) {
      print(action);
      if (action == ActionsPopupButton.update) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return UpdateOrAddAccessSearch(
                  accessForDB.id, 'Update', accessForDB);
            },
          ),
        );
      } else if (action == ActionsPopupButton.delete) {
        var alert = AlertDialog(
          title: Text(
            'DELETE THIS ACCESS ?',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          content: Text(
            'This action is irrevesible and delete this access from database.',
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineButton(
                borderSide: BorderSide.none,
                highlightElevation: 5.0,
                child: Text(
                  'DELETE',
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  backPreviousScreen();
                  print('Id to delete : id');
                  var provider =
                      Provider.of<LisaLoginModel>(context, listen: false);
                  int feedback = await provider.deleteAccessItem(
                    accessForDB.id,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Dashboard();
                      },
                    ),
                  );

                  print('Access delete from showPop ');
                  showToast("Access deleted");
                  print('Feedback : $feedback');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineButton(
                borderSide: BorderSide.none,
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );

        showDialog(
          context: context,
          builder: (_) => alert,
        );
      }
    },
    itemBuilder: (context) => [
      itemPopupMenu(
        ActionsPopupButton.update,
        Icons.update,
        'Update this access',
      ),
      itemPopupMenu(
        ActionsPopupButton.delete,
        Icons.delete,
        'Delete this access',
      ),
    ],
  );
}
