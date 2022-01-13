import 'dart:convert';
import 'dart:io';

import 'package:epa/auth/input_card.dart';
import 'package:epa/roots/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  String? _token;
  
  Homepage(
    this._token,
  
  );

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _fromTop = true;
  bool _langColor = true;
  bool? is_show_user_data=false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () async {
      final data = await _dataFromNet('https://epa-tools.uz/api/v1/agreement');

      SharedPreferences pref = await SharedPreferences.getInstance();
      bool isShow = pref.getBool("isShow").toString() == "null" ||
          pref.getBool("isShow")!;
      if (isShow) {
        _showDiolog(data);
        await pref.setBool("isShow", false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(
      BoxConstraints(maxWidth: size.width, maxHeight: size.height),
      designSize: const Size(360, 603),
      orientation: Orientation.portrait,
    );

    return WillPopScope(
      onWillPop: ()async{ 
        exit(0);
        },
      child: !is_show_user_data! ?Container(
        width: double.infinity,
        height: double.infinity,
        color:Colors.white,
      ) : FutureBuilder(
          future: _dataFromUser(widget._token),
          builder: (context, AsyncSnapshot snapshot) {
            
            if (snapshot.hasData && is_show_user_data!) {
              var data = snapshot.data["data"];
              return RefreshIndicator(
                  edgeOffset: 26.h,
                  key: Key("_refreshIndicatorKey"),
                  color: Colors.red,
                  child: SafeArea(
                    child: Container(
                      child: Scaffold(
                          resizeToAvoidBottomInset: true,
                          backgroundColor: Color.fromRGBO(242, 242, 242, 1),
                          body: Container(
                            height: 1.sh,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: () {
                                                showGeneralDialog(
                                                  barrierLabel: "Label",
                                                  barrierDismissible: true,
                                                  barrierColor: Colors.black87
                                                      .withOpacity(.88),
                                                  transitionDuration:
                                                      Duration(milliseconds: 700),
                                                  context: context,
                                                  pageBuilder:
                                                      (context, anim1, anim2) {
                                                    return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                        return Align(
                                                          alignment: _fromTop
                                                              ? Alignment
                                                                  .topCenter
                                                              : Alignment
                                                                  .bottomCenter,
                                                          child: SafeArea(
                                                            child: Container(
                                                              width: 332.w,
                                                              height: 192.h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight:
                                                                      Radius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 48.h,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(
                                                                            right:
                                                                                16.w,
                                                                          ),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.clear,
                                                                              size:
                                                                                  26.w,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                            horizontal:
                                                                                16.w),
                                                                    height: 69.h,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            CircleAvatar(
                                                                              radius:
                                                                                  12.7.r,
                                                                              backgroundColor:
                                                                                  Colors.black,
                                                                              child:
                                                                                  Center(
                                                                                child: CircleAvatar(
                                                                                  radius: 11.w,
                                                                                  child: Center(
                                                                                      child: Icon(
                                                                                    Icons.person_outline_rounded,
                                                                                    size: 21.w,
                                                                                    color: Colors.black,
                                                                                  )),
                                                                                  backgroundColor: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                                width: 6.h),
                                                                            Container(
                                                                              width:
                                                                                  130.w,
                                                                              child:
                                                                                  Text(
                                                                                data['name'],
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(130, 130, 130, 1),
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 13.w,
                                                                                  letterSpacing: .4,
                                                                                  decoration: TextDecoration.none,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [
                                                                            Text(
                                                                              'ID ' +
                                                                                  data['cardNumber'],
                                                                              style:
                                                                                  TextStyle(
                                                                                color: Color.fromRGBO(51, 51, 51, 1),
                                                                                fontWeight: FontWeight.w700,
                                                                                fontSize: 16,
                                                                                letterSpacing: .5,
                                                                                decoration: TextDecoration.none,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              '+' +
                                                                                  '${data['phoneNumber']!.substring(0, 3)} ${data['phoneNumber']!.substring(3, 5)} ${data['phoneNumber']!.substring(5, 12)}',
                                                                              style:
                                                                                  TextStyle(
                                                                                color: Color.fromRGBO(130, 130, 130, 1),
                                                                                fontSize: 13.w,
                                                                                letterSpacing: .1,
                                                                                fontWeight: FontWeight.w600,
                                                                                decoration: TextDecoration.none,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Divider(
                                                                    height: 1.3,
                                                                    thickness:
                                                                        1.2,
                                                                  ),
                                                                  Container(
                                                                    height: 72.h,
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                            horizontal:
                                                                                16.w),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            _logOut(
                                                                                widget._token);
                                                                            Navigator.pushAndRemoveUntil(
                                                                                context,
                                                                                MaterialPageRoute(builder: (context) => InputCard()),
                                                                                (route) => false);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                24.h,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.logout,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),
                                                                                Text(
                                                                                  "Chiqish",
                                                                                  style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1), fontSize: 15.w, fontWeight: FontWeight.w600, decoration: TextDecoration.none),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  transitionBuilder: (context,
                                                      anim1, anim2, child) {
                                                    return SlideTransition(
                                                      position: Tween(
                                                        begin: Offset(
                                                            0, _fromTop ? -1 : 1),
                                                        end: Offset(0, 0),
                                                      ).animate(anim1),
                                                      child: child,
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 11.r,
                                                        backgroundColor:
                                                            Colors.black,
                                                        child: Center(
                                                            child: CircleAvatar(
                                                          radius: 9.5,
                                                          child: Center(
                                                              child: Icon(
                                                            Icons
                                                                .person_outline_rounded,
                                                            size: 19.4,
                                                            color: Colors.black,
                                                          )),
                                                          backgroundColor:
                                                              Colors.white,
                                                        ))),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Container(
                                                      width: 153.w,
                                                      child: Text(
                                                        data['name'],
                                                        style: TextStyle(
                                                            color: Color.fromRGBO(
                                                                130, 130, 130, 1),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing: .5),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'ID ' + data['cardNumber'],
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          51, 51, 51, 1),
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 16,
                                                      letterSpacing: .4),
                                                ),
                                                Text(
                                                  '+' +
                                                      '${data['phoneNumber']!.substring(0, 3)} ${data['phoneNumber']!.substring(3, 5)} ${data['phoneNumber']!.substring(5, 12)}',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        130, 130, 130, 1),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 48.h),
                                        Container(
                                          height: 161.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(0, 2),
                                                  blurRadius: 14,
                                                  color:
                                                      Color.fromRGBO(0, 0, 0, .1))
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Mening ballarim",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        51, 51, 51, 1),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 24,
                                                    letterSpacing: .6),
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration:
                                                        BoxDecoration(boxShadow: [
                                                      BoxShadow(
                                                          offset: Offset(0, 8),
                                                          blurRadius: 16,
                                                          color:
                                                              data['blocked'] ==
                                                                      false
                                                                  ? Color
                                                                      .fromRGBO(
                                                                          39,
                                                                          174,
                                                                          96,
                                                                          0.4)
                                                                  : Colors.white)
                                                    ]),
                                                    child: CircleAvatar(
                                                      radius: 26,
                                                      backgroundColor:
                                                          data['blocked'] == false
                                                              ? Color.fromRGBO(
                                                                  39, 174, 96, 1)
                                                              : Color.fromRGBO(
                                                                  189,
                                                                  189,
                                                                  189,
                                                                  1),
                                                      child: Icon(
                                                        Icons.card_giftcard,
                                                        color: Colors.white,
                                                        size: 32,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  Text(
                                                    data['balance'].toString(),
                                                    style: TextStyle(
                                                      color: data['blocked'] ==
                                                              false
                                                          ? Color.fromRGBO(
                                                              39, 174, 96, 1)
                                                          : Color.fromRGBO(
                                                              189, 189, 189, 1),
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 42,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        data['blocked'] == false
                                            ? Column(
                                                children: [
                                                  SizedBox(height: 48.h),
                                                  Container(
                                                    height: 58.h,
                                                    width: double.infinity,
                                                    child: OutlinedButton.icon(
                                                      onPressed: () async {
                                                        SharedPreferences pref=await SharedPreferences.getInstance();
                                          String token=pref.getString("token").toString();
                                          print(token);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>

                                                            BottomNavigator(widget._token,data,1)
                                                                ,
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.add_box_outlined,
                                                        color: Colors.white,
                                                        size: 27,
                                                      ),
                                                      label: Text(
                                                        "Xarid qo'shish",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 20,
                                                            letterSpacing: .8),
                                                      ),
                                                      style: OutlinedButton.styleFrom(
                                                          backgroundColor:
                                                              Color.fromRGBO(
                                                                  237, 28, 36, 1),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          10)))),
                                                    ),
                                                  ),
                                                  SizedBox(height: 12.h),
                                                  Container(
                                                    height: 58.h,
                                                    width: double.infinity,
                                                    child: OutlinedButton.icon(
                                                      onPressed: () async {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    BottomNavigator(widget._token,data,2)));
                                                      },
                                                      icon: Icon(
                                                        Icons.history,
                                                        color: Colors.white,
                                                        size: 27,
                                                      ),
                                                      label: Text(
                                                        "Amaliyot tarixi",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 20,
                                                            letterSpacing: .8),
                                                      ),
                                                      style: OutlinedButton.styleFrom(
                                                          backgroundColor:
                                                              Color.fromRGBO(
                                                                  237, 28, 36, 1),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          10)))),
                                                    ),
                                                  ),
                                                  SizedBox(height: 12.h),
                                                  Container(
                                                    height: 58.h,
                                                    width: double.infinity,
                                                    child: OutlinedButton.icon(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                BottomNavigator(widget._token,data,3),
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.assessment_outlined,
                                                        color: Colors.white,
                                                        size: 27,
                                                      ),
                                                      label: Text(
                                                        "Katalog",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 20,
                                                            letterSpacing: .8),
                                                      ),
                                                      style: OutlinedButton.styleFrom(
                                                          backgroundColor:
                                                              Color.fromRGBO(
                                                                  237, 28, 36, 1),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          10)))),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 48.w, bottom: 72.w),
                                                    child: Container(
                                                      height: 240.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10.w),
                                                          border: Border.all(
                                                              width: 3.w,
                                                              color:
                                                                  Color.fromRGBO(
                                                                      176,
                                                                      31,
                                                                      31,
                                                                      1)),
                                                          color: Color.fromRGBO(
                                                              254, 233, 234, 1)),
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 20.w,
                                                            bottom: 20.w,
                                                            left: 14.w,
                                                            right: 14.w),
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                data['alert']
                                                                    ['message'],
                                                                style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          237,
                                                                          28,
                                                                          36,
                                                                          1),
                                                                  fontSize: 26.w,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  letterSpacing:
                                                                      .5,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              Text(
                                                                "Siz ortiq karta raqamingizga ball qo'sha olmaysiz va undan foydalana olmaysiz",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            79,
                                                                            79,
                                                                            79,
                                                                            1),
                                                                    fontSize:
                                                                        18.w),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 56.w,
                                                    child: OutlinedButton.icon(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0)),
                                                        ),
                                                        side: BorderSide(
                                                            color: Color.fromRGBO(
                                                                237, 28, 36, 1),
                                                            width: 2),
                                                      ),
                                                      onPressed: () => launch(
                                                          "tel://+998 95 400 04 00"),
                                                      icon: Icon(
                                                        Icons.phone_outlined,
                                                        color: Color.fromRGBO(
                                                            237, 28, 36, 1),
                                                      ),
                                                      label: Text(
                                                        "Biz bilan bog'lanish",
                                                        style: TextStyle(
                                                            fontSize: 19.0,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                  onRefresh: () async {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Homepage(widget._token)),
                        (route) => false);
                  });
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text(snapshot.error.toString())),
              );
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              );
            }
          }),
    );
  }

  _showDiolog(data) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: ()async{
             SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.setString("token", "null");
              await pref.setBool("isShow", true);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>InputCard()));
            return false;
          },
          child: AlertDialog(
            actionsPadding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 8.h),
            contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            insetPadding: EdgeInsets.all(12.h),
            title: Text(
              data['data']['title'],
              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w700),
            ),
            content: SingleChildScrollView(
              child: Text(data['data']['content']),
            ),
            actions: [
              Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: ()async {
                    final _response = await post(
                    Uri.parse('https://epa-tools.uz/api/v1/agreement'),
                    headers: <String, String>{
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer '+widget._token!,   
                    },
                    
                    
                  );
                print("post");
                 if ((await jsonDecode(_response.body))["success"].toString()=="true") {
                    is_show_user_data=true;
                 
                    Navigator.pop(context);
                     setState(() {
                 });
                 }
                
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    data['data']['actionName'],
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: .4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
 
 
  }

  Future _dataFromUser(_token) async {
    final _response = await get(Uri.parse("https://epa-tools.uz/api/v1/master"),
        headers: <String, String>{'Authorization': 'Bearer $_token'});
    if (_response.statusCode == 200) {
      final _bringData = jsonDecode(_response.body);
      print("get");
      return _bringData;
    } 
    else if (_response.statusCode == 401) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>InputCard()), (route) => false);
    } 
    else {
      return throw Exception("Malumot kelmadi");
    }
  }

  Future _logOut(_token) async {
    print("post");
    final _response = await post(
        Uri.parse("https://epa-tools.uz/api/v1/logout"),
        headers: <String, String>{'Authorization': 'Bearer $_token'});
    if (_response.statusCode == 200) {
      final _bringData = jsonDecode(_response.body);
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("token", "null");
      await pref.setBool("isShow", true);
      return _bringData;
    } else {
      return throw Exception("Malumot kelmadi");
    }
  }

  Future _dataFromNet(link) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
      is_show_user_data = !(pref.getBool("isShow").toString() == "null" ||
          pref.getBool("isShow")!);
          setState(() {
            
          });
    final _response = await get(Uri.parse(link));
    print("get");
    final _bringData = await json.decode(_response.body);
    return _bringData;
  }
}
