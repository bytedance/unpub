// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AppRouter(App service) {
  final router = Router();
  router.add(
    'GET',
    r'/api/packages/<name>',
    service.getVersions,
  );
  router.add(
    'GET',
    r'/api/packages/<name>/versions/<version>',
    service.getVersion,
  );
  router.add(
    'GET',
    r'/packages/<name>/versions/<version>.tar.gz',
    service.download,
  );
  router.add(
    'GET',
    r'/api/packages/versions/new',
    service.getUploadUrl,
  );
  router.add(
    'POST',
    r'/api/packages/versions/newUpload',
    service.upload,
  );
  router.add(
    'GET',
    r'/api/packages/versions/newUploadFinish',
    service.uploadFinish,
  );
  router.add(
    'POST',
    r'/api/packages/<name>/uploaders',
    service.addUploader,
  );
  router.add(
    'DELETE',
    r'/api/packages/<name>/uploaders/<email>',
    service.removeUploader,
  );
  router.add(
    'GET',
    r'/webapi/packages',
    service.getPackages,
  );
  router.add(
    'GET',
    r'/packages/<name>.json',
    service.getPackageVersions,
  );
  router.add(
    'GET',
    r'/webapi/package/<name>/<version>',
    service.getPackageDetail,
  );
  router.add(
    'GET',
    r'/',
    service.indexHtml,
  );
  router.add(
    'GET',
    r'/packages',
    service.indexHtml,
  );
  router.add(
    'GET',
    r'/packages/<name>',
    service.indexHtml,
  );
  router.add(
    'GET',
    r'/packages/<name>/versions/<version>',
    service.indexHtml,
  );
  router.add(
    'GET',
    r'/main.dart.js',
    service.mainDartJs,
  );
  router.add(
    'GET',
    r'/badge/<type>/<name>',
    service.badge,
  );
  return router;
}
