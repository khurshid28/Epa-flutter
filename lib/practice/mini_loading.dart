import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

class My_mini_Loading extends StatefulWidget {
  String token;
  String switch_name;
 
  My_mini_Loading(this.token,this.switch_name,{ Key? key }) : super(key: key);

  @override
  _My_mini_LoadingState createState() => _My_mini_LoadingState();
}

class _My_mini_LoadingState extends State<My_mini_Loading> {
  int ff=0;
  int ss=0;
  int numss=0;
  int num=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: get_data(widget.token, widget.switch_name,ff,ss),
        builder: (context,AsyncSnapshot snapshot) {
          
          if (snapshot.hasData && (num==ff && numss==ss)) {
            var data=snapshot.data;
            if (widget.switch_name=="xarid" ) {
              print(data['links'] );
              var prev=data['links']["prev"].toString() != "null";
              var next=data['links']["next"].toString() != "null";
               return  Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: (data['data'] as List).length + 1,
                            itemBuilder: (context, index) {  
                              var result_word="" ;
                              if ((data['data'] as List).length!=0) {
                                for (var i = 0; i < (data['data'][index==(data['data'] as List).length ? 0:index]['productName'].toString().split('').length >12 ? 12:data['data'][index]['productName'].toString().split('').length); i++) {
                                 result_word+=data['data'][index==(data['data'] as List).length ? 0:index]['productName'].toString()[i];
                              }
                              }
                              
                               result_word+="...";
                               return  index==(data['data'] as List).length ? !(prev || next) ? Container(
                                 color: Color.fromRGBO(242, 242, 242, 1),
                               ):
                               Row(
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
                               ): 
                                Column(
                                      children: [
                                        SizedBox(
                                            height: index == 0 ? 12.h : 8.h),
                                        Container(
                                          color: Colors.transparent,
                                          height: 56.h,
                                          child: ListTile(
                                            
                                            contentPadding:
                                                EdgeInsets.only(left: 2.w),
                                            leading: Container(
                                              width: 56.w,
                                              height: 56.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "https://epa-tools.uz/api/v1/products/" +
                                                            data[
                                                                    'data'][
                                                                    index 
                                                                       ]
                                                                    [
                                                                    "productId"]
                                                                .toString()
                                                                .toString() +
                                                            "/image"),
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                            title: Text(
                                              result_word,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      51, 51, 51, 1)),
                                            ),
                                            horizontalTitleGap: 8.w,
                                            minVerticalPadding: 10.h,
                                            subtitle: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 3.h),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time_rounded,
                                                    size: 17,
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Text(
                                                    data[
                                                            'data'][
                                                        
                                                            index]['date'],
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            130, 130, 130, 1)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            trailing: Container(
                                              width: 120.w,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 40.w,
                                                    height: 22.h,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.04),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                        child: Text(
                                                      data[
                                                                  'data'][
                                                                 
                                                                      index]
                                                                  ['amount']
                                                              .toString() +
                                                          ' ta'.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14.sp),
                                                    )),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "Berildi: ",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          letterSpacing: .3,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color.fromRGBO(
                                                              130, 130, 130, 1),
                                                        ),
                                                      ),
                                                      Text(
                                                        data[
                                                                    'data'][
                                                                    
                                                                        index][
                                                                    'bonusAdded']
                                                                .toString() +
                                                            ' b',
                                                        style: TextStyle(
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color.fromRGBO(
                                                              39, 174, 96, 1),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.h,
                                        ),
                                        Divider(
                                          thickness: 1.h,
                                          height: 0.h,
                                        )
                                      ],
                                    )
                                  ;
                            },
                          ),
                        ),
                      ],
                    );
            } else {
              print(data['links'] );
              var prev=data['links']["prev"].toString() != "null";
              var next=data['links']["next"].toString() != "null";
               return  Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: ListView.builder(
                              itemCount: (data['data'] as List).length+1,
                              itemBuilder: (context, index) {
                                var result_word="" ;
                              if ((data['data'] as List).length!=0) {
                                for (var i = 0; i < (data['data'][index==(data['data'] as List).length ? 0:index]['productName'].toString().split('').length >12 ? 12:data['data'][index]['productName'].toString().split('').length); i++) {
                                 result_word+=data['data'][index==(data['data'] as List).length ? 0:index]['productName'].toString()[i];
                              }
                              }
                              
                               result_word+="...";
                                return index==(data['data'] as List).length ? !(prev || next) ? Container(
                                  color: Color.fromRGBO(242, 242, 242, 1),
                                ):
                                 Row(
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
                                                 ss-=1;
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
                                                 ss=ss+1;
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
                               ): Column(
                                  children: [
                                    SizedBox(height: index == 0 ? 12.h : 8.h),
                                    Container(
                                      height: 56.h,
                                      color: Colors.transparent,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.only(
                                          left: 2.w,
                                        ),
                                        leading: Container(
                                          width: 56.w,
                                          height: 56.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://epa-tools.uz/api/v1/products/" +
                                                          data[
                                                                  'data'][
                                                                  index ]
                                                                  ["productId"]
                                                              .toString() +
                                                          "/image"),
                                                  fit: BoxFit.fill)),
                                        ),
                                        title: Text(
                                          result_word,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  51, 51, 51, 1)),
                                        ),
                                        horizontalTitleGap: 8.w,
                                        minVerticalPadding: 13.3.h,
                                        subtitle: Padding(
                                          padding: EdgeInsets.only(top: 3.h),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.access_time_rounded,
                                                size: 16,
                                              ),
                                              SizedBox(width: 4.w),
                                              Text(
                                                data['data']
                                                        [index]
                                                    ['date'],
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        130, 130, 130, 1)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 120.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 20.h,
                                                width: 40.w,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.04),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r)),
                                                child: Center(
                                                    child: Text(
                                                  data[
                                                              'data'][index]
                                                              ['amount']
                                                          .toString() +
                                                      ' ta'.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Yechildi: ",
                                                    style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          130, 130, 130, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    data[
                                                                'data'][index][
                                                                'bonusExchanged']
                                                            .toString() +
                                                        ' b',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color.fromRGBO(
                                                          201, 36, 36, 1),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 9.5.h,
                                    ),
                                    Divider(
                                      thickness: 1.h,
                                      height: 0,
                                    )
                                  ],
                                );
                                
                              
                              },
                              
                            ),
                          ),
                        ),
                      ],
                    );     
            }
            
          } else {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future get_data(token,switch_name,ff,ss)async{
   var headers= <String, String>{'Authorization': 'Bearer ${widget.token}'}; 
   var  _response;
   if (switch_name=="xarid") {
       _response = await get(
        Uri.parse("https://epa-tools.uz/api/v1/master/purchases?page="+(ff+1).toString()),
        headers: headers);
        num=ff;
      
      
   } else {
       _response = await get(
        Uri.parse("https://epa-tools.uz/api/v1/master/gifts?page="+(ss+1).toString()),
        headers: headers);
        numss=ss;
       
   }
    
    print("get");
    return await jsonDecode(_response.body);
  }
}