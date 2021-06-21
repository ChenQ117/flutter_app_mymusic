import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_mymusic/Utils/ColorUtils.dart';
import 'package:flutter_app_mymusic/Utils/MyHttpUtils.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();//手机号输入框管理者
  TextEditingController _passwordController = TextEditingController();//密码输入框管理者
  Map<String,dynamic> userCookie;//用于存储用户登录后的用户信息
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("登录中心"),),
      ),
      resizeToAvoidBottomInset: false,//避免键盘弹出导致overflow错误
      body: Column(
        children: [
          //登录logo
          Container(
              height: 200.0,
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Stack(
                  children: [
                    Positioned(
                      child: Text("LOGIN",textDirection: TextDirection.ltr,style: TextStyle(fontSize: 100,color: ColorUtils.createColorHex(0xf5f5f5)),),
                      left: -10.0,
                      top: 30.0,
                    ),
                    Positioned(
                      child: Text("欢迎回来！",textDirection: TextDirection.ltr,style: TextStyle(fontSize: 36,color: ColorUtils.createColorHex(0x555000)),),
                      left: 36.0,
                      top: 76.0,
                    )
                  ],
                ),
              )
          ),
          //账号密码输入框以及登录按钮
          Container(
            width: 300,
            child: Column(
              children: [
                //账号输入框
                Container(
                  height: 90.0,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      style: TextStyle(fontSize: 22),
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.all(10.0),
                        icon: Icon(Icons.account_circle_rounded,size: 50,),
                        labelText: "手机号",
                        labelStyle: TextStyle(fontSize: 22),
                        border:  OutlineInputBorder(),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: ColorUtils.createColorHex(0xf8f6fc,alpha: 0.8),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                //密码输入框
                Container(
                  height: 90.0,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      style: TextStyle(fontSize: 22),
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock,size: 50,),
                          labelText: '密码',
                          labelStyle: TextStyle(fontSize: 22),
                          border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: ColorUtils.createColorHex(0xf8f6fc,alpha: 0.8),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
                Padding(padding: EdgeInsets.all(20.0)),
                //登录按钮
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45.0,
                  child: RaisedButton(
                    child: Text("登录",style: TextStyle(fontSize: 22.0),),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                    color: ColorUtils.createColorHex(0xd43c44,alpha: 0.8),
                    highlightColor: ColorUtils.createColorHex(0xd43c44,alpha: 0.2),
                    onPressed: _login,
                  ),
                )
              ],
            ),
          ),
          //忘记密码区域
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 7.0),
              child: Text("忘记密码？",style: TextStyle(color: ColorUtils.createColorHex(0x4399fc),fontSize: 16.0),),
            ),
          ),
          //注册提醒区域
          Container(
            height: 200.0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                        text: "还没有账号？  ",
                        style: TextStyle(color: ColorUtils.createColorHex(0x606266)),
                      ),
                      TextSpan(
                          text: "马上注册",
                          style: TextStyle(color: ColorUtils.createColorHex(0x4399fc))
                      )
                    ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  void _login () async{
    String phone = _phoneController.text.trim();
    String password = _passwordController.text.trim();
    //1.前端验证：
    //1.1判断手机号是否合法
    RegExp exp = new RegExp("^1(3|4|5|6|7|8|9)\\d{9}");
    if(phone.isEmpty){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text("手机号不能为空")));
    }else if(!exp.hasMatch(phone)){
      showDialog(context: context, builder: (context)=>AlertDialog(title: Text("手机号格式错误")));
    }
    //1.2判断密码是否为空
    if(password.isEmpty){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text("密码不能为空")));
    }
    
    
    //2.后端验证
    Response response = await MyHttpUtils.getInstance().get("/login/cellphone",params: {"phone":phone,"password":password});
    userCookie = jsonDecode(response.toString());
    if(userCookie!=null){
      int code = userCookie["code"];
      if(code == 200){
        //登录成功，跳转到个人中心页
        showDialog(context: context, builder: (context)=>AlertDialog(title: Text("登录成功")));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var jsonEn = jsonEncode(userCookie["profile"]);

        prefs.setString("userInfo", jsonEn);
        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
        // Navigator.of(context).pushNamed("/");
      }else if(code == 502){
        //密码错误，弹出密码错误提示
        showDialog(context: context, builder: (context)=>AlertDialog(title: Text("密码错误")));
      }else if(code == 400){
        //手机号错误
        showDialog(context: context, builder: (context)=>AlertDialog(title: Text("手机号错误")));
      }else{
        showDialog(context: context, builder: (context)=>AlertDialog(title: Text("登录失败，请重新登录")));
      }
    }
  }
}

