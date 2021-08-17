import 'dart:io';

import 'package:chunked_stream/chunked_stream.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:unpub/unpub.dart' as unpub;

//test gzip data
const TEST_PKG_DATA = [
  0x8b, 0x1f, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x03, //
  0x02, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 //
];

main() {
  test('upload-download-default-path', () async {
    var baseDir = _setup_fixture('upload-download-default-path');
    var store = unpub.FileStore(baseDir.path);
    await store.upload('test_package', '1.0.0', TEST_PKG_DATA);
    var pkg2 = await readByteStream(store.download('test_package', '1.0.0'));
    expect(pkg2, TEST_PKG_DATA);
    expect(
        File(path.join(baseDir.path, 'test_package-1.0.0.tar.gz')).existsSync(),
        isTrue);
  });

  test('upload-download-custom-path', () async {
    var baseDir = _setup_fixture('upload-download-custom-path');
    var store =
        unpub.FileStore(baseDir.path, getFilePath: newFilePathFunc());
    await store.upload('test_package', '1.0.0', TEST_PKG_DATA);
    var pkg2 = await readByteStream(store.download('test_package', '1.0.0'));
    expect(pkg2, TEST_PKG_DATA);
    expect(
        File(path.join(baseDir.path, 'packages', 't', 'te', 'test_package',
                'versions', 'test_package-1.0.0.tar.gz'))
            .existsSync(),
        isTrue);
  });
}

String Function(String, String) newFilePathFunc() {
  return (String package, String version) {
    var grp = package[0];
    var subgrp = package.substring(0, 2);
    return path.join('packages', grp, subgrp, package, 'versions',
        '$package-$version.tar.gz');
  };
}

_setup_fixture(final String name) {
  var baseDir =
      Directory(path.absolute('test', 'fixtures', 'file_store', name));
  if (baseDir.existsSync()) {
    baseDir.deleteSync(recursive: true);
  }
  baseDir.createSync();
  return baseDir;
}
