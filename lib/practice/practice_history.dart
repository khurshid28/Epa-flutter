import 'package:epa/practice/mini_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PractiveHistory extends StatefulWidget {
  String? _token;
  
  PractiveHistory(
    this._token,
    
  );

  @override
  _PractiveHistoryState createState() => _PractiveHistoryState();
}

class _PractiveHistoryState extends State<PractiveHistory>
    with TickerProviderStateMixin {
  TabController? _controller;
  Color _xaridColor = Color.fromRGBO(237, 28, 36, 1);
  Color _sovgaColor = Color.fromRGBO(79, 79, 79, 1);
  @override
  void initState() {
    super.initState();
    _controller = TabController(initialIndex: 0, length: 2, vsync: this)
      ..addListener(() {
        if (_controller!.index == 0) {
          _xaridColor = Color.fromRGBO(237, 28, 36, 1);
          _sovgaColor = Color.fromRGBO(79, 79, 79, 1);
        } else {
          _xaridColor = Color.fromRGBO(79, 79, 79, 1);
          _sovgaColor = Color.fromRGBO(237, 28, 36, 1);
        }
        setState(() {});
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
    print(widget._token);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 0.w, left: 16.w, right: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
              width: 1.sw,
              child: Padding(
                padding:  EdgeInsets.only(left: 5.w),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
          child: Row(
            children: [
                Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,),
                SizedBox(width: 4.w,),
                Text("Ortga",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
              ),
            ),
            SizedBox(height: 20.h,),
            Center(
              child: Text(
                "Amaliyotlar tarixi",
                style: TextStyle(
                  color: Color.fromRGBO(51, 51, 51, 1),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            TabBar(
              onTap: (i) {
                if (i == 0) {
                  _xaridColor = Color.fromRGBO(237, 28, 36, 1);
                  _sovgaColor = Color.fromRGBO(79, 79, 79, 1);
                  _controller!..index = 0;
                } else {
                  _xaridColor = Color.fromRGBO(79, 79, 79, 1);
                  _sovgaColor = Color.fromRGBO(237, 28, 36, 1);
                  _controller!..index = 1;
                }
                setState(() {});
              },
              labelPadding: EdgeInsets.only(right: 0),
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.yellow,
              controller: _controller,
              tabs: [
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Container(
                    height: 34.w,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _xaridColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Xaridlar",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            letterSpacing: .8),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Container(
                    height: 34.w,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _sovgaColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Sovg'alar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          letterSpacing: .8,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.w),
            Container(
              height: 4.w,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(237, 28, 36, 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    My_mini_Loading(widget._token!, "xarid"),
                    My_mini_Loading(widget._token!, "sovga"
                  )
                  
                  
                  
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  







    }

