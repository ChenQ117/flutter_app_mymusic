
import 'package:dio/dio.dart';
/**
 * 单例模式，发送请求的工具类,对dio的封装
 */
class MyHttpUtils{
  final String localhost = "https://localhost:3000";
  final String mobilehost = "https://chenq7777.cn.utools.club";
  final int _CONNECTTIMEOUT = 5000;
  final int _RECEIVETIMEOUT = 3000;

  Dio _dio;
  BaseOptions _baseOptions;
  static MyHttpUtils _instance;//单例模式
  //获取单例实例
  static MyHttpUtils getInstance(){
    if(_instance == null){
      _instance = new MyHttpUtils();
    }
    return _instance;
  }
  //构造函数
  MyHttpUtils(){
    _baseOptions = new BaseOptions(
      connectTimeout: _CONNECTTIMEOUT,
      receiveTimeout: _RECEIVETIMEOUT,
      baseUrl: mobilehost,
      responseType: ResponseType.json,
      contentType: Headers.formUrlEncodedContentType,
      /*headers: {
        "resource":"android"
      }*/
    );
    _dio = new Dio(_baseOptions);
  }



  //打印出错的几种可能
  void formatError(DioError e) {
    if (e.type == DioErrorType.connectTimeout) {
      print("连接超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      print("请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      print("响应超时");
    } else if (e.type == DioErrorType.response) {
      print("出现异常");
    } else if (e.type == DioErrorType.cancel) {
      print("请求取消");
    } else {
      print("未知错误");
    }
  }

  //get请求方法
  Future<Response> get(url,{params,options,cancelToken}) async{
    Response response;
    try{
      response = await _dio.get(url,queryParameters: params,options: options,cancelToken: cancelToken);
    }on DioError catch(e){
      print('getHttp exception: $e');
      formatError(e);
    }
    return response;
  }

  //post请求
  post(url,{params,options,cancelToken}) async{
    Response response;
    try{
      response = await _dio.post(url,queryParameters: params,options: options,cancelToken: cancelToken);
    }on DioError catch(e){
      print('postHttp exception: $e');
      formatError(e);
    }
    return response;
  }

  //post Form请求
  postForm(url,{data,options,cancelToken}) async{
    Response response;
    try{
      response = await _dio.post(url,options: options,cancelToken: cancelToken,data: data);
      print('postHttp response: $response');
    }on DioError catch(e){
      print('postHttp exception: $e');
      formatError(e);
    }
    return response;
  }

  //下载文件
  downLoadFile(urlPath,savePath) async{
    Response response;
    try{
      response = await _dio.download(urlPath, savePath,onReceiveProgress: (int count,int total){
        print('$count $total');
      });
      print('downLoadFile response: $response');
    }on DioError catch(e){
      print('downLoadFile exception: $e');
      formatError(e);
    }
    return response;
  }


  //取消请求
  cancleRequests(CancelToken token){
    token.cancel("cancelled");
  }
}