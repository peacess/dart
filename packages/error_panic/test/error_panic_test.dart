import 'dart:ffi';
import 'dart:io';

import 'package:error_panic/src/error_lib/panic_.dart';
import 'package:test/test.dart';

import 'package:path/path.dart' as p;

final rustPanic = lang_panic(DynamicLibrary.open(_getRustPath()));
final goPanic = lang_panic(DynamicLibrary.open(_getGoPath()));
void main() {
  test('rust', () {
    try {
      print('rust panic, before call');
      rustPanic.ErrorPanic();
      print('rust panic, after call');
    } catch (e) {
      print(e);
    }
  });

  test('go', () {
    try {
      print('before call');
      goPanic.ErrorPanic();
      print('after call');
    } catch (e) {
      print(e);
    } finally {
      print('finally call go');
    }
  });
}

String _getRustPath() {
  final curPath = Directory.current.absolute.path;
  var path = p.join(curPath, 'lang/rust_panic/target/debug');
  if (Platform.isMacOS) {
    path = p.join(path, 'rust_panic.dylib');
  } else if (Platform.isWindows) {
    path = p.join(path, 'rust_panic.dll');
  } else {
    path = p.join(path, 'librust_panic.so');
  }
  return path;
}

String _getGoPath() {
  final curPath = Directory.current.absolute.path;
  var path = p.join(curPath, 'lang/go_panic');
  if (Platform.isMacOS) {
    path = p.join(path, 'go_panic.dylib');
  } else if (Platform.isWindows) {
    path = p.join(path, 'go_panic.dll');
  } else {
    path = p.join(path, 'go_panic.so');
  }
  return path;
}
