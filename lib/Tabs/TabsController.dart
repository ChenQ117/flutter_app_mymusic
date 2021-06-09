import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_mymusic/Tabs/HomePage.dart';
import 'package:flutter_app_mymusic/Tabs/PersonalPage.dart';
import 'package:flutter_app_mymusic/Tabs/VedioPage.dart';
import 'package:flutter_app_mymusic/Utils/ColorUtils.dart';

/**
 * 底部导航栏管理组件
 */
class TabsController extends StatefulWidget{
  final index;
  TabsController({Key key, this.index = 2}):super(key: key);
  @override
  State<StatefulWidget> createState() {
   return _TabsControllerState(this.index);
  }

}
class _TabsControllerState extends State{
  List _pageList=[
    HomePage(),
    VideoPage(),
    PersonalPage()
  ];
  int _currentIndex;
  _TabsControllerState(index){
    this._currentIndex = index;
  }
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);//隐藏状态栏
    return Scaffold(
      appBar: AppBar(
        title: Text("我的云音乐",textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: this._pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (int index){
          setState(() {
            this._currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: '主页'
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xe63b,fontFamily: "MyIcons")),
            label: '视频'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
            label: '个人中心'
          )
        ],
        selectedItemColor: ColorUtils.createColorHex(0xd43c33),

      ),
    );
  }

}