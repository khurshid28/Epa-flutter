
import 'package:another_flushbar/flushbar.dart';
import 'package:epa/roots/home_page.dart';
import 'package:epa/shopping/coming_data/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';

class AddShopping extends StatefulWidget {
  String? _token;
  Map? _user;
  AddShopping(this._token, this._user);

  @override
  _AddShoppingState createState() => _AddShoppingState();
}

class _AddShoppingState extends State<AddShopping>  with TickerProviderStateMixin{
  AnimationController? _animationController;
  AnimationController? _animationController2;
  TextEditingController _controllerMessage = TextEditingController();
  TextEditingController _controllerValue = TextEditingController();
  Color _borderColor1 = Color.fromRGBO(189, 189, 189, 1);
  bool _enable = true;
  String _err = '';
  int _bahs = 0;
  int _addHeight = 46;
  int _active = 1;
  File? _image;
  final picker = ImagePicker();
  bool keldi = false;
  var data;
  Color _addColor = Color.fromRGBO(189, 189, 189, 1);
  Product? myProduct;
  Future getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  void initState() {
    _animationController=AnimationController(vsync: this,duration: Duration(seconds: 2))
    ..addListener(() {
      if (_animationController!.value==1) {
        
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Homepage(widget._token)), (route) => false);
        
      }
    });
     _animationController2=AnimationController(vsync: this,duration: Duration(seconds: 3))..addListener(() {
       if(_animationController2!.value==1){
          _active=2;
                setState(() {
                  
                });
         _animationController!.forward(from: 0).then((value){
              
         });
        
       }
     });
    super.initState();
  }
  @override
  void dispose() {
    _animationController!.dispose();
    _animationController2!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(
      BoxConstraints(maxWidth: size.width, maxHeight: size.height),
      designSize: const Size(360, 603),
      orientation: Orientation.portrait,
    );
    if (!_enable) {
      Future.delayed(Duration(seconds: 1), () {
        _enable = true;
        setState(() {});
      });
    }
    if (_active == 1) {
      return _yangiXarid();
    } else if (_active == 2) {
      return _showXarid();
    } else if (_active == 3) {
      return _bahsOchish();
    } else if (_active == 4) {
      return _showBahs();
    }
    return Text('');
  }

  _yangiXarid() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: 1.sh,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.h, bottom: 32.h),
                          child: Text(
                            "Yangi xarid",
                            style: TextStyle(
                                color: Color.fromRGBO(51, 51, 51, 1),
                                fontSize: 25.w,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Text(
                        "Mahsulot qadog'idagi kodni kiriting",
                        style: TextStyle(
                            color: Color.fromRGBO(79, 79, 79, 1),
                            letterSpacing: .5,
                            fontSize: 16.w),
                      ),
                      SizedBox(height: 4.h),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        enabled: _enable,
                        textCapitalization: TextCapitalization.characters,
                        controller: _controllerValue,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 4,
                        ),
                       
                        onChanged: (e) {
                          setState(() {
                            if (e.length != 7 || e.length != 9) {
                              _addHeight = 46;
                              _bahs = 0;
                              _err = '';
                            }
                            if (e.length > 6) {
                              _borderColor1 = Color.fromRGBO(39, 174, 96, 1);
                              _addColor = Color.fromRGBO(237, 28, 36, 1);
                            } else {
                              _bahs = 0;
                              _err = '';
                              _addColor = Color.fromRGBO(189, 189, 189, 1);
                            }
                          });
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 24.0, vertical: 17.0),
                          hintText: '_ _ _ _ _ _ _ _',
                          hintStyle: TextStyle(
                              letterSpacing: 2.5,
                              color: Color.fromRGBO(130, 130, 130, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color.fromRGBO(189, 189, 189, 1)),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _borderColor1, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              
                        ),
                      ),
                      SizedBox(
                        height: 4.w,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical:10.h,),
                        child: Container(
                         width: 328.w,
                         height: 116.h,
                         color: Colors.transparent,
                         child: AnimatedBuilder(animation: _animationController2!, builder: (context,child){
                           if (_animationController2!.value==0) {
                             return Container();
                           }else if(_animationController2!.value<0.2){
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            );
                           }else{
                             var result_word="";
                             for (var i = 0; i < (data["data"]["productName"].toString().length >18?15: data["data"]["productName"].toString().length); i++) {
                               result_word+=data["data"]["productName"].toString()[i];
                             }
                             if (data["data"]["productName"].toString().length>18) {
                               result_word+="...";
                             }
                            return Container(
                              height: 116.h,
                              width: 324.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      
                                      Text("Siz "+result_word,style: TextStyle(fontSize:14.sp,color: Color(0xff4F4F4F)),),
                                      Text("modelli mahsulotni",style: TextStyle(fontSize:14.sp,color: Color(0xff4F4F4F)),),
                                      Text("kiritdingiz",style: TextStyle(fontSize:14.sp,color: Color(0xff4F4F4F)),),
                                      Text(data["data"]["bonusAdded"].toString()+" B",style: TextStyle(fontSize:20.sp,color: Color(0xff27AE60),fontWeight: FontWeight.bold,),),

                                      
                                    ],
                                  ),
                                  Container(
                                    width: 102.h,
                                    height: 102.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.r),
                                      image: DecorationImage(image: NetworkImage("https://epa-tools.uz/api/v1/products/"+data["data"]["productId"].toString()+"/image"),fit:BoxFit.cover,)
                                      ),
                                  ),
                                ],
                              ),
                            );
                           }
                         }),
                        ),
                      ),
                      Container(
                        height: _bahs.h,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () async {
                            _active = 3;
                            setState(() {});
                          },
                          child: Text(
                            "Bahs ochish",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                letterSpacing: .8),
                          ),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(237, 28, 36, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: _addHeight.h,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        
                        if(_controllerValue.text.length>6){
                           
                         data = await _dataFrom(
                            widget._token, _controllerValue.text.toString());
                        print(">>>>>>"+data.toString());
                        if (data['success'] == true) {
                            _animationController2!.forward(from: 0);
                        } else if (data['error']['code'] == 81) {
                           Flushbar(
                           padding: EdgeInsets.all(16.w),
                           dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                           backgroundColor: Colors.red,
                               flushbarPosition:FlushbarPosition.TOP,
                                message: "Xato Serial Raqam kiritdingiz",
                                messageColor: Colors.white,
                                titleText: Text("Epa:",style: TextStyle(color: Colors.white,fontSize: 17.sp),),
                                duration: Duration(seconds: 3),
                              )..show(context);

                          print(data);
                          
                        
                        }
                        else if (data['error']['code'] == 82) {
                          Flushbar(
                           padding: EdgeInsets.all(16.w),
                           dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                           backgroundColor: Colors.red,
                               flushbarPosition:FlushbarPosition.TOP,
                                message: data["data"]["title"],
                                messageColor: Colors.white,
                                titleText: Text("Epa:",style: TextStyle(color: Colors.white,fontSize: 17.sp),),
                                duration: Duration(seconds: 3),
                              )..show(context);

                          print(data);
                         
                          
                        }
                        else if (data['error']['code'] == 83) {
                          Flushbar(
                           padding: EdgeInsets.all(16.w),
                           dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                           backgroundColor: Colors.red,
                               flushbarPosition:FlushbarPosition.TOP,
                                message: data["data"]["title"],
                                messageColor: Colors.white,
                                titleText: Text("Epa:",style: TextStyle(color: Colors.white,fontSize: 17.sp),),
                                duration: Duration(seconds: 3),
                              )..show(context).then((value){
                                  _bahs = 46;
                                  _addHeight = 0;
                                  setState(() {});
                              });
                        
                        }
                        }else{
                          return null;
                        }
                      },
                      child: Text(
                        "Qo'shish",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: .8),
                      ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: _addColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _bahsOchish() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Center(
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
                 _bahs = 0;
                 _addHeight = 46;
              _controllerValue.text="";
                 _addColor=Color.fromRGBO(189, 189, 189, 1);
              _active=1;
              setState(() {
                
              });
            },
          ),
                ),
              ),
              SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.only(top: 48.w, bottom: 24),
                  child: Container(
                    height: 58.h,
                    child: Text(
                      "Mahsulot kodini rasmga olib yuklang",
                      style: TextStyle(
                          color: Color.fromRGBO(51, 51, 51, 1),
                          fontSize: 25.w,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Column(
                  children: [
                    DottedBorder(
                      borderType: BorderType.RRect,
                      padding: EdgeInsets.all(.5),
                      color: _image == null
                          ? Color.fromRGBO(130, 130, 130, 1)
                          : Color.fromRGBO(255, 255, 255, 1),
                      strokeWidth: _image == null ? 2 : 0,
                      dashPattern: [4, 4],
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(224, 224, 224, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                          height: 160.h,
                          width: 328.w,
                        child: Center(
                          child: Container(
                            child: GestureDetector(
                              onTap: _image == null ? () => getImage() : () {},
                              child: _image == null
                                  ? Container(
                                      height: 58.w,
                                      width: 58.w,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(237, 28, 36, 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 18.w,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(
                                      width: 1.sw,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: FileImage(_image!),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    _image == null
                        ? Container()
                        : Column(
                            children: [
                              Container(
                                height: 30,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      _image = null;
                                    });
                                  },
                                  icon: Icon(Icons.clear),
                                  iconSize: 20.w,
                                  color: Colors.red[600],
                                ),
                              ),
                              SizedBox(
                                height: 32.w,
                              ),
                              TextFormField(
                                controller: _controllerMessage,
                                keyboardType: TextInputType.multiline,
                                maxLines: 10,
                                cursorColor: Colors.grey[800],
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(200, 200, 200, 1),
                                          width: 1.1.w),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(200, 200, 200, 1),
                                        width: 1.1.w,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 24.w, vertical: 16.w),
                                    hintText: "Izohlaringizni qoldiring",
                                    hintStyle: TextStyle(
                                        color: Color.fromRGBO(130, 130, 130, 1),
                                        fontSize: 18.w,
                                        letterSpacing: .5)),
                                        
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.w, bottom: 32.w),
                                child: Container(
                                  height: 54.w,
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      setState(() {});
                                      data = await _dataForm(
                                        widget._token,
                                        _controllerMessage.text,
                                        _controllerValue.text,
                                        _image,
                                      );
                                      if (data["success"] == true) {
                                        _active = 4;
                                        setState(() {});
                                      } else {
                                        _active = 4;
                                        setState(() {});
                                       Flushbar(
                                        padding: EdgeInsets.all(16.w),
                                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                                        backgroundColor: Colors.red,
                                      flushbarPosition:FlushbarPosition.TOP,
                                        message: data["data"]["title"],
                                        messageColor: Colors.white,
                                        messageSize: 16.sp,
                                        titleText: Text("Epa:",style: TextStyle(color: Colors.white,fontSize: 17.sp),),
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                      
                                      }
                                    },
                                    child: Text(
                                      "Jo'natish",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          letterSpacing: .8),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromRGBO(237, 28, 36, 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showXarid() {
    return SafeArea(
      child: AnimatedBuilder(animation: _animationController!, builder: (context,child){
        if (_animationController!.value<0.5) {
          return Center(
            child: CircularProgressIndicator(color: Colors.red,),
          );
        } else {
          return Padding(
        padding:
            EdgeInsets.only(top: 32.h, bottom: 32.h, left: 16.w, right: 16.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data["data"]["message"].toString(),
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: .7),
              ),
              SizedBox(
                height: 40.w,
              ),
              Icon(Icons.check_circle_outline_rounded,
                  size: 80.0, color: Colors.green)
            ],
          ),
        ),
      );
        }
      }),
    );
  }

  _showBahs() {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.only(top:0.h, bottom: 32.h, left: 16.w, right: 16.w),
        child: Center(
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text(
                data['data']['title'] + data['data']['message'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              ),
              SizedBox(
                height: 40.w,
              ),
              Icon(Icons.check_circle_outline_rounded,
                  size: 80.0, color: Colors.green)
            ],
          ),
        ),
      ),
    );
  }

  Future _dataFrom(_token, _value) async {
    print("post");
    final _response = await http.post(
      Uri.parse("https://epa-tools.uz/api/v1/serial-numbers/capture"),
      headers: <String, String>{
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json'
      },
      body: json.encode(<String, String>{"value": _value}),
    );
    
    final _bringData = jsonDecode(_response.body);
    print("ok data>>>"+ _bringData.toString());
    return _bringData;
  }

  Future _dataForm(_token, _message, _value, image) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://epa-tools.uz/api/v1/serial-numbers/claim"),
    );
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Authorization': 'Bearer $_token',
    };

    request.files.add(
      http.MultipartFile(
        'image',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: DateTime.now().toIso8601String(),
      ),
    );
    request.fields.addAll({"value": _value, "message": _message});
    request.headers.addAll(headers);
    var response = await request.send();
    var data;

  
    await response.stream.transform(utf8.decoder).listen((value) {
      data = value;
    });

    return jsonDecode(data);
  }
}
