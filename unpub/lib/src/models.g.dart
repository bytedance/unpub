// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnpubVersion _$UnpubVersionFromJson(Map<String, dynamic> json) => UnpubVersion(
      json['version'] as String,
      json['pubspec'] as Map<String, dynamic>,
      json['pubspecYaml'] as String?,
      json['uploader'] as String?,
      json['readme'] as String?,
      json['changelog'] as String?,
      identity(json['createdAt'] as DateTime),
    );

Map<String, dynamic> _$UnpubVersionToJson(UnpubVersion instance) {
  final val = <String, dynamic>{
    'version': instance.version,
    'pubspec': instance.pubspec,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pubspecYaml', instance.pubspecYaml);
  writeNotNull('uploader', instance.uploader);
  writeNotNull('readme', instance.readme);
  writeNotNull('changelog', instance.changelog);
  writeNotNull('createdAt', dateToIsoString(instance.createdAt));
  return val;
}

UnpubPackage _$UnpubPackageFromJson(Map<String, dynamic> json) => UnpubPackage(
      json['name'] as String,
      (json['versions'] as List<dynamic>)
          .map((e) => UnpubVersion.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['private'] as bool,
      (json['uploaders'] as List<dynamic>?)?.map((e) => e as String).toList(),
      identity(json['createdAt'] as DateTime),
      identity(json['updatedAt'] as DateTime),
      json['download'] as int?,
    );

Map<String, dynamic> _$UnpubPackageToJson(UnpubPackage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'versions': instance.versions,
      'private': instance.private,
      'uploaders': instance.uploaders,
      'createdAt': dateToIsoString(instance.createdAt),
      'updatedAt': dateToIsoString(instance.updatedAt),
      'download': instance.download,
    };

UnpubQueryResult _$UnpubQueryResultFromJson(Map<String, dynamic> json) =>
    UnpubQueryResult(
      json['count'] as int,
      (json['packages'] as List<dynamic>)
          .map((e) => UnpubPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UnpubQueryResultToJson(UnpubQueryResult instance) =>
    <String, dynamic>{
      'count': instance.count,
      'packages': instance.packages,
    };
