import 'package:another_flushbar/flushbar.dart';
import 'package:epa/auth/activation_code.dart';
import 'package:epa/auth/phone_no_activation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Activation extends StatefulWidget {
  String _phoneNumber;
  String _cardNumber;
  Activation(this._phoneNumber, this._cardNumber);

  @override
  _ActivationState createState() => _ActivationState();
}

class _ActivationState extends State<Activation> {
  String _err = '';
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
            Navigator.pop(context);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget._phoneNumber,
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0)),
              SizedBox(height: 16.h),
              Text("Ushbu raqam siznikimi?",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
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
                    final data = await _dataFromNet(widget._cardNumber);
                    _err = data['data']['message'];
                    if (data["success"] == true) {
                      final _cardNumber = data["data"]["cardNumber"];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActivationCode(_cardNumber)),
                      );
                      
                    } else {
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

                    
                      
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Ha",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                height: 52.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      side: BorderSide(
                          color: Color.fromRGBO(237, 28, 36, 1), width: 2)),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PhoneNoActivation(widget._cardNumber),
                      ),
                    );
                  },
                  child: Text(
                    "Yo'q",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _dataFromNet(_cardNumber) async {
    final _response = await http.post(Uri.parse(
        "https://epa-tools.uz/api/v1/masters/$_cardNumber/send-code"));
    final _bringData = await json.decode(_response.body);
    print("post");
    return _bringData;
  }
}
