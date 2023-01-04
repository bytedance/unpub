import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

DateTime identity(DateTime x) => x;
String dateToIsoString(DateTime x) => x.toUtc().toIso8601String();

@JsonSerializable(includeIfNull: false)
class UnpubVersion {
  final String version;
  final Map<String, dynamic> pubspec;
  final String? pubspecYaml;
  final String? uploader; // TODO: not sure why null. keep it nullable
  final String? readme;
  final String? changelog;

  @JsonKey(fromJson: identity, toJson: dateToIsoString)
  final DateTime createdAt;

  UnpubVersion(
    this.version,
    this.pubspec,
    this.pubspecYaml,
    this.uploader,
    this.readme,
    this.changelog,
    this.createdAt,
  );

  factory UnpubVersion.fromJson(Map<String, dynamic> map) =>
      _$UnpubVersionFromJson(map);

  Map<String, dynamic> toJson() => _$UnpubVersionToJson(this);
}

@JsonSerializable()
class UnpubPackage {
  final String name;
  final List<UnpubVersion> versions;
  final bool private;
  final List<String>? uploaders;

  @JsonKey(fromJson: identity, toJson: dateToIsoString)
  final DateTime createdAt;

  @JsonKey(fromJson: identity, toJson: dateToIsoString)
  final DateTime updatedAt;

  final int? download;

  UnpubPackage(
    this.name,
    this.versions,
    this.private,
    this.uploaders,
    this.createdAt,
    this.updatedAt,
    this.download,
  );

  factory UnpubPackage.fromJson(Map<String, dynamic> map) =>
      _$UnpubPackageFromJson(map);

  Map<String, dynamic> toJson() => _$UnpubPackageToJson(this);
}

@JsonSerializable()
class UnpubQueryResult {
  int count;
  List<UnpubPackage> packages;

  UnpubQueryResult(this.count, this.packages);

  factory UnpubQueryResult.fromJson(Map<String, dynamic> map) =>
      _$UnpubQueryResultFromJson(map);
}
