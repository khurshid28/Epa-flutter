import 'package:epa/roots/home_page.dart';
import 'package:epa/shopping/add_shopping.dart';
import 'package:epa/katalog/katalog.dart';
import 'package:epa/practice/practice_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigator extends StatefulWidget{
  String? _token;
  Map _user;
  int _index;

  BottomNavigator(this._token,this._user,this._index);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  Color _selColor = Colors.red;
  Homepage? _homepage;
  AddShopping? _addShopping;
  PractiveHistory? _practiveHistory;
  Katalog? _katalog;
  List<Widget>? _listPage;
  @override
  void initState() {
    super.initState();
    _homepage = Homepage(widget._token);
    _addShopping = AddShopping(widget._token, widget._user);
    _practiveHistory = PractiveHistory(widget._token);
    _katalog = Katalog(widget._token,);
    _listPage = [_homepage!,_addShopping!,_practiveHistory!,_katalog!];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(
      BoxConstraints(maxWidth: size.width, maxHeight: size.height),
      designSize: const Size(360, 603),
      orientation: Orientation.portrait,
    );
    // print(widget._categories);
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
       resizeToAvoidBottomInset: true,



      body:
       _listPage![widget._index],


      bottomNavigationBar: Container(
        height: 72.h,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: widget._index,
          selectedItemColor: _selColor,
          unselectedLabelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
          selectedLabelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
          unselectedItemColor: Colors.black,
          elevation: 6,
          onTap: (e){
            setState(() {
              if(e == 0){
                Navigator.pop(context);
                _selColor = Colors.black;
              }
              else{
                widget._index = e;
              }
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Bosh sahifa",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: "   Xarid\n qo'shish"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Amaliyotlar \n     tarixi'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assessment_outlined),
              label: 'Katalog'
            ),
          ],
        ),
      ),
    );
  }
}
