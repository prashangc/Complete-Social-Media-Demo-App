import 'package:app/screens/home_screens.dart';
import 'package:app/screens/register_screens.dart';
import 'package:app/state/post_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login-screens";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  String? _username;
  String? _password;

  void _loginNow() async{
    var isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    bool islogin = await Provider.of<PostState>(context,listen: false).loginNow(_username.toString(), _password.toString());
    if(!islogin){
      Navigator.of(context).pushReplacementNamed(HomeScreens.routeName);
    }else{
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: const Text(
            "Please provide correct credentials.",
          ),
          actions: [
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child:  const Text(
                "Ok",
                 style: TextStyle(
                 fontSize: 18.0, 
                ),
              ),
            ),
          ],
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login to Code"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter your Username';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _username = v;
                  },
                  decoration: const InputDecoration(
                    labelText: "Username",
                  ),
                ),
                TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter your Password';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _password = v;
                  },
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(onPressed: (){
                      _loginNow();
                    },
                     child: const Text(
                       "Login",
                       style: TextStyle(
                         fontSize: 18.0, 
                       ),
                      ),
                    ),
                    const SizedBox(width:20.0,),
                    GestureDetector(
                      onTap: (){
                          Navigator.of(context).pushNamed(RegisterScreens.routeName);
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              
            ),
          ),
        ),
      ),
    );
  }
}