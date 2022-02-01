import 'package:app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");
    _logoutnow() {
      storage.clear();
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Image.asset('assets/kaneki.jpg'),
            const Text('About',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s'),
            ),  
            const Spacer(),
            ListTile(
              onTap: () {
                _logoutnow();
              },
              trailing: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: const Text("Logout"),
            ),
    
          ],
        ),
      ),
    );
  }
}