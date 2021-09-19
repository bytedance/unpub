import 'dart:async';
import 'dart:cli';
import 'dart:io';

import 'package:minio/minio.dart';
import 'package:unpub/unpub.dart';
import 'package:unpub/unpub_aws/lib/aws_credentials.dart';

/// Use AWS S3 as a package store
class S3Store extends PackageStore {
  String Function(String name, String version)? getObjectPath;

  String bucketName;
  String? region;
  String? endpoint;
  AwsCredentials? credentials;
  Minio? minio;
  final Map<String, String> _env = Map.from(Platform.environment);

  S3Store(this.bucketName,
      {this.region,
      this.getObjectPath,
      this.endpoint,
      this.credentials,
      this.minio}) {

    // Check for env vars or container credentials if none were provided.
    credentials ??= AwsCredentials();

    // Use a supplied minio instance or create a default
    minio ??= Minio(
      endPoint: endpoint ?? _env['AWS_S3_ENDPOINT'] ?? 's3.amazonaws.com',
      region: region ?? _env['AWS_DEFAULT_REGION'],
      accessKey: credentials!.awsAccessKeyId ?? '',
      secretKey: credentials!.awsSecretAccessKey ?? '',
    );

    // Check for a region or default region which is required
    if (region == null &&
        (_env['AWS_DEFAULT_REGION'] == null ||
            _env['AWS_DEFAULT_REGION']!.isEmpty)) {
      throw ArgumentError('Could not determine a default region for aws.');
    }
  }

  String _getObjectKey(String name, String version) {
    return getObjectPath?.call(name, version) ?? '$name/$name-$version.tar.gz';
  }

  @override
  Future<void> upload(String name, String version, List<int> content) async {
    await minio!.putObject(
        bucketName, _getObjectKey(name, version), Stream.value(content));
  }

  @override
  Stream<List<int>> download(String name, String version) {
    return waitFor(minio!.getObject(bucketName, _getObjectKey(name, version)));
  }
}
