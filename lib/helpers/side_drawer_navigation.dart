import 'package:ecomapp/screens/login_screen.dart';
import 'package:ecomapp/screens/order_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDrawerNavigation extends StatefulWidget {
  @override
  _SideDrawerNavigationState createState() => _SideDrawerNavigationState();
}

class _SideDrawerNavigationState extends State<SideDrawerNavigation> {
  SharedPreferences _prefs;
  String _loginLogoutMenuText = "Log In";
  IconData _loginLogoutIcon = Icons.exit_to_app;

  _isLoggedIn() async {
    _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    if (userId == 0) {
      setState(() {
        _loginLogoutMenuText = "Log In";
        _loginLogoutIcon = Icons.forward;
      });
    } else {
      setState(() {
        _loginLogoutMenuText = "Log Out";
        _loginLogoutIcon = Icons.exit_to_app;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Drawer(
        child: Container(
            child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("User Name"),
              accountEmail: Text("useremail@example.com"),
              currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.png'),
                radius: 50,
              )),
            ),
            ListTile(title: Text("Home"), leading: Icon(Icons.home)),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderListScreen()));
              },
              child: ListTile(
                  title: Text("Orders"), leading: Icon(Icons.shopping_basket)),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: ListTile(
                  title: Text(_loginLogoutMenuText),
                  leading: Icon(_loginLogoutIcon)),
            ),
          ],
        )),
      ),
    );
  }
}
