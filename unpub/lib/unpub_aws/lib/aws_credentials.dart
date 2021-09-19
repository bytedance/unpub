import 'dart:cli';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

class AwsCredentials {
  String? awsAccessKeyId;
  String? awsSecretAccessKey;
  String? awsSessionToken;
  final Map<String, String> _env = Map.from(Platform.environment);

  AwsCredentials({this.awsAccessKeyId,
      this.awsSecretAccessKey,
      this.awsSessionToken}) {

    awsAccessKeyId = awsAccessKeyId ?? _env['AWS_ACCESS_KEY_ID'];
    awsSecretAccessKey = awsSecretAccessKey ?? _env['AWS_SECRET_ACCESS_KEY'];

    if (_env['AWS_CONTAINER_CREDENTIALS_RELATIVE_URI'] != null &&
        awsAccessKeyId != null && awsSecretAccessKey != null) {
      var data = waitFor(getContainerCredentials());
      awsAccessKeyId = data['AccessKeyId'];
      awsSecretAccessKey = data['SecretAccessKey'];
      awsSessionToken = data['Token'];
    }

    if(awsAccessKeyId == null || awsSecretAccessKey == null) {
      throw ArgumentError('You must provide a valid Access Key and Secret for AWS.');
    }

  }

  Future<Map<String, String>> getContainerCredentials() async {
    var relativeUri = _env['AWS_CONTAINER_CREDENTIALS_RELATIVE_URI'] ?? '';
    var url = Uri.parse('http://169.254.170.2$relativeUri');
    var response = await http.read(url);
    Map<String, String> data = json.decode(response);
    return data;
  }
}
