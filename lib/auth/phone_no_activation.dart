import 'package:another_flushbar/flushbar.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:epa/auth/input_card.dart';
import 'package:epa/auth/phone_no_ok.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PhoneNoActivation extends StatefulWidget {
  String _cardNumber;
  PhoneNoActivation(this._cardNumber);

  @override
  _PhoneNoActivationState createState() => _PhoneNoActivationState();
}

class _PhoneNoActivationState extends State<PhoneNoActivation> {
  TextEditingController _controller = TextEditingController();
  String? _err;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(
      BoxConstraints(maxWidth: size.width, maxHeight: size.height),
      designSize: const Size(360, 603),
      orientation: Orientation.portrait,
    );
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
          icon: Padding(
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
              Text(""),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Telefon raqamingizni",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 24.0),
                      ),
                      Text(
                        "kiriting",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 24.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  TextFormField(
                    controller: _controller,
                    autocorrect: false,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      TextInputMask(
                        mask: '\\+999 99 999 99 99',
                        placeholder: '_ ',
                        maxPlaceHolders: 13,
                      )
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 17.0),
                      hintText: '+998 _ _  _ _ _  _ _  _ _',
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
                        final data = await _dataFromNet(
                            widget._cardNumber, _controller.text.split(' ').join('').split('+').join(''));
                        if (data["success"] == true) {
                          final _title = data['data']['title'];
                          final _message = data['data']['message'];
                          final _warn = data['data']['warning'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhoneNoOk(_title, _message,_warn),
                            ),
                          );
                        } else {
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
                        color: Color.fromRGBO(237, 28, 36, 1), width: 2),
                  ),
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

  Future _dataFromNet(_cardNumber, phoneNumber) async {
    final _response = await http.post(
        Uri.parse(
            "https://epa-tools.uz/api/v1/masters/$_cardNumber/phone-number"),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: json.encode(<String, String>{"phoneNumber": phoneNumber}));
        print("post");
    final _bringData = await json.decode(_response.body);
    print(_bringData);
    return _bringData;
  }
}
