import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:args/args.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:unpub/unpub.dart' as unpub;

main(List<String> args) async {
  var parser = ArgParser();
  parser.addOption('host', abbr: 'h', defaultsTo: '0.0.0.0');
  parser.addOption('port', abbr: 'p', defaultsTo: '4000');
  parser.addOption('database',
      abbr: 'd', defaultsTo: 'mongodb://localhost:27017/dart_pub');
  parser.addOption('proxy-origin', abbr: 'o', defaultsTo: '');

  var results = parser.parse(args);

  var host = results['host'] as String;
  var port = int.parse(results['port'] as String);
  var dbUri = results['database'] as String;
  var proxy_origin = results['proxy-origin'] as String;

  if (results.rest.isNotEmpty) {
    print('Got unexpected arguments: "${results.rest.join(' ')}".\n\nUsage:\n');
    print(parser.usage);
    exit(1);
  }

  final db = Db(dbUri);
  await db.open();

  var baseDir = path.absolute('unpub-packages');

  var app = unpub.App(
    metaStore: unpub.MongoStore(db),
    packageStore: unpub.FileStore(baseDir),
    proxy_origin: proxy_origin.trim().isEmpty ? null : Uri.parse(proxy_origin)
  );

  var server = await app.serve(host, port);
  print('Serving at http://${server.address.host}:${server.port}');
}
