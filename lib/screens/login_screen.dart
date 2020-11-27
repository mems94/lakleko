import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lakleko/models/lisa_login_model.dart';
import 'package:lakleko/screens/create_user.dart';
import 'package:lakleko/screens/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginScreenState extends State<LoginScreen> {
  String username;
  String password;
  bool state = false;
  bool visibility = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginStatus _loginStatus = LoginStatus.notSignIn;

  var value = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        preferences.getInt('value');
        _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
      },
    );
  }

  savePref(int value, String user, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        preferences.setInt('value', value);
        preferences.setString('user', user);
        preferences.setString('password', password);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.signIn:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Dashboard();
            },
          ),
        );
        break;

      case LoginStatus.notSignIn:
        return Scaffold(
          body: Container(
            color: Colors.white,
            margin: EdgeInsets.all(16.0),
            child: buildLoginScreen(context),
          ),
        );
        break;
    }
  }

  Widget buildLoginScreen(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300.0,
              height: 250.0,
              child: GestureDetector(
                child: Image.asset('images/myicon.jpg'),
                onLongPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CreateUser();
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              child: TextField(
                controller: usernameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your pseudo',
                ),
                onChanged: (String textuser) {
                  username = textuser;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                ),
                onChanged: (String textpassword) {
                  password = textpassword;
                },
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Visibility(
              visible: visibility,
              child: Text(
                'Username or password wrong',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            FlatButton(
              onPressed: () async {
                var authentication =
                    Provider.of<LisaLoginModel>(context, listen: false);
                bool state = await authentication.getUser(
                    username ?? 'bizaroid', password);

                print('State for login state : $state');
                usernameController.clear();
                passwordController.clear();
//                    state = true;
                if (state) {
                  setState(
                    () {
                      visibility = false;
                    },
                  );
                  print('Login granted');
                  savePref(1, username, password);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Dashboard();
                      },
                    ),
                  );
                } else {
                  setState(() {
                    visibility = true;
                  });
                }
              },
              color: Color(0xFF426E6D),
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 35.0,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Text(
                'Connect',
                style: TextStyle(
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
