// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:gzc_app/core/local_storage/secure_storage_service.dart'
    as _i1061;
import 'package:gzc_app/core/local_storage/shared_prefs_service.dart' as _i22;
import 'package:gzc_app/core/local_storage/storage_service.dart' as _i44;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i44.SecureStorageService>(
      () => _i1061.FlutterSecureStorageService(),
    );
    gh.factory<_i44.LocalStorageService>(() => _i22.SharedPrefsService());
    return this;
  }
}
