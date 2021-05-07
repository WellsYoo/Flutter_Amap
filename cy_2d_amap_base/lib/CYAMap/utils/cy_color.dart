library cyamap_base.utils.cy_color;

import 'dart:ui' show Color;

/// color 转换工具
class ColorUtil {
  /// 16进制字符串转Color
  ///
  /// 返回Color
  static Color hexToColor(String hex) {
    // rgb argb
    // 如果传入的十六进制颜色值不符合要求，返回默认值
    if (hex == null || (hex.length != 6 && hex.length != 8)) {
      hex = '#999999';
    }
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    return Color(int.parse(hex, radix: 16));
  }
}
