import 'package:another_flushbar/flushbar.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:epa/auth/activation.dart';
import 'package:epa/auth/phone_no_activation.dart';
import 'package:epa/auth/phone_no_ok.dart';
import 'package:epa/auth/registration.dart';
import 'package:epa/roots/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InputCard extends StatefulWidget {
  @override
  _InputCardState createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  String _xk = "Xush kelibsiz!";
  String _krk = "Karta raqamingizni kiriting:";
  String _ako = "Aktivlashtirish kodini olish";
  String _kry = "Karta raqamim yo'q";

  Color _activeColor = Color.fromRGBO(189, 189, 189, 1);
  // ignore: unused_field
  bool _enableActive = false;
  TextEditingController _controller = TextEditingController();
  var _err = "";
  bool _isEnable = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 42.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    _xk,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_krk,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(79, 79, 79, 1))),
                        SizedBox(height: 4.0),
                        TextFormField(
                          enabled: _isEnable,
                          controller: _controller,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 3,
                          ),
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 17.0),
                            hintText: '_ _ _ _ _ _ _ _',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(130, 130, 130, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0),
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
                          onChanged: (e) {
                            if (e.length == 8) {
                              _activeColor = Colors.red;
                              _enableActive = true;
                              _isEnable = false;
                              setState(() {});
                            } else {
                              _activeColor = Color.fromRGBO(189, 189, 189, 1);
                              _enableActive = false;
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: _activeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      onPressed: () async {
                        final data = await _dataFromNet(_controller.text);
                        
                        final _cardNumber = _controller.text;
                        print(">>>>>>>>"+data.toString());
                        if (data["success"] == true) {
                          final _phoneNumber = data["data"]["phoneNumber"];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Activation(_phoneNumber, _cardNumber)));
                        } else {
                          if (data['error']['code'] == 22 ||
                              data['error']['code'] == 23) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PhoneNoActivation(_cardNumber)));
                          } else if (data['error']['code'] == 24) {
                            final _title = data['data']['title'];
                            final _message = data['data']['message'];
                            final _warn= data['data']['warning'];
                            
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhoneNoOk(_title, _message,_warn)));
                          }
                          _err = data["data"]["message"];
                            Flushbar(
                          padding: EdgeInsets.all(16.w),
                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                          backgroundColor: Colors.red,
                         flushbarPosition:FlushbarPosition.TOP,
                          message: _err,
                          messageColor: Colors.white,
                          messageSize: 16.sp,
                          titleText: Text("Epa:",style: TextStyle(color: Colors.white,fontSize: 17.sp),),
                          duration: Duration(seconds: 3),
                        )..show(context);
                         
                        }
                      },
                      icon: Icon(Icons.lock_outline),
                      label: Text(
                        _ako,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 56.h,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      side: BorderSide(
                          color: Color.fromRGBO(237, 28, 36, 1), width: 2)),
                  onPressed: () async {
                    var jobsData = await _fetchFromNet(
                        "https://epa-tools.uz/api/v1/professions");
                    jobsData = jobsData["data"];
                    var cityData = await _fetchFromNet(
                        "https://epa-tools.uz/api/v1/regions");
                    cityData = cityData["data"];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Registration(jobsData, cityData)),
                    );
                  },
                  icon: Icon(
                    Icons.person_outlined,
                    color: Color.fromRGBO(237, 28, 36, 1),
                  ),
                  label: Text(
                    _kry,
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

  Future _dataFromNet(_cardNumber) async {
    final _response = await http.get(
      Uri.parse(
          "https://epa-tools.uz/api/v1/masters/$_cardNumber/phone-number"),
    );
    final _bringData = await json.decode(_response.body);
    print("get");
    return _bringData;
  }

  Future _fetchFromNet(_link) async {
    final _response = await http.get(
      Uri.parse(_link),
    );
    print("get");
    final _bringData = await json.decode(_response.body);
    print(_bringData);
    return _bringData;
  }
}
