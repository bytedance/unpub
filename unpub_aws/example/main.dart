import 'package:mongo_dart/mongo_dart.dart';
import 'package:unpub/unpub.dart' as unpub;
import 'package:unpub_aws/unpub_aws.dart' as unpub_aws;

main(List<String> args) async {
  final db = Db('mongodb://localhost:27017/dart_pub_test');
  await db.open(); // make sure the MongoDB connection opened

  final app = unpub.App(
    metaStore: unpub.MongoStore(db),
    packageStore: unpub_aws.S3Store('my-bucket-name',

        // We attempt to find region from AWS_DEFAULT_REGION. If one is not
        // available or provided an Argument error will be thrown.
        region: 'us-east-1',

        // Provide a different S3 compatible endpoint.
        endpoint: 'aws-alternative.example.com',

        // By default packages are sorted into folders in s3 like this.
        // Pass in an alternative if needed.
        getObjectPath: (String name, String version) => '$name/$name-$version.tar.gz',

        // You can provide credentials manually but...
        // Don't be bad at security populate env vars instead...
        // AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxxxxxxx
        // AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        credentials: unpub_aws.AwsCredentials(
            awsAccessKeyId: '',
            awsSecretAccessKey: '',
            awsSessionToken: '')),
  );

  final server = await app.serve('0.0.0.0', 4000);
  print('Serving at http://${server.address.host}:${server.port}');
}
