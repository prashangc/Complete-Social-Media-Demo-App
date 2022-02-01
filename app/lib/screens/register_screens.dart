import 'package:app/screens/login_screen.dart';
import 'package:app/state/post_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreens extends StatefulWidget {
  static const routeName = '/register-screens';
  @override
  _RegisterScreensState createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  String? _username;
  String? _password;
  String? _confirmPassword;
  final _form = GlobalKey<FormState>();

  void _registerNow() async {
    var isvalid = _form.currentState?.validate();
    if(!isvalid!){
      return;
    }
    _form.currentState?.save();
    bool isRegister = await Provider.of<PostState>(context, listen: false).registerNow(_username.toString(), _password.toString());  
    if (isRegister == false){
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
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
        title: const Text(
          'Register to code',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Username",
                  ),
                  validator: (v){
                    if (v!.isEmpty){
                      return 'Enter a Username';
                    }
                    return null;
                  },
                  onSaved: (v){
                    _username = v;
                  },
                ),
                 TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (v){
                    if (v!.isEmpty){
                      return 'Enter a Password';
                    }
                    return null;
                  },
                  onChanged: (v){
                    setState(() {
                      _password = v;                      
                    });
                  },
                  obscureText: true,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                  ),
                  validator: (v){
                    if(v!.isEmpty){
                      return "Enter a Password";
                    }
                    if (_password != v){
                      return 'Confirm Password';
                    }
                    return null;
                  },
                  onSaved: (v){
                      _confirmPassword = v;                      
                  },
                  obscureText: true,
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(onPressed: (){
                      _registerNow();
                    },
                     child: const Text(
                       "Register",
                       style: TextStyle(
                         fontSize: 18.0, 
                       ),
                      ),
                    ),
                    const SizedBox(width:20.0,),
                    GestureDetector(
                      onTap: (){
                          Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: const Text(
                        'Login now',
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