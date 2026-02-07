import 'dart:convert';

import 'package:drift/drift.dart';

import '../../app/i18n.dart';
import '../db/app_db.dart';

class SettingsRepo {
  SettingsRepo(this.db);
  final AppDatabase db;

  Future<AppLanguage> getLanguageForProfile(String profileId) async {
    final row = await (db.select(db.methodsConfig)
          ..where((m) => m.profileId.equals(profileId)))
        .getSingleOrNull();
    if (row == null) return AppLanguage.english;

    final map = _decodeJsonMap(row.customParamsJson);
    final languageCode = map['language']?.toString();
    return AppLanguage.fromCode(languageCode);
  }

  Future<void> setLanguageForProfile(
    String profileId,
    AppLanguage language,
  ) async {
    final row = await (db.select(db.methodsConfig)
          ..where((m) => m.profileId.equals(profileId)))
        .getSingleOrNull();
    final map = _decodeJsonMap(row?.customParamsJson);
    map['language'] = language.code;
    final encoded = jsonEncode(map);

    if (row == null) {
      await db.into(db.methodsConfig).insert(
            MethodsConfigCompanion.insert(
              profileId: profileId,
              customParamsJson: Value(encoded),
            ),
          );
      return;
    }

    await (db.update(db.methodsConfig)
          ..where((m) => m.profileId.equals(profileId)))
        .write(
      MethodsConfigCompanion(
        customParamsJson: Value(encoded),
      ),
    );
  }

  Map<String, dynamic> _decodeJsonMap(String? raw) {
    if (raw == null || raw.trim().isEmpty) return <String, dynamic>{};
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) {
        return decoded.map((key, value) => MapEntry('$key', value));
      }
    } catch (_) {
      return <String, dynamic>{};
    }
    return <String, dynamic>{};
  }
}
