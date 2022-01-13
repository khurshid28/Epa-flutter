import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

class Katalog extends StatefulWidget {
  String? _token;
  Katalog(this._token,);

  @override
  _KatalogState createState() => _KatalogState();
}

class _KatalogState extends State<Katalog> {
  List<bool> _list = List.generate(200, (i) => false);

  bool _e = false;
  int? _categoryId;
  int _active = 1;
  int num=0;
  // List<bool>? _genColor;
  List? _subCategories;
  int? _subCategoryId;
  Map? __products;
  String? _name;
  int id_son = 0;
  int numm=0;
  int ff=0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(
      BoxConstraints(maxWidth: size.width, maxHeight: size.height),
      designSize: const Size(360, 603),
      orientation: Orientation.portrait,
    );
    
    
      if (_active == 1) {
        return _categories();
      } else {
        num=2;
        return _product(_name, widget._token, id_son);
      }
    
  }

  _categories() {
    return FutureBuilder(
      future: get_category_data(),
      builder: (context,AsyncSnapshot snapshot){

        if (snapshot.hasData && num==0) {
          
          var data=snapshot.data;
          
          return SafeArea(
            child: Column(
              children: [
                SizedBox(
                height: 50.h,
                width: 1.sw,
                child: Padding(
                  padding:  EdgeInsets.only(left: 16.w),
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
             Navigator.of(context).pop();
            },
          ),
                ),
              ),
             
                Container(
                  height: 454.6.h,
                  child: ListView.builder(
      itemCount: data['data'].length,
      itemBuilder: (context, index) {
        return Column(
                  children: [
                    SizedBox(height: index == 0 ? 24.w : 0),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.w, horizontal: 16.w),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: _list[index] ? 2.w : 0,
                              color: _list[index]
                                  ? Color.fromRGBO(237, 28, 36, 1)
                                  : Colors.white),
                          color: _list[index]
                              ? Color.fromRGBO(237, 28, 36, 1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.w),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 8),
                                blurRadius: 24,
                                color: Color.fromRGBO(151, 151, 151, 0.5))
                          ]),
                      child: ExpansionTile(
                        onExpansionChanged: (e) {
                          print(index);
                          setState(() async {
                            _e = e;
                            setState(() {});
                            if (!_list[index]) {
                              _list[index] = true;
                              setState(() {});
                            } else {
                              _list[index] = false;
                              setState(() {});
                            }
                            setState(() {});
                            // __products = await _getCategoriesChild(
                            //     widget._token, data['data'][index]['id']);
                            id_son = data['data'][index]['id'];
                            if (data['data'][index]['children'] == null) {
                              _categoryId =data['data'][index]['id'];
                              _name = data['data'][index]['name'];
                              
                              _active = 3;
                              _list[index]=true;
                            }

                            setState(() {});
                          });
                        },
                        title: Row(
                          children: [
                            SvgPicture.network(
                              data['data'][index]["icon"].toString(),
                              color: _list[index]
                                  ? Colors.white
                                  : Color.fromRGBO(79, 79, 79, 1),
                              width: 22.w,
                              height: 24.h,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Container(
                              width: 200.w,
                              child: Text(
                                data['data'][index]['name'],
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: _list[index]
                                      ? Colors.white
                                      : Color.fromRGBO(79, 79, 79, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: _list[index] &&
                                data['data'][index]['children'] != null
                            ? Icon(
                                Icons.remove,
                                color: Color.fromRGBO(220, 220, 220, 1),
                              )
                            : Text(''),
                        children: [
                          Container(
                            margin: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.w),
                                bottomRight: Radius.circular(10.w),
                              ),
                              color: Color.fromRGBO(242, 242, 242, 1),
                            ),
                            width: double.infinity,
                            height:
                                data['data'][index]['children'] != null
                                    ? 186.w
                                    : 0,
                            child: ListView.builder(
                              itemCount: data['data'][index]
                                          ['children'] !=
                                      null
                                  ? data['data'][index]['children'].length
                                  : 0,
                              itemBuilder: (context, indexChild) {
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _subCategoryId = data['data'][index]
                                        ['children'][indexChild]['id'];
                                    // __products = await _getCategoriesChild(
                                    //     widget._token, _subCategoryId);

                                    id_son = data['data'][index]
                                        ['children'][indexChild]['id'];
                                    _name = data['data'][index]
                                        ['children'][indexChild]["name"];
                                    _active = 2;
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: indexChild == 0 ? 24.w : 4.w,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 4.w,
                                              backgroundColor:
                                                  Color.fromRGBO(189, 189, 189, 1),
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            Text(
                                              data['data'][index]
                                                  ['children'][indexChild]['name'],
                                              style: TextStyle(
                                                fontSize: 17.w,
                                                color: Color.fromRGBO(51, 51, 51, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 1.2.w,
                                          color: Color.fromRGBO(189, 189, 189, 1),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),  
                          )
                        ],
                      ),
                    ),
                  ],
        );
      },
    ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator(color: Colors.red,),);
        }
    });
  }
  Future get_category_data()async{
       var headers= <String, String>{'Authorization': 'Bearer ${widget._token}'}; 
       var  _response = await get(
        Uri.parse("https://epa-tools.uz/api/v1/product-categories"),
        headers: headers);
        print("get");
       
       var data=await jsonDecode(_response.body);
       num=0;
       return data;
  }
  _product(_name, _token, id) {
    return FutureBuilder(
      future: _getCategoriesChild(_token, id,ff),
      builder: (context, AsyncSnapshot snapshot) {
        
        if (snapshot.hasData) {
          var products = snapshot.data;
         if ((products['data'] as List).length>0) {
            if (products['data'][0]['thumbnail'].toString()=="null" || numm !=ff) {
            print("bring data>>>>"+products['data'].toString());
            return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            )
          );
          } else {
            var prev=products['links']["prev"].toString() != "null";
            var next=products['links']["next"].toString() != "null";
            return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
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
              _active=1;
              num=1;
              int len=_list.length;
              _list=List.generate(len, (index) => false);
              setState(() {
                
              });
            },
          ),
                ),
              ),
           
                  Container(
                    margin: EdgeInsets.only(top: 28.h, bottom: 12.h, left: 2.w),
                    child: Text(
                      _name.toString(),
                      style: TextStyle(
                          color: Color.fromRGBO(51, 51, 51, 1),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount:(products['data'] as List).length+1,
                      
                        itemBuilder: (context, index) {
                          return  index==(products['data'] as List).length ? !(prev || next) ?Container(): Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Container(
                                         color: Colors.transparent,
                                         height: 80.h,
                                         width: 260.w,
                                         alignment: Alignment.center,
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                       prev ?      InkWell(
                                               splashColor: Colors.transparent,
                                               highlightColor: Colors.transparent,
                                               onTap: (){
                                                 ff-=1;
                                                 setState(() {
                                                   
                                                 });
                                               },
                                               child: Padding(
                                                 padding: EdgeInsets.all(25.w),
                                                 child: Row(
                                                   children: [
                                                    Icon(Icons.arrow_back_ios_new_rounded),
                                                    SizedBox(width: 4.w,),
                                                     Text("Ortga",style: TextStyle(fontWeight: FontWeight.bold),),
                                                   ],
                                                 ),
                                               ),
                                             )
                                             
                                           :Container()  ,
                                         next ?     InkWell(
                                                splashColor: Colors.transparent,
                                               highlightColor: Colors.transparent,
                                               onTap: (){
                                                 ff=ff+1;
                                                 setState(() {
                                                   
                                                 });
                                               },
                                                child: Padding(
                                                  padding:  EdgeInsets.all(25.w),
                                                  child: Row(
                                                    children: [
                                                      Text("Oldinga",style: TextStyle(fontWeight: FontWeight.bold),),
                                                      SizedBox(width: 4.w,),
                                                      Icon(Icons.arrow_forward_ios_rounded),
                                                    ],
                                                  ),
                                                ),
                                              ):Container(),
                                           ],
                                         ),
                                         
                                     
                                     ),

                                   ],
                               ) :Column(
                                  children: [
                                    SizedBox(
                                      height: 0.h,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      
                                      leading: Container(
                                        width: 56.w,
                                        height: 56.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            image: DecorationImage(
                                              image: NetworkImage(products['data']
                                                  [index]['thumbnail'].toString()),
                                            )),
                                      ),
                                      horizontalTitleGap: 8.w,
                                      minVerticalPadding: 14.5.h,
                                      title: Container(
                                          child: Text(
                                        products!['data'][index]['name'].toString(),
                                        style: TextStyle(
                                            color: Color.fromRGBO(51, 51, 51, 1),
                                            fontSize: 16.w,
                                            fontWeight: FontWeight.w500),
                                      )),
                                      subtitle: Padding(
                                        padding: EdgeInsets.only(top: 2.5.h),
                                        child: Row(
                                          children: [
                                            Text(
                                                products['data'][index]
                                                            ['bonus']
                                                        .toString() +
                                                    " b",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        39, 174, 96, 1),
                                                    fontSize: 14.w,
                                                    fontWeight: FontWeight.w700)),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Text(
                                              "beriladi",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      130, 130, 130, 1),
                                                  fontSize: 12.w),
                                            ),
                                          ],
                                        ),
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            products['data'][index ]
                                                    ['price']
                                                .toString(),
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    201, 36, 36, 1),
                                                fontSize: 15.w,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Container(
                                            width: 110.w,
                                            height: 20.h,
                                            child: Text(
                                              "ballga olish mumkin",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      51, 51, 51, 1),
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.2.sp,
                                      height: 8.h,
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                  ],
                                );
                              
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        
          }
        
        }else if(snapshot.hasError){
          return Center(
            child: Text(
            "Error",
            ),
          );

        }
         else {
            return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            )
          );

        }
         } else {
           return Container();
         }
      },
    );
  }

  Future _getCategoriesChild(_token, id,_ff) async {
    final _response = await get(
        Uri.parse(
            "https://epa-tools.uz/api/v1/product-categories/$id/products?page="+(_ff+1).toString()),
        headers: <String, String>{'Authorization': 'Bearer $_token'});
    if (_response.statusCode == 200) {
      final _bringData =await jsonDecode(_response.body);
      print(_bringData);
    
        numm=_ff;
      
      return _bringData;
    } else {
      return throw Exception("Malumot");
    }
  }
}
