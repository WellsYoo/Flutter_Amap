import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cy_amap_location/cy_amap_location.dart';

void main() {
  const MethodChannel channel = MethodChannel('cy_amap_location');

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
    expect(await CyAmapLocation.platformVersion, '42');
  });
}
