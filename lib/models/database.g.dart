// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AnimalsTable extends Animals with TableInfo<$AnimalsTable, Animal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnimalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagNumberMeta = const VerificationMeta(
    'tagNumber',
  );
  @override
  late final GeneratedColumn<String> tagNumber = GeneratedColumn<String>(
    'tag_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
    'breed',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AnimalSex, String> sex =
      GeneratedColumn<String>(
        'sex',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AnimalSex>($AnimalsTable.$convertersex);
  @override
  late final GeneratedColumnWithTypeConverter<AnimalStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AnimalStatus>($AnimalsTable.$converterstatus);
  static const VerificationMeta _sireTagMeta = const VerificationMeta(
    'sireTag',
  );
  @override
  late final GeneratedColumn<String> sireTag = GeneratedColumn<String>(
    'sire_tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _damTagMeta = const VerificationMeta('damTag');
  @override
  late final GeneratedColumn<String> damTag = GeneratedColumn<String>(
    'dam_tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseWeightMeta = const VerificationMeta(
    'purchaseWeight',
  );
  @override
  late final GeneratedColumn<double> purchaseWeight = GeneratedColumn<double>(
    'purchase_weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rfidTagMeta = const VerificationMeta(
    'rfidTag',
  );
  @override
  late final GeneratedColumn<String> rfidTag = GeneratedColumn<String>(
    'rfid_tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _smartTagIdMeta = const VerificationMeta(
    'smartTagId',
  );
  @override
  late final GeneratedColumn<String> smartTagId = GeneratedColumn<String>(
    'smart_tag_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentPastureIdMeta = const VerificationMeta(
    'currentPastureId',
  );
  @override
  late final GeneratedColumn<String> currentPastureId = GeneratedColumn<String>(
    'current_pasture_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('synced'),
      ).withConverter<SyncStatus>($AnimalsTable.$convertersyncStatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tagNumber,
    breed,
    dateOfBirth,
    sex,
    status,
    sireTag,
    damTag,
    notes,
    purchaseDate,
    purchaseWeight,
    purchasePrice,
    rfidTag,
    smartTagId,
    currentPastureId,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'animals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Animal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tag_number')) {
      context.handle(
        _tagNumberMeta,
        tagNumber.isAcceptableOrUnknown(data['tag_number']!, _tagNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_tagNumberMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
        _breedMeta,
        breed.isAcceptableOrUnknown(data['breed']!, _breedMeta),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('sire_tag')) {
      context.handle(
        _sireTagMeta,
        sireTag.isAcceptableOrUnknown(data['sire_tag']!, _sireTagMeta),
      );
    }
    if (data.containsKey('dam_tag')) {
      context.handle(
        _damTagMeta,
        damTag.isAcceptableOrUnknown(data['dam_tag']!, _damTagMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('purchase_weight')) {
      context.handle(
        _purchaseWeightMeta,
        purchaseWeight.isAcceptableOrUnknown(
          data['purchase_weight']!,
          _purchaseWeightMeta,
        ),
      );
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    }
    if (data.containsKey('rfid_tag')) {
      context.handle(
        _rfidTagMeta,
        rfidTag.isAcceptableOrUnknown(data['rfid_tag']!, _rfidTagMeta),
      );
    }
    if (data.containsKey('smart_tag_id')) {
      context.handle(
        _smartTagIdMeta,
        smartTagId.isAcceptableOrUnknown(
          data['smart_tag_id']!,
          _smartTagIdMeta,
        ),
      );
    }
    if (data.containsKey('current_pasture_id')) {
      context.handle(
        _currentPastureIdMeta,
        currentPastureId.isAcceptableOrUnknown(
          data['current_pasture_id']!,
          _currentPastureIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Animal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Animal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tagNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_number'],
      )!,
      breed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}breed'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      )!,
      sex: $AnimalsTable.$convertersex.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sex'],
        )!,
      ),
      status: $AnimalsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      sireTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sire_tag'],
      ),
      damTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dam_tag'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      ),
      purchaseWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_weight'],
      ),
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      ),
      rfidTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rfid_tag'],
      ),
      smartTagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}smart_tag_id'],
      ),
      currentPastureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_pasture_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: $AnimalsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
    );
  }

  @override
  $AnimalsTable createAlias(String alias) {
    return $AnimalsTable(attachedDatabase, alias);
  }

  static TypeConverter<AnimalSex, String> $convertersex =
      const AnimalSexConverter();
  static TypeConverter<AnimalStatus, String> $converterstatus =
      const AnimalStatusConverter();
  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class Animal extends DataClass implements Insertable<Animal> {
  final String id;
  final String tagNumber;
  final String breed;
  final DateTime dateOfBirth;
  final AnimalSex sex;
  final AnimalStatus status;
  final String? sireTag;
  final String? damTag;
  final String notes;
  final DateTime? purchaseDate;
  final double? purchaseWeight;
  final double? purchasePrice;
  final String? rfidTag;
  final String? smartTagId;
  final String? currentPastureId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SyncStatus syncStatus;
  const Animal({
    required this.id,
    required this.tagNumber,
    required this.breed,
    required this.dateOfBirth,
    required this.sex,
    required this.status,
    this.sireTag,
    this.damTag,
    required this.notes,
    this.purchaseDate,
    this.purchaseWeight,
    this.purchasePrice,
    this.rfidTag,
    this.smartTagId,
    this.currentPastureId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tag_number'] = Variable<String>(tagNumber);
    map['breed'] = Variable<String>(breed);
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    {
      map['sex'] = Variable<String>($AnimalsTable.$convertersex.toSql(sex));
    }
    {
      map['status'] = Variable<String>(
        $AnimalsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || sireTag != null) {
      map['sire_tag'] = Variable<String>(sireTag);
    }
    if (!nullToAbsent || damTag != null) {
      map['dam_tag'] = Variable<String>(damTag);
    }
    map['notes'] = Variable<String>(notes);
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    if (!nullToAbsent || purchaseWeight != null) {
      map['purchase_weight'] = Variable<double>(purchaseWeight);
    }
    if (!nullToAbsent || purchasePrice != null) {
      map['purchase_price'] = Variable<double>(purchasePrice);
    }
    if (!nullToAbsent || rfidTag != null) {
      map['rfid_tag'] = Variable<String>(rfidTag);
    }
    if (!nullToAbsent || smartTagId != null) {
      map['smart_tag_id'] = Variable<String>(smartTagId);
    }
    if (!nullToAbsent || currentPastureId != null) {
      map['current_pasture_id'] = Variable<String>(currentPastureId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    {
      map['sync_status'] = Variable<String>(
        $AnimalsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    return map;
  }

  AnimalsCompanion toCompanion(bool nullToAbsent) {
    return AnimalsCompanion(
      id: Value(id),
      tagNumber: Value(tagNumber),
      breed: Value(breed),
      dateOfBirth: Value(dateOfBirth),
      sex: Value(sex),
      status: Value(status),
      sireTag: sireTag == null && nullToAbsent
          ? const Value.absent()
          : Value(sireTag),
      damTag: damTag == null && nullToAbsent
          ? const Value.absent()
          : Value(damTag),
      notes: Value(notes),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      purchaseWeight: purchaseWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseWeight),
      purchasePrice: purchasePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePrice),
      rfidTag: rfidTag == null && nullToAbsent
          ? const Value.absent()
          : Value(rfidTag),
      smartTagId: smartTagId == null && nullToAbsent
          ? const Value.absent()
          : Value(smartTagId),
      currentPastureId: currentPastureId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentPastureId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory Animal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Animal(
      id: serializer.fromJson<String>(json['id']),
      tagNumber: serializer.fromJson<String>(json['tagNumber']),
      breed: serializer.fromJson<String>(json['breed']),
      dateOfBirth: serializer.fromJson<DateTime>(json['dateOfBirth']),
      sex: serializer.fromJson<AnimalSex>(json['sex']),
      status: serializer.fromJson<AnimalStatus>(json['status']),
      sireTag: serializer.fromJson<String?>(json['sireTag']),
      damTag: serializer.fromJson<String?>(json['damTag']),
      notes: serializer.fromJson<String>(json['notes']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      purchaseWeight: serializer.fromJson<double?>(json['purchaseWeight']),
      purchasePrice: serializer.fromJson<double?>(json['purchasePrice']),
      rfidTag: serializer.fromJson<String?>(json['rfidTag']),
      smartTagId: serializer.fromJson<String?>(json['smartTagId']),
      currentPastureId: serializer.fromJson<String?>(json['currentPastureId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tagNumber': serializer.toJson<String>(tagNumber),
      'breed': serializer.toJson<String>(breed),
      'dateOfBirth': serializer.toJson<DateTime>(dateOfBirth),
      'sex': serializer.toJson<AnimalSex>(sex),
      'status': serializer.toJson<AnimalStatus>(status),
      'sireTag': serializer.toJson<String?>(sireTag),
      'damTag': serializer.toJson<String?>(damTag),
      'notes': serializer.toJson<String>(notes),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'purchaseWeight': serializer.toJson<double?>(purchaseWeight),
      'purchasePrice': serializer.toJson<double?>(purchasePrice),
      'rfidTag': serializer.toJson<String?>(rfidTag),
      'smartTagId': serializer.toJson<String?>(smartTagId),
      'currentPastureId': serializer.toJson<String?>(currentPastureId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
    };
  }

  Animal copyWith({
    String? id,
    String? tagNumber,
    String? breed,
    DateTime? dateOfBirth,
    AnimalSex? sex,
    AnimalStatus? status,
    Value<String?> sireTag = const Value.absent(),
    Value<String?> damTag = const Value.absent(),
    String? notes,
    Value<DateTime?> purchaseDate = const Value.absent(),
    Value<double?> purchaseWeight = const Value.absent(),
    Value<double?> purchasePrice = const Value.absent(),
    Value<String?> rfidTag = const Value.absent(),
    Value<String?> smartTagId = const Value.absent(),
    Value<String?> currentPastureId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
  }) => Animal(
    id: id ?? this.id,
    tagNumber: tagNumber ?? this.tagNumber,
    breed: breed ?? this.breed,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    sex: sex ?? this.sex,
    status: status ?? this.status,
    sireTag: sireTag.present ? sireTag.value : this.sireTag,
    damTag: damTag.present ? damTag.value : this.damTag,
    notes: notes ?? this.notes,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    purchaseWeight: purchaseWeight.present
        ? purchaseWeight.value
        : this.purchaseWeight,
    purchasePrice: purchasePrice.present
        ? purchasePrice.value
        : this.purchasePrice,
    rfidTag: rfidTag.present ? rfidTag.value : this.rfidTag,
    smartTagId: smartTagId.present ? smartTagId.value : this.smartTagId,
    currentPastureId: currentPastureId.present
        ? currentPastureId.value
        : this.currentPastureId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  Animal copyWithCompanion(AnimalsCompanion data) {
    return Animal(
      id: data.id.present ? data.id.value : this.id,
      tagNumber: data.tagNumber.present ? data.tagNumber.value : this.tagNumber,
      breed: data.breed.present ? data.breed.value : this.breed,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      sex: data.sex.present ? data.sex.value : this.sex,
      status: data.status.present ? data.status.value : this.status,
      sireTag: data.sireTag.present ? data.sireTag.value : this.sireTag,
      damTag: data.damTag.present ? data.damTag.value : this.damTag,
      notes: data.notes.present ? data.notes.value : this.notes,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      purchaseWeight: data.purchaseWeight.present
          ? data.purchaseWeight.value
          : this.purchaseWeight,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      rfidTag: data.rfidTag.present ? data.rfidTag.value : this.rfidTag,
      smartTagId: data.smartTagId.present
          ? data.smartTagId.value
          : this.smartTagId,
      currentPastureId: data.currentPastureId.present
          ? data.currentPastureId.value
          : this.currentPastureId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Animal(')
          ..write('id: $id, ')
          ..write('tagNumber: $tagNumber, ')
          ..write('breed: $breed, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('sex: $sex, ')
          ..write('status: $status, ')
          ..write('sireTag: $sireTag, ')
          ..write('damTag: $damTag, ')
          ..write('notes: $notes, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchaseWeight: $purchaseWeight, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('rfidTag: $rfidTag, ')
          ..write('smartTagId: $smartTagId, ')
          ..write('currentPastureId: $currentPastureId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tagNumber,
    breed,
    dateOfBirth,
    sex,
    status,
    sireTag,
    damTag,
    notes,
    purchaseDate,
    purchaseWeight,
    purchasePrice,
    rfidTag,
    smartTagId,
    currentPastureId,
    createdAt,
    updatedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Animal &&
          other.id == this.id &&
          other.tagNumber == this.tagNumber &&
          other.breed == this.breed &&
          other.dateOfBirth == this.dateOfBirth &&
          other.sex == this.sex &&
          other.status == this.status &&
          other.sireTag == this.sireTag &&
          other.damTag == this.damTag &&
          other.notes == this.notes &&
          other.purchaseDate == this.purchaseDate &&
          other.purchaseWeight == this.purchaseWeight &&
          other.purchasePrice == this.purchasePrice &&
          other.rfidTag == this.rfidTag &&
          other.smartTagId == this.smartTagId &&
          other.currentPastureId == this.currentPastureId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class AnimalsCompanion extends UpdateCompanion<Animal> {
  final Value<String> id;
  final Value<String> tagNumber;
  final Value<String> breed;
  final Value<DateTime> dateOfBirth;
  final Value<AnimalSex> sex;
  final Value<AnimalStatus> status;
  final Value<String?> sireTag;
  final Value<String?> damTag;
  final Value<String> notes;
  final Value<DateTime?> purchaseDate;
  final Value<double?> purchaseWeight;
  final Value<double?> purchasePrice;
  final Value<String?> rfidTag;
  final Value<String?> smartTagId;
  final Value<String?> currentPastureId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> rowid;
  const AnimalsCompanion({
    this.id = const Value.absent(),
    this.tagNumber = const Value.absent(),
    this.breed = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.sex = const Value.absent(),
    this.status = const Value.absent(),
    this.sireTag = const Value.absent(),
    this.damTag = const Value.absent(),
    this.notes = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchaseWeight = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.rfidTag = const Value.absent(),
    this.smartTagId = const Value.absent(),
    this.currentPastureId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnimalsCompanion.insert({
    required String id,
    required String tagNumber,
    this.breed = const Value.absent(),
    required DateTime dateOfBirth,
    required AnimalSex sex,
    required AnimalStatus status,
    this.sireTag = const Value.absent(),
    this.damTag = const Value.absent(),
    this.notes = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchaseWeight = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.rfidTag = const Value.absent(),
    this.smartTagId = const Value.absent(),
    this.currentPastureId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tagNumber = Value(tagNumber),
       dateOfBirth = Value(dateOfBirth),
       sex = Value(sex),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Animal> custom({
    Expression<String>? id,
    Expression<String>? tagNumber,
    Expression<String>? breed,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? sex,
    Expression<String>? status,
    Expression<String>? sireTag,
    Expression<String>? damTag,
    Expression<String>? notes,
    Expression<DateTime>? purchaseDate,
    Expression<double>? purchaseWeight,
    Expression<double>? purchasePrice,
    Expression<String>? rfidTag,
    Expression<String>? smartTagId,
    Expression<String>? currentPastureId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tagNumber != null) 'tag_number': tagNumber,
      if (breed != null) 'breed': breed,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (sex != null) 'sex': sex,
      if (status != null) 'status': status,
      if (sireTag != null) 'sire_tag': sireTag,
      if (damTag != null) 'dam_tag': damTag,
      if (notes != null) 'notes': notes,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (purchaseWeight != null) 'purchase_weight': purchaseWeight,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (rfidTag != null) 'rfid_tag': rfidTag,
      if (smartTagId != null) 'smart_tag_id': smartTagId,
      if (currentPastureId != null) 'current_pasture_id': currentPastureId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnimalsCompanion copyWith({
    Value<String>? id,
    Value<String>? tagNumber,
    Value<String>? breed,
    Value<DateTime>? dateOfBirth,
    Value<AnimalSex>? sex,
    Value<AnimalStatus>? status,
    Value<String?>? sireTag,
    Value<String?>? damTag,
    Value<String>? notes,
    Value<DateTime?>? purchaseDate,
    Value<double?>? purchaseWeight,
    Value<double?>? purchasePrice,
    Value<String?>? rfidTag,
    Value<String?>? smartTagId,
    Value<String?>? currentPastureId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? rowid,
  }) {
    return AnimalsCompanion(
      id: id ?? this.id,
      tagNumber: tagNumber ?? this.tagNumber,
      breed: breed ?? this.breed,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      sex: sex ?? this.sex,
      status: status ?? this.status,
      sireTag: sireTag ?? this.sireTag,
      damTag: damTag ?? this.damTag,
      notes: notes ?? this.notes,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchaseWeight: purchaseWeight ?? this.purchaseWeight,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      rfidTag: rfidTag ?? this.rfidTag,
      smartTagId: smartTagId ?? this.smartTagId,
      currentPastureId: currentPastureId ?? this.currentPastureId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tagNumber.present) {
      map['tag_number'] = Variable<String>(tagNumber.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(
        $AnimalsTable.$convertersex.toSql(sex.value),
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $AnimalsTable.$converterstatus.toSql(status.value),
      );
    }
    if (sireTag.present) {
      map['sire_tag'] = Variable<String>(sireTag.value);
    }
    if (damTag.present) {
      map['dam_tag'] = Variable<String>(damTag.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (purchaseWeight.present) {
      map['purchase_weight'] = Variable<double>(purchaseWeight.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (rfidTag.present) {
      map['rfid_tag'] = Variable<String>(rfidTag.value);
    }
    if (smartTagId.present) {
      map['smart_tag_id'] = Variable<String>(smartTagId.value);
    }
    if (currentPastureId.present) {
      map['current_pasture_id'] = Variable<String>(currentPastureId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $AnimalsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnimalsCompanion(')
          ..write('id: $id, ')
          ..write('tagNumber: $tagNumber, ')
          ..write('breed: $breed, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('sex: $sex, ')
          ..write('status: $status, ')
          ..write('sireTag: $sireTag, ')
          ..write('damTag: $damTag, ')
          ..write('notes: $notes, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchaseWeight: $purchaseWeight, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('rfidTag: $rfidTag, ')
          ..write('smartTagId: $smartTagId, ')
          ..write('currentPastureId: $currentPastureId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CalvingRecordsTable extends CalvingRecords
    with TableInfo<$CalvingRecordsTable, CalvingRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalvingRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animalIdMeta = const VerificationMeta(
    'animalId',
  );
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
    'animal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animals (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calfTagMeta = const VerificationMeta(
    'calfTag',
  );
  @override
  late final GeneratedColumn<String> calfTag = GeneratedColumn<String>(
    'calf_tag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AnimalSex, String> calfSex =
      GeneratedColumn<String>(
        'calf_sex',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AnimalSex>($CalvingRecordsTable.$convertercalfSex);
  static const VerificationMeta _birthWeightMeta = const VerificationMeta(
    'birthWeight',
  );
  @override
  late final GeneratedColumn<double> birthWeight = GeneratedColumn<double>(
    'birth_weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _calvingEaseScoreMeta = const VerificationMeta(
    'calvingEaseScore',
  );
  @override
  late final GeneratedColumn<int> calvingEaseScore = GeneratedColumn<int>(
    'calving_ease_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('synced'),
      ).withConverter<SyncStatus>($CalvingRecordsTable.$convertersyncStatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    animalId,
    date,
    calfTag,
    calfSex,
    birthWeight,
    calvingEaseScore,
    notes,
    createdAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calving_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalvingRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(
        _animalIdMeta,
        animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('calf_tag')) {
      context.handle(
        _calfTagMeta,
        calfTag.isAcceptableOrUnknown(data['calf_tag']!, _calfTagMeta),
      );
    } else if (isInserting) {
      context.missing(_calfTagMeta);
    }
    if (data.containsKey('birth_weight')) {
      context.handle(
        _birthWeightMeta,
        birthWeight.isAcceptableOrUnknown(
          data['birth_weight']!,
          _birthWeightMeta,
        ),
      );
    }
    if (data.containsKey('calving_ease_score')) {
      context.handle(
        _calvingEaseScoreMeta,
        calvingEaseScore.isAcceptableOrUnknown(
          data['calving_ease_score']!,
          _calvingEaseScoreMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalvingRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalvingRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      animalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      calfTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calf_tag'],
      )!,
      calfSex: $CalvingRecordsTable.$convertercalfSex.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}calf_sex'],
        )!,
      ),
      birthWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}birth_weight'],
      ),
      calvingEaseScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calving_ease_score'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: $CalvingRecordsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
    );
  }

  @override
  $CalvingRecordsTable createAlias(String alias) {
    return $CalvingRecordsTable(attachedDatabase, alias);
  }

  static TypeConverter<AnimalSex, String> $convertercalfSex =
      const AnimalSexConverter();
  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class CalvingRecord extends DataClass implements Insertable<CalvingRecord> {
  final String id;
  final String animalId;
  final DateTime date;
  final String calfTag;
  final AnimalSex calfSex;
  final double? birthWeight;
  final int calvingEaseScore;
  final String notes;
  final DateTime createdAt;
  final SyncStatus syncStatus;
  const CalvingRecord({
    required this.id,
    required this.animalId,
    required this.date,
    required this.calfTag,
    required this.calfSex,
    this.birthWeight,
    required this.calvingEaseScore,
    required this.notes,
    required this.createdAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['animal_id'] = Variable<String>(animalId);
    map['date'] = Variable<DateTime>(date);
    map['calf_tag'] = Variable<String>(calfTag);
    {
      map['calf_sex'] = Variable<String>(
        $CalvingRecordsTable.$convertercalfSex.toSql(calfSex),
      );
    }
    if (!nullToAbsent || birthWeight != null) {
      map['birth_weight'] = Variable<double>(birthWeight);
    }
    map['calving_ease_score'] = Variable<int>(calvingEaseScore);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    {
      map['sync_status'] = Variable<String>(
        $CalvingRecordsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    return map;
  }

  CalvingRecordsCompanion toCompanion(bool nullToAbsent) {
    return CalvingRecordsCompanion(
      id: Value(id),
      animalId: Value(animalId),
      date: Value(date),
      calfTag: Value(calfTag),
      calfSex: Value(calfSex),
      birthWeight: birthWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(birthWeight),
      calvingEaseScore: Value(calvingEaseScore),
      notes: Value(notes),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory CalvingRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalvingRecord(
      id: serializer.fromJson<String>(json['id']),
      animalId: serializer.fromJson<String>(json['animalId']),
      date: serializer.fromJson<DateTime>(json['date']),
      calfTag: serializer.fromJson<String>(json['calfTag']),
      calfSex: serializer.fromJson<AnimalSex>(json['calfSex']),
      birthWeight: serializer.fromJson<double?>(json['birthWeight']),
      calvingEaseScore: serializer.fromJson<int>(json['calvingEaseScore']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'animalId': serializer.toJson<String>(animalId),
      'date': serializer.toJson<DateTime>(date),
      'calfTag': serializer.toJson<String>(calfTag),
      'calfSex': serializer.toJson<AnimalSex>(calfSex),
      'birthWeight': serializer.toJson<double?>(birthWeight),
      'calvingEaseScore': serializer.toJson<int>(calvingEaseScore),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
    };
  }

  CalvingRecord copyWith({
    String? id,
    String? animalId,
    DateTime? date,
    String? calfTag,
    AnimalSex? calfSex,
    Value<double?> birthWeight = const Value.absent(),
    int? calvingEaseScore,
    String? notes,
    DateTime? createdAt,
    SyncStatus? syncStatus,
  }) => CalvingRecord(
    id: id ?? this.id,
    animalId: animalId ?? this.animalId,
    date: date ?? this.date,
    calfTag: calfTag ?? this.calfTag,
    calfSex: calfSex ?? this.calfSex,
    birthWeight: birthWeight.present ? birthWeight.value : this.birthWeight,
    calvingEaseScore: calvingEaseScore ?? this.calvingEaseScore,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  CalvingRecord copyWithCompanion(CalvingRecordsCompanion data) {
    return CalvingRecord(
      id: data.id.present ? data.id.value : this.id,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      date: data.date.present ? data.date.value : this.date,
      calfTag: data.calfTag.present ? data.calfTag.value : this.calfTag,
      calfSex: data.calfSex.present ? data.calfSex.value : this.calfSex,
      birthWeight: data.birthWeight.present
          ? data.birthWeight.value
          : this.birthWeight,
      calvingEaseScore: data.calvingEaseScore.present
          ? data.calvingEaseScore.value
          : this.calvingEaseScore,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalvingRecord(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('date: $date, ')
          ..write('calfTag: $calfTag, ')
          ..write('calfSex: $calfSex, ')
          ..write('birthWeight: $birthWeight, ')
          ..write('calvingEaseScore: $calvingEaseScore, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    animalId,
    date,
    calfTag,
    calfSex,
    birthWeight,
    calvingEaseScore,
    notes,
    createdAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalvingRecord &&
          other.id == this.id &&
          other.animalId == this.animalId &&
          other.date == this.date &&
          other.calfTag == this.calfTag &&
          other.calfSex == this.calfSex &&
          other.birthWeight == this.birthWeight &&
          other.calvingEaseScore == this.calvingEaseScore &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class CalvingRecordsCompanion extends UpdateCompanion<CalvingRecord> {
  final Value<String> id;
  final Value<String> animalId;
  final Value<DateTime> date;
  final Value<String> calfTag;
  final Value<AnimalSex> calfSex;
  final Value<double?> birthWeight;
  final Value<int> calvingEaseScore;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> rowid;
  const CalvingRecordsCompanion({
    this.id = const Value.absent(),
    this.animalId = const Value.absent(),
    this.date = const Value.absent(),
    this.calfTag = const Value.absent(),
    this.calfSex = const Value.absent(),
    this.birthWeight = const Value.absent(),
    this.calvingEaseScore = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CalvingRecordsCompanion.insert({
    required String id,
    required String animalId,
    required DateTime date,
    required String calfTag,
    required AnimalSex calfSex,
    this.birthWeight = const Value.absent(),
    this.calvingEaseScore = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       animalId = Value(animalId),
       date = Value(date),
       calfTag = Value(calfTag),
       calfSex = Value(calfSex),
       createdAt = Value(createdAt);
  static Insertable<CalvingRecord> custom({
    Expression<String>? id,
    Expression<String>? animalId,
    Expression<DateTime>? date,
    Expression<String>? calfTag,
    Expression<String>? calfSex,
    Expression<double>? birthWeight,
    Expression<int>? calvingEaseScore,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (animalId != null) 'animal_id': animalId,
      if (date != null) 'date': date,
      if (calfTag != null) 'calf_tag': calfTag,
      if (calfSex != null) 'calf_sex': calfSex,
      if (birthWeight != null) 'birth_weight': birthWeight,
      if (calvingEaseScore != null) 'calving_ease_score': calvingEaseScore,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CalvingRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? animalId,
    Value<DateTime>? date,
    Value<String>? calfTag,
    Value<AnimalSex>? calfSex,
    Value<double?>? birthWeight,
    Value<int>? calvingEaseScore,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? rowid,
  }) {
    return CalvingRecordsCompanion(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      date: date ?? this.date,
      calfTag: calfTag ?? this.calfTag,
      calfSex: calfSex ?? this.calfSex,
      birthWeight: birthWeight ?? this.birthWeight,
      calvingEaseScore: calvingEaseScore ?? this.calvingEaseScore,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (calfTag.present) {
      map['calf_tag'] = Variable<String>(calfTag.value);
    }
    if (calfSex.present) {
      map['calf_sex'] = Variable<String>(
        $CalvingRecordsTable.$convertercalfSex.toSql(calfSex.value),
      );
    }
    if (birthWeight.present) {
      map['birth_weight'] = Variable<double>(birthWeight.value);
    }
    if (calvingEaseScore.present) {
      map['calving_ease_score'] = Variable<int>(calvingEaseScore.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $CalvingRecordsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalvingRecordsCompanion(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('date: $date, ')
          ..write('calfTag: $calfTag, ')
          ..write('calfSex: $calfSex, ')
          ..write('birthWeight: $birthWeight, ')
          ..write('calvingEaseScore: $calvingEaseScore, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TreatmentRecordsTable extends TreatmentRecords
    with TableInfo<$TreatmentRecordsTable, TreatmentRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreatmentRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animalIdMeta = const VerificationMeta(
    'animalId',
  );
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
    'animal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animals (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _treatmentMeta = const VerificationMeta(
    'treatment',
  );
  @override
  late final GeneratedColumn<String> treatment = GeneratedColumn<String>(
    'treatment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
    'dosage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TreatmentRoute, String> route =
      GeneratedColumn<String>(
        'route',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TreatmentRoute>($TreatmentRecordsTable.$converterroute);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _withdrawalDaysMeta = const VerificationMeta(
    'withdrawalDays',
  );
  @override
  late final GeneratedColumn<int> withdrawalDays = GeneratedColumn<int>(
    'withdrawal_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _withdrawalDateMeta = const VerificationMeta(
    'withdrawalDate',
  );
  @override
  late final GeneratedColumn<DateTime> withdrawalDate =
      GeneratedColumn<DateTime>(
        'withdrawal_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('synced'),
      ).withConverter<SyncStatus>($TreatmentRecordsTable.$convertersyncStatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    animalId,
    date,
    treatment,
    dosage,
    route,
    reason,
    withdrawalDays,
    withdrawalDate,
    notes,
    createdAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'treatment_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<TreatmentRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(
        _animalIdMeta,
        animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('treatment')) {
      context.handle(
        _treatmentMeta,
        treatment.isAcceptableOrUnknown(data['treatment']!, _treatmentMeta),
      );
    } else if (isInserting) {
      context.missing(_treatmentMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(
        _dosageMeta,
        dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('withdrawal_days')) {
      context.handle(
        _withdrawalDaysMeta,
        withdrawalDays.isAcceptableOrUnknown(
          data['withdrawal_days']!,
          _withdrawalDaysMeta,
        ),
      );
    }
    if (data.containsKey('withdrawal_date')) {
      context.handle(
        _withdrawalDateMeta,
        withdrawalDate.isAcceptableOrUnknown(
          data['withdrawal_date']!,
          _withdrawalDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TreatmentRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TreatmentRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      animalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      treatment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}treatment'],
      )!,
      dosage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dosage'],
      )!,
      route: $TreatmentRecordsTable.$converterroute.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}route'],
        )!,
      ),
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      withdrawalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}withdrawal_days'],
      )!,
      withdrawalDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}withdrawal_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: $TreatmentRecordsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
    );
  }

  @override
  $TreatmentRecordsTable createAlias(String alias) {
    return $TreatmentRecordsTable(attachedDatabase, alias);
  }

  static TypeConverter<TreatmentRoute, String> $converterroute =
      const TreatmentRouteConverter();
  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class TreatmentRecord extends DataClass implements Insertable<TreatmentRecord> {
  final String id;
  final String animalId;
  final DateTime date;
  final String treatment;
  final String dosage;
  final TreatmentRoute route;
  final String reason;
  final int withdrawalDays;
  final DateTime? withdrawalDate;
  final String notes;
  final DateTime createdAt;
  final SyncStatus syncStatus;
  const TreatmentRecord({
    required this.id,
    required this.animalId,
    required this.date,
    required this.treatment,
    required this.dosage,
    required this.route,
    required this.reason,
    required this.withdrawalDays,
    this.withdrawalDate,
    required this.notes,
    required this.createdAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['animal_id'] = Variable<String>(animalId);
    map['date'] = Variable<DateTime>(date);
    map['treatment'] = Variable<String>(treatment);
    map['dosage'] = Variable<String>(dosage);
    {
      map['route'] = Variable<String>(
        $TreatmentRecordsTable.$converterroute.toSql(route),
      );
    }
    map['reason'] = Variable<String>(reason);
    map['withdrawal_days'] = Variable<int>(withdrawalDays);
    if (!nullToAbsent || withdrawalDate != null) {
      map['withdrawal_date'] = Variable<DateTime>(withdrawalDate);
    }
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    {
      map['sync_status'] = Variable<String>(
        $TreatmentRecordsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    return map;
  }

  TreatmentRecordsCompanion toCompanion(bool nullToAbsent) {
    return TreatmentRecordsCompanion(
      id: Value(id),
      animalId: Value(animalId),
      date: Value(date),
      treatment: Value(treatment),
      dosage: Value(dosage),
      route: Value(route),
      reason: Value(reason),
      withdrawalDays: Value(withdrawalDays),
      withdrawalDate: withdrawalDate == null && nullToAbsent
          ? const Value.absent()
          : Value(withdrawalDate),
      notes: Value(notes),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory TreatmentRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TreatmentRecord(
      id: serializer.fromJson<String>(json['id']),
      animalId: serializer.fromJson<String>(json['animalId']),
      date: serializer.fromJson<DateTime>(json['date']),
      treatment: serializer.fromJson<String>(json['treatment']),
      dosage: serializer.fromJson<String>(json['dosage']),
      route: serializer.fromJson<TreatmentRoute>(json['route']),
      reason: serializer.fromJson<String>(json['reason']),
      withdrawalDays: serializer.fromJson<int>(json['withdrawalDays']),
      withdrawalDate: serializer.fromJson<DateTime?>(json['withdrawalDate']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'animalId': serializer.toJson<String>(animalId),
      'date': serializer.toJson<DateTime>(date),
      'treatment': serializer.toJson<String>(treatment),
      'dosage': serializer.toJson<String>(dosage),
      'route': serializer.toJson<TreatmentRoute>(route),
      'reason': serializer.toJson<String>(reason),
      'withdrawalDays': serializer.toJson<int>(withdrawalDays),
      'withdrawalDate': serializer.toJson<DateTime?>(withdrawalDate),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
    };
  }

  TreatmentRecord copyWith({
    String? id,
    String? animalId,
    DateTime? date,
    String? treatment,
    String? dosage,
    TreatmentRoute? route,
    String? reason,
    int? withdrawalDays,
    Value<DateTime?> withdrawalDate = const Value.absent(),
    String? notes,
    DateTime? createdAt,
    SyncStatus? syncStatus,
  }) => TreatmentRecord(
    id: id ?? this.id,
    animalId: animalId ?? this.animalId,
    date: date ?? this.date,
    treatment: treatment ?? this.treatment,
    dosage: dosage ?? this.dosage,
    route: route ?? this.route,
    reason: reason ?? this.reason,
    withdrawalDays: withdrawalDays ?? this.withdrawalDays,
    withdrawalDate: withdrawalDate.present
        ? withdrawalDate.value
        : this.withdrawalDate,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  TreatmentRecord copyWithCompanion(TreatmentRecordsCompanion data) {
    return TreatmentRecord(
      id: data.id.present ? data.id.value : this.id,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      date: data.date.present ? data.date.value : this.date,
      treatment: data.treatment.present ? data.treatment.value : this.treatment,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      route: data.route.present ? data.route.value : this.route,
      reason: data.reason.present ? data.reason.value : this.reason,
      withdrawalDays: data.withdrawalDays.present
          ? data.withdrawalDays.value
          : this.withdrawalDays,
      withdrawalDate: data.withdrawalDate.present
          ? data.withdrawalDate.value
          : this.withdrawalDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentRecord(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('date: $date, ')
          ..write('treatment: $treatment, ')
          ..write('dosage: $dosage, ')
          ..write('route: $route, ')
          ..write('reason: $reason, ')
          ..write('withdrawalDays: $withdrawalDays, ')
          ..write('withdrawalDate: $withdrawalDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    animalId,
    date,
    treatment,
    dosage,
    route,
    reason,
    withdrawalDays,
    withdrawalDate,
    notes,
    createdAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TreatmentRecord &&
          other.id == this.id &&
          other.animalId == this.animalId &&
          other.date == this.date &&
          other.treatment == this.treatment &&
          other.dosage == this.dosage &&
          other.route == this.route &&
          other.reason == this.reason &&
          other.withdrawalDays == this.withdrawalDays &&
          other.withdrawalDate == this.withdrawalDate &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class TreatmentRecordsCompanion extends UpdateCompanion<TreatmentRecord> {
  final Value<String> id;
  final Value<String> animalId;
  final Value<DateTime> date;
  final Value<String> treatment;
  final Value<String> dosage;
  final Value<TreatmentRoute> route;
  final Value<String> reason;
  final Value<int> withdrawalDays;
  final Value<DateTime?> withdrawalDate;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> rowid;
  const TreatmentRecordsCompanion({
    this.id = const Value.absent(),
    this.animalId = const Value.absent(),
    this.date = const Value.absent(),
    this.treatment = const Value.absent(),
    this.dosage = const Value.absent(),
    this.route = const Value.absent(),
    this.reason = const Value.absent(),
    this.withdrawalDays = const Value.absent(),
    this.withdrawalDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TreatmentRecordsCompanion.insert({
    required String id,
    required String animalId,
    required DateTime date,
    required String treatment,
    this.dosage = const Value.absent(),
    required TreatmentRoute route,
    this.reason = const Value.absent(),
    this.withdrawalDays = const Value.absent(),
    this.withdrawalDate = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       animalId = Value(animalId),
       date = Value(date),
       treatment = Value(treatment),
       route = Value(route),
       createdAt = Value(createdAt);
  static Insertable<TreatmentRecord> custom({
    Expression<String>? id,
    Expression<String>? animalId,
    Expression<DateTime>? date,
    Expression<String>? treatment,
    Expression<String>? dosage,
    Expression<String>? route,
    Expression<String>? reason,
    Expression<int>? withdrawalDays,
    Expression<DateTime>? withdrawalDate,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (animalId != null) 'animal_id': animalId,
      if (date != null) 'date': date,
      if (treatment != null) 'treatment': treatment,
      if (dosage != null) 'dosage': dosage,
      if (route != null) 'route': route,
      if (reason != null) 'reason': reason,
      if (withdrawalDays != null) 'withdrawal_days': withdrawalDays,
      if (withdrawalDate != null) 'withdrawal_date': withdrawalDate,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TreatmentRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? animalId,
    Value<DateTime>? date,
    Value<String>? treatment,
    Value<String>? dosage,
    Value<TreatmentRoute>? route,
    Value<String>? reason,
    Value<int>? withdrawalDays,
    Value<DateTime?>? withdrawalDate,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? rowid,
  }) {
    return TreatmentRecordsCompanion(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      date: date ?? this.date,
      treatment: treatment ?? this.treatment,
      dosage: dosage ?? this.dosage,
      route: route ?? this.route,
      reason: reason ?? this.reason,
      withdrawalDays: withdrawalDays ?? this.withdrawalDays,
      withdrawalDate: withdrawalDate ?? this.withdrawalDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (treatment.present) {
      map['treatment'] = Variable<String>(treatment.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (route.present) {
      map['route'] = Variable<String>(
        $TreatmentRecordsTable.$converterroute.toSql(route.value),
      );
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (withdrawalDays.present) {
      map['withdrawal_days'] = Variable<int>(withdrawalDays.value);
    }
    if (withdrawalDate.present) {
      map['withdrawal_date'] = Variable<DateTime>(withdrawalDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $TreatmentRecordsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentRecordsCompanion(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('date: $date, ')
          ..write('treatment: $treatment, ')
          ..write('dosage: $dosage, ')
          ..write('route: $route, ')
          ..write('reason: $reason, ')
          ..write('withdrawalDays: $withdrawalDays, ')
          ..write('withdrawalDate: $withdrawalDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeightRecordsTable extends WeightRecords
    with TableInfo<$WeightRecordsTable, WeightRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animalIdMeta = const VerificationMeta(
    'animalId',
  );
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
    'animal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animals (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('synced'),
      ).withConverter<SyncStatus>($WeightRecordsTable.$convertersyncStatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    animalId,
    date,
    weight,
    notes,
    createdAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeightRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(
        _animalIdMeta,
        animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      animalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: $WeightRecordsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
    );
  }

  @override
  $WeightRecordsTable createAlias(String alias) {
    return $WeightRecordsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class WeightRecord extends DataClass implements Insertable<WeightRecord> {
  final String id;
  final String animalId;
  final DateTime date;
  final double weight;
  final String notes;
  final DateTime createdAt;
  final SyncStatus syncStatus;
  const WeightRecord({
    required this.id,
    required this.animalId,
    required this.date,
    required this.weight,
    required this.notes,
    required this.createdAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['animal_id'] = Variable<String>(animalId);
    map['date'] = Variable<DateTime>(date);
    map['weight'] = Variable<double>(weight);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    {
      map['sync_status'] = Variable<String>(
        $WeightRecordsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    return map;
  }

  WeightRecordsCompanion toCompanion(bool nullToAbsent) {
    return WeightRecordsCompanion(
      id: Value(id),
      animalId: Value(animalId),
      date: Value(date),
      weight: Value(weight),
      notes: Value(notes),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory WeightRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightRecord(
      id: serializer.fromJson<String>(json['id']),
      animalId: serializer.fromJson<String>(json['animalId']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double>(json['weight']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'animalId': serializer.toJson<String>(animalId),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double>(weight),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
    };
  }

  WeightRecord copyWith({
    String? id,
    String? animalId,
    DateTime? date,
    double? weight,
    String? notes,
    DateTime? createdAt,
    SyncStatus? syncStatus,
  }) => WeightRecord(
    id: id ?? this.id,
    animalId: animalId ?? this.animalId,
    date: date ?? this.date,
    weight: weight ?? this.weight,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  WeightRecord copyWithCompanion(WeightRecordsCompanion data) {
    return WeightRecord(
      id: data.id.present ? data.id.value : this.id,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightRecord(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, animalId, date, weight, notes, createdAt, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightRecord &&
          other.id == this.id &&
          other.animalId == this.animalId &&
          other.date == this.date &&
          other.weight == this.weight &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class WeightRecordsCompanion extends UpdateCompanion<WeightRecord> {
  final Value<String> id;
  final Value<String> animalId;
  final Value<DateTime> date;
  final Value<double> weight;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> rowid;
  const WeightRecordsCompanion({
    this.id = const Value.absent(),
    this.animalId = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeightRecordsCompanion.insert({
    required String id,
    required String animalId,
    required DateTime date,
    required double weight,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       animalId = Value(animalId),
       date = Value(date),
       weight = Value(weight),
       createdAt = Value(createdAt);
  static Insertable<WeightRecord> custom({
    Expression<String>? id,
    Expression<String>? animalId,
    Expression<DateTime>? date,
    Expression<double>? weight,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (animalId != null) 'animal_id': animalId,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeightRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? animalId,
    Value<DateTime>? date,
    Value<double>? weight,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? rowid,
  }) {
    return WeightRecordsCompanion(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $WeightRecordsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightRecordsCompanion(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PriceAlertsTable extends PriceAlerts
    with TableInfo<$PriceAlertsTable, PriceAlert> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PriceAlertsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PriceAlertType, String>
  alertType = GeneratedColumn<String>(
    'alert_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<PriceAlertType>($PriceAlertsTable.$converteralertType);
  static const VerificationMeta _weightClassMeta = const VerificationMeta(
    'weightClass',
  );
  @override
  late final GeneratedColumn<String> weightClass = GeneratedColumn<String>(
    'weight_class',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetPriceMeta = const VerificationMeta(
    'targetPrice',
  );
  @override
  late final GeneratedColumn<double> targetPrice = GeneratedColumn<double>(
    'target_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAboveTargetMeta = const VerificationMeta(
    'isAboveTarget',
  );
  @override
  late final GeneratedColumn<bool> isAboveTarget = GeneratedColumn<bool>(
    'is_above_target',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_above_target" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastTriggeredMeta = const VerificationMeta(
    'lastTriggered',
  );
  @override
  late final GeneratedColumn<DateTime> lastTriggered =
      GeneratedColumn<DateTime>(
        'last_triggered',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    alertType,
    weightClass,
    targetPrice,
    isAboveTarget,
    isEnabled,
    lastTriggered,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_alerts';
  @override
  VerificationContext validateIntegrity(
    Insertable<PriceAlert> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('weight_class')) {
      context.handle(
        _weightClassMeta,
        weightClass.isAcceptableOrUnknown(
          data['weight_class']!,
          _weightClassMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weightClassMeta);
    }
    if (data.containsKey('target_price')) {
      context.handle(
        _targetPriceMeta,
        targetPrice.isAcceptableOrUnknown(
          data['target_price']!,
          _targetPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetPriceMeta);
    }
    if (data.containsKey('is_above_target')) {
      context.handle(
        _isAboveTargetMeta,
        isAboveTarget.isAcceptableOrUnknown(
          data['is_above_target']!,
          _isAboveTargetMeta,
        ),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('last_triggered')) {
      context.handle(
        _lastTriggeredMeta,
        lastTriggered.isAcceptableOrUnknown(
          data['last_triggered']!,
          _lastTriggeredMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PriceAlert map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceAlert(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      alertType: $PriceAlertsTable.$converteralertType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}alert_type'],
        )!,
      ),
      weightClass: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weight_class'],
      )!,
      targetPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_price'],
      )!,
      isAboveTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_above_target'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      lastTriggered: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_triggered'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PriceAlertsTable createAlias(String alias) {
    return $PriceAlertsTable(attachedDatabase, alias);
  }

  static TypeConverter<PriceAlertType, String> $converteralertType =
      const PriceAlertTypeConverter();
}

class PriceAlert extends DataClass implements Insertable<PriceAlert> {
  final String id;
  final PriceAlertType alertType;
  final String weightClass;
  final double targetPrice;
  final bool isAboveTarget;
  final bool isEnabled;
  final DateTime? lastTriggered;
  final DateTime createdAt;
  const PriceAlert({
    required this.id,
    required this.alertType,
    required this.weightClass,
    required this.targetPrice,
    required this.isAboveTarget,
    required this.isEnabled,
    this.lastTriggered,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['alert_type'] = Variable<String>(
        $PriceAlertsTable.$converteralertType.toSql(alertType),
      );
    }
    map['weight_class'] = Variable<String>(weightClass);
    map['target_price'] = Variable<double>(targetPrice);
    map['is_above_target'] = Variable<bool>(isAboveTarget);
    map['is_enabled'] = Variable<bool>(isEnabled);
    if (!nullToAbsent || lastTriggered != null) {
      map['last_triggered'] = Variable<DateTime>(lastTriggered);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PriceAlertsCompanion toCompanion(bool nullToAbsent) {
    return PriceAlertsCompanion(
      id: Value(id),
      alertType: Value(alertType),
      weightClass: Value(weightClass),
      targetPrice: Value(targetPrice),
      isAboveTarget: Value(isAboveTarget),
      isEnabled: Value(isEnabled),
      lastTriggered: lastTriggered == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTriggered),
      createdAt: Value(createdAt),
    );
  }

  factory PriceAlert.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PriceAlert(
      id: serializer.fromJson<String>(json['id']),
      alertType: serializer.fromJson<PriceAlertType>(json['alertType']),
      weightClass: serializer.fromJson<String>(json['weightClass']),
      targetPrice: serializer.fromJson<double>(json['targetPrice']),
      isAboveTarget: serializer.fromJson<bool>(json['isAboveTarget']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      lastTriggered: serializer.fromJson<DateTime?>(json['lastTriggered']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'alertType': serializer.toJson<PriceAlertType>(alertType),
      'weightClass': serializer.toJson<String>(weightClass),
      'targetPrice': serializer.toJson<double>(targetPrice),
      'isAboveTarget': serializer.toJson<bool>(isAboveTarget),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'lastTriggered': serializer.toJson<DateTime?>(lastTriggered),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PriceAlert copyWith({
    String? id,
    PriceAlertType? alertType,
    String? weightClass,
    double? targetPrice,
    bool? isAboveTarget,
    bool? isEnabled,
    Value<DateTime?> lastTriggered = const Value.absent(),
    DateTime? createdAt,
  }) => PriceAlert(
    id: id ?? this.id,
    alertType: alertType ?? this.alertType,
    weightClass: weightClass ?? this.weightClass,
    targetPrice: targetPrice ?? this.targetPrice,
    isAboveTarget: isAboveTarget ?? this.isAboveTarget,
    isEnabled: isEnabled ?? this.isEnabled,
    lastTriggered: lastTriggered.present
        ? lastTriggered.value
        : this.lastTriggered,
    createdAt: createdAt ?? this.createdAt,
  );
  PriceAlert copyWithCompanion(PriceAlertsCompanion data) {
    return PriceAlert(
      id: data.id.present ? data.id.value : this.id,
      alertType: data.alertType.present ? data.alertType.value : this.alertType,
      weightClass: data.weightClass.present
          ? data.weightClass.value
          : this.weightClass,
      targetPrice: data.targetPrice.present
          ? data.targetPrice.value
          : this.targetPrice,
      isAboveTarget: data.isAboveTarget.present
          ? data.isAboveTarget.value
          : this.isAboveTarget,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      lastTriggered: data.lastTriggered.present
          ? data.lastTriggered.value
          : this.lastTriggered,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PriceAlert(')
          ..write('id: $id, ')
          ..write('alertType: $alertType, ')
          ..write('weightClass: $weightClass, ')
          ..write('targetPrice: $targetPrice, ')
          ..write('isAboveTarget: $isAboveTarget, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('lastTriggered: $lastTriggered, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    alertType,
    weightClass,
    targetPrice,
    isAboveTarget,
    isEnabled,
    lastTriggered,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PriceAlert &&
          other.id == this.id &&
          other.alertType == this.alertType &&
          other.weightClass == this.weightClass &&
          other.targetPrice == this.targetPrice &&
          other.isAboveTarget == this.isAboveTarget &&
          other.isEnabled == this.isEnabled &&
          other.lastTriggered == this.lastTriggered &&
          other.createdAt == this.createdAt);
}

class PriceAlertsCompanion extends UpdateCompanion<PriceAlert> {
  final Value<String> id;
  final Value<PriceAlertType> alertType;
  final Value<String> weightClass;
  final Value<double> targetPrice;
  final Value<bool> isAboveTarget;
  final Value<bool> isEnabled;
  final Value<DateTime?> lastTriggered;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PriceAlertsCompanion({
    this.id = const Value.absent(),
    this.alertType = const Value.absent(),
    this.weightClass = const Value.absent(),
    this.targetPrice = const Value.absent(),
    this.isAboveTarget = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.lastTriggered = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PriceAlertsCompanion.insert({
    required String id,
    required PriceAlertType alertType,
    required String weightClass,
    required double targetPrice,
    this.isAboveTarget = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.lastTriggered = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       alertType = Value(alertType),
       weightClass = Value(weightClass),
       targetPrice = Value(targetPrice),
       createdAt = Value(createdAt);
  static Insertable<PriceAlert> custom({
    Expression<String>? id,
    Expression<String>? alertType,
    Expression<String>? weightClass,
    Expression<double>? targetPrice,
    Expression<bool>? isAboveTarget,
    Expression<bool>? isEnabled,
    Expression<DateTime>? lastTriggered,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (alertType != null) 'alert_type': alertType,
      if (weightClass != null) 'weight_class': weightClass,
      if (targetPrice != null) 'target_price': targetPrice,
      if (isAboveTarget != null) 'is_above_target': isAboveTarget,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (lastTriggered != null) 'last_triggered': lastTriggered,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PriceAlertsCompanion copyWith({
    Value<String>? id,
    Value<PriceAlertType>? alertType,
    Value<String>? weightClass,
    Value<double>? targetPrice,
    Value<bool>? isAboveTarget,
    Value<bool>? isEnabled,
    Value<DateTime?>? lastTriggered,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PriceAlertsCompanion(
      id: id ?? this.id,
      alertType: alertType ?? this.alertType,
      weightClass: weightClass ?? this.weightClass,
      targetPrice: targetPrice ?? this.targetPrice,
      isAboveTarget: isAboveTarget ?? this.isAboveTarget,
      isEnabled: isEnabled ?? this.isEnabled,
      lastTriggered: lastTriggered ?? this.lastTriggered,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (alertType.present) {
      map['alert_type'] = Variable<String>(
        $PriceAlertsTable.$converteralertType.toSql(alertType.value),
      );
    }
    if (weightClass.present) {
      map['weight_class'] = Variable<String>(weightClass.value);
    }
    if (targetPrice.present) {
      map['target_price'] = Variable<double>(targetPrice.value);
    }
    if (isAboveTarget.present) {
      map['is_above_target'] = Variable<bool>(isAboveTarget.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (lastTriggered.present) {
      map['last_triggered'] = Variable<DateTime>(lastTriggered.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PriceAlertsCompanion(')
          ..write('id: $id, ')
          ..write('alertType: $alertType, ')
          ..write('weightClass: $weightClass, ')
          ..write('targetPrice: $targetPrice, ')
          ..write('isAboveTarget: $isAboveTarget, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('lastTriggered: $lastTriggered, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RanchSettingsTable extends RanchSettings
    with TableInfo<$RanchSettingsTable, RanchSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RanchSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ranchNameMeta = const VerificationMeta(
    'ranchName',
  );
  @override
  late final GeneratedColumn<String> ranchName = GeneratedColumn<String>(
    'ranch_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('My Ranch'),
  );
  static const VerificationMeta _locationLatitudeMeta = const VerificationMeta(
    'locationLatitude',
  );
  @override
  late final GeneratedColumn<double> locationLatitude = GeneratedColumn<double>(
    'location_latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationLongitudeMeta = const VerificationMeta(
    'locationLongitude',
  );
  @override
  late final GeneratedColumn<double> locationLongitude =
      GeneratedColumn<double>(
        'location_longitude',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _locationNameMeta = const VerificationMeta(
    'locationName',
  );
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
    'location_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _priceAlertsEnabledMeta =
      const VerificationMeta('priceAlertsEnabled');
  @override
  late final GeneratedColumn<bool> priceAlertsEnabled = GeneratedColumn<bool>(
    'price_alerts_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("price_alerts_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _weatherAlertsEnabledMeta =
      const VerificationMeta('weatherAlertsEnabled');
  @override
  late final GeneratedColumn<bool> weatherAlertsEnabled = GeneratedColumn<bool>(
    'weather_alerts_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("weather_alerts_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _severeWeatherAlertsEnabledMeta =
      const VerificationMeta('severeWeatherAlertsEnabled');
  @override
  late final GeneratedColumn<bool> severeWeatherAlertsEnabled =
      GeneratedColumn<bool>(
        'severe_weather_alerts_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("severe_weather_alerts_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ranchName,
    locationLatitude,
    locationLongitude,
    locationName,
    notificationsEnabled,
    priceAlertsEnabled,
    weatherAlertsEnabled,
    severeWeatherAlertsEnabled,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ranch_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<RanchSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ranch_name')) {
      context.handle(
        _ranchNameMeta,
        ranchName.isAcceptableOrUnknown(data['ranch_name']!, _ranchNameMeta),
      );
    }
    if (data.containsKey('location_latitude')) {
      context.handle(
        _locationLatitudeMeta,
        locationLatitude.isAcceptableOrUnknown(
          data['location_latitude']!,
          _locationLatitudeMeta,
        ),
      );
    }
    if (data.containsKey('location_longitude')) {
      context.handle(
        _locationLongitudeMeta,
        locationLongitude.isAcceptableOrUnknown(
          data['location_longitude']!,
          _locationLongitudeMeta,
        ),
      );
    }
    if (data.containsKey('location_name')) {
      context.handle(
        _locationNameMeta,
        locationName.isAcceptableOrUnknown(
          data['location_name']!,
          _locationNameMeta,
        ),
      );
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
        _notificationsEnabledMeta,
        notificationsEnabled.isAcceptableOrUnknown(
          data['notifications_enabled']!,
          _notificationsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('price_alerts_enabled')) {
      context.handle(
        _priceAlertsEnabledMeta,
        priceAlertsEnabled.isAcceptableOrUnknown(
          data['price_alerts_enabled']!,
          _priceAlertsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('weather_alerts_enabled')) {
      context.handle(
        _weatherAlertsEnabledMeta,
        weatherAlertsEnabled.isAcceptableOrUnknown(
          data['weather_alerts_enabled']!,
          _weatherAlertsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('severe_weather_alerts_enabled')) {
      context.handle(
        _severeWeatherAlertsEnabledMeta,
        severeWeatherAlertsEnabled.isAcceptableOrUnknown(
          data['severe_weather_alerts_enabled']!,
          _severeWeatherAlertsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RanchSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RanchSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ranchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ranch_name'],
      )!,
      locationLatitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}location_latitude'],
      ),
      locationLongitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}location_longitude'],
      ),
      locationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_name'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
      priceAlertsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}price_alerts_enabled'],
      )!,
      weatherAlertsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}weather_alerts_enabled'],
      )!,
      severeWeatherAlertsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}severe_weather_alerts_enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RanchSettingsTable createAlias(String alias) {
    return $RanchSettingsTable(attachedDatabase, alias);
  }
}

class RanchSetting extends DataClass implements Insertable<RanchSetting> {
  final String id;
  final String ranchName;
  final double? locationLatitude;
  final double? locationLongitude;
  final String locationName;
  final bool notificationsEnabled;
  final bool priceAlertsEnabled;
  final bool weatherAlertsEnabled;
  final bool severeWeatherAlertsEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RanchSetting({
    required this.id,
    required this.ranchName,
    this.locationLatitude,
    this.locationLongitude,
    required this.locationName,
    required this.notificationsEnabled,
    required this.priceAlertsEnabled,
    required this.weatherAlertsEnabled,
    required this.severeWeatherAlertsEnabled,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ranch_name'] = Variable<String>(ranchName);
    if (!nullToAbsent || locationLatitude != null) {
      map['location_latitude'] = Variable<double>(locationLatitude);
    }
    if (!nullToAbsent || locationLongitude != null) {
      map['location_longitude'] = Variable<double>(locationLongitude);
    }
    map['location_name'] = Variable<String>(locationName);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['price_alerts_enabled'] = Variable<bool>(priceAlertsEnabled);
    map['weather_alerts_enabled'] = Variable<bool>(weatherAlertsEnabled);
    map['severe_weather_alerts_enabled'] = Variable<bool>(
      severeWeatherAlertsEnabled,
    );
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RanchSettingsCompanion toCompanion(bool nullToAbsent) {
    return RanchSettingsCompanion(
      id: Value(id),
      ranchName: Value(ranchName),
      locationLatitude: locationLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLatitude),
      locationLongitude: locationLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLongitude),
      locationName: Value(locationName),
      notificationsEnabled: Value(notificationsEnabled),
      priceAlertsEnabled: Value(priceAlertsEnabled),
      weatherAlertsEnabled: Value(weatherAlertsEnabled),
      severeWeatherAlertsEnabled: Value(severeWeatherAlertsEnabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RanchSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RanchSetting(
      id: serializer.fromJson<String>(json['id']),
      ranchName: serializer.fromJson<String>(json['ranchName']),
      locationLatitude: serializer.fromJson<double?>(json['locationLatitude']),
      locationLongitude: serializer.fromJson<double?>(
        json['locationLongitude'],
      ),
      locationName: serializer.fromJson<String>(json['locationName']),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
      priceAlertsEnabled: serializer.fromJson<bool>(json['priceAlertsEnabled']),
      weatherAlertsEnabled: serializer.fromJson<bool>(
        json['weatherAlertsEnabled'],
      ),
      severeWeatherAlertsEnabled: serializer.fromJson<bool>(
        json['severeWeatherAlertsEnabled'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ranchName': serializer.toJson<String>(ranchName),
      'locationLatitude': serializer.toJson<double?>(locationLatitude),
      'locationLongitude': serializer.toJson<double?>(locationLongitude),
      'locationName': serializer.toJson<String>(locationName),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'priceAlertsEnabled': serializer.toJson<bool>(priceAlertsEnabled),
      'weatherAlertsEnabled': serializer.toJson<bool>(weatherAlertsEnabled),
      'severeWeatherAlertsEnabled': serializer.toJson<bool>(
        severeWeatherAlertsEnabled,
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RanchSetting copyWith({
    String? id,
    String? ranchName,
    Value<double?> locationLatitude = const Value.absent(),
    Value<double?> locationLongitude = const Value.absent(),
    String? locationName,
    bool? notificationsEnabled,
    bool? priceAlertsEnabled,
    bool? weatherAlertsEnabled,
    bool? severeWeatherAlertsEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RanchSetting(
    id: id ?? this.id,
    ranchName: ranchName ?? this.ranchName,
    locationLatitude: locationLatitude.present
        ? locationLatitude.value
        : this.locationLatitude,
    locationLongitude: locationLongitude.present
        ? locationLongitude.value
        : this.locationLongitude,
    locationName: locationName ?? this.locationName,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    priceAlertsEnabled: priceAlertsEnabled ?? this.priceAlertsEnabled,
    weatherAlertsEnabled: weatherAlertsEnabled ?? this.weatherAlertsEnabled,
    severeWeatherAlertsEnabled:
        severeWeatherAlertsEnabled ?? this.severeWeatherAlertsEnabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RanchSetting copyWithCompanion(RanchSettingsCompanion data) {
    return RanchSetting(
      id: data.id.present ? data.id.value : this.id,
      ranchName: data.ranchName.present ? data.ranchName.value : this.ranchName,
      locationLatitude: data.locationLatitude.present
          ? data.locationLatitude.value
          : this.locationLatitude,
      locationLongitude: data.locationLongitude.present
          ? data.locationLongitude.value
          : this.locationLongitude,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      priceAlertsEnabled: data.priceAlertsEnabled.present
          ? data.priceAlertsEnabled.value
          : this.priceAlertsEnabled,
      weatherAlertsEnabled: data.weatherAlertsEnabled.present
          ? data.weatherAlertsEnabled.value
          : this.weatherAlertsEnabled,
      severeWeatherAlertsEnabled: data.severeWeatherAlertsEnabled.present
          ? data.severeWeatherAlertsEnabled.value
          : this.severeWeatherAlertsEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RanchSetting(')
          ..write('id: $id, ')
          ..write('ranchName: $ranchName, ')
          ..write('locationLatitude: $locationLatitude, ')
          ..write('locationLongitude: $locationLongitude, ')
          ..write('locationName: $locationName, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('priceAlertsEnabled: $priceAlertsEnabled, ')
          ..write('weatherAlertsEnabled: $weatherAlertsEnabled, ')
          ..write('severeWeatherAlertsEnabled: $severeWeatherAlertsEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ranchName,
    locationLatitude,
    locationLongitude,
    locationName,
    notificationsEnabled,
    priceAlertsEnabled,
    weatherAlertsEnabled,
    severeWeatherAlertsEnabled,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RanchSetting &&
          other.id == this.id &&
          other.ranchName == this.ranchName &&
          other.locationLatitude == this.locationLatitude &&
          other.locationLongitude == this.locationLongitude &&
          other.locationName == this.locationName &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.priceAlertsEnabled == this.priceAlertsEnabled &&
          other.weatherAlertsEnabled == this.weatherAlertsEnabled &&
          other.severeWeatherAlertsEnabled == this.severeWeatherAlertsEnabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RanchSettingsCompanion extends UpdateCompanion<RanchSetting> {
  final Value<String> id;
  final Value<String> ranchName;
  final Value<double?> locationLatitude;
  final Value<double?> locationLongitude;
  final Value<String> locationName;
  final Value<bool> notificationsEnabled;
  final Value<bool> priceAlertsEnabled;
  final Value<bool> weatherAlertsEnabled;
  final Value<bool> severeWeatherAlertsEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RanchSettingsCompanion({
    this.id = const Value.absent(),
    this.ranchName = const Value.absent(),
    this.locationLatitude = const Value.absent(),
    this.locationLongitude = const Value.absent(),
    this.locationName = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.priceAlertsEnabled = const Value.absent(),
    this.weatherAlertsEnabled = const Value.absent(),
    this.severeWeatherAlertsEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RanchSettingsCompanion.insert({
    required String id,
    this.ranchName = const Value.absent(),
    this.locationLatitude = const Value.absent(),
    this.locationLongitude = const Value.absent(),
    this.locationName = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.priceAlertsEnabled = const Value.absent(),
    this.weatherAlertsEnabled = const Value.absent(),
    this.severeWeatherAlertsEnabled = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RanchSetting> custom({
    Expression<String>? id,
    Expression<String>? ranchName,
    Expression<double>? locationLatitude,
    Expression<double>? locationLongitude,
    Expression<String>? locationName,
    Expression<bool>? notificationsEnabled,
    Expression<bool>? priceAlertsEnabled,
    Expression<bool>? weatherAlertsEnabled,
    Expression<bool>? severeWeatherAlertsEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ranchName != null) 'ranch_name': ranchName,
      if (locationLatitude != null) 'location_latitude': locationLatitude,
      if (locationLongitude != null) 'location_longitude': locationLongitude,
      if (locationName != null) 'location_name': locationName,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (priceAlertsEnabled != null)
        'price_alerts_enabled': priceAlertsEnabled,
      if (weatherAlertsEnabled != null)
        'weather_alerts_enabled': weatherAlertsEnabled,
      if (severeWeatherAlertsEnabled != null)
        'severe_weather_alerts_enabled': severeWeatherAlertsEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RanchSettingsCompanion copyWith({
    Value<String>? id,
    Value<String>? ranchName,
    Value<double?>? locationLatitude,
    Value<double?>? locationLongitude,
    Value<String>? locationName,
    Value<bool>? notificationsEnabled,
    Value<bool>? priceAlertsEnabled,
    Value<bool>? weatherAlertsEnabled,
    Value<bool>? severeWeatherAlertsEnabled,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RanchSettingsCompanion(
      id: id ?? this.id,
      ranchName: ranchName ?? this.ranchName,
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      locationName: locationName ?? this.locationName,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      priceAlertsEnabled: priceAlertsEnabled ?? this.priceAlertsEnabled,
      weatherAlertsEnabled: weatherAlertsEnabled ?? this.weatherAlertsEnabled,
      severeWeatherAlertsEnabled:
          severeWeatherAlertsEnabled ?? this.severeWeatherAlertsEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ranchName.present) {
      map['ranch_name'] = Variable<String>(ranchName.value);
    }
    if (locationLatitude.present) {
      map['location_latitude'] = Variable<double>(locationLatitude.value);
    }
    if (locationLongitude.present) {
      map['location_longitude'] = Variable<double>(locationLongitude.value);
    }
    if (locationName.present) {
      map['location_name'] = Variable<String>(locationName.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (priceAlertsEnabled.present) {
      map['price_alerts_enabled'] = Variable<bool>(priceAlertsEnabled.value);
    }
    if (weatherAlertsEnabled.present) {
      map['weather_alerts_enabled'] = Variable<bool>(
        weatherAlertsEnabled.value,
      );
    }
    if (severeWeatherAlertsEnabled.present) {
      map['severe_weather_alerts_enabled'] = Variable<bool>(
        severeWeatherAlertsEnabled.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RanchSettingsCompanion(')
          ..write('id: $id, ')
          ..write('ranchName: $ranchName, ')
          ..write('locationLatitude: $locationLatitude, ')
          ..write('locationLongitude: $locationLongitude, ')
          ..write('locationName: $locationName, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('priceAlertsEnabled: $priceAlertsEnabled, ')
          ..write('weatherAlertsEnabled: $weatherAlertsEnabled, ')
          ..write('severeWeatherAlertsEnabled: $severeWeatherAlertsEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PasturesTable extends Pastures with TableInfo<$PasturesTable, Pasture> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PasturesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _boundaryJsonMeta = const VerificationMeta(
    'boundaryJson',
  );
  @override
  late final GeneratedColumn<String> boundaryJson = GeneratedColumn<String>(
    'boundary_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _acreageMeta = const VerificationMeta(
    'acreage',
  );
  @override
  late final GeneratedColumn<double> acreage = GeneratedColumn<double>(
    'acreage',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('synced'),
      ).withConverter<SyncStatus>($PasturesTable.$convertersyncStatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    boundaryJson,
    acreage,
    notes,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pastures';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pasture> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('boundary_json')) {
      context.handle(
        _boundaryJsonMeta,
        boundaryJson.isAcceptableOrUnknown(
          data['boundary_json']!,
          _boundaryJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_boundaryJsonMeta);
    }
    if (data.containsKey('acreage')) {
      context.handle(
        _acreageMeta,
        acreage.isAcceptableOrUnknown(data['acreage']!, _acreageMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pasture map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pasture(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      boundaryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}boundary_json'],
      )!,
      acreage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}acreage'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: $PasturesTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
    );
  }

  @override
  $PasturesTable createAlias(String alias) {
    return $PasturesTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class Pasture extends DataClass implements Insertable<Pasture> {
  final String id;
  final String name;
  final String boundaryJson;
  final double? acreage;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SyncStatus syncStatus;
  const Pasture({
    required this.id,
    required this.name,
    required this.boundaryJson,
    this.acreage,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['boundary_json'] = Variable<String>(boundaryJson);
    if (!nullToAbsent || acreage != null) {
      map['acreage'] = Variable<double>(acreage);
    }
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    {
      map['sync_status'] = Variable<String>(
        $PasturesTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    return map;
  }

  PasturesCompanion toCompanion(bool nullToAbsent) {
    return PasturesCompanion(
      id: Value(id),
      name: Value(name),
      boundaryJson: Value(boundaryJson),
      acreage: acreage == null && nullToAbsent
          ? const Value.absent()
          : Value(acreage),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory Pasture.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pasture(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      boundaryJson: serializer.fromJson<String>(json['boundaryJson']),
      acreage: serializer.fromJson<double?>(json['acreage']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'boundaryJson': serializer.toJson<String>(boundaryJson),
      'acreage': serializer.toJson<double?>(acreage),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
    };
  }

  Pasture copyWith({
    String? id,
    String? name,
    String? boundaryJson,
    Value<double?> acreage = const Value.absent(),
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
  }) => Pasture(
    id: id ?? this.id,
    name: name ?? this.name,
    boundaryJson: boundaryJson ?? this.boundaryJson,
    acreage: acreage.present ? acreage.value : this.acreage,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  Pasture copyWithCompanion(PasturesCompanion data) {
    return Pasture(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      boundaryJson: data.boundaryJson.present
          ? data.boundaryJson.value
          : this.boundaryJson,
      acreage: data.acreage.present ? data.acreage.value : this.acreage,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pasture(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('boundaryJson: $boundaryJson, ')
          ..write('acreage: $acreage, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    boundaryJson,
    acreage,
    notes,
    createdAt,
    updatedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pasture &&
          other.id == this.id &&
          other.name == this.name &&
          other.boundaryJson == this.boundaryJson &&
          other.acreage == this.acreage &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class PasturesCompanion extends UpdateCompanion<Pasture> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> boundaryJson;
  final Value<double?> acreage;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> rowid;
  const PasturesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.boundaryJson = const Value.absent(),
    this.acreage = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PasturesCompanion.insert({
    required String id,
    required String name,
    required String boundaryJson,
    this.acreage = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       boundaryJson = Value(boundaryJson),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Pasture> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? boundaryJson,
    Expression<double>? acreage,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (boundaryJson != null) 'boundary_json': boundaryJson,
      if (acreage != null) 'acreage': acreage,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PasturesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? boundaryJson,
    Value<double?>? acreage,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? rowid,
  }) {
    return PasturesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      boundaryJson: boundaryJson ?? this.boundaryJson,
      acreage: acreage ?? this.acreage,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (boundaryJson.present) {
      map['boundary_json'] = Variable<String>(boundaryJson.value);
    }
    if (acreage.present) {
      map['acreage'] = Variable<double>(acreage.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $PasturesTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PasturesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('boundaryJson: $boundaryJson, ')
          ..write('acreage: $acreage, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GrazingRotationsTable extends GrazingRotations
    with TableInfo<$GrazingRotationsTable, GrazingRotation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrazingRotationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pastureIdMeta = const VerificationMeta(
    'pastureId',
  );
  @override
  late final GeneratedColumn<String> pastureId = GeneratedColumn<String>(
    'pasture_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pastures (id)',
    ),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _animalIdsMeta = const VerificationMeta(
    'animalIds',
  );
  @override
  late final GeneratedColumn<String> animalIds = GeneratedColumn<String>(
    'animal_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('synced'),
      ).withConverter<SyncStatus>($GrazingRotationsTable.$convertersyncStatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pastureId,
    startDate,
    endDate,
    animalIds,
    notes,
    createdAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grazing_rotations';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrazingRotation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pasture_id')) {
      context.handle(
        _pastureIdMeta,
        pastureId.isAcceptableOrUnknown(data['pasture_id']!, _pastureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pastureIdMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('animal_ids')) {
      context.handle(
        _animalIdsMeta,
        animalIds.isAcceptableOrUnknown(data['animal_ids']!, _animalIdsMeta),
      );
    } else if (isInserting) {
      context.missing(_animalIdsMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrazingRotation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrazingRotation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pastureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pasture_id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      animalIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_ids'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: $GrazingRotationsTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
    );
  }

  @override
  $GrazingRotationsTable createAlias(String alias) {
    return $GrazingRotationsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class GrazingRotation extends DataClass implements Insertable<GrazingRotation> {
  final String id;
  final String pastureId;
  final DateTime startDate;
  final DateTime? endDate;
  final String animalIds;
  final String notes;
  final DateTime createdAt;
  final SyncStatus syncStatus;
  const GrazingRotation({
    required this.id,
    required this.pastureId,
    required this.startDate,
    this.endDate,
    required this.animalIds,
    required this.notes,
    required this.createdAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pasture_id'] = Variable<String>(pastureId);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['animal_ids'] = Variable<String>(animalIds);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    {
      map['sync_status'] = Variable<String>(
        $GrazingRotationsTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    return map;
  }

  GrazingRotationsCompanion toCompanion(bool nullToAbsent) {
    return GrazingRotationsCompanion(
      id: Value(id),
      pastureId: Value(pastureId),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      animalIds: Value(animalIds),
      notes: Value(notes),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory GrazingRotation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrazingRotation(
      id: serializer.fromJson<String>(json['id']),
      pastureId: serializer.fromJson<String>(json['pastureId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      animalIds: serializer.fromJson<String>(json['animalIds']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pastureId': serializer.toJson<String>(pastureId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'animalIds': serializer.toJson<String>(animalIds),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
    };
  }

  GrazingRotation copyWith({
    String? id,
    String? pastureId,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    String? animalIds,
    String? notes,
    DateTime? createdAt,
    SyncStatus? syncStatus,
  }) => GrazingRotation(
    id: id ?? this.id,
    pastureId: pastureId ?? this.pastureId,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    animalIds: animalIds ?? this.animalIds,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  GrazingRotation copyWithCompanion(GrazingRotationsCompanion data) {
    return GrazingRotation(
      id: data.id.present ? data.id.value : this.id,
      pastureId: data.pastureId.present ? data.pastureId.value : this.pastureId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      animalIds: data.animalIds.present ? data.animalIds.value : this.animalIds,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrazingRotation(')
          ..write('id: $id, ')
          ..write('pastureId: $pastureId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('animalIds: $animalIds, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pastureId,
    startDate,
    endDate,
    animalIds,
    notes,
    createdAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrazingRotation &&
          other.id == this.id &&
          other.pastureId == this.pastureId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.animalIds == this.animalIds &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class GrazingRotationsCompanion extends UpdateCompanion<GrazingRotation> {
  final Value<String> id;
  final Value<String> pastureId;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<String> animalIds;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> rowid;
  const GrazingRotationsCompanion({
    this.id = const Value.absent(),
    this.pastureId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.animalIds = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GrazingRotationsCompanion.insert({
    required String id,
    required String pastureId,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    required String animalIds,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pastureId = Value(pastureId),
       startDate = Value(startDate),
       animalIds = Value(animalIds),
       createdAt = Value(createdAt);
  static Insertable<GrazingRotation> custom({
    Expression<String>? id,
    Expression<String>? pastureId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? animalIds,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pastureId != null) 'pasture_id': pastureId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (animalIds != null) 'animal_ids': animalIds,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GrazingRotationsCompanion copyWith({
    Value<String>? id,
    Value<String>? pastureId,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<String>? animalIds,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? rowid,
  }) {
    return GrazingRotationsCompanion(
      id: id ?? this.id,
      pastureId: pastureId ?? this.pastureId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      animalIds: animalIds ?? this.animalIds,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pastureId.present) {
      map['pasture_id'] = Variable<String>(pastureId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (animalIds.present) {
      map['animal_ids'] = Variable<String>(animalIds.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $GrazingRotationsTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrazingRotationsCompanion(')
          ..write('id: $id, ')
          ..write('pastureId: $pastureId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('animalIds: $animalIds, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmartTagReadingsTable extends SmartTagReadings
    with TableInfo<$SmartTagReadingsTable, SmartTagReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmartTagReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animalIdMeta = const VerificationMeta(
    'animalId',
  );
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
    'animal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animals (id)',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activityLevelMeta = const VerificationMeta(
    'activityLevel',
  );
  @override
  late final GeneratedColumn<double> activityLevel = GeneratedColumn<double>(
    'activity_level',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _batteryLevelMeta = const VerificationMeta(
    'batteryLevel',
  );
  @override
  late final GeneratedColumn<int> batteryLevel = GeneratedColumn<int>(
    'battery_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    animalId,
    timestamp,
    temperature,
    activityLevel,
    latitude,
    longitude,
    batteryLevel,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'smart_tag_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmartTagReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(
        _animalIdMeta,
        animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('activity_level')) {
      context.handle(
        _activityLevelMeta,
        activityLevel.isAcceptableOrUnknown(
          data['activity_level']!,
          _activityLevelMeta,
        ),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('battery_level')) {
      context.handle(
        _batteryLevelMeta,
        batteryLevel.isAcceptableOrUnknown(
          data['battery_level']!,
          _batteryLevelMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmartTagReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmartTagReading(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      animalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      ),
      activityLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}activity_level'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      batteryLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}battery_level'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SmartTagReadingsTable createAlias(String alias) {
    return $SmartTagReadingsTable(attachedDatabase, alias);
  }
}

class SmartTagReading extends DataClass implements Insertable<SmartTagReading> {
  final String id;
  final String animalId;
  final DateTime timestamp;
  final double? temperature;
  final double? activityLevel;
  final double? latitude;
  final double? longitude;
  final int? batteryLevel;
  final DateTime createdAt;
  const SmartTagReading({
    required this.id,
    required this.animalId,
    required this.timestamp,
    this.temperature,
    this.activityLevel,
    this.latitude,
    this.longitude,
    this.batteryLevel,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['animal_id'] = Variable<String>(animalId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<double>(temperature);
    }
    if (!nullToAbsent || activityLevel != null) {
      map['activity_level'] = Variable<double>(activityLevel);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || batteryLevel != null) {
      map['battery_level'] = Variable<int>(batteryLevel);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SmartTagReadingsCompanion toCompanion(bool nullToAbsent) {
    return SmartTagReadingsCompanion(
      id: Value(id),
      animalId: Value(animalId),
      timestamp: Value(timestamp),
      temperature: temperature == null && nullToAbsent
          ? const Value.absent()
          : Value(temperature),
      activityLevel: activityLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(activityLevel),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      batteryLevel: batteryLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(batteryLevel),
      createdAt: Value(createdAt),
    );
  }

  factory SmartTagReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmartTagReading(
      id: serializer.fromJson<String>(json['id']),
      animalId: serializer.fromJson<String>(json['animalId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      temperature: serializer.fromJson<double?>(json['temperature']),
      activityLevel: serializer.fromJson<double?>(json['activityLevel']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      batteryLevel: serializer.fromJson<int?>(json['batteryLevel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'animalId': serializer.toJson<String>(animalId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'temperature': serializer.toJson<double?>(temperature),
      'activityLevel': serializer.toJson<double?>(activityLevel),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'batteryLevel': serializer.toJson<int?>(batteryLevel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SmartTagReading copyWith({
    String? id,
    String? animalId,
    DateTime? timestamp,
    Value<double?> temperature = const Value.absent(),
    Value<double?> activityLevel = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<int?> batteryLevel = const Value.absent(),
    DateTime? createdAt,
  }) => SmartTagReading(
    id: id ?? this.id,
    animalId: animalId ?? this.animalId,
    timestamp: timestamp ?? this.timestamp,
    temperature: temperature.present ? temperature.value : this.temperature,
    activityLevel: activityLevel.present
        ? activityLevel.value
        : this.activityLevel,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    batteryLevel: batteryLevel.present ? batteryLevel.value : this.batteryLevel,
    createdAt: createdAt ?? this.createdAt,
  );
  SmartTagReading copyWithCompanion(SmartTagReadingsCompanion data) {
    return SmartTagReading(
      id: data.id.present ? data.id.value : this.id,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      activityLevel: data.activityLevel.present
          ? data.activityLevel.value
          : this.activityLevel,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      batteryLevel: data.batteryLevel.present
          ? data.batteryLevel.value
          : this.batteryLevel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmartTagReading(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('timestamp: $timestamp, ')
          ..write('temperature: $temperature, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    animalId,
    timestamp,
    temperature,
    activityLevel,
    latitude,
    longitude,
    batteryLevel,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmartTagReading &&
          other.id == this.id &&
          other.animalId == this.animalId &&
          other.timestamp == this.timestamp &&
          other.temperature == this.temperature &&
          other.activityLevel == this.activityLevel &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.batteryLevel == this.batteryLevel &&
          other.createdAt == this.createdAt);
}

class SmartTagReadingsCompanion extends UpdateCompanion<SmartTagReading> {
  final Value<String> id;
  final Value<String> animalId;
  final Value<DateTime> timestamp;
  final Value<double?> temperature;
  final Value<double?> activityLevel;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<int?> batteryLevel;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SmartTagReadingsCompanion({
    this.id = const Value.absent(),
    this.animalId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.temperature = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmartTagReadingsCompanion.insert({
    required String id,
    required String animalId,
    required DateTime timestamp,
    this.temperature = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       animalId = Value(animalId),
       timestamp = Value(timestamp),
       createdAt = Value(createdAt);
  static Insertable<SmartTagReading> custom({
    Expression<String>? id,
    Expression<String>? animalId,
    Expression<DateTime>? timestamp,
    Expression<double>? temperature,
    Expression<double>? activityLevel,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<int>? batteryLevel,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (animalId != null) 'animal_id': animalId,
      if (timestamp != null) 'timestamp': timestamp,
      if (temperature != null) 'temperature': temperature,
      if (activityLevel != null) 'activity_level': activityLevel,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (batteryLevel != null) 'battery_level': batteryLevel,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmartTagReadingsCompanion copyWith({
    Value<String>? id,
    Value<String>? animalId,
    Value<DateTime>? timestamp,
    Value<double?>? temperature,
    Value<double?>? activityLevel,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<int?>? batteryLevel,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SmartTagReadingsCompanion(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      timestamp: timestamp ?? this.timestamp,
      temperature: temperature ?? this.temperature,
      activityLevel: activityLevel ?? this.activityLevel,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (activityLevel.present) {
      map['activity_level'] = Variable<double>(activityLevel.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (batteryLevel.present) {
      map['battery_level'] = Variable<int>(batteryLevel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmartTagReadingsCompanion(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('timestamp: $timestamp, ')
          ..write('temperature: $temperature, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HealthAlertsTable extends HealthAlerts
    with TableInfo<$HealthAlertsTable, HealthAlert> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthAlertsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animalIdMeta = const VerificationMeta(
    'animalId',
  );
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
    'animal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animals (id)',
    ),
  );
  static const VerificationMeta _alertTypeMeta = const VerificationMeta(
    'alertType',
  );
  @override
  late final GeneratedColumn<String> alertType = GeneratedColumn<String>(
    'alert_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isResolvedMeta = const VerificationMeta(
    'isResolved',
  );
  @override
  late final GeneratedColumn<bool> isResolved = GeneratedColumn<bool>(
    'is_resolved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_resolved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
    'resolved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    animalId,
    alertType,
    message,
    isResolved,
    createdAt,
    resolvedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_alerts';
  @override
  VerificationContext validateIntegrity(
    Insertable<HealthAlert> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(
        _animalIdMeta,
        animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('alert_type')) {
      context.handle(
        _alertTypeMeta,
        alertType.isAcceptableOrUnknown(data['alert_type']!, _alertTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_alertTypeMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('is_resolved')) {
      context.handle(
        _isResolvedMeta,
        isResolved.isAcceptableOrUnknown(data['is_resolved']!, _isResolvedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthAlert map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthAlert(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      animalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_id'],
      )!,
      alertType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alert_type'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      isResolved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_resolved'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}resolved_at'],
      ),
    );
  }

  @override
  $HealthAlertsTable createAlias(String alias) {
    return $HealthAlertsTable(attachedDatabase, alias);
  }
}

class HealthAlert extends DataClass implements Insertable<HealthAlert> {
  final String id;
  final String animalId;
  final String alertType;
  final String message;
  final bool isResolved;
  final DateTime createdAt;
  final DateTime? resolvedAt;
  const HealthAlert({
    required this.id,
    required this.animalId,
    required this.alertType,
    required this.message,
    required this.isResolved,
    required this.createdAt,
    this.resolvedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['animal_id'] = Variable<String>(animalId);
    map['alert_type'] = Variable<String>(alertType);
    map['message'] = Variable<String>(message);
    map['is_resolved'] = Variable<bool>(isResolved);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt);
    }
    return map;
  }

  HealthAlertsCompanion toCompanion(bool nullToAbsent) {
    return HealthAlertsCompanion(
      id: Value(id),
      animalId: Value(animalId),
      alertType: Value(alertType),
      message: Value(message),
      isResolved: Value(isResolved),
      createdAt: Value(createdAt),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
    );
  }

  factory HealthAlert.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthAlert(
      id: serializer.fromJson<String>(json['id']),
      animalId: serializer.fromJson<String>(json['animalId']),
      alertType: serializer.fromJson<String>(json['alertType']),
      message: serializer.fromJson<String>(json['message']),
      isResolved: serializer.fromJson<bool>(json['isResolved']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      resolvedAt: serializer.fromJson<DateTime?>(json['resolvedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'animalId': serializer.toJson<String>(animalId),
      'alertType': serializer.toJson<String>(alertType),
      'message': serializer.toJson<String>(message),
      'isResolved': serializer.toJson<bool>(isResolved),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'resolvedAt': serializer.toJson<DateTime?>(resolvedAt),
    };
  }

  HealthAlert copyWith({
    String? id,
    String? animalId,
    String? alertType,
    String? message,
    bool? isResolved,
    DateTime? createdAt,
    Value<DateTime?> resolvedAt = const Value.absent(),
  }) => HealthAlert(
    id: id ?? this.id,
    animalId: animalId ?? this.animalId,
    alertType: alertType ?? this.alertType,
    message: message ?? this.message,
    isResolved: isResolved ?? this.isResolved,
    createdAt: createdAt ?? this.createdAt,
    resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
  );
  HealthAlert copyWithCompanion(HealthAlertsCompanion data) {
    return HealthAlert(
      id: data.id.present ? data.id.value : this.id,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      alertType: data.alertType.present ? data.alertType.value : this.alertType,
      message: data.message.present ? data.message.value : this.message,
      isResolved: data.isResolved.present
          ? data.isResolved.value
          : this.isResolved,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthAlert(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('alertType: $alertType, ')
          ..write('message: $message, ')
          ..write('isResolved: $isResolved, ')
          ..write('createdAt: $createdAt, ')
          ..write('resolvedAt: $resolvedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    animalId,
    alertType,
    message,
    isResolved,
    createdAt,
    resolvedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthAlert &&
          other.id == this.id &&
          other.animalId == this.animalId &&
          other.alertType == this.alertType &&
          other.message == this.message &&
          other.isResolved == this.isResolved &&
          other.createdAt == this.createdAt &&
          other.resolvedAt == this.resolvedAt);
}

class HealthAlertsCompanion extends UpdateCompanion<HealthAlert> {
  final Value<String> id;
  final Value<String> animalId;
  final Value<String> alertType;
  final Value<String> message;
  final Value<bool> isResolved;
  final Value<DateTime> createdAt;
  final Value<DateTime?> resolvedAt;
  final Value<int> rowid;
  const HealthAlertsCompanion({
    this.id = const Value.absent(),
    this.animalId = const Value.absent(),
    this.alertType = const Value.absent(),
    this.message = const Value.absent(),
    this.isResolved = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HealthAlertsCompanion.insert({
    required String id,
    required String animalId,
    required String alertType,
    required String message,
    this.isResolved = const Value.absent(),
    required DateTime createdAt,
    this.resolvedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       animalId = Value(animalId),
       alertType = Value(alertType),
       message = Value(message),
       createdAt = Value(createdAt);
  static Insertable<HealthAlert> custom({
    Expression<String>? id,
    Expression<String>? animalId,
    Expression<String>? alertType,
    Expression<String>? message,
    Expression<bool>? isResolved,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? resolvedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (animalId != null) 'animal_id': animalId,
      if (alertType != null) 'alert_type': alertType,
      if (message != null) 'message': message,
      if (isResolved != null) 'is_resolved': isResolved,
      if (createdAt != null) 'created_at': createdAt,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HealthAlertsCompanion copyWith({
    Value<String>? id,
    Value<String>? animalId,
    Value<String>? alertType,
    Value<String>? message,
    Value<bool>? isResolved,
    Value<DateTime>? createdAt,
    Value<DateTime?>? resolvedAt,
    Value<int>? rowid,
  }) {
    return HealthAlertsCompanion(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      alertType: alertType ?? this.alertType,
      message: message ?? this.message,
      isResolved: isResolved ?? this.isResolved,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (alertType.present) {
      map['alert_type'] = Variable<String>(alertType.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (isResolved.present) {
      map['is_resolved'] = Variable<bool>(isResolved.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthAlertsCompanion(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('alertType: $alertType, ')
          ..write('message: $message, ')
          ..write('isResolved: $isResolved, ')
          ..write('createdAt: $createdAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _assigneeMeta = const VerificationMeta(
    'assignee',
  );
  @override
  late final GeneratedColumn<String> assignee = GeneratedColumn<String>(
    'assignee',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TaskPriority, String> priority =
      GeneratedColumn<String>(
        'priority',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TaskPriority>($TasksTable.$converterpriority);
  @override
  late final GeneratedColumnWithTypeConverter<TaskStatus, String> taskStatus =
      GeneratedColumn<String>(
        'task_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TaskStatus>($TasksTable.$convertertaskStatus);
  static const VerificationMeta _relatedAnimalIdMeta = const VerificationMeta(
    'relatedAnimalId',
  );
  @override
  late final GeneratedColumn<String> relatedAnimalId = GeneratedColumn<String>(
    'related_animal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('synced'),
      ).withConverter<SyncStatus>($TasksTable.$convertersyncStatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    assignee,
    dueDate,
    priority,
    taskStatus,
    relatedAnimalId,
    createdAt,
    updatedAt,
    completedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('assignee')) {
      context.handle(
        _assigneeMeta,
        assignee.isAcceptableOrUnknown(data['assignee']!, _assigneeMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('related_animal_id')) {
      context.handle(
        _relatedAnimalIdMeta,
        relatedAnimalId.isAcceptableOrUnknown(
          data['related_animal_id']!,
          _relatedAnimalIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      assignee: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assignee'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      priority: $TasksTable.$converterpriority.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}priority'],
        )!,
      ),
      taskStatus: $TasksTable.$convertertaskStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}task_status'],
        )!,
      ),
      relatedAnimalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_animal_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      syncStatus: $TasksTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }

  static TypeConverter<TaskPriority, String> $converterpriority =
      const TaskPriorityConverter();
  static TypeConverter<TaskStatus, String> $convertertaskStatus =
      const TaskStatusConverter();
  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class Task extends DataClass implements Insertable<Task> {
  final String id;
  final String title;
  final String description;
  final String? assignee;
  final DateTime? dueDate;
  final TaskPriority priority;
  final TaskStatus taskStatus;
  final String? relatedAnimalId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final SyncStatus syncStatus;
  const Task({
    required this.id,
    required this.title,
    required this.description,
    this.assignee,
    this.dueDate,
    required this.priority,
    required this.taskStatus,
    this.relatedAnimalId,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || assignee != null) {
      map['assignee'] = Variable<String>(assignee);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    {
      map['priority'] = Variable<String>(
        $TasksTable.$converterpriority.toSql(priority),
      );
    }
    {
      map['task_status'] = Variable<String>(
        $TasksTable.$convertertaskStatus.toSql(taskStatus),
      );
    }
    if (!nullToAbsent || relatedAnimalId != null) {
      map['related_animal_id'] = Variable<String>(relatedAnimalId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    {
      map['sync_status'] = Variable<String>(
        $TasksTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      assignee: assignee == null && nullToAbsent
          ? const Value.absent()
          : Value(assignee),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      priority: Value(priority),
      taskStatus: Value(taskStatus),
      relatedAnimalId: relatedAnimalId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedAnimalId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      assignee: serializer.fromJson<String?>(json['assignee']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      priority: serializer.fromJson<TaskPriority>(json['priority']),
      taskStatus: serializer.fromJson<TaskStatus>(json['taskStatus']),
      relatedAnimalId: serializer.fromJson<String?>(json['relatedAnimalId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'assignee': serializer.toJson<String?>(assignee),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'priority': serializer.toJson<TaskPriority>(priority),
      'taskStatus': serializer.toJson<TaskStatus>(taskStatus),
      'relatedAnimalId': serializer.toJson<String?>(relatedAnimalId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
    };
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    Value<String?> assignee = const Value.absent(),
    Value<DateTime?> dueDate = const Value.absent(),
    TaskPriority? priority,
    TaskStatus? taskStatus,
    Value<String?> relatedAnimalId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    SyncStatus? syncStatus,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    assignee: assignee.present ? assignee.value : this.assignee,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    priority: priority ?? this.priority,
    taskStatus: taskStatus ?? this.taskStatus,
    relatedAnimalId: relatedAnimalId.present
        ? relatedAnimalId.value
        : this.relatedAnimalId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      assignee: data.assignee.present ? data.assignee.value : this.assignee,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      priority: data.priority.present ? data.priority.value : this.priority,
      taskStatus: data.taskStatus.present
          ? data.taskStatus.value
          : this.taskStatus,
      relatedAnimalId: data.relatedAnimalId.present
          ? data.relatedAnimalId.value
          : this.relatedAnimalId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('assignee: $assignee, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('taskStatus: $taskStatus, ')
          ..write('relatedAnimalId: $relatedAnimalId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    assignee,
    dueDate,
    priority,
    taskStatus,
    relatedAnimalId,
    createdAt,
    updatedAt,
    completedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.assignee == this.assignee &&
          other.dueDate == this.dueDate &&
          other.priority == this.priority &&
          other.taskStatus == this.taskStatus &&
          other.relatedAnimalId == this.relatedAnimalId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt &&
          other.syncStatus == this.syncStatus);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String?> assignee;
  final Value<DateTime?> dueDate;
  final Value<TaskPriority> priority;
  final Value<TaskStatus> taskStatus;
  final Value<String?> relatedAnimalId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> completedAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.assignee = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.taskStatus = const Value.absent(),
    this.relatedAnimalId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.assignee = const Value.absent(),
    this.dueDate = const Value.absent(),
    required TaskPriority priority,
    required TaskStatus taskStatus,
    this.relatedAnimalId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.completedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       priority = Value(priority),
       taskStatus = Value(taskStatus),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Task> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? assignee,
    Expression<DateTime>? dueDate,
    Expression<String>? priority,
    Expression<String>? taskStatus,
    Expression<String>? relatedAnimalId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (assignee != null) 'assignee': assignee,
      if (dueDate != null) 'due_date': dueDate,
      if (priority != null) 'priority': priority,
      if (taskStatus != null) 'task_status': taskStatus,
      if (relatedAnimalId != null) 'related_animal_id': relatedAnimalId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String?>? assignee,
    Value<DateTime?>? dueDate,
    Value<TaskPriority>? priority,
    Value<TaskStatus>? taskStatus,
    Value<String?>? relatedAnimalId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? completedAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? rowid,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assignee: assignee ?? this.assignee,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      taskStatus: taskStatus ?? this.taskStatus,
      relatedAnimalId: relatedAnimalId ?? this.relatedAnimalId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (assignee.present) {
      map['assignee'] = Variable<String>(assignee.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(
        $TasksTable.$converterpriority.toSql(priority.value),
      );
    }
    if (taskStatus.present) {
      map['task_status'] = Variable<String>(
        $TasksTable.$convertertaskStatus.toSql(taskStatus.value),
      );
    }
    if (relatedAnimalId.present) {
      map['related_animal_id'] = Variable<String>(relatedAnimalId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $TasksTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('assignee: $assignee, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('taskStatus: $taskStatus, ')
          ..write('relatedAnimalId: $relatedAnimalId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ExpenseCategory, String>
  category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<ExpenseCategory>($ExpensesTable.$convertercategory);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animalIdMeta = const VerificationMeta(
    'animalId',
  );
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
    'animal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pastureIdMeta = const VerificationMeta(
    'pastureId',
  );
  @override
  late final GeneratedColumn<String> pastureId = GeneratedColumn<String>(
    'pasture_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vendorMeta = const VerificationMeta('vendor');
  @override
  late final GeneratedColumn<String> vendor = GeneratedColumn<String>(
    'vendor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _receiptPathMeta = const VerificationMeta(
    'receiptPath',
  );
  @override
  late final GeneratedColumn<String> receiptPath = GeneratedColumn<String>(
    'receipt_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('synced'),
      ).withConverter<SyncStatus>($ExpensesTable.$convertersyncStatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    category,
    amount,
    description,
    date,
    animalId,
    pastureId,
    vendor,
    receiptPath,
    createdAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(
        _animalIdMeta,
        animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta),
      );
    }
    if (data.containsKey('pasture_id')) {
      context.handle(
        _pastureIdMeta,
        pastureId.isAcceptableOrUnknown(data['pasture_id']!, _pastureIdMeta),
      );
    }
    if (data.containsKey('vendor')) {
      context.handle(
        _vendorMeta,
        vendor.isAcceptableOrUnknown(data['vendor']!, _vendorMeta),
      );
    }
    if (data.containsKey('receipt_path')) {
      context.handle(
        _receiptPathMeta,
        receiptPath.isAcceptableOrUnknown(
          data['receipt_path']!,
          _receiptPathMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      category: $ExpensesTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      animalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_id'],
      ),
      pastureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pasture_id'],
      ),
      vendor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor'],
      )!,
      receiptPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: $ExpensesTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }

  static TypeConverter<ExpenseCategory, String> $convertercategory =
      const ExpenseCategoryConverter();
  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final ExpenseCategory category;
  final double amount;
  final String description;
  final DateTime date;
  final String? animalId;
  final String? pastureId;
  final String vendor;
  final String? receiptPath;
  final DateTime createdAt;
  final SyncStatus syncStatus;
  const Expense({
    required this.id,
    required this.category,
    required this.amount,
    required this.description,
    required this.date,
    this.animalId,
    this.pastureId,
    required this.vendor,
    this.receiptPath,
    required this.createdAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['category'] = Variable<String>(
        $ExpensesTable.$convertercategory.toSql(category),
      );
    }
    map['amount'] = Variable<double>(amount);
    map['description'] = Variable<String>(description);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || animalId != null) {
      map['animal_id'] = Variable<String>(animalId);
    }
    if (!nullToAbsent || pastureId != null) {
      map['pasture_id'] = Variable<String>(pastureId);
    }
    map['vendor'] = Variable<String>(vendor);
    if (!nullToAbsent || receiptPath != null) {
      map['receipt_path'] = Variable<String>(receiptPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    {
      map['sync_status'] = Variable<String>(
        $ExpensesTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      category: Value(category),
      amount: Value(amount),
      description: Value(description),
      date: Value(date),
      animalId: animalId == null && nullToAbsent
          ? const Value.absent()
          : Value(animalId),
      pastureId: pastureId == null && nullToAbsent
          ? const Value.absent()
          : Value(pastureId),
      vendor: Value(vendor),
      receiptPath: receiptPath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptPath),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      category: serializer.fromJson<ExpenseCategory>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      description: serializer.fromJson<String>(json['description']),
      date: serializer.fromJson<DateTime>(json['date']),
      animalId: serializer.fromJson<String?>(json['animalId']),
      pastureId: serializer.fromJson<String?>(json['pastureId']),
      vendor: serializer.fromJson<String>(json['vendor']),
      receiptPath: serializer.fromJson<String?>(json['receiptPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'category': serializer.toJson<ExpenseCategory>(category),
      'amount': serializer.toJson<double>(amount),
      'description': serializer.toJson<String>(description),
      'date': serializer.toJson<DateTime>(date),
      'animalId': serializer.toJson<String?>(animalId),
      'pastureId': serializer.toJson<String?>(pastureId),
      'vendor': serializer.toJson<String>(vendor),
      'receiptPath': serializer.toJson<String?>(receiptPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
    };
  }

  Expense copyWith({
    String? id,
    ExpenseCategory? category,
    double? amount,
    String? description,
    DateTime? date,
    Value<String?> animalId = const Value.absent(),
    Value<String?> pastureId = const Value.absent(),
    String? vendor,
    Value<String?> receiptPath = const Value.absent(),
    DateTime? createdAt,
    SyncStatus? syncStatus,
  }) => Expense(
    id: id ?? this.id,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    description: description ?? this.description,
    date: date ?? this.date,
    animalId: animalId.present ? animalId.value : this.animalId,
    pastureId: pastureId.present ? pastureId.value : this.pastureId,
    vendor: vendor ?? this.vendor,
    receiptPath: receiptPath.present ? receiptPath.value : this.receiptPath,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      description: data.description.present
          ? data.description.value
          : this.description,
      date: data.date.present ? data.date.value : this.date,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      pastureId: data.pastureId.present ? data.pastureId.value : this.pastureId,
      vendor: data.vendor.present ? data.vendor.value : this.vendor,
      receiptPath: data.receiptPath.present
          ? data.receiptPath.value
          : this.receiptPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('animalId: $animalId, ')
          ..write('pastureId: $pastureId, ')
          ..write('vendor: $vendor, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    category,
    amount,
    description,
    date,
    animalId,
    pastureId,
    vendor,
    receiptPath,
    createdAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.date == this.date &&
          other.animalId == this.animalId &&
          other.pastureId == this.pastureId &&
          other.vendor == this.vendor &&
          other.receiptPath == this.receiptPath &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<ExpenseCategory> category;
  final Value<double> amount;
  final Value<String> description;
  final Value<DateTime> date;
  final Value<String?> animalId;
  final Value<String?> pastureId;
  final Value<String> vendor;
  final Value<String?> receiptPath;
  final Value<DateTime> createdAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.animalId = const Value.absent(),
    this.pastureId = const Value.absent(),
    this.vendor = const Value.absent(),
    this.receiptPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    required ExpenseCategory category,
    required double amount,
    this.description = const Value.absent(),
    required DateTime date,
    this.animalId = const Value.absent(),
    this.pastureId = const Value.absent(),
    this.vendor = const Value.absent(),
    this.receiptPath = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       category = Value(category),
       amount = Value(amount),
       date = Value(date),
       createdAt = Value(createdAt);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<String>? description,
    Expression<DateTime>? date,
    Expression<String>? animalId,
    Expression<String>? pastureId,
    Expression<String>? vendor,
    Expression<String>? receiptPath,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (animalId != null) 'animal_id': animalId,
      if (pastureId != null) 'pasture_id': pastureId,
      if (vendor != null) 'vendor': vendor,
      if (receiptPath != null) 'receipt_path': receiptPath,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<String>? id,
    Value<ExpenseCategory>? category,
    Value<double>? amount,
    Value<String>? description,
    Value<DateTime>? date,
    Value<String?>? animalId,
    Value<String?>? pastureId,
    Value<String>? vendor,
    Value<String?>? receiptPath,
    Value<DateTime>? createdAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
      animalId: animalId ?? this.animalId,
      pastureId: pastureId ?? this.pastureId,
      vendor: vendor ?? this.vendor,
      receiptPath: receiptPath ?? this.receiptPath,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $ExpensesTable.$convertercategory.toSql(category.value),
      );
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (pastureId.present) {
      map['pasture_id'] = Variable<String>(pastureId.value);
    }
    if (vendor.present) {
      map['vendor'] = Variable<String>(vendor.value);
    }
    if (receiptPath.present) {
      map['receipt_path'] = Variable<String>(receiptPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $ExpensesTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('animalId: $animalId, ')
          ..write('pastureId: $pastureId, ')
          ..write('vendor: $vendor, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animalIdMeta = const VerificationMeta(
    'animalId',
  );
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
    'animal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animals (id)',
    ),
  );
  static const VerificationMeta _saleDateMeta = const VerificationMeta(
    'saleDate',
  );
  @override
  late final GeneratedColumn<DateTime> saleDate = GeneratedColumn<DateTime>(
    'sale_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saleWeightMeta = const VerificationMeta(
    'saleWeight',
  );
  @override
  late final GeneratedColumn<double> saleWeight = GeneratedColumn<double>(
    'sale_weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricePerPoundMeta = const VerificationMeta(
    'pricePerPound',
  );
  @override
  late final GeneratedColumn<double> pricePerPound = GeneratedColumn<double>(
    'price_per_pound',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _buyerMeta = const VerificationMeta('buyer');
  @override
  late final GeneratedColumn<String> buyer = GeneratedColumn<String>(
    'buyer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _marketLocationMeta = const VerificationMeta(
    'marketLocation',
  );
  @override
  late final GeneratedColumn<String> marketLocation = GeneratedColumn<String>(
    'market_location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>(
        'sync_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('synced'),
      ).withConverter<SyncStatus>($SalesTable.$convertersyncStatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    animalId,
    saleDate,
    saleWeight,
    pricePerPound,
    totalPrice,
    buyer,
    marketLocation,
    notes,
    createdAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(
        _animalIdMeta,
        animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('sale_date')) {
      context.handle(
        _saleDateMeta,
        saleDate.isAcceptableOrUnknown(data['sale_date']!, _saleDateMeta),
      );
    } else if (isInserting) {
      context.missing(_saleDateMeta);
    }
    if (data.containsKey('sale_weight')) {
      context.handle(
        _saleWeightMeta,
        saleWeight.isAcceptableOrUnknown(data['sale_weight']!, _saleWeightMeta),
      );
    } else if (isInserting) {
      context.missing(_saleWeightMeta);
    }
    if (data.containsKey('price_per_pound')) {
      context.handle(
        _pricePerPoundMeta,
        pricePerPound.isAcceptableOrUnknown(
          data['price_per_pound']!,
          _pricePerPoundMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricePerPoundMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('buyer')) {
      context.handle(
        _buyerMeta,
        buyer.isAcceptableOrUnknown(data['buyer']!, _buyerMeta),
      );
    }
    if (data.containsKey('market_location')) {
      context.handle(
        _marketLocationMeta,
        marketLocation.isAcceptableOrUnknown(
          data['market_location']!,
          _marketLocationMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      animalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_id'],
      )!,
      saleDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sale_date'],
      )!,
      saleWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sale_weight'],
      )!,
      pricePerPound: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_per_pound'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      buyer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}buyer'],
      )!,
      marketLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}market_location'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: $SalesTable.$convertersyncStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sync_status'],
        )!,
      ),
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncStatus, String> $convertersyncStatus =
      const SyncStatusConverter();
}

class Sale extends DataClass implements Insertable<Sale> {
  final String id;
  final String animalId;
  final DateTime saleDate;
  final double saleWeight;
  final double pricePerPound;
  final double totalPrice;
  final String buyer;
  final String marketLocation;
  final String notes;
  final DateTime createdAt;
  final SyncStatus syncStatus;
  const Sale({
    required this.id,
    required this.animalId,
    required this.saleDate,
    required this.saleWeight,
    required this.pricePerPound,
    required this.totalPrice,
    required this.buyer,
    required this.marketLocation,
    required this.notes,
    required this.createdAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['animal_id'] = Variable<String>(animalId);
    map['sale_date'] = Variable<DateTime>(saleDate);
    map['sale_weight'] = Variable<double>(saleWeight);
    map['price_per_pound'] = Variable<double>(pricePerPound);
    map['total_price'] = Variable<double>(totalPrice);
    map['buyer'] = Variable<String>(buyer);
    map['market_location'] = Variable<String>(marketLocation);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    {
      map['sync_status'] = Variable<String>(
        $SalesTable.$convertersyncStatus.toSql(syncStatus),
      );
    }
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      animalId: Value(animalId),
      saleDate: Value(saleDate),
      saleWeight: Value(saleWeight),
      pricePerPound: Value(pricePerPound),
      totalPrice: Value(totalPrice),
      buyer: Value(buyer),
      marketLocation: Value(marketLocation),
      notes: Value(notes),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory Sale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<String>(json['id']),
      animalId: serializer.fromJson<String>(json['animalId']),
      saleDate: serializer.fromJson<DateTime>(json['saleDate']),
      saleWeight: serializer.fromJson<double>(json['saleWeight']),
      pricePerPound: serializer.fromJson<double>(json['pricePerPound']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      buyer: serializer.fromJson<String>(json['buyer']),
      marketLocation: serializer.fromJson<String>(json['marketLocation']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<SyncStatus>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'animalId': serializer.toJson<String>(animalId),
      'saleDate': serializer.toJson<DateTime>(saleDate),
      'saleWeight': serializer.toJson<double>(saleWeight),
      'pricePerPound': serializer.toJson<double>(pricePerPound),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'buyer': serializer.toJson<String>(buyer),
      'marketLocation': serializer.toJson<String>(marketLocation),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<SyncStatus>(syncStatus),
    };
  }

  Sale copyWith({
    String? id,
    String? animalId,
    DateTime? saleDate,
    double? saleWeight,
    double? pricePerPound,
    double? totalPrice,
    String? buyer,
    String? marketLocation,
    String? notes,
    DateTime? createdAt,
    SyncStatus? syncStatus,
  }) => Sale(
    id: id ?? this.id,
    animalId: animalId ?? this.animalId,
    saleDate: saleDate ?? this.saleDate,
    saleWeight: saleWeight ?? this.saleWeight,
    pricePerPound: pricePerPound ?? this.pricePerPound,
    totalPrice: totalPrice ?? this.totalPrice,
    buyer: buyer ?? this.buyer,
    marketLocation: marketLocation ?? this.marketLocation,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      saleDate: data.saleDate.present ? data.saleDate.value : this.saleDate,
      saleWeight: data.saleWeight.present
          ? data.saleWeight.value
          : this.saleWeight,
      pricePerPound: data.pricePerPound.present
          ? data.pricePerPound.value
          : this.pricePerPound,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      buyer: data.buyer.present ? data.buyer.value : this.buyer,
      marketLocation: data.marketLocation.present
          ? data.marketLocation.value
          : this.marketLocation,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('saleDate: $saleDate, ')
          ..write('saleWeight: $saleWeight, ')
          ..write('pricePerPound: $pricePerPound, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('buyer: $buyer, ')
          ..write('marketLocation: $marketLocation, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    animalId,
    saleDate,
    saleWeight,
    pricePerPound,
    totalPrice,
    buyer,
    marketLocation,
    notes,
    createdAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.animalId == this.animalId &&
          other.saleDate == this.saleDate &&
          other.saleWeight == this.saleWeight &&
          other.pricePerPound == this.pricePerPound &&
          other.totalPrice == this.totalPrice &&
          other.buyer == this.buyer &&
          other.marketLocation == this.marketLocation &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<String> id;
  final Value<String> animalId;
  final Value<DateTime> saleDate;
  final Value<double> saleWeight;
  final Value<double> pricePerPound;
  final Value<double> totalPrice;
  final Value<String> buyer;
  final Value<String> marketLocation;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<SyncStatus> syncStatus;
  final Value<int> rowid;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.animalId = const Value.absent(),
    this.saleDate = const Value.absent(),
    this.saleWeight = const Value.absent(),
    this.pricePerPound = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.buyer = const Value.absent(),
    this.marketLocation = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesCompanion.insert({
    required String id,
    required String animalId,
    required DateTime saleDate,
    required double saleWeight,
    required double pricePerPound,
    required double totalPrice,
    this.buyer = const Value.absent(),
    this.marketLocation = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       animalId = Value(animalId),
       saleDate = Value(saleDate),
       saleWeight = Value(saleWeight),
       pricePerPound = Value(pricePerPound),
       totalPrice = Value(totalPrice),
       createdAt = Value(createdAt);
  static Insertable<Sale> custom({
    Expression<String>? id,
    Expression<String>? animalId,
    Expression<DateTime>? saleDate,
    Expression<double>? saleWeight,
    Expression<double>? pricePerPound,
    Expression<double>? totalPrice,
    Expression<String>? buyer,
    Expression<String>? marketLocation,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (animalId != null) 'animal_id': animalId,
      if (saleDate != null) 'sale_date': saleDate,
      if (saleWeight != null) 'sale_weight': saleWeight,
      if (pricePerPound != null) 'price_per_pound': pricePerPound,
      if (totalPrice != null) 'total_price': totalPrice,
      if (buyer != null) 'buyer': buyer,
      if (marketLocation != null) 'market_location': marketLocation,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesCompanion copyWith({
    Value<String>? id,
    Value<String>? animalId,
    Value<DateTime>? saleDate,
    Value<double>? saleWeight,
    Value<double>? pricePerPound,
    Value<double>? totalPrice,
    Value<String>? buyer,
    Value<String>? marketLocation,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<SyncStatus>? syncStatus,
    Value<int>? rowid,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      saleDate: saleDate ?? this.saleDate,
      saleWeight: saleWeight ?? this.saleWeight,
      pricePerPound: pricePerPound ?? this.pricePerPound,
      totalPrice: totalPrice ?? this.totalPrice,
      buyer: buyer ?? this.buyer,
      marketLocation: marketLocation ?? this.marketLocation,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (saleDate.present) {
      map['sale_date'] = Variable<DateTime>(saleDate.value);
    }
    if (saleWeight.present) {
      map['sale_weight'] = Variable<double>(saleWeight.value);
    }
    if (pricePerPound.present) {
      map['price_per_pound'] = Variable<double>(pricePerPound.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (buyer.present) {
      map['buyer'] = Variable<String>(buyer.value);
    }
    if (marketLocation.present) {
      map['market_location'] = Variable<String>(marketLocation.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
        $SalesTable.$convertersyncStatus.toSql(syncStatus.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('saleDate: $saleDate, ')
          ..write('saleWeight: $saleWeight, ')
          ..write('pricePerPound: $pricePerPound, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('buyer: $buyer, ')
          ..write('marketLocation: $marketLocation, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PredictiveAlertsTable extends PredictiveAlerts
    with TableInfo<$PredictiveAlertsTable, PredictiveAlert> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PredictiveAlertsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alertTypeMeta = const VerificationMeta(
    'alertType',
  );
  @override
  late final GeneratedColumn<String> alertType = GeneratedColumn<String>(
    'alert_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animalIdMeta = const VerificationMeta(
    'animalId',
  );
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
    'animal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _predictedDateMeta = const VerificationMeta(
    'predictedDate',
  );
  @override
  late final GeneratedColumn<DateTime> predictedDate =
      GeneratedColumn<DateTime>(
        'predicted_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAcknowledgedMeta = const VerificationMeta(
    'isAcknowledged',
  );
  @override
  late final GeneratedColumn<bool> isAcknowledged = GeneratedColumn<bool>(
    'is_acknowledged',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_acknowledged" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    alertType,
    animalId,
    predictedDate,
    message,
    isAcknowledged,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'predictive_alerts';
  @override
  VerificationContext validateIntegrity(
    Insertable<PredictiveAlert> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('alert_type')) {
      context.handle(
        _alertTypeMeta,
        alertType.isAcceptableOrUnknown(data['alert_type']!, _alertTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_alertTypeMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(
        _animalIdMeta,
        animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta),
      );
    }
    if (data.containsKey('predicted_date')) {
      context.handle(
        _predictedDateMeta,
        predictedDate.isAcceptableOrUnknown(
          data['predicted_date']!,
          _predictedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_predictedDateMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('is_acknowledged')) {
      context.handle(
        _isAcknowledgedMeta,
        isAcknowledged.isAcceptableOrUnknown(
          data['is_acknowledged']!,
          _isAcknowledgedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PredictiveAlert map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PredictiveAlert(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      alertType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alert_type'],
      )!,
      animalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_id'],
      ),
      predictedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}predicted_date'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      isAcknowledged: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_acknowledged'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PredictiveAlertsTable createAlias(String alias) {
    return $PredictiveAlertsTable(attachedDatabase, alias);
  }
}

class PredictiveAlert extends DataClass implements Insertable<PredictiveAlert> {
  final String id;
  final String alertType;
  final String? animalId;
  final DateTime predictedDate;
  final String message;
  final bool isAcknowledged;
  final DateTime createdAt;
  const PredictiveAlert({
    required this.id,
    required this.alertType,
    this.animalId,
    required this.predictedDate,
    required this.message,
    required this.isAcknowledged,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['alert_type'] = Variable<String>(alertType);
    if (!nullToAbsent || animalId != null) {
      map['animal_id'] = Variable<String>(animalId);
    }
    map['predicted_date'] = Variable<DateTime>(predictedDate);
    map['message'] = Variable<String>(message);
    map['is_acknowledged'] = Variable<bool>(isAcknowledged);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PredictiveAlertsCompanion toCompanion(bool nullToAbsent) {
    return PredictiveAlertsCompanion(
      id: Value(id),
      alertType: Value(alertType),
      animalId: animalId == null && nullToAbsent
          ? const Value.absent()
          : Value(animalId),
      predictedDate: Value(predictedDate),
      message: Value(message),
      isAcknowledged: Value(isAcknowledged),
      createdAt: Value(createdAt),
    );
  }

  factory PredictiveAlert.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PredictiveAlert(
      id: serializer.fromJson<String>(json['id']),
      alertType: serializer.fromJson<String>(json['alertType']),
      animalId: serializer.fromJson<String?>(json['animalId']),
      predictedDate: serializer.fromJson<DateTime>(json['predictedDate']),
      message: serializer.fromJson<String>(json['message']),
      isAcknowledged: serializer.fromJson<bool>(json['isAcknowledged']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'alertType': serializer.toJson<String>(alertType),
      'animalId': serializer.toJson<String?>(animalId),
      'predictedDate': serializer.toJson<DateTime>(predictedDate),
      'message': serializer.toJson<String>(message),
      'isAcknowledged': serializer.toJson<bool>(isAcknowledged),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PredictiveAlert copyWith({
    String? id,
    String? alertType,
    Value<String?> animalId = const Value.absent(),
    DateTime? predictedDate,
    String? message,
    bool? isAcknowledged,
    DateTime? createdAt,
  }) => PredictiveAlert(
    id: id ?? this.id,
    alertType: alertType ?? this.alertType,
    animalId: animalId.present ? animalId.value : this.animalId,
    predictedDate: predictedDate ?? this.predictedDate,
    message: message ?? this.message,
    isAcknowledged: isAcknowledged ?? this.isAcknowledged,
    createdAt: createdAt ?? this.createdAt,
  );
  PredictiveAlert copyWithCompanion(PredictiveAlertsCompanion data) {
    return PredictiveAlert(
      id: data.id.present ? data.id.value : this.id,
      alertType: data.alertType.present ? data.alertType.value : this.alertType,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      predictedDate: data.predictedDate.present
          ? data.predictedDate.value
          : this.predictedDate,
      message: data.message.present ? data.message.value : this.message,
      isAcknowledged: data.isAcknowledged.present
          ? data.isAcknowledged.value
          : this.isAcknowledged,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PredictiveAlert(')
          ..write('id: $id, ')
          ..write('alertType: $alertType, ')
          ..write('animalId: $animalId, ')
          ..write('predictedDate: $predictedDate, ')
          ..write('message: $message, ')
          ..write('isAcknowledged: $isAcknowledged, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    alertType,
    animalId,
    predictedDate,
    message,
    isAcknowledged,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PredictiveAlert &&
          other.id == this.id &&
          other.alertType == this.alertType &&
          other.animalId == this.animalId &&
          other.predictedDate == this.predictedDate &&
          other.message == this.message &&
          other.isAcknowledged == this.isAcknowledged &&
          other.createdAt == this.createdAt);
}

class PredictiveAlertsCompanion extends UpdateCompanion<PredictiveAlert> {
  final Value<String> id;
  final Value<String> alertType;
  final Value<String?> animalId;
  final Value<DateTime> predictedDate;
  final Value<String> message;
  final Value<bool> isAcknowledged;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PredictiveAlertsCompanion({
    this.id = const Value.absent(),
    this.alertType = const Value.absent(),
    this.animalId = const Value.absent(),
    this.predictedDate = const Value.absent(),
    this.message = const Value.absent(),
    this.isAcknowledged = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PredictiveAlertsCompanion.insert({
    required String id,
    required String alertType,
    this.animalId = const Value.absent(),
    required DateTime predictedDate,
    required String message,
    this.isAcknowledged = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       alertType = Value(alertType),
       predictedDate = Value(predictedDate),
       message = Value(message),
       createdAt = Value(createdAt);
  static Insertable<PredictiveAlert> custom({
    Expression<String>? id,
    Expression<String>? alertType,
    Expression<String>? animalId,
    Expression<DateTime>? predictedDate,
    Expression<String>? message,
    Expression<bool>? isAcknowledged,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (alertType != null) 'alert_type': alertType,
      if (animalId != null) 'animal_id': animalId,
      if (predictedDate != null) 'predicted_date': predictedDate,
      if (message != null) 'message': message,
      if (isAcknowledged != null) 'is_acknowledged': isAcknowledged,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PredictiveAlertsCompanion copyWith({
    Value<String>? id,
    Value<String>? alertType,
    Value<String?>? animalId,
    Value<DateTime>? predictedDate,
    Value<String>? message,
    Value<bool>? isAcknowledged,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PredictiveAlertsCompanion(
      id: id ?? this.id,
      alertType: alertType ?? this.alertType,
      animalId: animalId ?? this.animalId,
      predictedDate: predictedDate ?? this.predictedDate,
      message: message ?? this.message,
      isAcknowledged: isAcknowledged ?? this.isAcknowledged,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (alertType.present) {
      map['alert_type'] = Variable<String>(alertType.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (predictedDate.present) {
      map['predicted_date'] = Variable<DateTime>(predictedDate.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (isAcknowledged.present) {
      map['is_acknowledged'] = Variable<bool>(isAcknowledged.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PredictiveAlertsCompanion(')
          ..write('id: $id, ')
          ..write('alertType: $alertType, ')
          ..write('animalId: $animalId, ')
          ..write('predictedDate: $predictedDate, ')
          ..write('message: $message, ')
          ..write('isAcknowledged: $isAcknowledged, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _syncTableNameMeta = const VerificationMeta(
    'syncTableName',
  );
  @override
  late final GeneratedColumn<String> syncTableName = GeneratedColumn<String>(
    'sync_table_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncTableName,
    recordId,
    operation,
    data,
    createdAt,
    retryCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_table_name')) {
      context.handle(
        _syncTableNameMeta,
        syncTableName.isAcceptableOrUnknown(
          data['sync_table_name']!,
          _syncTableNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_syncTableNameMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncTableName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_table_name'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String syncTableName;
  final String recordId;
  final String operation;
  final String data;
  final DateTime createdAt;
  final int retryCount;
  const SyncQueueData({
    required this.id,
    required this.syncTableName,
    required this.recordId,
    required this.operation,
    required this.data,
    required this.createdAt,
    required this.retryCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_table_name'] = Variable<String>(syncTableName);
    map['record_id'] = Variable<String>(recordId);
    map['operation'] = Variable<String>(operation);
    map['data'] = Variable<String>(data);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['retry_count'] = Variable<int>(retryCount);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      syncTableName: Value(syncTableName),
      recordId: Value(recordId),
      operation: Value(operation),
      data: Value(data),
      createdAt: Value(createdAt),
      retryCount: Value(retryCount),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      syncTableName: serializer.fromJson<String>(json['syncTableName']),
      recordId: serializer.fromJson<String>(json['recordId']),
      operation: serializer.fromJson<String>(json['operation']),
      data: serializer.fromJson<String>(json['data']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncTableName': serializer.toJson<String>(syncTableName),
      'recordId': serializer.toJson<String>(recordId),
      'operation': serializer.toJson<String>(operation),
      'data': serializer.toJson<String>(data),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'retryCount': serializer.toJson<int>(retryCount),
    };
  }

  SyncQueueData copyWith({
    int? id,
    String? syncTableName,
    String? recordId,
    String? operation,
    String? data,
    DateTime? createdAt,
    int? retryCount,
  }) => SyncQueueData(
    id: id ?? this.id,
    syncTableName: syncTableName ?? this.syncTableName,
    recordId: recordId ?? this.recordId,
    operation: operation ?? this.operation,
    data: data ?? this.data,
    createdAt: createdAt ?? this.createdAt,
    retryCount: retryCount ?? this.retryCount,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      syncTableName: data.syncTableName.present
          ? data.syncTableName.value
          : this.syncTableName,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      operation: data.operation.present ? data.operation.value : this.operation,
      data: data.data.present ? data.data.value : this.data,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('data: $data, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncTableName,
    recordId,
    operation,
    data,
    createdAt,
    retryCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.syncTableName == this.syncTableName &&
          other.recordId == this.recordId &&
          other.operation == this.operation &&
          other.data == this.data &&
          other.createdAt == this.createdAt &&
          other.retryCount == this.retryCount);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> syncTableName;
  final Value<String> recordId;
  final Value<String> operation;
  final Value<String> data;
  final Value<DateTime> createdAt;
  final Value<int> retryCount;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.syncTableName = const Value.absent(),
    this.recordId = const Value.absent(),
    this.operation = const Value.absent(),
    this.data = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String syncTableName,
    required String recordId,
    required String operation,
    required String data,
    required DateTime createdAt,
    this.retryCount = const Value.absent(),
  }) : syncTableName = Value(syncTableName),
       recordId = Value(recordId),
       operation = Value(operation),
       data = Value(data),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? syncTableName,
    Expression<String>? recordId,
    Expression<String>? operation,
    Expression<String>? data,
    Expression<DateTime>? createdAt,
    Expression<int>? retryCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncTableName != null) 'sync_table_name': syncTableName,
      if (recordId != null) 'record_id': recordId,
      if (operation != null) 'operation': operation,
      if (data != null) 'data': data,
      if (createdAt != null) 'created_at': createdAt,
      if (retryCount != null) 'retry_count': retryCount,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? syncTableName,
    Value<String>? recordId,
    Value<String>? operation,
    Value<String>? data,
    Value<DateTime>? createdAt,
    Value<int>? retryCount,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      syncTableName: syncTableName ?? this.syncTableName,
      recordId: recordId ?? this.recordId,
      operation: operation ?? this.operation,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncTableName.present) {
      map['sync_table_name'] = Variable<String>(syncTableName.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('data: $data, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AnimalsTable animals = $AnimalsTable(this);
  late final $CalvingRecordsTable calvingRecords = $CalvingRecordsTable(this);
  late final $TreatmentRecordsTable treatmentRecords = $TreatmentRecordsTable(
    this,
  );
  late final $WeightRecordsTable weightRecords = $WeightRecordsTable(this);
  late final $PriceAlertsTable priceAlerts = $PriceAlertsTable(this);
  late final $RanchSettingsTable ranchSettings = $RanchSettingsTable(this);
  late final $PasturesTable pastures = $PasturesTable(this);
  late final $GrazingRotationsTable grazingRotations = $GrazingRotationsTable(
    this,
  );
  late final $SmartTagReadingsTable smartTagReadings = $SmartTagReadingsTable(
    this,
  );
  late final $HealthAlertsTable healthAlerts = $HealthAlertsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $PredictiveAlertsTable predictiveAlerts = $PredictiveAlertsTable(
    this,
  );
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    animals,
    calvingRecords,
    treatmentRecords,
    weightRecords,
    priceAlerts,
    ranchSettings,
    pastures,
    grazingRotations,
    smartTagReadings,
    healthAlerts,
    tasks,
    expenses,
    sales,
    predictiveAlerts,
    syncQueue,
  ];
}

typedef $$AnimalsTableCreateCompanionBuilder =
    AnimalsCompanion Function({
      required String id,
      required String tagNumber,
      Value<String> breed,
      required DateTime dateOfBirth,
      required AnimalSex sex,
      required AnimalStatus status,
      Value<String?> sireTag,
      Value<String?> damTag,
      Value<String> notes,
      Value<DateTime?> purchaseDate,
      Value<double?> purchaseWeight,
      Value<double?> purchasePrice,
      Value<String?> rfidTag,
      Value<String?> smartTagId,
      Value<String?> currentPastureId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });
typedef $$AnimalsTableUpdateCompanionBuilder =
    AnimalsCompanion Function({
      Value<String> id,
      Value<String> tagNumber,
      Value<String> breed,
      Value<DateTime> dateOfBirth,
      Value<AnimalSex> sex,
      Value<AnimalStatus> status,
      Value<String?> sireTag,
      Value<String?> damTag,
      Value<String> notes,
      Value<DateTime?> purchaseDate,
      Value<double?> purchaseWeight,
      Value<double?> purchasePrice,
      Value<String?> rfidTag,
      Value<String?> smartTagId,
      Value<String?> currentPastureId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });

final class $$AnimalsTableReferences
    extends BaseReferences<_$AppDatabase, $AnimalsTable, Animal> {
  $$AnimalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CalvingRecordsTable, List<CalvingRecord>>
  _calvingRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.calvingRecords,
    aliasName: $_aliasNameGenerator(db.animals.id, db.calvingRecords.animalId),
  );

  $$CalvingRecordsTableProcessedTableManager get calvingRecordsRefs {
    final manager = $$CalvingRecordsTableTableManager(
      $_db,
      $_db.calvingRecords,
    ).filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_calvingRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TreatmentRecordsTable, List<TreatmentRecord>>
  _treatmentRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.treatmentRecords,
    aliasName: $_aliasNameGenerator(
      db.animals.id,
      db.treatmentRecords.animalId,
    ),
  );

  $$TreatmentRecordsTableProcessedTableManager get treatmentRecordsRefs {
    final manager = $$TreatmentRecordsTableTableManager(
      $_db,
      $_db.treatmentRecords,
    ).filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _treatmentRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WeightRecordsTable, List<WeightRecord>>
  _weightRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weightRecords,
    aliasName: $_aliasNameGenerator(db.animals.id, db.weightRecords.animalId),
  );

  $$WeightRecordsTableProcessedTableManager get weightRecordsRefs {
    final manager = $$WeightRecordsTableTableManager(
      $_db,
      $_db.weightRecords,
    ).filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_weightRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SmartTagReadingsTable, List<SmartTagReading>>
  _smartTagReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.smartTagReadings,
    aliasName: $_aliasNameGenerator(
      db.animals.id,
      db.smartTagReadings.animalId,
    ),
  );

  $$SmartTagReadingsTableProcessedTableManager get smartTagReadingsRefs {
    final manager = $$SmartTagReadingsTableTableManager(
      $_db,
      $_db.smartTagReadings,
    ).filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _smartTagReadingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HealthAlertsTable, List<HealthAlert>>
  _healthAlertsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.healthAlerts,
    aliasName: $_aliasNameGenerator(db.animals.id, db.healthAlerts.animalId),
  );

  $$HealthAlertsTableProcessedTableManager get healthAlertsRefs {
    final manager = $$HealthAlertsTableTableManager(
      $_db,
      $_db.healthAlerts,
    ).filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_healthAlertsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SalesTable, List<Sale>> _salesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sales,
    aliasName: $_aliasNameGenerator(db.animals.id, db.sales.animalId),
  );

  $$SalesTableProcessedTableManager get salesRefs {
    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_salesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AnimalsTableFilterComposer
    extends Composer<_$AppDatabase, $AnimalsTable> {
  $$AnimalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagNumber => $composableBuilder(
    column: $table.tagNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AnimalSex, AnimalSex, String> get sex =>
      $composableBuilder(
        column: $table.sex,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<AnimalStatus, AnimalStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get sireTag => $composableBuilder(
    column: $table.sireTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damTag => $composableBuilder(
    column: $table.damTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchaseWeight => $composableBuilder(
    column: $table.purchaseWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rfidTag => $composableBuilder(
    column: $table.rfidTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get smartTagId => $composableBuilder(
    column: $table.smartTagId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentPastureId => $composableBuilder(
    column: $table.currentPastureId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  Expression<bool> calvingRecordsRefs(
    Expression<bool> Function($$CalvingRecordsTableFilterComposer f) f,
  ) {
    final $$CalvingRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.calvingRecords,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CalvingRecordsTableFilterComposer(
            $db: $db,
            $table: $db.calvingRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> treatmentRecordsRefs(
    Expression<bool> Function($$TreatmentRecordsTableFilterComposer f) f,
  ) {
    final $$TreatmentRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.treatmentRecords,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreatmentRecordsTableFilterComposer(
            $db: $db,
            $table: $db.treatmentRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weightRecordsRefs(
    Expression<bool> Function($$WeightRecordsTableFilterComposer f) f,
  ) {
    final $$WeightRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weightRecords,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeightRecordsTableFilterComposer(
            $db: $db,
            $table: $db.weightRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> smartTagReadingsRefs(
    Expression<bool> Function($$SmartTagReadingsTableFilterComposer f) f,
  ) {
    final $$SmartTagReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smartTagReadings,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SmartTagReadingsTableFilterComposer(
            $db: $db,
            $table: $db.smartTagReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> healthAlertsRefs(
    Expression<bool> Function($$HealthAlertsTableFilterComposer f) f,
  ) {
    final $$HealthAlertsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.healthAlerts,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HealthAlertsTableFilterComposer(
            $db: $db,
            $table: $db.healthAlerts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> salesRefs(
    Expression<bool> Function($$SalesTableFilterComposer f) f,
  ) {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AnimalsTableOrderingComposer
    extends Composer<_$AppDatabase, $AnimalsTable> {
  $$AnimalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagNumber => $composableBuilder(
    column: $table.tagNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sireTag => $composableBuilder(
    column: $table.sireTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damTag => $composableBuilder(
    column: $table.damTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchaseWeight => $composableBuilder(
    column: $table.purchaseWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rfidTag => $composableBuilder(
    column: $table.rfidTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get smartTagId => $composableBuilder(
    column: $table.smartTagId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentPastureId => $composableBuilder(
    column: $table.currentPastureId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnimalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnimalsTable> {
  $$AnimalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tagNumber =>
      $composableBuilder(column: $table.tagNumber, builder: (column) => column);

  GeneratedColumn<String> get breed =>
      $composableBuilder(column: $table.breed, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AnimalSex, String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AnimalStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get sireTag =>
      $composableBuilder(column: $table.sireTag, builder: (column) => column);

  GeneratedColumn<String> get damTag =>
      $composableBuilder(column: $table.damTag, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get purchaseWeight => $composableBuilder(
    column: $table.purchaseWeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rfidTag =>
      $composableBuilder(column: $table.rfidTag, builder: (column) => column);

  GeneratedColumn<String> get smartTagId => $composableBuilder(
    column: $table.smartTagId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentPastureId => $composableBuilder(
    column: $table.currentPastureId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  Expression<T> calvingRecordsRefs<T extends Object>(
    Expression<T> Function($$CalvingRecordsTableAnnotationComposer a) f,
  ) {
    final $$CalvingRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.calvingRecords,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CalvingRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.calvingRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> treatmentRecordsRefs<T extends Object>(
    Expression<T> Function($$TreatmentRecordsTableAnnotationComposer a) f,
  ) {
    final $$TreatmentRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.treatmentRecords,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TreatmentRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.treatmentRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> weightRecordsRefs<T extends Object>(
    Expression<T> Function($$WeightRecordsTableAnnotationComposer a) f,
  ) {
    final $$WeightRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weightRecords,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeightRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.weightRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> smartTagReadingsRefs<T extends Object>(
    Expression<T> Function($$SmartTagReadingsTableAnnotationComposer a) f,
  ) {
    final $$SmartTagReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smartTagReadings,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SmartTagReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.smartTagReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> healthAlertsRefs<T extends Object>(
    Expression<T> Function($$HealthAlertsTableAnnotationComposer a) f,
  ) {
    final $$HealthAlertsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.healthAlerts,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HealthAlertsTableAnnotationComposer(
            $db: $db,
            $table: $db.healthAlerts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> salesRefs<T extends Object>(
    Expression<T> Function($$SalesTableAnnotationComposer a) f,
  ) {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AnimalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnimalsTable,
          Animal,
          $$AnimalsTableFilterComposer,
          $$AnimalsTableOrderingComposer,
          $$AnimalsTableAnnotationComposer,
          $$AnimalsTableCreateCompanionBuilder,
          $$AnimalsTableUpdateCompanionBuilder,
          (Animal, $$AnimalsTableReferences),
          Animal,
          PrefetchHooks Function({
            bool calvingRecordsRefs,
            bool treatmentRecordsRefs,
            bool weightRecordsRefs,
            bool smartTagReadingsRefs,
            bool healthAlertsRefs,
            bool salesRefs,
          })
        > {
  $$AnimalsTableTableManager(_$AppDatabase db, $AnimalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnimalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnimalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnimalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tagNumber = const Value.absent(),
                Value<String> breed = const Value.absent(),
                Value<DateTime> dateOfBirth = const Value.absent(),
                Value<AnimalSex> sex = const Value.absent(),
                Value<AnimalStatus> status = const Value.absent(),
                Value<String?> sireTag = const Value.absent(),
                Value<String?> damTag = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<double?> purchaseWeight = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<String?> rfidTag = const Value.absent(),
                Value<String?> smartTagId = const Value.absent(),
                Value<String?> currentPastureId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnimalsCompanion(
                id: id,
                tagNumber: tagNumber,
                breed: breed,
                dateOfBirth: dateOfBirth,
                sex: sex,
                status: status,
                sireTag: sireTag,
                damTag: damTag,
                notes: notes,
                purchaseDate: purchaseDate,
                purchaseWeight: purchaseWeight,
                purchasePrice: purchasePrice,
                rfidTag: rfidTag,
                smartTagId: smartTagId,
                currentPastureId: currentPastureId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tagNumber,
                Value<String> breed = const Value.absent(),
                required DateTime dateOfBirth,
                required AnimalSex sex,
                required AnimalStatus status,
                Value<String?> sireTag = const Value.absent(),
                Value<String?> damTag = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<double?> purchaseWeight = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<String?> rfidTag = const Value.absent(),
                Value<String?> smartTagId = const Value.absent(),
                Value<String?> currentPastureId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnimalsCompanion.insert(
                id: id,
                tagNumber: tagNumber,
                breed: breed,
                dateOfBirth: dateOfBirth,
                sex: sex,
                status: status,
                sireTag: sireTag,
                damTag: damTag,
                notes: notes,
                purchaseDate: purchaseDate,
                purchaseWeight: purchaseWeight,
                purchasePrice: purchasePrice,
                rfidTag: rfidTag,
                smartTagId: smartTagId,
                currentPastureId: currentPastureId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AnimalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                calvingRecordsRefs = false,
                treatmentRecordsRefs = false,
                weightRecordsRefs = false,
                smartTagReadingsRefs = false,
                healthAlertsRefs = false,
                salesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (calvingRecordsRefs) db.calvingRecords,
                    if (treatmentRecordsRefs) db.treatmentRecords,
                    if (weightRecordsRefs) db.weightRecords,
                    if (smartTagReadingsRefs) db.smartTagReadings,
                    if (healthAlertsRefs) db.healthAlerts,
                    if (salesRefs) db.sales,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (calvingRecordsRefs)
                        await $_getPrefetchedData<
                          Animal,
                          $AnimalsTable,
                          CalvingRecord
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalsTableReferences
                              ._calvingRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalsTableReferences(
                                db,
                                table,
                                p0,
                              ).calvingRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.animalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (treatmentRecordsRefs)
                        await $_getPrefetchedData<
                          Animal,
                          $AnimalsTable,
                          TreatmentRecord
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalsTableReferences
                              ._treatmentRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalsTableReferences(
                                db,
                                table,
                                p0,
                              ).treatmentRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.animalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (weightRecordsRefs)
                        await $_getPrefetchedData<
                          Animal,
                          $AnimalsTable,
                          WeightRecord
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalsTableReferences
                              ._weightRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalsTableReferences(
                                db,
                                table,
                                p0,
                              ).weightRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.animalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (smartTagReadingsRefs)
                        await $_getPrefetchedData<
                          Animal,
                          $AnimalsTable,
                          SmartTagReading
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalsTableReferences
                              ._smartTagReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalsTableReferences(
                                db,
                                table,
                                p0,
                              ).smartTagReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.animalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (healthAlertsRefs)
                        await $_getPrefetchedData<
                          Animal,
                          $AnimalsTable,
                          HealthAlert
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalsTableReferences
                              ._healthAlertsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalsTableReferences(
                                db,
                                table,
                                p0,
                              ).healthAlertsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.animalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (salesRefs)
                        await $_getPrefetchedData<Animal, $AnimalsTable, Sale>(
                          currentTable: table,
                          referencedTable: $$AnimalsTableReferences
                              ._salesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalsTableReferences(db, table, p0).salesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.animalId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AnimalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnimalsTable,
      Animal,
      $$AnimalsTableFilterComposer,
      $$AnimalsTableOrderingComposer,
      $$AnimalsTableAnnotationComposer,
      $$AnimalsTableCreateCompanionBuilder,
      $$AnimalsTableUpdateCompanionBuilder,
      (Animal, $$AnimalsTableReferences),
      Animal,
      PrefetchHooks Function({
        bool calvingRecordsRefs,
        bool treatmentRecordsRefs,
        bool weightRecordsRefs,
        bool smartTagReadingsRefs,
        bool healthAlertsRefs,
        bool salesRefs,
      })
    >;
typedef $$CalvingRecordsTableCreateCompanionBuilder =
    CalvingRecordsCompanion Function({
      required String id,
      required String animalId,
      required DateTime date,
      required String calfTag,
      required AnimalSex calfSex,
      Value<double?> birthWeight,
      Value<int> calvingEaseScore,
      Value<String> notes,
      required DateTime createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });
typedef $$CalvingRecordsTableUpdateCompanionBuilder =
    CalvingRecordsCompanion Function({
      Value<String> id,
      Value<String> animalId,
      Value<DateTime> date,
      Value<String> calfTag,
      Value<AnimalSex> calfSex,
      Value<double?> birthWeight,
      Value<int> calvingEaseScore,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });

final class $$CalvingRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $CalvingRecordsTable, CalvingRecord> {
  $$CalvingRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AnimalsTable _animalIdTable(_$AppDatabase db) =>
      db.animals.createAlias(
        $_aliasNameGenerator(db.calvingRecords.animalId, db.animals.id),
      );

  $$AnimalsTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalsTableTableManager(
      $_db,
      $_db.animals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CalvingRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $CalvingRecordsTable> {
  $$CalvingRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calfTag => $composableBuilder(
    column: $table.calfTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AnimalSex, AnimalSex, String> get calfSex =>
      $composableBuilder(
        column: $table.calfSex,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get birthWeight => $composableBuilder(
    column: $table.birthWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calvingEaseScore => $composableBuilder(
    column: $table.calvingEaseScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$AnimalsTableFilterComposer get animalId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableFilterComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CalvingRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $CalvingRecordsTable> {
  $$CalvingRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calfTag => $composableBuilder(
    column: $table.calfTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calfSex => $composableBuilder(
    column: $table.calfSex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get birthWeight => $composableBuilder(
    column: $table.birthWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calvingEaseScore => $composableBuilder(
    column: $table.calvingEaseScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnimalsTableOrderingComposer get animalId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableOrderingComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CalvingRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalvingRecordsTable> {
  $$CalvingRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get calfTag =>
      $composableBuilder(column: $table.calfTag, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AnimalSex, String> get calfSex =>
      $composableBuilder(column: $table.calfSex, builder: (column) => column);

  GeneratedColumn<double> get birthWeight => $composableBuilder(
    column: $table.birthWeight,
    builder: (column) => column,
  );

  GeneratedColumn<int> get calvingEaseScore => $composableBuilder(
    column: $table.calvingEaseScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  $$AnimalsTableAnnotationComposer get animalId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableAnnotationComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CalvingRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalvingRecordsTable,
          CalvingRecord,
          $$CalvingRecordsTableFilterComposer,
          $$CalvingRecordsTableOrderingComposer,
          $$CalvingRecordsTableAnnotationComposer,
          $$CalvingRecordsTableCreateCompanionBuilder,
          $$CalvingRecordsTableUpdateCompanionBuilder,
          (CalvingRecord, $$CalvingRecordsTableReferences),
          CalvingRecord,
          PrefetchHooks Function({bool animalId})
        > {
  $$CalvingRecordsTableTableManager(
    _$AppDatabase db,
    $CalvingRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalvingRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalvingRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalvingRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> animalId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> calfTag = const Value.absent(),
                Value<AnimalSex> calfSex = const Value.absent(),
                Value<double?> birthWeight = const Value.absent(),
                Value<int> calvingEaseScore = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CalvingRecordsCompanion(
                id: id,
                animalId: animalId,
                date: date,
                calfTag: calfTag,
                calfSex: calfSex,
                birthWeight: birthWeight,
                calvingEaseScore: calvingEaseScore,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String animalId,
                required DateTime date,
                required String calfTag,
                required AnimalSex calfSex,
                Value<double?> birthWeight = const Value.absent(),
                Value<int> calvingEaseScore = const Value.absent(),
                Value<String> notes = const Value.absent(),
                required DateTime createdAt,
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CalvingRecordsCompanion.insert(
                id: id,
                animalId: animalId,
                date: date,
                calfTag: calfTag,
                calfSex: calfSex,
                birthWeight: birthWeight,
                calvingEaseScore: calvingEaseScore,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CalvingRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({animalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (animalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.animalId,
                                referencedTable: $$CalvingRecordsTableReferences
                                    ._animalIdTable(db),
                                referencedColumn:
                                    $$CalvingRecordsTableReferences
                                        ._animalIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CalvingRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalvingRecordsTable,
      CalvingRecord,
      $$CalvingRecordsTableFilterComposer,
      $$CalvingRecordsTableOrderingComposer,
      $$CalvingRecordsTableAnnotationComposer,
      $$CalvingRecordsTableCreateCompanionBuilder,
      $$CalvingRecordsTableUpdateCompanionBuilder,
      (CalvingRecord, $$CalvingRecordsTableReferences),
      CalvingRecord,
      PrefetchHooks Function({bool animalId})
    >;
typedef $$TreatmentRecordsTableCreateCompanionBuilder =
    TreatmentRecordsCompanion Function({
      required String id,
      required String animalId,
      required DateTime date,
      required String treatment,
      Value<String> dosage,
      required TreatmentRoute route,
      Value<String> reason,
      Value<int> withdrawalDays,
      Value<DateTime?> withdrawalDate,
      Value<String> notes,
      required DateTime createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });
typedef $$TreatmentRecordsTableUpdateCompanionBuilder =
    TreatmentRecordsCompanion Function({
      Value<String> id,
      Value<String> animalId,
      Value<DateTime> date,
      Value<String> treatment,
      Value<String> dosage,
      Value<TreatmentRoute> route,
      Value<String> reason,
      Value<int> withdrawalDays,
      Value<DateTime?> withdrawalDate,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });

final class $$TreatmentRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $TreatmentRecordsTable, TreatmentRecord> {
  $$TreatmentRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AnimalsTable _animalIdTable(_$AppDatabase db) =>
      db.animals.createAlias(
        $_aliasNameGenerator(db.treatmentRecords.animalId, db.animals.id),
      );

  $$AnimalsTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalsTableTableManager(
      $_db,
      $_db.animals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TreatmentRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $TreatmentRecordsTable> {
  $$TreatmentRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treatment => $composableBuilder(
    column: $table.treatment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dosage => $composableBuilder(
    column: $table.dosage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TreatmentRoute, TreatmentRoute, String>
  get route => $composableBuilder(
    column: $table.route,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get withdrawalDays => $composableBuilder(
    column: $table.withdrawalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get withdrawalDate => $composableBuilder(
    column: $table.withdrawalDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$AnimalsTableFilterComposer get animalId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableFilterComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TreatmentRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $TreatmentRecordsTable> {
  $$TreatmentRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treatment => $composableBuilder(
    column: $table.treatment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dosage => $composableBuilder(
    column: $table.dosage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get route => $composableBuilder(
    column: $table.route,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get withdrawalDays => $composableBuilder(
    column: $table.withdrawalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get withdrawalDate => $composableBuilder(
    column: $table.withdrawalDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnimalsTableOrderingComposer get animalId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableOrderingComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TreatmentRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TreatmentRecordsTable> {
  $$TreatmentRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get treatment =>
      $composableBuilder(column: $table.treatment, builder: (column) => column);

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TreatmentRoute, String> get route =>
      $composableBuilder(column: $table.route, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<int> get withdrawalDays => $composableBuilder(
    column: $table.withdrawalDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get withdrawalDate => $composableBuilder(
    column: $table.withdrawalDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  $$AnimalsTableAnnotationComposer get animalId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableAnnotationComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TreatmentRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TreatmentRecordsTable,
          TreatmentRecord,
          $$TreatmentRecordsTableFilterComposer,
          $$TreatmentRecordsTableOrderingComposer,
          $$TreatmentRecordsTableAnnotationComposer,
          $$TreatmentRecordsTableCreateCompanionBuilder,
          $$TreatmentRecordsTableUpdateCompanionBuilder,
          (TreatmentRecord, $$TreatmentRecordsTableReferences),
          TreatmentRecord,
          PrefetchHooks Function({bool animalId})
        > {
  $$TreatmentRecordsTableTableManager(
    _$AppDatabase db,
    $TreatmentRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreatmentRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreatmentRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreatmentRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> animalId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> treatment = const Value.absent(),
                Value<String> dosage = const Value.absent(),
                Value<TreatmentRoute> route = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<int> withdrawalDays = const Value.absent(),
                Value<DateTime?> withdrawalDate = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TreatmentRecordsCompanion(
                id: id,
                animalId: animalId,
                date: date,
                treatment: treatment,
                dosage: dosage,
                route: route,
                reason: reason,
                withdrawalDays: withdrawalDays,
                withdrawalDate: withdrawalDate,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String animalId,
                required DateTime date,
                required String treatment,
                Value<String> dosage = const Value.absent(),
                required TreatmentRoute route,
                Value<String> reason = const Value.absent(),
                Value<int> withdrawalDays = const Value.absent(),
                Value<DateTime?> withdrawalDate = const Value.absent(),
                Value<String> notes = const Value.absent(),
                required DateTime createdAt,
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TreatmentRecordsCompanion.insert(
                id: id,
                animalId: animalId,
                date: date,
                treatment: treatment,
                dosage: dosage,
                route: route,
                reason: reason,
                withdrawalDays: withdrawalDays,
                withdrawalDate: withdrawalDate,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TreatmentRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({animalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (animalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.animalId,
                                referencedTable:
                                    $$TreatmentRecordsTableReferences
                                        ._animalIdTable(db),
                                referencedColumn:
                                    $$TreatmentRecordsTableReferences
                                        ._animalIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TreatmentRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TreatmentRecordsTable,
      TreatmentRecord,
      $$TreatmentRecordsTableFilterComposer,
      $$TreatmentRecordsTableOrderingComposer,
      $$TreatmentRecordsTableAnnotationComposer,
      $$TreatmentRecordsTableCreateCompanionBuilder,
      $$TreatmentRecordsTableUpdateCompanionBuilder,
      (TreatmentRecord, $$TreatmentRecordsTableReferences),
      TreatmentRecord,
      PrefetchHooks Function({bool animalId})
    >;
typedef $$WeightRecordsTableCreateCompanionBuilder =
    WeightRecordsCompanion Function({
      required String id,
      required String animalId,
      required DateTime date,
      required double weight,
      Value<String> notes,
      required DateTime createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });
typedef $$WeightRecordsTableUpdateCompanionBuilder =
    WeightRecordsCompanion Function({
      Value<String> id,
      Value<String> animalId,
      Value<DateTime> date,
      Value<double> weight,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });

final class $$WeightRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $WeightRecordsTable, WeightRecord> {
  $$WeightRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AnimalsTable _animalIdTable(_$AppDatabase db) =>
      db.animals.createAlias(
        $_aliasNameGenerator(db.weightRecords.animalId, db.animals.id),
      );

  $$AnimalsTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalsTableTableManager(
      $_db,
      $_db.animals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeightRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$AnimalsTableFilterComposer get animalId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableFilterComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnimalsTableOrderingComposer get animalId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableOrderingComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  $$AnimalsTableAnnotationComposer get animalId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableAnnotationComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeightRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeightRecordsTable,
          WeightRecord,
          $$WeightRecordsTableFilterComposer,
          $$WeightRecordsTableOrderingComposer,
          $$WeightRecordsTableAnnotationComposer,
          $$WeightRecordsTableCreateCompanionBuilder,
          $$WeightRecordsTableUpdateCompanionBuilder,
          (WeightRecord, $$WeightRecordsTableReferences),
          WeightRecord,
          PrefetchHooks Function({bool animalId})
        > {
  $$WeightRecordsTableTableManager(_$AppDatabase db, $WeightRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> animalId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeightRecordsCompanion(
                id: id,
                animalId: animalId,
                date: date,
                weight: weight,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String animalId,
                required DateTime date,
                required double weight,
                Value<String> notes = const Value.absent(),
                required DateTime createdAt,
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeightRecordsCompanion.insert(
                id: id,
                animalId: animalId,
                date: date,
                weight: weight,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeightRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({animalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (animalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.animalId,
                                referencedTable: $$WeightRecordsTableReferences
                                    ._animalIdTable(db),
                                referencedColumn: $$WeightRecordsTableReferences
                                    ._animalIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeightRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeightRecordsTable,
      WeightRecord,
      $$WeightRecordsTableFilterComposer,
      $$WeightRecordsTableOrderingComposer,
      $$WeightRecordsTableAnnotationComposer,
      $$WeightRecordsTableCreateCompanionBuilder,
      $$WeightRecordsTableUpdateCompanionBuilder,
      (WeightRecord, $$WeightRecordsTableReferences),
      WeightRecord,
      PrefetchHooks Function({bool animalId})
    >;
typedef $$PriceAlertsTableCreateCompanionBuilder =
    PriceAlertsCompanion Function({
      required String id,
      required PriceAlertType alertType,
      required String weightClass,
      required double targetPrice,
      Value<bool> isAboveTarget,
      Value<bool> isEnabled,
      Value<DateTime?> lastTriggered,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$PriceAlertsTableUpdateCompanionBuilder =
    PriceAlertsCompanion Function({
      Value<String> id,
      Value<PriceAlertType> alertType,
      Value<String> weightClass,
      Value<double> targetPrice,
      Value<bool> isAboveTarget,
      Value<bool> isEnabled,
      Value<DateTime?> lastTriggered,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$PriceAlertsTableFilterComposer
    extends Composer<_$AppDatabase, $PriceAlertsTable> {
  $$PriceAlertsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PriceAlertType, PriceAlertType, String>
  get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get weightClass => $composableBuilder(
    column: $table.weightClass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetPrice => $composableBuilder(
    column: $table.targetPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAboveTarget => $composableBuilder(
    column: $table.isAboveTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastTriggered => $composableBuilder(
    column: $table.lastTriggered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PriceAlertsTableOrderingComposer
    extends Composer<_$AppDatabase, $PriceAlertsTable> {
  $$PriceAlertsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weightClass => $composableBuilder(
    column: $table.weightClass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetPrice => $composableBuilder(
    column: $table.targetPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAboveTarget => $composableBuilder(
    column: $table.isAboveTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastTriggered => $composableBuilder(
    column: $table.lastTriggered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PriceAlertsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PriceAlertsTable> {
  $$PriceAlertsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PriceAlertType, String> get alertType =>
      $composableBuilder(column: $table.alertType, builder: (column) => column);

  GeneratedColumn<String> get weightClass => $composableBuilder(
    column: $table.weightClass,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetPrice => $composableBuilder(
    column: $table.targetPrice,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAboveTarget => $composableBuilder(
    column: $table.isAboveTarget,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get lastTriggered => $composableBuilder(
    column: $table.lastTriggered,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PriceAlertsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PriceAlertsTable,
          PriceAlert,
          $$PriceAlertsTableFilterComposer,
          $$PriceAlertsTableOrderingComposer,
          $$PriceAlertsTableAnnotationComposer,
          $$PriceAlertsTableCreateCompanionBuilder,
          $$PriceAlertsTableUpdateCompanionBuilder,
          (
            PriceAlert,
            BaseReferences<_$AppDatabase, $PriceAlertsTable, PriceAlert>,
          ),
          PriceAlert,
          PrefetchHooks Function()
        > {
  $$PriceAlertsTableTableManager(_$AppDatabase db, $PriceAlertsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PriceAlertsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PriceAlertsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PriceAlertsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<PriceAlertType> alertType = const Value.absent(),
                Value<String> weightClass = const Value.absent(),
                Value<double> targetPrice = const Value.absent(),
                Value<bool> isAboveTarget = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DateTime?> lastTriggered = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PriceAlertsCompanion(
                id: id,
                alertType: alertType,
                weightClass: weightClass,
                targetPrice: targetPrice,
                isAboveTarget: isAboveTarget,
                isEnabled: isEnabled,
                lastTriggered: lastTriggered,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required PriceAlertType alertType,
                required String weightClass,
                required double targetPrice,
                Value<bool> isAboveTarget = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DateTime?> lastTriggered = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PriceAlertsCompanion.insert(
                id: id,
                alertType: alertType,
                weightClass: weightClass,
                targetPrice: targetPrice,
                isAboveTarget: isAboveTarget,
                isEnabled: isEnabled,
                lastTriggered: lastTriggered,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PriceAlertsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PriceAlertsTable,
      PriceAlert,
      $$PriceAlertsTableFilterComposer,
      $$PriceAlertsTableOrderingComposer,
      $$PriceAlertsTableAnnotationComposer,
      $$PriceAlertsTableCreateCompanionBuilder,
      $$PriceAlertsTableUpdateCompanionBuilder,
      (
        PriceAlert,
        BaseReferences<_$AppDatabase, $PriceAlertsTable, PriceAlert>,
      ),
      PriceAlert,
      PrefetchHooks Function()
    >;
typedef $$RanchSettingsTableCreateCompanionBuilder =
    RanchSettingsCompanion Function({
      required String id,
      Value<String> ranchName,
      Value<double?> locationLatitude,
      Value<double?> locationLongitude,
      Value<String> locationName,
      Value<bool> notificationsEnabled,
      Value<bool> priceAlertsEnabled,
      Value<bool> weatherAlertsEnabled,
      Value<bool> severeWeatherAlertsEnabled,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$RanchSettingsTableUpdateCompanionBuilder =
    RanchSettingsCompanion Function({
      Value<String> id,
      Value<String> ranchName,
      Value<double?> locationLatitude,
      Value<double?> locationLongitude,
      Value<String> locationName,
      Value<bool> notificationsEnabled,
      Value<bool> priceAlertsEnabled,
      Value<bool> weatherAlertsEnabled,
      Value<bool> severeWeatherAlertsEnabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$RanchSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $RanchSettingsTable> {
  $$RanchSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ranchName => $composableBuilder(
    column: $table.ranchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get locationLatitude => $composableBuilder(
    column: $table.locationLatitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get locationLongitude => $composableBuilder(
    column: $table.locationLongitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get priceAlertsEnabled => $composableBuilder(
    column: $table.priceAlertsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get weatherAlertsEnabled => $composableBuilder(
    column: $table.weatherAlertsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get severeWeatherAlertsEnabled => $composableBuilder(
    column: $table.severeWeatherAlertsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RanchSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $RanchSettingsTable> {
  $$RanchSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ranchName => $composableBuilder(
    column: $table.ranchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get locationLatitude => $composableBuilder(
    column: $table.locationLatitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get locationLongitude => $composableBuilder(
    column: $table.locationLongitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get priceAlertsEnabled => $composableBuilder(
    column: $table.priceAlertsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get weatherAlertsEnabled => $composableBuilder(
    column: $table.weatherAlertsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get severeWeatherAlertsEnabled => $composableBuilder(
    column: $table.severeWeatherAlertsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RanchSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RanchSettingsTable> {
  $$RanchSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ranchName =>
      $composableBuilder(column: $table.ranchName, builder: (column) => column);

  GeneratedColumn<double> get locationLatitude => $composableBuilder(
    column: $table.locationLatitude,
    builder: (column) => column,
  );

  GeneratedColumn<double> get locationLongitude => $composableBuilder(
    column: $table.locationLongitude,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get priceAlertsEnabled => $composableBuilder(
    column: $table.priceAlertsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get weatherAlertsEnabled => $composableBuilder(
    column: $table.weatherAlertsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get severeWeatherAlertsEnabled => $composableBuilder(
    column: $table.severeWeatherAlertsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RanchSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RanchSettingsTable,
          RanchSetting,
          $$RanchSettingsTableFilterComposer,
          $$RanchSettingsTableOrderingComposer,
          $$RanchSettingsTableAnnotationComposer,
          $$RanchSettingsTableCreateCompanionBuilder,
          $$RanchSettingsTableUpdateCompanionBuilder,
          (
            RanchSetting,
            BaseReferences<_$AppDatabase, $RanchSettingsTable, RanchSetting>,
          ),
          RanchSetting,
          PrefetchHooks Function()
        > {
  $$RanchSettingsTableTableManager(_$AppDatabase db, $RanchSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RanchSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RanchSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RanchSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ranchName = const Value.absent(),
                Value<double?> locationLatitude = const Value.absent(),
                Value<double?> locationLongitude = const Value.absent(),
                Value<String> locationName = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<bool> priceAlertsEnabled = const Value.absent(),
                Value<bool> weatherAlertsEnabled = const Value.absent(),
                Value<bool> severeWeatherAlertsEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RanchSettingsCompanion(
                id: id,
                ranchName: ranchName,
                locationLatitude: locationLatitude,
                locationLongitude: locationLongitude,
                locationName: locationName,
                notificationsEnabled: notificationsEnabled,
                priceAlertsEnabled: priceAlertsEnabled,
                weatherAlertsEnabled: weatherAlertsEnabled,
                severeWeatherAlertsEnabled: severeWeatherAlertsEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> ranchName = const Value.absent(),
                Value<double?> locationLatitude = const Value.absent(),
                Value<double?> locationLongitude = const Value.absent(),
                Value<String> locationName = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<bool> priceAlertsEnabled = const Value.absent(),
                Value<bool> weatherAlertsEnabled = const Value.absent(),
                Value<bool> severeWeatherAlertsEnabled = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RanchSettingsCompanion.insert(
                id: id,
                ranchName: ranchName,
                locationLatitude: locationLatitude,
                locationLongitude: locationLongitude,
                locationName: locationName,
                notificationsEnabled: notificationsEnabled,
                priceAlertsEnabled: priceAlertsEnabled,
                weatherAlertsEnabled: weatherAlertsEnabled,
                severeWeatherAlertsEnabled: severeWeatherAlertsEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RanchSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RanchSettingsTable,
      RanchSetting,
      $$RanchSettingsTableFilterComposer,
      $$RanchSettingsTableOrderingComposer,
      $$RanchSettingsTableAnnotationComposer,
      $$RanchSettingsTableCreateCompanionBuilder,
      $$RanchSettingsTableUpdateCompanionBuilder,
      (
        RanchSetting,
        BaseReferences<_$AppDatabase, $RanchSettingsTable, RanchSetting>,
      ),
      RanchSetting,
      PrefetchHooks Function()
    >;
typedef $$PasturesTableCreateCompanionBuilder =
    PasturesCompanion Function({
      required String id,
      required String name,
      required String boundaryJson,
      Value<double?> acreage,
      Value<String> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });
typedef $$PasturesTableUpdateCompanionBuilder =
    PasturesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> boundaryJson,
      Value<double?> acreage,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });

final class $$PasturesTableReferences
    extends BaseReferences<_$AppDatabase, $PasturesTable, Pasture> {
  $$PasturesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GrazingRotationsTable, List<GrazingRotation>>
  _grazingRotationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.grazingRotations,
    aliasName: $_aliasNameGenerator(
      db.pastures.id,
      db.grazingRotations.pastureId,
    ),
  );

  $$GrazingRotationsTableProcessedTableManager get grazingRotationsRefs {
    final manager = $$GrazingRotationsTableTableManager(
      $_db,
      $_db.grazingRotations,
    ).filter((f) => f.pastureId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _grazingRotationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PasturesTableFilterComposer
    extends Composer<_$AppDatabase, $PasturesTable> {
  $$PasturesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boundaryJson => $composableBuilder(
    column: $table.boundaryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get acreage => $composableBuilder(
    column: $table.acreage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  Expression<bool> grazingRotationsRefs(
    Expression<bool> Function($$GrazingRotationsTableFilterComposer f) f,
  ) {
    final $$GrazingRotationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.grazingRotations,
      getReferencedColumn: (t) => t.pastureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrazingRotationsTableFilterComposer(
            $db: $db,
            $table: $db.grazingRotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PasturesTableOrderingComposer
    extends Composer<_$AppDatabase, $PasturesTable> {
  $$PasturesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boundaryJson => $composableBuilder(
    column: $table.boundaryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get acreage => $composableBuilder(
    column: $table.acreage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PasturesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PasturesTable> {
  $$PasturesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get boundaryJson => $composableBuilder(
    column: $table.boundaryJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get acreage =>
      $composableBuilder(column: $table.acreage, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  Expression<T> grazingRotationsRefs<T extends Object>(
    Expression<T> Function($$GrazingRotationsTableAnnotationComposer a) f,
  ) {
    final $$GrazingRotationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.grazingRotations,
      getReferencedColumn: (t) => t.pastureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrazingRotationsTableAnnotationComposer(
            $db: $db,
            $table: $db.grazingRotations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PasturesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PasturesTable,
          Pasture,
          $$PasturesTableFilterComposer,
          $$PasturesTableOrderingComposer,
          $$PasturesTableAnnotationComposer,
          $$PasturesTableCreateCompanionBuilder,
          $$PasturesTableUpdateCompanionBuilder,
          (Pasture, $$PasturesTableReferences),
          Pasture,
          PrefetchHooks Function({bool grazingRotationsRefs})
        > {
  $$PasturesTableTableManager(_$AppDatabase db, $PasturesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PasturesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PasturesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PasturesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> boundaryJson = const Value.absent(),
                Value<double?> acreage = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PasturesCompanion(
                id: id,
                name: name,
                boundaryJson: boundaryJson,
                acreage: acreage,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String boundaryJson,
                Value<double?> acreage = const Value.absent(),
                Value<String> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PasturesCompanion.insert(
                id: id,
                name: name,
                boundaryJson: boundaryJson,
                acreage: acreage,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PasturesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({grazingRotationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (grazingRotationsRefs) db.grazingRotations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (grazingRotationsRefs)
                    await $_getPrefetchedData<
                      Pasture,
                      $PasturesTable,
                      GrazingRotation
                    >(
                      currentTable: table,
                      referencedTable: $$PasturesTableReferences
                          ._grazingRotationsRefsTable(db),
                      managerFromTypedResult: (p0) => $$PasturesTableReferences(
                        db,
                        table,
                        p0,
                      ).grazingRotationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.pastureId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PasturesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PasturesTable,
      Pasture,
      $$PasturesTableFilterComposer,
      $$PasturesTableOrderingComposer,
      $$PasturesTableAnnotationComposer,
      $$PasturesTableCreateCompanionBuilder,
      $$PasturesTableUpdateCompanionBuilder,
      (Pasture, $$PasturesTableReferences),
      Pasture,
      PrefetchHooks Function({bool grazingRotationsRefs})
    >;
typedef $$GrazingRotationsTableCreateCompanionBuilder =
    GrazingRotationsCompanion Function({
      required String id,
      required String pastureId,
      required DateTime startDate,
      Value<DateTime?> endDate,
      required String animalIds,
      Value<String> notes,
      required DateTime createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });
typedef $$GrazingRotationsTableUpdateCompanionBuilder =
    GrazingRotationsCompanion Function({
      Value<String> id,
      Value<String> pastureId,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<String> animalIds,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });

final class $$GrazingRotationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $GrazingRotationsTable, GrazingRotation> {
  $$GrazingRotationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PasturesTable _pastureIdTable(_$AppDatabase db) =>
      db.pastures.createAlias(
        $_aliasNameGenerator(db.grazingRotations.pastureId, db.pastures.id),
      );

  $$PasturesTableProcessedTableManager get pastureId {
    final $_column = $_itemColumn<String>('pasture_id')!;

    final manager = $$PasturesTableTableManager(
      $_db,
      $_db.pastures,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pastureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GrazingRotationsTableFilterComposer
    extends Composer<_$AppDatabase, $GrazingRotationsTable> {
  $$GrazingRotationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get animalIds => $composableBuilder(
    column: $table.animalIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$PasturesTableFilterComposer get pastureId {
    final $$PasturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastureId,
      referencedTable: $db.pastures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PasturesTableFilterComposer(
            $db: $db,
            $table: $db.pastures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrazingRotationsTableOrderingComposer
    extends Composer<_$AppDatabase, $GrazingRotationsTable> {
  $$GrazingRotationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get animalIds => $composableBuilder(
    column: $table.animalIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$PasturesTableOrderingComposer get pastureId {
    final $$PasturesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastureId,
      referencedTable: $db.pastures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PasturesTableOrderingComposer(
            $db: $db,
            $table: $db.pastures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrazingRotationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrazingRotationsTable> {
  $$GrazingRotationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get animalIds =>
      $composableBuilder(column: $table.animalIds, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  $$PasturesTableAnnotationComposer get pastureId {
    final $$PasturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastureId,
      referencedTable: $db.pastures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PasturesTableAnnotationComposer(
            $db: $db,
            $table: $db.pastures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrazingRotationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrazingRotationsTable,
          GrazingRotation,
          $$GrazingRotationsTableFilterComposer,
          $$GrazingRotationsTableOrderingComposer,
          $$GrazingRotationsTableAnnotationComposer,
          $$GrazingRotationsTableCreateCompanionBuilder,
          $$GrazingRotationsTableUpdateCompanionBuilder,
          (GrazingRotation, $$GrazingRotationsTableReferences),
          GrazingRotation,
          PrefetchHooks Function({bool pastureId})
        > {
  $$GrazingRotationsTableTableManager(
    _$AppDatabase db,
    $GrazingRotationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrazingRotationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrazingRotationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrazingRotationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pastureId = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String> animalIds = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrazingRotationsCompanion(
                id: id,
                pastureId: pastureId,
                startDate: startDate,
                endDate: endDate,
                animalIds: animalIds,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pastureId,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                required String animalIds,
                Value<String> notes = const Value.absent(),
                required DateTime createdAt,
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrazingRotationsCompanion.insert(
                id: id,
                pastureId: pastureId,
                startDate: startDate,
                endDate: endDate,
                animalIds: animalIds,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GrazingRotationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pastureId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pastureId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pastureId,
                                referencedTable:
                                    $$GrazingRotationsTableReferences
                                        ._pastureIdTable(db),
                                referencedColumn:
                                    $$GrazingRotationsTableReferences
                                        ._pastureIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GrazingRotationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrazingRotationsTable,
      GrazingRotation,
      $$GrazingRotationsTableFilterComposer,
      $$GrazingRotationsTableOrderingComposer,
      $$GrazingRotationsTableAnnotationComposer,
      $$GrazingRotationsTableCreateCompanionBuilder,
      $$GrazingRotationsTableUpdateCompanionBuilder,
      (GrazingRotation, $$GrazingRotationsTableReferences),
      GrazingRotation,
      PrefetchHooks Function({bool pastureId})
    >;
typedef $$SmartTagReadingsTableCreateCompanionBuilder =
    SmartTagReadingsCompanion Function({
      required String id,
      required String animalId,
      required DateTime timestamp,
      Value<double?> temperature,
      Value<double?> activityLevel,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<int?> batteryLevel,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SmartTagReadingsTableUpdateCompanionBuilder =
    SmartTagReadingsCompanion Function({
      Value<String> id,
      Value<String> animalId,
      Value<DateTime> timestamp,
      Value<double?> temperature,
      Value<double?> activityLevel,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<int?> batteryLevel,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$SmartTagReadingsTableReferences
    extends
        BaseReferences<_$AppDatabase, $SmartTagReadingsTable, SmartTagReading> {
  $$SmartTagReadingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AnimalsTable _animalIdTable(_$AppDatabase db) =>
      db.animals.createAlias(
        $_aliasNameGenerator(db.smartTagReadings.animalId, db.animals.id),
      );

  $$AnimalsTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalsTableTableManager(
      $_db,
      $_db.animals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SmartTagReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $SmartTagReadingsTable> {
  $$SmartTagReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AnimalsTableFilterComposer get animalId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableFilterComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SmartTagReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SmartTagReadingsTable> {
  $$SmartTagReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnimalsTableOrderingComposer get animalId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableOrderingComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SmartTagReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmartTagReadingsTable> {
  $$SmartTagReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<double> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AnimalsTableAnnotationComposer get animalId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableAnnotationComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SmartTagReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SmartTagReadingsTable,
          SmartTagReading,
          $$SmartTagReadingsTableFilterComposer,
          $$SmartTagReadingsTableOrderingComposer,
          $$SmartTagReadingsTableAnnotationComposer,
          $$SmartTagReadingsTableCreateCompanionBuilder,
          $$SmartTagReadingsTableUpdateCompanionBuilder,
          (SmartTagReading, $$SmartTagReadingsTableReferences),
          SmartTagReading,
          PrefetchHooks Function({bool animalId})
        > {
  $$SmartTagReadingsTableTableManager(
    _$AppDatabase db,
    $SmartTagReadingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmartTagReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmartTagReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmartTagReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> animalId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<double?> activityLevel = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<int?> batteryLevel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SmartTagReadingsCompanion(
                id: id,
                animalId: animalId,
                timestamp: timestamp,
                temperature: temperature,
                activityLevel: activityLevel,
                latitude: latitude,
                longitude: longitude,
                batteryLevel: batteryLevel,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String animalId,
                required DateTime timestamp,
                Value<double?> temperature = const Value.absent(),
                Value<double?> activityLevel = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<int?> batteryLevel = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SmartTagReadingsCompanion.insert(
                id: id,
                animalId: animalId,
                timestamp: timestamp,
                temperature: temperature,
                activityLevel: activityLevel,
                latitude: latitude,
                longitude: longitude,
                batteryLevel: batteryLevel,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SmartTagReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({animalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (animalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.animalId,
                                referencedTable:
                                    $$SmartTagReadingsTableReferences
                                        ._animalIdTable(db),
                                referencedColumn:
                                    $$SmartTagReadingsTableReferences
                                        ._animalIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SmartTagReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SmartTagReadingsTable,
      SmartTagReading,
      $$SmartTagReadingsTableFilterComposer,
      $$SmartTagReadingsTableOrderingComposer,
      $$SmartTagReadingsTableAnnotationComposer,
      $$SmartTagReadingsTableCreateCompanionBuilder,
      $$SmartTagReadingsTableUpdateCompanionBuilder,
      (SmartTagReading, $$SmartTagReadingsTableReferences),
      SmartTagReading,
      PrefetchHooks Function({bool animalId})
    >;
typedef $$HealthAlertsTableCreateCompanionBuilder =
    HealthAlertsCompanion Function({
      required String id,
      required String animalId,
      required String alertType,
      required String message,
      Value<bool> isResolved,
      required DateTime createdAt,
      Value<DateTime?> resolvedAt,
      Value<int> rowid,
    });
typedef $$HealthAlertsTableUpdateCompanionBuilder =
    HealthAlertsCompanion Function({
      Value<String> id,
      Value<String> animalId,
      Value<String> alertType,
      Value<String> message,
      Value<bool> isResolved,
      Value<DateTime> createdAt,
      Value<DateTime?> resolvedAt,
      Value<int> rowid,
    });

final class $$HealthAlertsTableReferences
    extends BaseReferences<_$AppDatabase, $HealthAlertsTable, HealthAlert> {
  $$HealthAlertsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AnimalsTable _animalIdTable(_$AppDatabase db) =>
      db.animals.createAlias(
        $_aliasNameGenerator(db.healthAlerts.animalId, db.animals.id),
      );

  $$AnimalsTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalsTableTableManager(
      $_db,
      $_db.animals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HealthAlertsTableFilterComposer
    extends Composer<_$AppDatabase, $HealthAlertsTable> {
  $$HealthAlertsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isResolved => $composableBuilder(
    column: $table.isResolved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AnimalsTableFilterComposer get animalId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableFilterComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HealthAlertsTableOrderingComposer
    extends Composer<_$AppDatabase, $HealthAlertsTable> {
  $$HealthAlertsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isResolved => $composableBuilder(
    column: $table.isResolved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnimalsTableOrderingComposer get animalId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableOrderingComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HealthAlertsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HealthAlertsTable> {
  $$HealthAlertsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get alertType =>
      $composableBuilder(column: $table.alertType, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<bool> get isResolved => $composableBuilder(
    column: $table.isResolved,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );

  $$AnimalsTableAnnotationComposer get animalId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableAnnotationComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HealthAlertsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HealthAlertsTable,
          HealthAlert,
          $$HealthAlertsTableFilterComposer,
          $$HealthAlertsTableOrderingComposer,
          $$HealthAlertsTableAnnotationComposer,
          $$HealthAlertsTableCreateCompanionBuilder,
          $$HealthAlertsTableUpdateCompanionBuilder,
          (HealthAlert, $$HealthAlertsTableReferences),
          HealthAlert,
          PrefetchHooks Function({bool animalId})
        > {
  $$HealthAlertsTableTableManager(_$AppDatabase db, $HealthAlertsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HealthAlertsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HealthAlertsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HealthAlertsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> animalId = const Value.absent(),
                Value<String> alertType = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<bool> isResolved = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HealthAlertsCompanion(
                id: id,
                animalId: animalId,
                alertType: alertType,
                message: message,
                isResolved: isResolved,
                createdAt: createdAt,
                resolvedAt: resolvedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String animalId,
                required String alertType,
                required String message,
                Value<bool> isResolved = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HealthAlertsCompanion.insert(
                id: id,
                animalId: animalId,
                alertType: alertType,
                message: message,
                isResolved: isResolved,
                createdAt: createdAt,
                resolvedAt: resolvedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HealthAlertsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({animalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (animalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.animalId,
                                referencedTable: $$HealthAlertsTableReferences
                                    ._animalIdTable(db),
                                referencedColumn: $$HealthAlertsTableReferences
                                    ._animalIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HealthAlertsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HealthAlertsTable,
      HealthAlert,
      $$HealthAlertsTableFilterComposer,
      $$HealthAlertsTableOrderingComposer,
      $$HealthAlertsTableAnnotationComposer,
      $$HealthAlertsTableCreateCompanionBuilder,
      $$HealthAlertsTableUpdateCompanionBuilder,
      (HealthAlert, $$HealthAlertsTableReferences),
      HealthAlert,
      PrefetchHooks Function({bool animalId})
    >;
typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      required String id,
      required String title,
      Value<String> description,
      Value<String?> assignee,
      Value<DateTime?> dueDate,
      required TaskPriority priority,
      required TaskStatus taskStatus,
      Value<String?> relatedAnimalId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> completedAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<String?> assignee,
      Value<DateTime?> dueDate,
      Value<TaskPriority> priority,
      Value<TaskStatus> taskStatus,
      Value<String?> relatedAnimalId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> completedAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assignee => $composableBuilder(
    column: $table.assignee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TaskPriority, TaskPriority, String>
  get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TaskStatus, TaskStatus, String>
  get taskStatus => $composableBuilder(
    column: $table.taskStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get relatedAnimalId => $composableBuilder(
    column: $table.relatedAnimalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assignee => $composableBuilder(
    column: $table.assignee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskStatus => $composableBuilder(
    column: $table.taskStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedAnimalId => $composableBuilder(
    column: $table.relatedAnimalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assignee =>
      $composableBuilder(column: $table.assignee, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TaskPriority, String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TaskStatus, String> get taskStatus =>
      $composableBuilder(
        column: $table.taskStatus,
        builder: (column) => column,
      );

  GeneratedColumn<String> get relatedAnimalId => $composableBuilder(
    column: $table.relatedAnimalId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
          Task,
          PrefetchHooks Function()
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> assignee = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<TaskPriority> priority = const Value.absent(),
                Value<TaskStatus> taskStatus = const Value.absent(),
                Value<String?> relatedAnimalId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                description: description,
                assignee: assignee,
                dueDate: dueDate,
                priority: priority,
                taskStatus: taskStatus,
                relatedAnimalId: relatedAnimalId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String> description = const Value.absent(),
                Value<String?> assignee = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                required TaskPriority priority,
                required TaskStatus taskStatus,
                Value<String?> relatedAnimalId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                description: description,
                assignee: assignee,
                dueDate: dueDate,
                priority: priority,
                taskStatus: taskStatus,
                relatedAnimalId: relatedAnimalId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
      Task,
      PrefetchHooks Function()
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      required String id,
      required ExpenseCategory category,
      required double amount,
      Value<String> description,
      required DateTime date,
      Value<String?> animalId,
      Value<String?> pastureId,
      Value<String> vendor,
      Value<String?> receiptPath,
      required DateTime createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<String> id,
      Value<ExpenseCategory> category,
      Value<double> amount,
      Value<String> description,
      Value<DateTime> date,
      Value<String?> animalId,
      Value<String?> pastureId,
      Value<String> vendor,
      Value<String?> receiptPath,
      Value<DateTime> createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ExpenseCategory, ExpenseCategory, String>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get animalId => $composableBuilder(
    column: $table.animalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pastureId => $composableBuilder(
    column: $table.pastureId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendor => $composableBuilder(
    column: $table.vendor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get animalId => $composableBuilder(
    column: $table.animalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pastureId => $composableBuilder(
    column: $table.pastureId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendor => $composableBuilder(
    column: $table.vendor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExpenseCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get animalId =>
      $composableBuilder(column: $table.animalId, builder: (column) => column);

  GeneratedColumn<String> get pastureId =>
      $composableBuilder(column: $table.pastureId, builder: (column) => column);

  GeneratedColumn<String> get vendor =>
      $composableBuilder(column: $table.vendor, builder: (column) => column);

  GeneratedColumn<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<ExpenseCategory> category = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> animalId = const Value.absent(),
                Value<String?> pastureId = const Value.absent(),
                Value<String> vendor = const Value.absent(),
                Value<String?> receiptPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                category: category,
                amount: amount,
                description: description,
                date: date,
                animalId: animalId,
                pastureId: pastureId,
                vendor: vendor,
                receiptPath: receiptPath,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required ExpenseCategory category,
                required double amount,
                Value<String> description = const Value.absent(),
                required DateTime date,
                Value<String?> animalId = const Value.absent(),
                Value<String?> pastureId = const Value.absent(),
                Value<String> vendor = const Value.absent(),
                Value<String?> receiptPath = const Value.absent(),
                required DateTime createdAt,
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                category: category,
                amount: amount,
                description: description,
                date: date,
                animalId: animalId,
                pastureId: pastureId,
                vendor: vendor,
                receiptPath: receiptPath,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      required String id,
      required String animalId,
      required DateTime saleDate,
      required double saleWeight,
      required double pricePerPound,
      required double totalPrice,
      Value<String> buyer,
      Value<String> marketLocation,
      Value<String> notes,
      required DateTime createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });
typedef $$SalesTableUpdateCompanionBuilder =
    SalesCompanion Function({
      Value<String> id,
      Value<String> animalId,
      Value<DateTime> saleDate,
      Value<double> saleWeight,
      Value<double> pricePerPound,
      Value<double> totalPrice,
      Value<String> buyer,
      Value<String> marketLocation,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<SyncStatus> syncStatus,
      Value<int> rowid,
    });

final class $$SalesTableReferences
    extends BaseReferences<_$AppDatabase, $SalesTable, Sale> {
  $$SalesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AnimalsTable _animalIdTable(_$AppDatabase db) => db.animals
      .createAlias($_aliasNameGenerator(db.sales.animalId, db.animals.id));

  $$AnimalsTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalsTableTableManager(
      $_db,
      $_db.animals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get saleDate => $composableBuilder(
    column: $table.saleDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get saleWeight => $composableBuilder(
    column: $table.saleWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerPound => $composableBuilder(
    column: $table.pricePerPound,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buyer => $composableBuilder(
    column: $table.buyer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marketLocation => $composableBuilder(
    column: $table.marketLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String>
  get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$AnimalsTableFilterComposer get animalId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableFilterComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get saleDate => $composableBuilder(
    column: $table.saleDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get saleWeight => $composableBuilder(
    column: $table.saleWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerPound => $composableBuilder(
    column: $table.pricePerPound,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buyer => $composableBuilder(
    column: $table.buyer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marketLocation => $composableBuilder(
    column: $table.marketLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnimalsTableOrderingComposer get animalId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableOrderingComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get saleDate =>
      $composableBuilder(column: $table.saleDate, builder: (column) => column);

  GeneratedColumn<double> get saleWeight => $composableBuilder(
    column: $table.saleWeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pricePerPound => $composableBuilder(
    column: $table.pricePerPound,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get buyer =>
      $composableBuilder(column: $table.buyer, builder: (column) => column);

  GeneratedColumn<String> get marketLocation => $composableBuilder(
    column: $table.marketLocation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get syncStatus =>
      $composableBuilder(
        column: $table.syncStatus,
        builder: (column) => column,
      );

  $$AnimalsTableAnnotationComposer get animalId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalsTableAnnotationComposer(
            $db: $db,
            $table: $db.animals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          Sale,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (Sale, $$SalesTableReferences),
          Sale,
          PrefetchHooks Function({bool animalId})
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> animalId = const Value.absent(),
                Value<DateTime> saleDate = const Value.absent(),
                Value<double> saleWeight = const Value.absent(),
                Value<double> pricePerPound = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<String> buyer = const Value.absent(),
                Value<String> marketLocation = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                animalId: animalId,
                saleDate: saleDate,
                saleWeight: saleWeight,
                pricePerPound: pricePerPound,
                totalPrice: totalPrice,
                buyer: buyer,
                marketLocation: marketLocation,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String animalId,
                required DateTime saleDate,
                required double saleWeight,
                required double pricePerPound,
                required double totalPrice,
                Value<String> buyer = const Value.absent(),
                Value<String> marketLocation = const Value.absent(),
                Value<String> notes = const Value.absent(),
                required DateTime createdAt,
                Value<SyncStatus> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                animalId: animalId,
                saleDate: saleDate,
                saleWeight: saleWeight,
                pricePerPound: pricePerPound,
                totalPrice: totalPrice,
                buyer: buyer,
                marketLocation: marketLocation,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SalesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({animalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (animalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.animalId,
                                referencedTable: $$SalesTableReferences
                                    ._animalIdTable(db),
                                referencedColumn: $$SalesTableReferences
                                    ._animalIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      Sale,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (Sale, $$SalesTableReferences),
      Sale,
      PrefetchHooks Function({bool animalId})
    >;
typedef $$PredictiveAlertsTableCreateCompanionBuilder =
    PredictiveAlertsCompanion Function({
      required String id,
      required String alertType,
      Value<String?> animalId,
      required DateTime predictedDate,
      required String message,
      Value<bool> isAcknowledged,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$PredictiveAlertsTableUpdateCompanionBuilder =
    PredictiveAlertsCompanion Function({
      Value<String> id,
      Value<String> alertType,
      Value<String?> animalId,
      Value<DateTime> predictedDate,
      Value<String> message,
      Value<bool> isAcknowledged,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$PredictiveAlertsTableFilterComposer
    extends Composer<_$AppDatabase, $PredictiveAlertsTable> {
  $$PredictiveAlertsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get animalId => $composableBuilder(
    column: $table.animalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get predictedDate => $composableBuilder(
    column: $table.predictedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAcknowledged => $composableBuilder(
    column: $table.isAcknowledged,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PredictiveAlertsTableOrderingComposer
    extends Composer<_$AppDatabase, $PredictiveAlertsTable> {
  $$PredictiveAlertsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get animalId => $composableBuilder(
    column: $table.animalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get predictedDate => $composableBuilder(
    column: $table.predictedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAcknowledged => $composableBuilder(
    column: $table.isAcknowledged,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PredictiveAlertsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PredictiveAlertsTable> {
  $$PredictiveAlertsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get alertType =>
      $composableBuilder(column: $table.alertType, builder: (column) => column);

  GeneratedColumn<String> get animalId =>
      $composableBuilder(column: $table.animalId, builder: (column) => column);

  GeneratedColumn<DateTime> get predictedDate => $composableBuilder(
    column: $table.predictedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<bool> get isAcknowledged => $composableBuilder(
    column: $table.isAcknowledged,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PredictiveAlertsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PredictiveAlertsTable,
          PredictiveAlert,
          $$PredictiveAlertsTableFilterComposer,
          $$PredictiveAlertsTableOrderingComposer,
          $$PredictiveAlertsTableAnnotationComposer,
          $$PredictiveAlertsTableCreateCompanionBuilder,
          $$PredictiveAlertsTableUpdateCompanionBuilder,
          (
            PredictiveAlert,
            BaseReferences<
              _$AppDatabase,
              $PredictiveAlertsTable,
              PredictiveAlert
            >,
          ),
          PredictiveAlert,
          PrefetchHooks Function()
        > {
  $$PredictiveAlertsTableTableManager(
    _$AppDatabase db,
    $PredictiveAlertsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PredictiveAlertsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PredictiveAlertsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PredictiveAlertsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> alertType = const Value.absent(),
                Value<String?> animalId = const Value.absent(),
                Value<DateTime> predictedDate = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<bool> isAcknowledged = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PredictiveAlertsCompanion(
                id: id,
                alertType: alertType,
                animalId: animalId,
                predictedDate: predictedDate,
                message: message,
                isAcknowledged: isAcknowledged,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String alertType,
                Value<String?> animalId = const Value.absent(),
                required DateTime predictedDate,
                required String message,
                Value<bool> isAcknowledged = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PredictiveAlertsCompanion.insert(
                id: id,
                alertType: alertType,
                animalId: animalId,
                predictedDate: predictedDate,
                message: message,
                isAcknowledged: isAcknowledged,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PredictiveAlertsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PredictiveAlertsTable,
      PredictiveAlert,
      $$PredictiveAlertsTableFilterComposer,
      $$PredictiveAlertsTableOrderingComposer,
      $$PredictiveAlertsTableAnnotationComposer,
      $$PredictiveAlertsTableCreateCompanionBuilder,
      $$PredictiveAlertsTableUpdateCompanionBuilder,
      (
        PredictiveAlert,
        BaseReferences<_$AppDatabase, $PredictiveAlertsTable, PredictiveAlert>,
      ),
      PredictiveAlert,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      required String syncTableName,
      required String recordId,
      required String operation,
      required String data,
      required DateTime createdAt,
      Value<int> retryCount,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      Value<String> syncTableName,
      Value<String> recordId,
      Value<String> operation,
      Value<String> data,
      Value<DateTime> createdAt,
      Value<int> retryCount,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncTableName => $composableBuilder(
    column: $table.syncTableName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncTableName => $composableBuilder(
    column: $table.syncTableName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncTableName => $composableBuilder(
    column: $table.syncTableName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncTableName = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> data = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                syncTableName: syncTableName,
                recordId: recordId,
                operation: operation,
                data: data,
                createdAt: createdAt,
                retryCount: retryCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String syncTableName,
                required String recordId,
                required String operation,
                required String data,
                required DateTime createdAt,
                Value<int> retryCount = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                syncTableName: syncTableName,
                recordId: recordId,
                operation: operation,
                data: data,
                createdAt: createdAt,
                retryCount: retryCount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AnimalsTableTableManager get animals =>
      $$AnimalsTableTableManager(_db, _db.animals);
  $$CalvingRecordsTableTableManager get calvingRecords =>
      $$CalvingRecordsTableTableManager(_db, _db.calvingRecords);
  $$TreatmentRecordsTableTableManager get treatmentRecords =>
      $$TreatmentRecordsTableTableManager(_db, _db.treatmentRecords);
  $$WeightRecordsTableTableManager get weightRecords =>
      $$WeightRecordsTableTableManager(_db, _db.weightRecords);
  $$PriceAlertsTableTableManager get priceAlerts =>
      $$PriceAlertsTableTableManager(_db, _db.priceAlerts);
  $$RanchSettingsTableTableManager get ranchSettings =>
      $$RanchSettingsTableTableManager(_db, _db.ranchSettings);
  $$PasturesTableTableManager get pastures =>
      $$PasturesTableTableManager(_db, _db.pastures);
  $$GrazingRotationsTableTableManager get grazingRotations =>
      $$GrazingRotationsTableTableManager(_db, _db.grazingRotations);
  $$SmartTagReadingsTableTableManager get smartTagReadings =>
      $$SmartTagReadingsTableTableManager(_db, _db.smartTagReadings);
  $$HealthAlertsTableTableManager get healthAlerts =>
      $$HealthAlertsTableTableManager(_db, _db.healthAlerts);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$PredictiveAlertsTableTableManager get predictiveAlerts =>
      $$PredictiveAlertsTableTableManager(_db, _db.predictiveAlerts);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
}
