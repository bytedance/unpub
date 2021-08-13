import 'package:unpub/unpub.dart' as unpub;

main(List<String> args) async {
  var basedir = './unpub-packages'; // Base directory to save pacakges
  var db = 'mongodb://localhost:27017/dart_pub'; // MongoDB uri

  var metaStore = unpub.MongoStore(db);
  await metaStore.db.open();

  var packageStore = unpub.FileStore(basedir);

  var app = unpub.App(
    metaStore: metaStore,
    packageStore: packageStore,
  );

  var server = await app.serve('0.0.0.0', 8000);
  print('Serving at http://${server.address.host}:${server.port}');
}
