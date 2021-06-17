import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mymusic/Utils/ColorUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  double startY=0;//手指起始的坐标
  double moveY=0;//手指移动的坐标
  double moveDistance=0;//手指移动的距离
  Map<String,dynamic> userInfo;//用户登录数据
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 800.0,
            child: Stack(
                alignment: Alignment.center,
                children: [
                  //背景图片
                  Positioned(
                    top: 0.0,
                    child: Opacity(
                      opacity: 0.6,
                      child: Container(
                        height: 360.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage("lib/asserts/images/personal/bgImg2.jpg"),
                              alignment: Alignment.topCenter,
                            fit: BoxFit.fill,
                            // scale: 2.0
                          ),
                        ),
                      ),
                    ),
                  ),
                  //头像和昵称
                  Positioned(
                    top: 90.0,
                    left: 20.0,
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: 75.0,
                            height: 75.0,
                            margin: EdgeInsets.fromLTRB(2.0, 0, 10.0, 5.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromRGBO(233, 233, 233, 1.0),width: 1.5),
                              borderRadius: BorderRadius.circular(50.0)
                            ),
                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset("lib/asserts/images/personal/missing-face.png",fit: BoxFit.fill,),
                            ),
                          ),
                          Text("游客",style: TextStyle(fontSize: 22.0,color: Color.fromRGBO(96, 96, 99, 1.0)),)
                        ],
                      ),
                    )
                  ),

                  //vip卡片区域
                  Positioned(
                    top: 170,
                    left: 20.0,
                    child: Container(
                        height: 280.0,
                        width: 350.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            color: ColorUtils.createColorHex(0x000000,alpha: 0.7),
                            border: Border.all(width: 1.0,style: BorderStyle.solid)
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 350.0,
                              height: 250.0,
                              child: Stack(
                                children: [
                                  //王冠区域
                                  Positioned(
                                    left: 12.0,
                                    top: 12.0,
                                    child: Icon(IconData(0xe610,fontFamily: "MyIcons"),size: 18.0,color: ColorUtils.createColorHex(0xf7d680),),
                                  ),
                                  Positioned(
                                    top: 12.0,
                                    left: 36.0,
                                    child: Text("⑦柒会员",style: TextStyle(color: ColorUtils.createColorHex(0xf7d680),fontSize: 16.0)),
                                  ),
                                  Positioned(
                                    top: 12.0,
                                    right: 12.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 2.0),
                                        child: Text("立即开通",style: TextStyle(color: ColorUtils.createColorHex(0x36343c),fontSize: 14.0)),
                                      ),
                                      decoration: BoxDecoration(
                                          color: ColorUtils.createColorHex(0xf9e6af),
                                          borderRadius: BorderRadius.circular(50.0)
                                      ),
                                    ),
                                  ),
                                  //背景图片
                                  Positioned(
                                    top: 36.0,
                                    right: 0.0,
                                    child: Image.asset("lib/asserts/images/personal/vip-card-bg.png"),
                                  ),
                                  //广告信息
                                  Positioned(
                                    left: 12.0,
                                    top: 55.0,
                                    child: Text("ChenQ Union",style: TextStyle(color: ColorUtils.createColorHex(0xf6e5a3),fontSize: 26.0),),
                                  ),
                                  Positioned(
                                    left: 12.0,
                                    top: 90.0,
                                    child: Text("开通会员听音乐",style: TextStyle(color: ColorUtils.createColorHex(0xd8cba9),fontSize: 16.0),),
                                  )
                                ],
                              ),
                            )

                          ],
                        )
                    ),
                  ),
                  Positioned(
                    top: 270.0,
                      child: Listener(
                        onPointerDown: (PointerDownEvent event)=>setState(()=> startY=event.position.dy),
                        onPointerMove: (PointerMoveEvent event){
                          setState(() {
                            moveY = event.position.dy;
                            moveDistance = moveY-startY;
                            if(moveDistance<=0){
                              return;
                            }
                            if(moveDistance>80){
                              moveDistance = 80;
                            }
                          });
                        },
                          onPointerUp: (PointerUpEvent event){
                          //计时器，实现下拉栏缓慢返回
                          Timer timer = Timer.periodic(Duration(milliseconds: 2), (Timer timer){
                            setState(() {
                              if(moveDistance<=0.0){
                                moveDistance = 0.0;
                                timer.cancel();
                              }else{
                                moveDistance-=0.5;
                              }
                            });
                          });
                          },
                        child: Transform.translate(
                          offset: Offset(0.0,moveDistance),
                          child: Container(
                            width: 400.0,
                              height: 550.0,

                              child: Column(
                                children: [
                                  Image.asset("lib/asserts/images/personal/arc.png",fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
                                  //个人中心和近期播放
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 520.0,
                                    decoration: BoxDecoration(
                                        color: ColorUtils.createColorHex(0xf5f5f5)
                                    ),
                                    child: Column(
                                      children: [
                                        //个人中心列表
                                        Container(
                                          child: Container(
                                              width: 350.0,
                                              height: 90.0,
                                              decoration: BoxDecoration(
                                                  color: ColorUtils.createColorHex(0xffffff),
                                                  borderRadius: BorderRadius.circular(16.0)
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 13.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Column(
                                                          children: [
                                                            Icon(IconData(0xe6b6,fontFamily: "MyIcons"),size: 36.0,color: ColorUtils.createColorHex(0xd43c33),),
                                                            SizedBox(width: 8.0,height: 8.0,),
                                                            Text(" 我的消息",style: TextStyle(fontSize: 14.0),)
                                                          ],
                                                        )
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Column(
                                                          children: [
                                                            Icon(IconData(0xe62f,fontFamily: "MyIcons"),size: 36.0,color: ColorUtils.createColorHex(0xd43c33),),
                                                            SizedBox(width: 8.0,height: 8.0,),
                                                            Text(" 我的好友",style: TextStyle(fontSize: 14.0),)
                                                          ],
                                                        )
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Column(
                                                          children: [
                                                            Icon(IconData(0xe600,fontFamily: "MyIcons"),size: 36.0,color: ColorUtils.createColorHex(0xd43c33),),
                                                            SizedBox(width: 8.0,height: 8.0,),
                                                            Text(" 个人主页",style: TextStyle(fontSize: 14.0),)
                                                          ],
                                                        )
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Column(
                                                          children: [
                                                            Icon(IconData(0xe655,fontFamily: "MyIcons"),size: 36.0,color: ColorUtils.createColorHex(0xd43c33),),
                                                            SizedBox(width: 8.0,height: 8.0,),
                                                            Text(" 个性装扮",style: TextStyle(fontSize: 14.0),)
                                                          ],
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(10.0)),
                                        //最近播放列表
                                        Container(
                                            child: Container(
                                              width: 350.0,
                                              height: 340.0,
                                              decoration: BoxDecoration(
                                                  color: ColorUtils.createColorHex(0xffffff),
                                                  borderRadius: BorderRadius.circular(16.0)
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                      width: 350.0,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                        child: Text("最近播放",style: TextStyle(fontSize: 22,color: ColorUtils.createColorHex(0x333349))),
                                                      )
                                                  ),

                                                  Container(
                                                      width: 350.0,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                        child: Text("暂无播放记录",style: TextStyle(fontSize: 22)),
                                                      )
                                                  ),
                                                  Divider(color: Color.fromRGBO(220, 220, 220, 1.0),),
                                                  ListTile(
                                                    title: Text("我的音乐"),
                                                    trailing: Icon(Icons.keyboard_arrow_right),
                                                  ),
                                                  Divider(color: Color.fromRGBO(220, 220, 220, 1.0),),
                                                  ListTile(
                                                    title: Text("我的收藏"),
                                                    trailing: Icon(Icons.keyboard_arrow_right),
                                                  ),
                                                  Divider(color: Color.fromRGBO(220, 220, 220, 1.0),),
                                                  ListTile(
                                                    title: Text("我的电台"),
                                                    trailing: Icon(Icons.keyboard_arrow_right),
                                                  ),
                                                ],
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              )
                          ),
                        )
                      )
                  )
                ]
            )
          )
       )
    );
  }
  getUserInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userInfo = jsonDecode(prefs.getString("userInfo"));
  }
}
