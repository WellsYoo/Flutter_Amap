import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cy_2d_amap_base/cy_2d_amap_base.dart';

void main() {
  const MethodChannel channel = MethodChannel('cy_2d_amap_base');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Cy2dAmapBase.platformVersion, '42');
  });
}
