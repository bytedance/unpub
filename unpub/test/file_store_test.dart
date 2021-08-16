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
  test('upload-download-flat-file', () async {
    var baseDir = _setup_fixture('upload-download-flat-file');
    var store = unpub.FileStore(baseDir.path);
    await store.upload('test_package', '1.0.0', TEST_PKG_DATA);
    var pkg2 = await readByteStream(store.download('test_package', '1.0.0'));
    expect(pkg2, TEST_PKG_DATA);
    expect(
        File(path.join(baseDir.path, 'test_package-1.0.0.tar.gz')).existsSync(),
        isTrue);
  });

  test('upload-download-as-tree', () async {
    var baseDir = _setup_fixture('upload-download-as-tree');
    var store = unpub.FileStore(baseDir.path, asTree: true);
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

Directory _setup_fixture(final String name) {
  var baseDir =
      Directory(path.absolute('test', 'fixtures', 'file_store', name));
  if (baseDir.existsSync()) {
    baseDir.deleteSync(recursive: true);
  }
  baseDir.createSync();
  return baseDir;
}
