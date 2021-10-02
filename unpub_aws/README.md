# unpub_aws

A collection of modules to use for deploying unpub into AWS infrastructure.

# Available Features
### 1. [S3 File Storage](#s3-file-storage)


## S3 File Storage

Use AWS S3 or another S3 API compatible endpoint as your file storage.

```dart
import 'package:unpub/unpub.dart' as unpub;
import 'package:unpub/' as unpub_aws;

var app = unpub.App(
  // ...
  packageStore: unpub.S3Store('your-bucket-name'),
);
```

### What you need:
- An S3 bucket created in AWS
- AWS access credentials

Authentication for AWS can be handled in 1 of 2 ways: Environment variables or during the `S3Store` class construction.

#### Environment Variables
```dotenv
AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxxx
AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
AWS_DEFAULT_REGION=us-west-2
AWS_S3_ENDPOINT=s3.amazonaws.com
```


Kitchen Sink Example:

```dart
import 'package:mongo_dart/mongo_dart.dart';
import 'package:unpub/unpub.dart' as unpub;
import 'package:unpub_aws/src/aws_credentials.dart';
import 'package:unpub_aws/unpub_aws.dart' as unpub_aws;

main(List<String> args) async {
  final db = Db('mongodb://localhost:27017/dart_pub');
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
        // don't be bad at security populate env vars instead...
        // 
        // AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxxxxxxx
        // AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        credentials: AwsCredentials(
            awsAccessKeyId: '',
            awsSecretAccessKey: '')),
  );

  final server = await app.serve('0.0.0.0', 4000);
  print('Serving at http://${server.address.host}:${server.port}');
}

```
