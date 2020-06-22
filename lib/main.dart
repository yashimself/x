import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:webview_flutter/webview_flutter.dart';



void main() => runApp(MaterialApp(
  home: MyApp(),
));


class MyApp extends StatelessWidget {

  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Builder(
              builder: (context) => FlatButton.icon(onPressed: (){
                  Scaffold.of(context).showSnackBar(SnackBar(
                   content: Text('Thanks for helping with the testing!'),
                    action: SnackBarAction(
                      label: 'Source Code',
                      onPressed: () {
                        WebView(
                        initialUrl: 'github.com/yashimself',
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated: (WebViewController controller){

                          _controller.complete(controller);
                          },

                        );


                    },
                    ),
                    duration: Duration(seconds: 3),
                  ));
              },
                  icon: Icon(AntDesign.github),
                label: Text(''),
                  ),
            )
            ),
          ]
      ),

      appBar: AppBar(
        title: Text('X',
        textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          InkWell(
            child: RaisedButton(onPressed: (){
              WebView(
                initialUrl: 'https://github.com/yashimself/x',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController controller){

                  _controller.complete(controller);
                },

              );

            },
              color: Colors.white70,
              child: Text('Click me'),
              elevation: 2.0,
    ),
          )
        ],
      ),
    );
  }
}
