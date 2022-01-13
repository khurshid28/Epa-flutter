import 'package:another_flushbar/flushbar.dart';
import 'package:epa/auth/activation_code.dart';
import 'package:epa/auth/input_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_mask/easy_mask.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Registration extends StatefulWidget {
  List<dynamic> _jobsArr;
  List<dynamic> _cityArr;
  Registration(this._jobsArr, this._cityArr);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  String? _isTeam = "no";
  bool? _enable = false;
  Color _regionBorderColor = Colors.grey.shade400;
  Color _cityBorderColor = Colors.grey.shade400;
  Color _jobBorderColor = Color.fromRGBO(189, 189, 189, 1);
  double _regionBorderWidth = 1;
  double _cityBorderWidth = 1;
  double _jobBorderWidth = 1;
  String _tanlash = "Tanlash*";
  String _shahar = "Shahar*";
  String _tuman = "Tuman*";
  Color _jobTitleColor = Color.fromRGBO(150, 150, 150, 1);
  Color _cityTitleColor = Color.fromRGBO(150, 150, 150, 1);
  Color _regionTitleColor = Color.fromRGBO(150, 150, 150, 1);
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _patronymicController = TextEditingController();
  TextEditingController _teamController = TextEditingController();
  TextEditingController _phon1Controller = TextEditingController();
  TextEditingController _phon2Controller = TextEditingController();
  int? _cityId;
  int? _regionId;
  int? _jobId;
  DateTime? _date;
  String? _birthday;
  bool showing_date=false;
  bool showing_kasb=false;
  bool showing_shahar=false;
  bool showing_tuman=false;
  bool showing_soni=false;
  List<dynamic> _regionList = [];
  @override
  void initState() {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      "Ro'yxatdan o'tish",
                      style: TextStyle(
                        letterSpacing: .5,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "Shaxsiy ma'lumotlar",
                    style: TextStyle(
                      color: Color.fromRGBO(100, 100, 100, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (e){
                        if(e!.length > 0){
                          return null;
                        }
                        else{
                          return "Ism kiritilmagan";
                        }
                    },
                    controller: _nameController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.h, vertical: 17.w),
                      hintText: 'Ism*',
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(150, 150, 150, 1),
                          fontSize: 18.w),
                      fillColor: Colors.white,
                      filled: true,
                      errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            )),
                            focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            )),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(39, 174, 96, 1),
                            )),
                            
                      enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(189, 189, 189, 1),
                            )),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (e){
                        if(e!.length > 0){
                          return null;
                        }
                        else{
                          return "Familiya kiritilmagan";
                        }
                    },
                    controller: _surnameController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.h, vertical: 17.w),
                      hintText: 'Familiya*',
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(150, 150, 150, 1),
                          fontSize: 18.w),
                      fillColor: Colors.white,
                      filled: true,
                      errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            )),
                            focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            )),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(39, 174, 96, 1),
                            )),
                            
                      enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(189, 189, 189, 1),
                            )),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                   
                    controller: _patronymicController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.h, vertical: 17.w),
                      hintText: 'Otangizning ismi',
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(150, 150, 150, 1),
                          fontSize: 18.0),
                      fillColor: Colors.white,
                      filled: true,
                      errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            )),
                            focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            )),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(39, 174, 96, 1),
                            )),
                            
                      enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(189, 189, 189, 1),
                            )),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Tug'ilgan sana",
                    style: TextStyle(
                      color: Color.fromRGBO(79, 79, 79, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  OutlinedButton(
                    
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        side: BorderSide(color:showing_date ? Colors.red: Color.fromRGBO(189, 189, 189, 1),width: 1.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          
                        ),
                        padding: EdgeInsets.only(left: 24.w, right: 134.w, top: 12.h, bottom: 10.h)
                      ),
                      onPressed: () async {
                        setState(() {
                          print(_date);
                          if (_date == null) {
                            _date = DateTime.now();
                          }
                        });
                        _date = await showDatePicker(
                          context: context,
                          initialDate: _date!,
                          initialEntryMode: DatePickerEntryMode.calendar,
                          firstDate: DateTime(1900, DateTime.january),
                          lastDate: DateTime(2022, DateTime.december),
                        );
                        _birthday = (_date!.year).toString() +
                            '-' +
                            (_date!.month > 9 ? _date!.month.toString():"0"+_date!.month.toString())+
                            '-' +
                             (_date!.day > 9 ? _date!.day.toString():"0"+_date!.day.toString());
                             showing_date=false;
                        setState(() {});
                      },
                      child: Container(
                        width: 170.w,
                        height: 22.h,
                        child: Text(
                          _date == null
                              ? '_ _ _ _ / _ _ / _ _ *'
                              : _birthday.toString(),
                          style: TextStyle(
                            color: Color.fromRGBO(130, 130, 130, 1),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )),
                      if (showing_date) SizedBox(height: 16.h,child: Row(
                        
                        children: [
                          SizedBox(width:18.w),
                          Text("Tug'ilgan sana kiritilmagan",style: TextStyle(color: Colors.red[700],fontSize: 11.sp,fontWeight: FontWeight.w200),),
                        ],
                      ),),
                  SizedBox(height: 16.h),
                  Text(
                    "Kasbingiz?",
                    style: TextStyle(
                      color: Color.fromRGBO(79, 79, 79, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        border: Border.all(
                            color:showing_kasb? Colors.red: _jobBorderColor, width: _jobBorderWidth),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(.15, .1),
                              blurRadius: 8,
                              color: Colors.black12)
                        ]),

                    // JOBS
                    child: ExpansionTile(
                      key: GlobalKey(),
                      title: Text(
                        _tanlash,
                        style: TextStyle(
                          color: _jobTitleColor,
                          fontSize: 18.sp,
                        ),
                      ),
                      children: [
                        Container(
                          width: double.infinity,
                          height: 249.h,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 24.w, right: 24.w, top: 8.h),
                            child: ListView.builder(
                                itemCount: widget._jobsArr.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      setState(() {
                                        _tanlash = widget._jobsArr[index]["name"];
                                        _jobId = widget._jobsArr[index]["id"];
                                        _jobBorderColor = Colors.green;
                                        _jobBorderWidth = 2;
                                        _jobTitleColor = Colors.black;
                                            showing_kasb=false;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 3,
                                              backgroundColor: Color.fromRGBO(
                                                  189, 189, 189, 1),
                                            ),
                                            SizedBox(width: 12.w),
                                            Text(
                                              widget._jobsArr[index]["name"],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: .4),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: Color.fromRGBO(230, 230, 230, 1),
                                          height: 8.h,
                                          thickness: 1.4,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                  
                  if (showing_kasb) SizedBox(height: 16.h,child: Row(
                        
                        children: [
                          SizedBox(width:18.w),
                          Text("Kasb kiritilmagan",style: TextStyle(color: Colors.red[700],fontSize: 11.sp,fontWeight: FontWeight.w200),),
                        ],
                      ),),
                  SizedBox(height: 12.h),
                  Text(
                    "Jamoa bo'lib ishlaysizmi? (ixtiyoriy)",
                    style: TextStyle(
                      color: Color.fromRGBO(79, 79, 79, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.h,
                        child: Transform.scale(
                          scale: .6,
                          child: Theme(
                            data: ThemeData(
                                unselectedWidgetColor:
                                    Color.fromRGBO(189, 189, 189, 1)),
                            child: Radio(
                              value: "yeah",
                              groupValue: _isTeam,
                              onChanged: (String? e) {
                                setState(() {
                                  _isTeam = e;
                                  _enable = true;
                                });
                              },
                              activeColor: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          _isTeam = "yeah";
                          _enable = true;
                          setState(() {});
                        },
                        child: Text(
                          "Ha",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 28.w),
                      Container(
                        width: 12.w,
                        height: 12.h,
                        child: Transform.scale(
                          scale: .6,
                          child: Theme(
                            data: ThemeData(
                                unselectedWidgetColor:
                                    Color.fromRGBO(189, 189, 189, 1)),
                            child: Radio(
                              value: "no",
                              groupValue: _isTeam,
                              onChanged: (String? e) {
                                setState(() {
                                  _isTeam = e;
                                  _enable = false;
                                });
                              },
                              activeColor: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          _isTeam = "no";
                          _enable = false;
                          _teamController.clear();
                          setState(() {});
                        },
                        child: Text(
                          "Yo'q",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Necha kishi?",
                    style: TextStyle(
                      color: Color.fromRGBO(79, 79, 79, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _teamController,
                    
                    onChanged: (e){
                      if (e!="") {
                        showing_soni=false;
                      }
                    },
                    validator: (e){
                      if (e=="" && _isTeam!="no") {
                        return "Ishchilar soni kiritilmagan";
                      } else {
                        return null;
                      }
                    },
                    onTap: () {
                      _jobBorderColor = Colors.black87;
                      _jobBorderWidth = 1;
                      _cityBorderColor = Colors.black87;
                      _cityBorderWidth = 1;
                      _regionBorderColor = Colors.black87;
                      _regionBorderWidth = 1;
                      setState(() {});
                    },
                    style: TextStyle(fontSize: 18.w),
                    inputFormatters: [
                      TextInputMask(
                          mask: '99',
                          placeholder: '_',
                          maxPlaceHolders: 2,
                          reverse: false)
                    ],
                    enabled: _enable,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '_ _',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 17.0),
                      hintStyle: _enable == true
                          ? TextStyle(
                              color: Color.fromRGBO(130, 130, 130, 1),
                              fontSize: 18.0)
                          : TextStyle(
                              color: Color.fromRGBO(189, 189, 189, 1),
                              fontSize: 18.0),
                      fillColor: _enable == true
                          ? Colors.white
                          : Color.fromRGBO(242, 242, 242, 1),
                      filled: true,
                      errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            )),
                            focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            )),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(39, 174, 96, 1),
                            )),
                            
                      enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(189, 189, 189, 1),
                            )),
                            
                    disabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(189, 189, 189, 1),
                            )),
                      
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Yashash manzilingiz",
                    style: TextStyle(
                      color: Color.fromRGBO(79, 79, 79, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
               
                  //CITY
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: _cityBorderColor, width: _cityBorderWidth),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(.15, .1),
                            blurRadius: 8,
                            color: Colors.black12)
                      ],
                    ),
                    child: ExpansionTile(
                      key: GlobalKey(),
                      title: Text(
                        _shahar,
                        style: TextStyle(
                          color: _cityTitleColor,
                          fontSize: 18.0,
                        ),
                      ),
                      children: [
                        Container(
                          width: double.infinity,
                          height: 249.h,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 24.w, right: 24.w, top: 8.h),
                            child: ListView.builder(
                                itemCount: widget._cityArr.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (_shahar != "Shahar*") {
                                        _tuman = "Tuman*";
                                        _regionBorderColor = Colors.grey.shade400;
                                        _regionBorderWidth = 1.w;
                                        _regionTitleColor = Colors.grey.shade400;
                                      }
                                      _shahar = widget._cityArr[index]["name"];
                                      _cityId = widget._cityArr[index]["id"];
                                      _cityTitleColor = Colors.black;
                                      _jobBorderColor = Colors.grey.shade400;
                                      _jobBorderWidth = 1;
                                      _cityBorderColor = Colors.green;
                                      _cityBorderWidth = 2;
                                      var data = await _dataFromNet(
                                          "https://epa-tools.uz/api/v1/regions/$_cityId/cities");
                                      _regionList = data["data"];
                                      showing_shahar=false;
                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 3,
                                              backgroundColor: Color.fromRGBO(
                                                  189, 189, 189, 1),
                                            ),
                                            SizedBox(width: 12.w),
                                            Text(
                                              widget._cityArr[index]["name"],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: .4),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: Color.fromRGBO(230, 230, 230, 1),
                                          height: 8.h,
                                          thickness: 1.4,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                   if (showing_shahar) SizedBox(height: 16.h,child: Row(
                        
                        children: [
                          SizedBox(width:18.w),
                          Text("Shahar kiritilmagan",style: TextStyle(color: Colors.red[700],fontSize: 11.sp,fontWeight: FontWeight.w200),),
                        ],
                      ),),
                      SizedBox(height: 4.h),
                  // REGION
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: _regionBorderColor, width: _regionBorderWidth),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(.15, .1),
                            blurRadius: 8,
                            color: Colors.black12)
                      ],
                    ),
                    child: ExpansionTile(
                      key: GlobalKey(),
                      title: Text(
                        _tuman,
                        style: TextStyle(
                          color: _regionTitleColor,
                          fontSize: 18.0,
                        ),
                      ),
                      children: [
                        Container(
                          width: double.infinity,
                          height: 249.h,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 24.w, right: 24.w, top: 8.h),
                            child: ListView.builder(
                                itemCount: _regionList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      _tuman = _regionList[index]["name"];
                                      _regionId = _regionList[index]["id"];
                                      _regionTitleColor = Colors.black;
                                      _cityBorderColor = Colors.black87;

                                      _cityBorderWidth = 1;
                                      _regionBorderColor = Colors.green;
                                      _regionBorderWidth = 2;
                                      _jobBorderColor = Colors.black87;
                                      _jobBorderWidth = 1;
                                      showing_tuman=false;
                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 3,
                                              backgroundColor: Color.fromRGBO(
                                                  189, 189, 189, 1),
                                            ),
                                            SizedBox(width: 12.w),
                                            Text(
                                              _regionList[index]["name"],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: .4),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: Color.fromRGBO(230, 230, 230, 1),
                                          height: 8.h,
                                          thickness: 1.4,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (showing_tuman) SizedBox(height: 16.h,child: Row(
                        
                        children: [
                          SizedBox(width:18.w),
                          Text("Tuman kiritilmagan",style: TextStyle(color: Colors.red[700],fontSize: 11.sp,fontWeight: FontWeight.w200),),
                        ],
                      ),), 
                  SizedBox(height: 16.h),
                  Text(
                    "Telefon raqamingiz",
                    style: TextStyle(
                      color: Color.fromRGBO(79, 79, 79, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (e){
                        if(e!.length > 1){
                          return null;
                        }
                        else{
                          return "Telefon raqam kiritilmagan";
                        }
                    },
                    controller: _phon1Controller,
                    onTap: () {
                      _jobBorderColor = Colors.black87;
                      _jobBorderWidth = 1;
                      _cityBorderColor = Colors.black87;
                      _cityBorderWidth = 1;
                      _regionBorderColor = Colors.black87;
                      _regionBorderWidth = 1;
                      setState(() {});
                    },
                    style: TextStyle(fontSize: 18.w),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      TextInputMask(
                          mask: '\\+999 99 999 99 99',
                          placeholder: '_ ',
                          maxPlaceHolders: 13,
                          reverse: false)
                    ],
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 24.h, vertical: 17.w),
                      hintText: '+998 _ _  _ _ _  _ _ _ _*',
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(150, 150, 150, 1),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2),
                      fillColor: Colors.white,
                      filled: true,
                      errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            )),
                            focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            )),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(39, 174, 96, 1),
                            )),
                            
                      enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(189, 189, 189, 1),
                            )),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Qo'shimcha raqam (ixtiyoriy)",
                    style: TextStyle(
                      color: Color.fromRGBO(130, 130, 130, 1),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  TextFormField(
                    controller: _phon2Controller,
                    style: TextStyle(fontSize: 18.w),
                    inputFormatters: [
                      TextInputMask(
                        mask: '\\+999 99 999 99 99',
                        placeholder: '_ ',
                        maxPlaceHolders: 13,
                      )
                    ],
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 24.h, vertical: 17.w),
                      hintText: '+998_ _  _ _ _  _ _ _ _',
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(150, 150, 150, 1),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(189, 189, 189, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(39, 174, 96, 1), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  
                  Container(
                    width: double.infinity,
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: () async {
                        
                         if (_date==null) {
                            showing_date=true;
                            setState(() {});
                          }
                          if (_tanlash == "Tanlash*") {
                            showing_kasb=true;
                            setState(() {});
                          }
                          if (_shahar == "Shahar*") {
                            showing_shahar=true;
                            setState(() {});
                          }
                          if (_tuman == "Tuman*") {
                            showing_tuman=true;
                            setState(() {});
                          }
                          if (_isTeam !="no" && _teamController.text=="") {
                            showing_soni=true;
                            setState(() {});
                          }
                        if (_formKey.currentState!.validate() && !showing_date && !showing_kasb && !showing_soni && !showing_shahar && !showing_tuman) {
                          
                          var data = await _postFromNet(
                          _nameController.text,
                          _surnameController.text,
                          _patronymicController.text,
                          _phon1Controller.text
                              .split(' ')
                              .join('')
                              .split('+')
                              .join(''),
                          _birthday,
                          _cityId,
                          _regionId,
                          _jobId,
                          _phon2Controller.text
                              .split(' ')
                              .join('')
                              .split('+')
                              .join(''),
                          _enable == true ? _teamController.text : '1',
                        );
                        print(">>>>>>"+data.toString());
                        if (data['success'] == true) {
                          final _cardNumber = data["data"]["cardNumber"];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActivationCode(_cardNumber),
                              ),
                              );
                        } else {

                          if (data['error']["code"]==61) {
                           Flushbar(
                            padding: EdgeInsets.all(16.w),
                            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                            backgroundColor: Colors.red,
                           flushbarPosition:FlushbarPosition.TOP,
                            message: data['data']['title'],
                            messageColor: Colors.white,
                            messageSize: 16.sp,
                            titleText: Text("Epa:",style: TextStyle(color: Colors.white,fontSize: 17.sp),),
                            duration: Duration(seconds: 3),
                          )..show(context);
                            
                          }
                         
                          if (data['error']['code']==60) {
                             Flushbar(
                            padding: EdgeInsets.all(16.w),
                            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                            backgroundColor: Colors.red,
                           flushbarPosition:FlushbarPosition.TOP,
                            message: "Xato ma'lumot kirityabsiz!?",
                            messageColor: Colors.white,
                            messageSize: 16.sp,
                            titleText: Text("Epa:",style: TextStyle(color: Colors.white,fontSize: 17.sp),),
                            duration: Duration(seconds: 3),
                          )..show(context);
                    
                          }
                        }

                        }else{
                           Flushbar(
                            padding: EdgeInsets.all(16.w),
                            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                            backgroundColor: Colors.red,
                           flushbarPosition:FlushbarPosition.TOP,
                            message: "Ma'lumotlarni To'ldiring!",
                            messageColor: Colors.white,
                            messageSize: 16.sp,
                            titleText: Text("Epa:",style: TextStyle(color: Colors.white,fontSize: 17.sp),),
                            duration: Duration(seconds: 3),
                          )..show(context);
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
                        "Jo'natish",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: .4),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _agreement() async {
    final _response =
        await http.get(Uri.parse("https://epa-tools.uz/api/v1/agreement"));
    final data = await json.decode(_response.body);
    print("get");
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding:
                EdgeInsets.only(left: 14.w, right: 14.w, bottom: 8.h),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            insetPadding: EdgeInsets.all(12.h),
            title: Text(
              data['data']['title'],
              style: TextStyle(fontSize: 26.w, fontWeight: FontWeight.w700),
            ),
            content: SingleChildScrollView(
              child: Text(data['data']['content']),
            ),
            actions: [
              Container(
                height: 40.h,
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () async {
                    Navigator.pop(context);
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
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: .4,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future _dataFromNet(link) async {
    final _response = await http.get(Uri.parse(link));
    final _bringData = await json.decode(_response.body);
    print("get");
    return _bringData;
  }

  Future _postFromNet(_name, _surname, _patronymic, _phon1, _birth, _cityId,
      _regionId, _jobId, _phon2, _team) async {
    final _response = await http.post(
      Uri.parse("https://epa-tools.uz/api/v1/masters"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, dynamic>{
        'name': _name,
        'surname': _surname,
        'patronymic': _patronymic,
        'professionId': _jobId,
        'regionId': _cityId,
        'cityId': _regionId,
        'phoneNumber': _phon1,
        'phoneNumber2': _phon2,
        'birthday': _birth,
        'team': true,
        'teamAmount': int.parse(_team),
      }),
    );
    print("post");
    final _bringData = json.decode(_response.body);
    return _bringData;
  }
}
