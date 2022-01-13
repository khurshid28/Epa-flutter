import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:epa/auth/input_card.dart';
import 'package:epa/roots/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivationCode extends StatefulWidget {
  String? _cardNumber;
  ActivationCode(this._cardNumber);

  @override
  _ActivationCodeState createState() => _ActivationCodeState();
}

class _ActivationCodeState extends State<ActivationCode>
    with TickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();
  String? _err;
  bool _isEnable = true;
  Timer? _timer;
  int _secCount = 59;
  int _minCount = 2;
  double _refHeight = 0;
  double _refIcon = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        this._secCount -= 1;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(
      BoxConstraints(maxWidth: size.width, maxHeight: size.height),
      designSize: const Size(360, 603),
      orientation: Orientation.portrait,
    );
    if (!_isEnable) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _isEnable = true;
        });
      });
    }
    if (_secCount == 0 && _minCount == 0) {
      _timer!.cancel();
      _refHeight = 30;
      _refIcon = 20;
      setState(() {});
    }
    if (_secCount == 0 && _minCount != 0) {
      _secCount = 59;
      _minCount -= 1;
      setState(() {});
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>InputCard()), (route) => false);
          },

          icon:Padding(
                    padding: EdgeInsets.all(25.w),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new_rounded),
                        SizedBox(width: 4.w,),
                        Text("Ortga",style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 42.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(("")),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("SMS kodni kiriting",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 24.0)),
                  SizedBox(height: 32.h),
                  TextFormField(
                    enabled: _isEnable,
                    controller: _controller,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      TextInputMask(
                          mask: '9 9 9 9 9',
                          placeholder: '_ ',
                          maxPlaceHolders: 5,
                          reverse: false)
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 17.0),
                      hintText: '_ _ _ _ _',
                      hintStyle: TextStyle(
                          letterSpacing: 1.2,
                          color: Color.fromRGBO(130, 130, 130, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(189, 189, 189, 1)),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(39, 174, 96, 1),
                              width: 2.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                  Container(
                    height: 20.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (_secCount > 9)
                            ? Text(
                                '0' +
                                    _minCount.toString() +
                                    ':' +
                                    _secCount.toString(),
                                style: TextStyle(
                                    color: Color.fromRGBO(79, 79, 79, 1),
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: .7),
                              )
                            : Text(
                                '0' +
                                    _minCount.toString() +
                                    ':' +
                                    '0' +
                                    _secCount.toString(),
                                style: TextStyle(
                                    color: Color.fromRGBO(79, 79, 79, 1),
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: .7),
                              ),
                        Container(
                          height: _refHeight.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.all(0)),
                                onPressed: () async {
                                  if (_minCount == 0 && _secCount == 0) {
                                    _refHeight = 0;
                                    _refIcon = 0;
                                    final data =
                                        await _sendCode(widget._cardNumber);
                                    if (data["success"] == true) {
                                      final _cardNumber =
                                          data["data"]["cardNumber"];
                                      setState(() {});
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Waiting(_cardNumber)),
                                      );
                                    }
                                  } else {}
                                },
                                child: Text(
                                  "Qayta yuborish",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              Icon(Icons.refresh_rounded, size: _refIcon)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(237, 28, 36, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      onPressed: () async {
                       

                        _isEnable = false;
                        setState(() {});
                        final _code = _controller.text.split(' ').join('');
                        final data =
                            await _dataFromNet(widget._cardNumber, _code);
                        if (data["success"] == true) {
                          final _token = data['data']['token'];
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          await pref.setString("token", _token);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homepage(_token),
                            ),
                            (route) => false,
                          );
                        } else {
                          _err = data["data"]["message"];
                          Flushbar(
                          padding: EdgeInsets.all(16.w),
                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                          backgroundColor: Colors.red,
                         flushbarPosition:FlushbarPosition.TOP,
                          message: _err!,
                          messageColor: Colors.white,
                          messageSize: 16.sp,
                          titleText: Text("Epa:",style: TextStyle(color: Colors.white,fontSize: 17.sp),),
                          duration: Duration(seconds: 3),
                        )..show(context);
                         
                        }
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(""),
              Container(
                width: double.infinity,
                height: 52.h,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      side: BorderSide(
                          color: Color.fromRGBO(237, 28, 36, 1), width: 2)),
                  onPressed: () => launch("tel://+998 95 400 04 00"),
                  icon: Icon(
                    Icons.phone_outlined,
                    color: Color.fromRGBO(237, 28, 36, 1),
                  ),
                  label: Text(
                    "Biz bilan bog'lanish",
                    style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _dataFromNet(_cardNumber, _code) async {
    if (_code!="") {
      final _response = await http.post(
      Uri.parse('https://epa-tools.uz/api/v1/masters/$_cardNumber/check-code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'code': _code ,
      }),
      
    );
    print("post");
    final _bringData = await json.decode(_response.body);
    print(_bringData);
    return _bringData;
    }
  }

  Future _sendCode(_cardNumber) async {
    final _response = await http.post(Uri.parse(
        "https://epa-tools.uz/api/v1/masters/$_cardNumber/send-code"));
    final _bringData = await json.decode(_response.body);
    print("post");
    return _bringData;
  }

  Future _resendCode(_cardNumber) async {
    final _response = await http.post(Uri.parse(
        "https://epa-tools.uz/api/v1/masters/$_cardNumber/send-code"));
    final _bringData = await json.decode(_response.body);
    print("post");
    return _bringData;
  }
}


class Waiting extends StatefulWidget {
  String _cardNumber;
  Waiting(this._cardNumber);
  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> with TickerProviderStateMixin{
  AnimationController? _animationController;
  @override
  void initState() {
    _animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 500))..addListener(() { })..forward(from: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context,child){
           if (_animationController!.value ==1) {
             return  ActivationCode(widget._cardNumber);
           } else {
             return Scaffold(
               backgroundColor: Color.fromRGBO(242, 242, 242, 1), ,
               body: Center(
                 child: CircularProgressIndicator(
                   color: Colors.red,
                 ),
               ),
             );
           }
      },
    );
  }
}
