import 'package:url_launcher/url_launcher.dart';

launchURL(String s) async{
  const url='https://github.com/yashimself/x';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}