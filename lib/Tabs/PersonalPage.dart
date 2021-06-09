import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mymusic/Utils/ColorUtils.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        //背景图片
        Positioned(
          // top: 0.0,
          child: Opacity(
            opacity: 0.7,
            child: Container(
              // height: 290.0,
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                    image: AssetImage("lib/asserts/images/personal/bgImg2.jpg")
                ),
              ),
            ),
          ),
        ),

        //vip卡片区域
        Positioned(
          top: 130,
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
          top: 325.0,
          left: 0.0,
          right: 0.0,
          child: Image.asset("lib/asserts/images/personal/arc.png"),
        ),
        //个人中心列表
        Positioned(
          top: 346.0,
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
        //最近播放列表

      ],
    );
  }
}
