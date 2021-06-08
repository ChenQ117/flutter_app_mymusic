import 'package:flutter/material.dart';

/**
 * 因为当使用十六进制创建Color时，需要传入0xFF000000,其中0x表示十六进制，FF表示透明度其取值为00-FF，最后的6个0才表示颜色的十六进制代码
 * 使用比较复杂所以创建一个ColorUtils类
 * 只需传入0x000000
 * 如果想设置透明度，则再传入一个数值，取值范围为0-1，默认为1
 *
 * 使用说明：传入十六进制颜色值 透明度值（可选）
 */
class ColorUtils{
  static Color createColorHex(int hex,{double alpha=1}){
    if(alpha>1){
      alpha = 1;
    }
    if(alpha<0){
      alpha = 0;
    }
    return Color.fromRGBO(
        (hex & 0xFF0000)>>16,
        (hex & 0x00FF00)>>8,
        (hex & 0x0000FF)>>0,
        alpha
    );
  }
}