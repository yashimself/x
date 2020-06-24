import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  //text field state

  String email='';
  String password='';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.black,
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
      body: Container(
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
            decoration: textInputDecoration.copyWith(hintText: 'Email'),
            validator: (val) => val.isEmpty ? 'Enter an email' : null,
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
                  color: Colors.black,
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
                  dynamic result = await _auth.RegisterwithEmailandPass(email, password);
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
    )
    );
  }
}
