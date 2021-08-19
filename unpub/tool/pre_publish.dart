import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dart_style/dart_style.dart';

var files = ['index.html', 'main.dart.js', 'style.dart.css'];

main(List<String> args) {
  for (var file in files) {
    var content =
        File(path.absolute('unpub_web/build', file)).readAsStringSync();
    content = content.replaceAll('\\', '\\\\').replaceAll('\$', '\\\$');
    content = 'const content="""$content""";';
    File(path.absolute('unpub/lib/src/static', file + '.dart'))
        .writeAsStringSync(DartFormatter().format(content));
  }
}
