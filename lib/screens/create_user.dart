import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lakleko/constants/constants.dart';
import 'package:lakleko/models/lisa_login.dart';
import 'package:provider/provider.dart';
import 'package:lakleko/models/lisa_login_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF426E6D), body: MyForm());
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _scaffoldKey = GlobalKey<FormState>();

  String newUsername;

  String newUserPassword;

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast(String notification) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xFF426E6D),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            notification,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
  }

  void submitForm(BuildContext context) async {
    final form = _scaffoldKey.currentState;

    if (form.validate()) {
      print('Username : $newUsername');
      print('Password : $newUserPassword');

      LisaLogin newLisaUser = LisaLogin(newUsername, newUserPassword);
      var createUser = Provider.of<LisaLoginModel>(context, listen: false);
      int stateUser = await createUser.createUser(newLisaUser);

      try {
        if (stateUser != null) {
          usernameController.clear();
          passwordController.clear();
          newUserPassword = '';
//          final snackBar = SnackBar(
//            content: Text('User $newUsername addes to database'),
//          );
//          Scaffold.of(context).showSnackBar(snackBar);

//print toast from the custom_toast file
          _showToast("User added to database, use it");
        } else {
          print('Return code from DB : $stateUser');
          _showToast("Error creating user, try again");
          throw 'error creating user on database';
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                padding: EdgeInsets.only(right: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Hello !!',
                        style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      'Welcome to Lakleko',
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'your access manager',
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Well, create a username ',
                      softWrap: true,
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'to access to Lakleko',
                      softWrap: true,
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 15.0,
            ),
            decoration: kBoxDecorationForFirstContainer.copyWith(
              color: Colors.white,
            ),
            child: Form(
              key: _scaffoldKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 25.0),
                    child: TextFormField(
                      controller: usernameController,
                      decoration: kInputDecorationListviewAddUpdate.copyWith(
                        hintText: 'Enter username',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.grey.shade400,
                            size: 30.0,
                          ),
                        ),
                      ),
                      onChanged: (String user) {
                        newUsername = user;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 25.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: kInputDecorationListviewAddUpdate.copyWith(
                        hintText: 'Enter password',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            right: 15.0,
                          ),
                          child: Icon(
                            Icons.compare_arrows,
                            color: Colors.grey.shade400,
                            size: 30.0,
                          ),
                        ),
                      ),
                      onChanged: (String password) {
                        newUserPassword = password;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: RaisedButton(
                      color: Color(0xFF426E6D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'ADD NEW USER',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        submitForm(context);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
