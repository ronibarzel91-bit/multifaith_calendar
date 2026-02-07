import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/app_db.dart';

class ProfilesRepo {
  ProfilesRepo(this.db);
  final AppDatabase db;
  final _uuid = const Uuid();

  Future<String> createDefaultProfileIfMissing() async {
    final existing = await db.select(db.profiles).get();
    if (existing.isNotEmpty) {
      Profile? existingDefault;
      for (final profile in existing) {
        if (profile.isDefault) {
          existingDefault = profile;
          break;
        }
      }
      if (existingDefault != null) {
        await _ensureMethodsConfig(existingDefault.id);
        return existingDefault.id;
      }

      final profileId = existing.first.id;
      await (db.update(db.profiles)..where((p) => p.id.equals(profileId)))
          .write(const ProfilesCompanion(isDefault: Value(true)));
      await _ensureMethodsConfig(profileId);
      return profileId;
    }

    final id = _uuid.v4();
    final now = DateTime.now();

    await db.into(db.profiles).insert(ProfilesCompanion.insert(
      id: id,
      name: 'בית',
      countryCode: 'IL',
      timezone: 'Asia/Jerusalem',
      lat: 31.7683,
      lon: 35.2137,
      elevation: const Value(null),
      isDefault: const Value(true),
      createdAt: now,
      updatedAt: now,
    ));

    await _ensureMethodsConfig(id);

    return id;
  }

  Future<void> _ensureMethodsConfig(String profileId) async {
    final existing = await (db.select(db.methodsConfig)
          ..where((m) => m.profileId.equals(profileId)))
        .getSingleOrNull();
    if (existing != null) return;

    await db.into(db.methodsConfig).insert(
          MethodsConfigCompanion.insert(profileId: profileId),
        );
  }

  Future<Profile?> getDefaultProfile() async {
    final q = db.select(db.profiles)..where((p) => p.isDefault.equals(true));
    return q.getSingleOrNull();
  }

  Stream<List<Profile>> watchProfiles() {
    final q = db.select(db.profiles)
      ..orderBy([
        (p) => OrderingTerm.desc(p.isDefault),
        (p) => OrderingTerm.asc(p.name),
      ]);
    return q.watch();
  }

  Future<List<Profile>> getProfiles() {
    final q = db.select(db.profiles)
      ..orderBy([
        (p) => OrderingTerm.desc(p.isDefault),
        (p) => OrderingTerm.asc(p.name),
      ]);
    return q.get();
  }

  Future<String> createProfile({
    required String name,
    required String countryCode,
    required String timezone,
    required double lat,
    required double lon,
    double? elevation,
    bool isDefault = false,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    if (isDefault) {
      await _clearDefaultProfileFlag();
    }

    await db.into(db.profiles).insert(
          ProfilesCompanion.insert(
            id: id,
            name: name,
            countryCode: countryCode,
            timezone: timezone,
            lat: lat,
            lon: lon,
            elevation: Value(elevation),
            isDefault: Value(isDefault),
            createdAt: now,
            updatedAt: now,
          ),
        );

    await _ensureMethodsConfig(id);
    return id;
  }

  Future<void> updateProfile({
    required String profileId,
    required String name,
    required String countryCode,
    required String timezone,
    required double lat,
    required double lon,
    double? elevation,
  }) async {
    final now = DateTime.now();
    await (db.update(db.profiles)..where((p) => p.id.equals(profileId))).write(
      ProfilesCompanion(
        name: Value(name),
        countryCode: Value(countryCode),
        timezone: Value(timezone),
        lat: Value(lat),
        lon: Value(lon),
        elevation: Value(elevation),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> setDefaultProfile(String profileId) async {
    await _clearDefaultProfileFlag();
    await (db.update(db.profiles)..where((p) => p.id.equals(profileId))).write(
      const ProfilesCompanion(
        isDefault: Value(true),
      ),
    );
  }

  Future<void> _clearDefaultProfileFlag() async {
    await db.update(db.profiles).write(const ProfilesCompanion(
          isDefault: Value(false),
        ));
  }
}
