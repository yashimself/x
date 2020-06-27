import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:x/services/database.dart';
import 'package:x/services/sp.dart';
import 'package:x/shared/loading.dart';
import 'package:x/shared/constants.dart';
import 'package:x/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  DatabaseService databaseService = new DatabaseService();

  //text field state

  String email='';
  String password='';
  String error = '';
  String name = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
        backgroundColor: Color(0xFFddf3f5),
        appBar: AppBar(
        backgroundColor: Color(0xFFa6dcef),
        elevation: 0.0,
        title: Text('Register',
        style: TextStyle(
          color: Colors.white,
        ),
        ),
          actions: [
            FlatButton.icon(
              onPressed: (){
                return widget.toggleView();
            },
            icon: Icon(Icons.person,
            color: Colors.white,
            ),
            label: Text('Sign In',
            style: TextStyle(
              color: Colors.white,
            ),
            ),
            )
            ],
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
                child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('X',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                      ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) => val.isEmpty ? 'Enter your Name' : null,
                    onChanged: (val){
                      setState(() {
                        name=val;
                      });
                    },
                  ),
                SizedBox(height: 20),
                TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) {
                 return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : 'Enter an email';
                },
                onChanged: (val){
                setState(() {
                email=val;
                });
                },
                ),
                SizedBox(height: 20),
                TextFormField(
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Enter a password with more than 6 characters' : null,
                onChanged: (val){
                setState(() {
                password=val;
                });

                },
                ),
                  SizedBox(height: 20,),
                  RaisedButton(
                    splashColor: Colors.white,
                      color: Color(0xFFa6dcef),
                      child: Text('Sign up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.RegisterwithEmailandPass(email, password).then((val){

                        Map<String, String> userInfo = {
                          "email": email,
                          "name" : name
                        };
                        Sp.saveUserEmailsharedpreference(email);
                        Sp.saveUsernamesharedpreference(name);

                        databaseService.dbUpstream(userInfo);

                        Sp.saveUserLoggedinpreference(true);



                      });
                      if (result == null) {
                        setState(() {
                          error = ' Please use valid email and password ';
                          loading = false;
                        });
                      }
                    }
                  }
                  ),
                  SizedBox(height: 20.0,),
                    Text(error,
                    style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                )
                )
    ]),
    )
    ),
        ),
      )
    );
  }
}
