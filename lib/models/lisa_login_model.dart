import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lakleko/models/lisa_access_item.dart';
import 'package:lakleko/models/lisa_login.dart';
import 'package:lakleko/utils/for_login/dbHelperLogin.dart';
import 'package:lakleko/utils/for_access_item/dbHelperItem.dart';

class LisaLoginModel extends ChangeNotifier {
  LisaLoginModel();

  int newListCount;

  DbHelperLogin dbForLogin = DbHelperLogin();
  var dbForItem = DbHelperItem();

  List<LisaAccessItem> myListAccess = [];

  List<LisaAccessItem> get listAccess {
    return myListAccess;
  }

  Future<int> getCount() async {
    int count = await dbForItem.getCount();
    notifyListeners();
    return count;
  }

  int get listAccessCount {
    return myListAccess.length;
  }

  Future<int> deleteAccessItem(int id, [int indexList]) async {
    int feedback = await dbForItem.delete(id);
//    myListAccess.removeAt(indexList);
    updateAccesListView();
    return feedback;
  }

  Future<int> addAccessItem(LisaAccessItem lisaAccessItem) async {
    int idItemAdded = await dbForItem.save(lisaAccessItem);
    LisaAccessItem newAccessItem = await dbForItem.getItem(idItemAdded);
    myListAccess.add(newAccessItem);
    updateAccesListView();
    print('Item $idItemAdded added');
    return idItemAdded;
  }

  handleSubmittedAccessUpdateInDB(int index, LisaAccessItem item) {
    myListAccess.removeWhere((element) {
      // ignore: unnecessary_statements
      myListAccess[index].siteName == item.siteName;
      return;
    });
  }

  updateAccessItem(LisaAccessItem lisaAccessItem) {
    dbForItem.update(lisaAccessItem);
    updateAccesListView();
  }

  void updateAccesListView() async {
//    myListAccess = List<LisaAccessItem>();
    Future<List<LisaAccessItem>> itemList = dbForItem.getItems();
    itemList.then((eachItem) {
      this.myListAccess = eachItem;
      this.newListCount = eachItem.length;
      notifyListeners();
    });
  }

  Future<LisaAccessItem> getAccessItem(int id) async {
    var accessItem = await dbForItem.getItem(id);
    return accessItem;
  }

  Future<bool> getUser(String username, String password) async {
    LisaLogin user = await dbForLogin.getItem(username, password);
    print('User not in database');
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> createUser(LisaLogin lisaLogin) async {
    int result = await dbForLogin.save(lisaLogin);
    notifyListeners();
    updateAccesListView();
    return result;
  }
}
