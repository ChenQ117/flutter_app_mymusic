


import 'package:flutter/material.dart';
import 'package:flutter_app_mymusic/Tabs/PersonalPage.dart';
import 'package:flutter_app_mymusic/Tabs/TabsController.dart';
import 'package:flutter_app_mymusic/pages/LoginPage.dart';

//配置路由
final routes={
  '/':(context)=>TabsController(),
  '/loginPage':(context)=>LoginPage(),
  '/personalPage':(context)=>PersonalPage(),
  // '/tabsController':(context)=>TabsController()
};

//固定写法
var onGenerateRoute=(RouteSettings settings){
  //统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if(pageContentBuilder != null){
    if(settings.arguments != null){
      final Route route = MaterialPageRoute(
          builder: (context)=>
              pageContentBuilder(context,arguments:settings.arguments));
      return route;
    }else{
      final Route route = MaterialPageRoute(
          builder: (context)=>
              pageContentBuilder(context));
      return route;
    }
  }
};