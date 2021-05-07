library bmfmap_base.utils.bmf_log;

import 'cy_amap_env.dart';

/// log输出
class CYAMapLog {
  static const String _tagDef = "###common_tag###";
  static String _tag = _tagDef;

  static void init({String tag = _tagDef}) {
    _tag = _tagDef;
  }

  static void d(Object object, {String tag}) {
    if (CYAMapEnv.debug) {
      _pringLog(tag, ' d ', object);
    }
  }

  static void v(Object object, {String tag}) {
    _pringLog(tag, ' v ', object);
  }

  static void e(Object object, {String tag}) {
    _pringLog(tag, ' e ', object);
  }

  static void _pringLog(String tag, String sTag, Object object) {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(null == tag || tag.isEmpty ? _tag : tag);
    stringBuffer.write(sTag);
    stringBuffer.write(object);
    print(stringBuffer.toString());
  }
}
