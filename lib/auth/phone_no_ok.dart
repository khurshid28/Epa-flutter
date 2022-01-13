import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneNoOk extends StatefulWidget {
  String? _title;
  String? _message;
  String? _warn;
  PhoneNoOk(this._title, this._message,this._warn);

  @override
  _PhoneNoOkState createState() => _PhoneNoOkState();
}

class _PhoneNoOkState extends State<PhoneNoOk> {

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
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(top: 48.h, bottom: 32.h, left: 16.w, right: 16.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                Column(
                  children: [
                    Text(widget._title.toString(),
                        style: TextStyle(
                            fontSize: 32.0,
                            color: Color.fromRGBO(51, 51, 51, 1),
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.1)),
                    SizedBox(height: 32.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        widget._message.toString(), textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 19.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Icon(Icons.check_circle_outline_rounded,
                        size: 100.0, color: Colors.green)
                  ],
                ),
                SizedBox(height: 40.h),
               widget._warn! =="" ? Container():Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline_rounded,
                        size: 32.0, color: Colors.redAccent),
                    SizedBox(width: 12.w),
                    Column(
                      children: [
                        Text(widget._warn!,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color.fromRGBO(150, 150, 150, 1),
                                fontWeight: FontWeight.w400)),
                       
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
