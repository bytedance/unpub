import 'dart:io';

import 'package:path/path.dart' as path;

import 'package_store.dart';

class FileStore extends PackageStore {
  String baseDir;
  bool asTree;

  FileStore(this.baseDir, {this.asTree: false});

  File _getTarballFile(String package, String version) {
    if (asTree) {
      var grp = package[0];
      var subgrp = package.substring(0, 2);
      return File(path.join(baseDir, 'packages', grp, subgrp, package,
          'versions', '$package-$version.tar.gz'));
    }

    return File(path.join(baseDir, '$package-$version.tar.gz'));
  }

  @override
  Future<void> upload(String package, String version, List<int> content) async {
    var file = _getTarballFile(package, version);
    await file.create(recursive: true);
    await file.writeAsBytes(content);
  }

  @override
  Stream<List<int>> download(String package, String version) {
    return _getTarballFile(package, version).openRead();
  }
}
