import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_mymusic/Utils/ColorUtils.dart';
import 'package:flutter_app_mymusic/Utils/MyHttpUtils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dio _dio = new Dio();
  // String localhost = "https://localhost:3000";
  // String mobilehost = "https://chenq7777.cn.utools.club";
  List banners = []; //轮播图数据
  List recommendData = []; //推荐歌曲板块数据
  List topData = <Map<String, dynamic>>[]; //排行榜数据
  // Map<String,dynamic>  topData=new Map();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //轮播图
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 180.0,
                // aspectRatio: 16/9,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return getItemBuilder(index);
                  },
                  itemCount: 10,
                  pagination: SwiperPagination(),
                  // control: SwiperControl(),//切换的箭头
                  autoplay: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
              ),
              //五个图标导航区域
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Icon(IconData(0xe62c, fontFamily: "MyIcons"),
                              size: 33, color: ColorUtils.createColorHex(
                                  0xffffff),),
                            decoration: BoxDecoration(
                              color: ColorUtils.createColorHex(0xd43c33),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: ColorUtils.createColorHex(0xd43c33),
                                width: 17.0,
                                style: BorderStyle.solid,
                              ),

                            ),
                          ),
                          Text("每日推荐"),
                        ],
                      ),

                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Icon(IconData(0xe607, fontFamily: "MyIcons"),
                              size: 33, color: ColorUtils.createColorHex(
                                  0xffffff),),
                            decoration: BoxDecoration(
                              color: ColorUtils.createColorHex(0xd43c33),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: ColorUtils.createColorHex(0xd43c33),
                                width: 17.0,
                                style: BorderStyle.solid,
                              ),

                            ),
                          ),
                          Text("歌单"),
                        ],
                      ),

                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Icon(IconData(0xe64f, fontFamily: "MyIcons"),
                              size: 33, color: ColorUtils.createColorHex(
                                  0xffffff),),
                            decoration: BoxDecoration(
                              color: ColorUtils.createColorHex(0xd43c33),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: ColorUtils.createColorHex(0xd43c33),
                                width: 17.0,
                                style: BorderStyle.solid,
                              ),

                            ),
                          ),
                          Text("排行榜"),
                        ],
                      ),

                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Icon(IconData(0xe633, fontFamily: "MyIcons"),
                              size: 33, color: ColorUtils.createColorHex(
                                  0xffffff),),
                            decoration: BoxDecoration(
                              color: ColorUtils.createColorHex(0xd43c33),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: ColorUtils.createColorHex(0xd43c33),
                                width: 17.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          Text("电台"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Icon(IconData(0xe728, fontFamily: "MyIcons"),
                              size: 33, color: ColorUtils.createColorHex(
                                  0xffffff),),
                            decoration: BoxDecoration(
                              color: ColorUtils.createColorHex(0xd43c33),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: ColorUtils.createColorHex(0xd43c33),
                                width: 17.0,
                                style: BorderStyle.solid,
                              ),

                            ),
                          ),
                          Text("直播"),
                        ],
                      ),

                    ),
                  ),
                ],
              ),
              //推荐歌曲
              Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Text("推荐歌曲", textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(133, 133, 133, 1),
                            fontSize: 24),)
                  )
              ),
              //推荐歌曲内容区域
              Container(
                // width: MediaQuery.of(context).size.width,
                  height: 38.0,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Positioned(
                          child: Text(
                            "为你精心推荐", textDirection: TextDirection.ltr,
                            style: TextStyle(fontSize: 20),),
                          left: 3.0,
                          top: 3.0,
                        ),
                        Positioned(
                            right: 3.0,
                            top: 3.0,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text("查看更多",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 16),),
                              ),
                              /*Padding(
                        padding: EdgeInsets.all(4),
                        child:
                      ),*/
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black87,
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                            )
                        )
                      ],
                    ),
                  )
                /*Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text("为你精心推荐",textDirection: TextDirection.ltr,),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Container(
                          child:  Text("查看更多",textDirection: TextDirection.rtl,style: TextStyle(fontSize: 18),),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87,width: 1.0,style: BorderStyle.solid)
                          ),
                        )
                      )
                  )


                ],
              ),*/
                /*decoration: BoxDecoration(
            border: Border.all(color: Colors.black87,width: 1.0,style: BorderStyle.solid)
          ),*/
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Container(
                // width: 300.0,
                height: 220.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return getRecommendWidget(index);
                    }
                ),
              ),
              //排行榜
              Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Text("排行榜", textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 24,
                          color: Color.fromRGBO(133, 133, 133, 1)),),
                  )
              ),
              //排行榜内容区域
              Container(
                height: 40.0,
                child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Positioned(
                          child: Text("热歌风向标", textDirection: TextDirection.ltr,
                            style: TextStyle(fontSize: 20.0),),
                          left: 3.0,
                          top: 3.0,
                        ),
                        Positioned(
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text("查看更多",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 16.0),),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black87,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          right: 3.0,
                          top: 3.0,
                        )
                      ],
                    )
                ),
              ),
              Container(
                height: 350.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: getTopWidget(index),
                      );
                    }

                ),
              )
            ],
          ),
        )
    );
  }

  //返回轮播图所需要的图片
  Widget getItemBuilder(index) {
    String pic;
    //在banners还没有获取到图片数据时先给他设置一张图片，这样用户就不会看到报错的页面了
    if (banners.isEmpty) {
      pic =
      "https://p1.music.126.net/gWmqDS3Os7FWFkJ3s8Wotw==/109951166052270907.jpg";
      setBannerList();
    } else {
      pic = banners[index]["pic"];
      pic = pic.replaceFirst("http:", "https:");
    }
    return Image.network(pic, fit: BoxFit.fill);
  }

  //返回封装好的推荐歌曲板块的图片和文字
  Widget getRecommendWidget(index) {
    String picUrl;
    String name;
    if (recommendData.isEmpty) {
      picUrl =
      "https://p1.music.126.net/KSAOQEGv81YeHGNt2S6a1A==/109951165823578660.jpg";
      name = "旷寂砂岩丨海风中失落的血色馈赠";
      setRecommendData();
    } else {
      picUrl = recommendData[index]["picUrl"];
      picUrl = picUrl.replaceFirst("http:", "https:");
      name = recommendData[index]["name"];
    }
    return Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  picUrl, fit: BoxFit.cover, width: 130.0, height: 130.0,),
              ),
              Container(
                width: 140.0,
                child: Text(name, overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 16.0),),
              )
            ],
          ),
        )
    );
  }

  Widget getTopWidget(index) {
    String name;
    List data = [];
    List widget = <Widget>[];
    if (topData.length<index+1 || topData[index] == null) {
      //显示正在加载框
      widget.add(Center(child: new CircularProgressIndicator()));
      setTopData();
    } else {
      name = topData[index]["name"];
      widget.add(
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 35.0,
            child: Stack(
              children: [
                Positioned(child: Text(name, textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 20.0),), left: 3.0,)
              ],
            ),
          )
      );
      List tracks = topData[index]["tracks"];
      if(tracks.length>3){
        tracks = tracks.sublist(0, 3);
      }
      for (var i = 0; i < tracks.length; ++i) {
        Map baseData = {
          "name": tracks[i]["al"]["name"],
          "id": i + 1,
          "picUrl": tracks[i]["al"]["picUrl"].toString().replaceFirst(
              "http:", "https:")
        };
        data.add(baseData);
      }
      for (var i = 0; i < data.length; ++i) {
        widget.add(
            new Padding(
              padding: EdgeInsets.all(1.0),
              child: Container(
                height: 85.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(data[i]["picUrl"], fit: BoxFit.cover,
                        width: 75.0,
                        height: 75.0,),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Text(data[i]["id"].toString(),
                      style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.all(10.0)),
                    // Text(data[i]["name"].toString()+"----------------",style: TextStyle(fontSize: 18.0),overflow: TextOverflow.ellipsis,maxLines: 1,),
                    Container(
                      width: 185.0, //如果不设置宽度，则overflow可能会失效
                      child: Text(
                        data[i]["name"], style: TextStyle(fontSize: 18.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,),
                    )
                  ],
                ),
              ),
            )
        );
      }
    }
    return Container(
      width: 320.0,
      child: Column(
          children: widget
      ),
      decoration: BoxDecoration(
        color: ColorUtils.createColorHex(0xfdfdfd),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  setBannerList() async {
    Response response = await MyHttpUtils.getInstance().get("/banner",params:{ "type":1});
    Map<String, dynamic> responseData = new Map<String, dynamic>.from(
        jsonDecode(response.toString()));
    if(responseData["code"] == 200){
      setState(() {
        banners = responseData["banners"];
      });
    }
    /*return Container(
        child: FutureBuilder(
          future: _dio.get(mobilehost+"/banner?type=2"),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            //请求完成
            if(snapshot.connectionState == ConnectionState.done){
              Response response = snapshot.data;
              //如果请求失败，返回错误信息
              if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
              //请求成功，通过项目信息构建请求成功的组件
              Map<String, dynamic> responseData = new Map<String, dynamic>.from(jsonDecode(response.toString()));
              banners = responseData["banners"];
              String pic = banners[index]["pic"];
              pic = pic.replaceFirst("http:", "https:");
              return Image.network(pic,fit: BoxFit.fill);
            }else{
              // 请求未结束，显示loading
              return CircularProgressIndicator();
            }
          },
        )
    );*/
  }

  setRecommendData() async {
    Response response = await MyHttpUtils.getInstance().get("/personalized",params:{ "limit":10});
    Map<String, dynamic> responseData = jsonDecode(response.toString());
    if(responseData["code"] == 200){
      setState(() {
        recommendData = responseData["result"];
      });
    }
  }

  setTopData() async {
    for (var i = 0; i < 5; i++) {
      Response response = await MyHttpUtils.getInstance().get("/top/list",params:{ "idx":i});
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      if (responseData["code"] == 200) {
        setState(() {
          topData.insert(i, responseData["playlist"]);
        });
      }
    }
  }

}