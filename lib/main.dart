import 'package:epa/auth/input_card.dart';
import 'package:epa/roots/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
void main()async {
WidgetsFlutterBinding.ensureInitialized();
PackageInfo packageInfo = await PackageInfo.fromPlatform();
String version = packageInfo.version;

SharedPreferences pref=await SharedPreferences.getInstance();

if (version!=pref.getString("version").toString()) {
  await pref.setString("token", "null");
  await pref.setBool("isShow", true);
  await pref.setString("version", version);
}
  String token=pref.getString("token").toString();
  runApp(MyApp(token));
}
class MyApp extends StatelessWidget {
  String token;
  MyApp(this.token);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Montserrat',
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "Epa",
      routes: {
      'inputcard': (context) => InputCard(),
    },

      home:token !="null" ? Logotip(child: Homepage(token),)  : Logotip(child: InputCard(),),
    );
  }
}

class Logotip extends StatefulWidget {
  Widget? child;
   Logotip({this.child, Key? key }) : super(key: key);

  @override
  _LogotipState createState() => _LogotipState();
}

class _LogotipState extends State<Logotip> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000),(){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget.child!), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(237, 28, 36, 1),
            image: DecorationImage(
              image: AssetImage('assets/Vector.png'),
            )
          ),
        ),
      ),
    );
  }
}































