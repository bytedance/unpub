import 'dart:io';

import 'package:chunked_stream/chunked_stream.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:unpub/unpub.dart' as unpub;

main() {
  test('upload-download', () async {
    var baseDir = Directory(path.absolute(
        'test', 'fixtures', 'tree_file_store', 'upload-download'));
    if (baseDir.existsSync()) {
      baseDir.deleteSync(recursive: true);
    }

    baseDir.createSync();

    var store = unpub.TreeFileStore(baseDir.path);

    var pkg = [
      0x8b, 0x1f, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x03, //test gzip data
      0x02, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 //
    ];

    await store.upload('test_package', '1.0.0', pkg);
    var pkg2 = await readByteStream(store.download('test_package', '1.0.0'));
    expect(pkg2, pkg);
  });
}
