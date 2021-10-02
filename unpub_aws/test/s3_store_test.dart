import 'dart:io';
import 'package:chunked_stream/chunked_stream.dart';
import 'package:minio/minio.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:unpub_aws/unpub_aws.dart';

void main() async {
  group('test s3 file store', () {
    late S3Store testS3Store;

    setUp(() async {
      testS3Store = S3Store('dart-pub-test',
          region: 'us-east-1',
          endpoint: 'localhost',
          getObjectPath: newFilePathFunc(),
          credentials: mockCreds,

          // Tests use an s3 mock docker image from docker-compose.yml
          minio: Minio(
            endPoint: 'localhost',
            accessKey: '',
            secretKey: '',
            useSSL: false,
            port: 9090,
            region: 'us-test-1',
          ));
    });

    test('aws-credentials-manual', () async {
      var creds = AwsCredentials(
          awsAccessKeyId: 'specialKey', awsSecretAccessKey: 'specialSecret');
      expect(creds.awsAccessKeyId, 'specialKey');
      expect(creds.awsSecretAccessKey, 'specialSecret');
    });

    test('aws-credentials-env', () async {
      var credMap = {
        'AWS_ACCESS_KEY_ID': 'special-key-id',
        'AWS_SECRET_ACCESS_KEY': 'special-access-key',
      };
      var creds = await AwsCredentials(environment: credMap);
      expect(creds.awsAccessKeyId, credMap['AWS_ACCESS_KEY_ID']);
      expect(creds.awsSecretAccessKey, credMap['AWS_SECRET_ACCESS_KEY']);
    });

    test('aws-credentials-ecs-container-iam', () async {
      var credMap = {
        'AWS_CONTAINER_CREDENTIALS_RELATIVE_URI': 'special-access-key',
      };
      Map<String, String> containerCredentials = {
        'AccessKeyId': 'container-creds-key',
        'SecretAccessKey': 'container-creds-secret',
        'Token': 'container-creds-token'
      };
      var creds = await AwsCredentials(
          environment: credMap, containerCredentials: containerCredentials);

      expect(creds.awsAccessKeyId, containerCredentials['AccessKeyId']);
      expect(creds.awsSecretAccessKey, containerCredentials['SecretAccessKey']);
      expect(creds.awsSessionToken, containerCredentials['Token']);
    });

    test('upload-download-default-path', () async {
      await testS3Store.upload('test_package', '1.0.0', testPackageData);
      var pkg1 =
          await readByteStream(testS3Store.download('test_package', '1.0.0'));
      expect(pkg1, testPackageData);
    });

    test('upload-download-custom-path', () async {
      expect(testS3Store.getObjectPath!.call('test_package', '1.0.0'),
          newFilePathFunc().call('test_package', '1.0.0'));
      expect(testS3Store.getObjectPath!.call('test_package2', '2.0.0'),
          newFilePathFunc().call('test_package2', '2.0.0'));

      await testS3Store.upload('test_package', '1.0.0', testPackageData2);
      var pkg2 =
          await readByteStream(testS3Store.download('test_package', '1.0.0'));
      expect(pkg2, testPackageData2, reason: 'tar.gz content did not match');
    });

    test('require-default-aws-region', () async {
      var storePass =
          S3Store('dart-pub-test', region: 'us-east-1', credentials: mockCreds);
      expect(storePass.region, 'us-east-1');

      // Don't run tests with AWS environment set variables please
      expect(Platform.environment['AWS_DEFAULT_REGION'], null);
      try {
        S3Store('dart_pub_test', credentials: mockCreds);
      } on ArgumentError catch (e) {
        expect(e.message, 'Could not determine a default region for aws.');
      }
    });
  });
}

final mockCreds = AwsCredentials(awsAccessKeyId: '', awsSecretAccessKey: '');

//test gzip data
const testPackageData = [
  0x8b, 0x1f, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x03, //
  0x02, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 //
];

// This is a tar.gz file with a `hello.txt` file that has `hello` written inside
const testPackageData2 = [31,139,8,0,4,81,79,97,0,3,237,207,73,10,128,48,12,5,
  80,215,158,34,39,144,84,99,123,30,209,138,139,98,193,214,233,246,142,116,37,
  238,84,132,188,205,39,16,194,79,163,141,177,137,159,124,244,28,68,148,68,176,
  165,82,98,79,76,143,249,36,65,144,72,51,153,99,38,17,80,144,162,60,2,124,176,
  83,208,59,95,116,107,149,210,26,237,188,30,116,235,108,123,177,183,174,213,
  245,205,157,227,17,8,249,19,141,29,171,57,254,186,5,99,140,177,183,45,78,193,
  149,248,0,8,0,0];

String Function(String, String) newFilePathFunc() {
  return (String package, String version) {
    var grp = package[0];
    var subgrp = package.substring(0, 2);
    return path.join('packages', grp, subgrp, package, 'versions',
        '$package-$version.tar.gz');
  };
}
