// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AccountsTableTable extends AccountsTable
    with TableInfo<$AccountsTableTable, AccountEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTableTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ILS'),
  );
  static const VerificationMeta _initialBalanceMeta = const VerificationMeta(
    'initialBalance',
  );
  @override
  late final GeneratedColumn<double> initialBalance = GeneratedColumn<double>(
    'initial_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _currentBalanceMeta = const VerificationMeta(
    'currentBalance',
  );
  @override
  late final GeneratedColumn<double> currentBalance = GeneratedColumn<double>(
    'current_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _linkedAccountIdMeta = const VerificationMeta(
    'linkedAccountId',
  );
  @override
  late final GeneratedColumn<String> linkedAccountId = GeneratedColumn<String>(
    'linked_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _billingDayOfMonthMeta = const VerificationMeta(
    'billingDayOfMonth',
  );
  @override
  late final GeneratedColumn<int> billingDayOfMonth = GeneratedColumn<int>(
    'billing_day_of_month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF3B82F6),
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('bank'),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    currency,
    initialBalance,
    currentBalance,
    linkedAccountId,
    billingDayOfMonth,
    colorValue,
    iconName,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountEntry> instance, {
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
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('initial_balance')) {
      context.handle(
        _initialBalanceMeta,
        initialBalance.isAcceptableOrUnknown(
          data['initial_balance']!,
          _initialBalanceMeta,
        ),
      );
    }
    if (data.containsKey('current_balance')) {
      context.handle(
        _currentBalanceMeta,
        currentBalance.isAcceptableOrUnknown(
          data['current_balance']!,
          _currentBalanceMeta,
        ),
      );
    }
    if (data.containsKey('linked_account_id')) {
      context.handle(
        _linkedAccountIdMeta,
        linkedAccountId.isAcceptableOrUnknown(
          data['linked_account_id']!,
          _linkedAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('billing_day_of_month')) {
      context.handle(
        _billingDayOfMonthMeta,
        billingDayOfMonth.isAcceptableOrUnknown(
          data['billing_day_of_month']!,
          _billingDayOfMonthMeta,
        ),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      initialBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}initial_balance'],
      )!,
      currentBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_balance'],
      )!,
      linkedAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_account_id'],
      ),
      billingDayOfMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}billing_day_of_month'],
      ),
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
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
  $AccountsTableTable createAlias(String alias) {
    return $AccountsTableTable(attachedDatabase, alias);
  }
}

class AccountEntry extends DataClass implements Insertable<AccountEntry> {
  final String id;
  final String name;
  final String type;
  final String currency;
  final double initialBalance;
  final double currentBalance;
  final String? linkedAccountId;
  final int? billingDayOfMonth;
  final int colorValue;
  final String iconName;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AccountEntry({
    required this.id,
    required this.name,
    required this.type,
    required this.currency,
    required this.initialBalance,
    required this.currentBalance,
    this.linkedAccountId,
    this.billingDayOfMonth,
    required this.colorValue,
    required this.iconName,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['currency'] = Variable<String>(currency);
    map['initial_balance'] = Variable<double>(initialBalance);
    map['current_balance'] = Variable<double>(currentBalance);
    if (!nullToAbsent || linkedAccountId != null) {
      map['linked_account_id'] = Variable<String>(linkedAccountId);
    }
    if (!nullToAbsent || billingDayOfMonth != null) {
      map['billing_day_of_month'] = Variable<int>(billingDayOfMonth);
    }
    map['color_value'] = Variable<int>(colorValue);
    map['icon_name'] = Variable<String>(iconName);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AccountsTableCompanion toCompanion(bool nullToAbsent) {
    return AccountsTableCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      currency: Value(currency),
      initialBalance: Value(initialBalance),
      currentBalance: Value(currentBalance),
      linkedAccountId: linkedAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedAccountId),
      billingDayOfMonth: billingDayOfMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(billingDayOfMonth),
      colorValue: Value(colorValue),
      iconName: Value(iconName),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AccountEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      currency: serializer.fromJson<String>(json['currency']),
      initialBalance: serializer.fromJson<double>(json['initialBalance']),
      currentBalance: serializer.fromJson<double>(json['currentBalance']),
      linkedAccountId: serializer.fromJson<String?>(json['linkedAccountId']),
      billingDayOfMonth: serializer.fromJson<int?>(json['billingDayOfMonth']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      iconName: serializer.fromJson<String>(json['iconName']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'currency': serializer.toJson<String>(currency),
      'initialBalance': serializer.toJson<double>(initialBalance),
      'currentBalance': serializer.toJson<double>(currentBalance),
      'linkedAccountId': serializer.toJson<String?>(linkedAccountId),
      'billingDayOfMonth': serializer.toJson<int?>(billingDayOfMonth),
      'colorValue': serializer.toJson<int>(colorValue),
      'iconName': serializer.toJson<String>(iconName),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AccountEntry copyWith({
    String? id,
    String? name,
    String? type,
    String? currency,
    double? initialBalance,
    double? currentBalance,
    Value<String?> linkedAccountId = const Value.absent(),
    Value<int?> billingDayOfMonth = const Value.absent(),
    int? colorValue,
    String? iconName,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AccountEntry(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    currency: currency ?? this.currency,
    initialBalance: initialBalance ?? this.initialBalance,
    currentBalance: currentBalance ?? this.currentBalance,
    linkedAccountId: linkedAccountId.present
        ? linkedAccountId.value
        : this.linkedAccountId,
    billingDayOfMonth: billingDayOfMonth.present
        ? billingDayOfMonth.value
        : this.billingDayOfMonth,
    colorValue: colorValue ?? this.colorValue,
    iconName: iconName ?? this.iconName,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AccountEntry copyWithCompanion(AccountsTableCompanion data) {
    return AccountEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      currency: data.currency.present ? data.currency.value : this.currency,
      initialBalance: data.initialBalance.present
          ? data.initialBalance.value
          : this.initialBalance,
      currentBalance: data.currentBalance.present
          ? data.currentBalance.value
          : this.currentBalance,
      linkedAccountId: data.linkedAccountId.present
          ? data.linkedAccountId.value
          : this.linkedAccountId,
      billingDayOfMonth: data.billingDayOfMonth.present
          ? data.billingDayOfMonth.value
          : this.billingDayOfMonth,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('currency: $currency, ')
          ..write('initialBalance: $initialBalance, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('billingDayOfMonth: $billingDayOfMonth, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconName: $iconName, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    currency,
    initialBalance,
    currentBalance,
    linkedAccountId,
    billingDayOfMonth,
    colorValue,
    iconName,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.currency == this.currency &&
          other.initialBalance == this.initialBalance &&
          other.currentBalance == this.currentBalance &&
          other.linkedAccountId == this.linkedAccountId &&
          other.billingDayOfMonth == this.billingDayOfMonth &&
          other.colorValue == this.colorValue &&
          other.iconName == this.iconName &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AccountsTableCompanion extends UpdateCompanion<AccountEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> currency;
  final Value<double> initialBalance;
  final Value<double> currentBalance;
  final Value<String?> linkedAccountId;
  final Value<int?> billingDayOfMonth;
  final Value<int> colorValue;
  final Value<String> iconName;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AccountsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.currency = const Value.absent(),
    this.initialBalance = const Value.absent(),
    this.currentBalance = const Value.absent(),
    this.linkedAccountId = const Value.absent(),
    this.billingDayOfMonth = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.iconName = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsTableCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.currency = const Value.absent(),
    this.initialBalance = const Value.absent(),
    this.currentBalance = const Value.absent(),
    this.linkedAccountId = const Value.absent(),
    this.billingDayOfMonth = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.iconName = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type);
  static Insertable<AccountEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? currency,
    Expression<double>? initialBalance,
    Expression<double>? currentBalance,
    Expression<String>? linkedAccountId,
    Expression<int>? billingDayOfMonth,
    Expression<int>? colorValue,
    Expression<String>? iconName,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (currency != null) 'currency': currency,
      if (initialBalance != null) 'initial_balance': initialBalance,
      if (currentBalance != null) 'current_balance': currentBalance,
      if (linkedAccountId != null) 'linked_account_id': linkedAccountId,
      if (billingDayOfMonth != null) 'billing_day_of_month': billingDayOfMonth,
      if (colorValue != null) 'color_value': colorValue,
      if (iconName != null) 'icon_name': iconName,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<String>? currency,
    Value<double>? initialBalance,
    Value<double>? currentBalance,
    Value<String?>? linkedAccountId,
    Value<int?>? billingDayOfMonth,
    Value<int>? colorValue,
    Value<String>? iconName,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AccountsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      currency: currency ?? this.currency,
      initialBalance: initialBalance ?? this.initialBalance,
      currentBalance: currentBalance ?? this.currentBalance,
      linkedAccountId: linkedAccountId ?? this.linkedAccountId,
      billingDayOfMonth: billingDayOfMonth ?? this.billingDayOfMonth,
      colorValue: colorValue ?? this.colorValue,
      iconName: iconName ?? this.iconName,
      isArchived: isArchived ?? this.isArchived,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (initialBalance.present) {
      map['initial_balance'] = Variable<double>(initialBalance.value);
    }
    if (currentBalance.present) {
      map['current_balance'] = Variable<double>(currentBalance.value);
    }
    if (linkedAccountId.present) {
      map['linked_account_id'] = Variable<String>(linkedAccountId.value);
    }
    if (billingDayOfMonth.present) {
      map['billing_day_of_month'] = Variable<int>(billingDayOfMonth.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
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
    return (StringBuffer('AccountsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('currency: $currency, ')
          ..write('initialBalance: $initialBalance, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('billingDayOfMonth: $billingDayOfMonth, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconName: $iconName, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spendingClassificationMeta =
      const VerificationMeta('spendingClassification');
  @override
  late final GeneratedColumn<String> spendingClassification =
      GeneratedColumn<String>(
        'spending_classification',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('needs'),
      );
  static const VerificationMeta _flexibilityMeta = const VerificationMeta(
    'flexibility',
  );
  @override
  late final GeneratedColumn<String> flexibility = GeneratedColumn<String>(
    'flexibility',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('variable'),
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF3B82F6),
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('uncategorized'),
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    parentId,
    name,
    type,
    spendingClassification,
    flexibility,
    colorValue,
    iconName,
    isDefault,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('spending_classification')) {
      context.handle(
        _spendingClassificationMeta,
        spendingClassification.isAcceptableOrUnknown(
          data['spending_classification']!,
          _spendingClassificationMeta,
        ),
      );
    }
    if (data.containsKey('flexibility')) {
      context.handle(
        _flexibilityMeta,
        flexibility.isAcceptableOrUnknown(
          data['flexibility']!,
          _flexibilityMeta,
        ),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      spendingClassification: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spending_classification'],
      )!,
      flexibility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flexibility'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
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
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoryEntry extends DataClass implements Insertable<CategoryEntry> {
  final String id;
  final String? parentId;
  final String name;
  final String type;
  final String spendingClassification;
  final String flexibility;
  final int colorValue;
  final String iconName;
  final bool isDefault;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CategoryEntry({
    required this.id,
    this.parentId,
    required this.name,
    required this.type,
    required this.spendingClassification,
    required this.flexibility,
    required this.colorValue,
    required this.iconName,
    required this.isDefault,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['spending_classification'] = Variable<String>(spendingClassification);
    map['flexibility'] = Variable<String>(flexibility);
    map['color_value'] = Variable<int>(colorValue);
    map['icon_name'] = Variable<String>(iconName);
    map['is_default'] = Variable<bool>(isDefault);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      name: Value(name),
      type: Value(type),
      spendingClassification: Value(spendingClassification),
      flexibility: Value(flexibility),
      colorValue: Value(colorValue),
      iconName: Value(iconName),
      isDefault: Value(isDefault),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryEntry(
      id: serializer.fromJson<String>(json['id']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      spendingClassification: serializer.fromJson<String>(
        json['spendingClassification'],
      ),
      flexibility: serializer.fromJson<String>(json['flexibility']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      iconName: serializer.fromJson<String>(json['iconName']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'parentId': serializer.toJson<String?>(parentId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'spendingClassification': serializer.toJson<String>(
        spendingClassification,
      ),
      'flexibility': serializer.toJson<String>(flexibility),
      'colorValue': serializer.toJson<int>(colorValue),
      'iconName': serializer.toJson<String>(iconName),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoryEntry copyWith({
    String? id,
    Value<String?> parentId = const Value.absent(),
    String? name,
    String? type,
    String? spendingClassification,
    String? flexibility,
    int? colorValue,
    String? iconName,
    bool? isDefault,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CategoryEntry(
    id: id ?? this.id,
    parentId: parentId.present ? parentId.value : this.parentId,
    name: name ?? this.name,
    type: type ?? this.type,
    spendingClassification:
        spendingClassification ?? this.spendingClassification,
    flexibility: flexibility ?? this.flexibility,
    colorValue: colorValue ?? this.colorValue,
    iconName: iconName ?? this.iconName,
    isDefault: isDefault ?? this.isDefault,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CategoryEntry copyWithCompanion(CategoriesTableCompanion data) {
    return CategoryEntry(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      spendingClassification: data.spendingClassification.present
          ? data.spendingClassification.value
          : this.spendingClassification,
      flexibility: data.flexibility.present
          ? data.flexibility.value
          : this.flexibility,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEntry(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('spendingClassification: $spendingClassification, ')
          ..write('flexibility: $flexibility, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconName: $iconName, ')
          ..write('isDefault: $isDefault, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    parentId,
    name,
    type,
    spendingClassification,
    flexibility,
    colorValue,
    iconName,
    isDefault,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEntry &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.name == this.name &&
          other.type == this.type &&
          other.spendingClassification == this.spendingClassification &&
          other.flexibility == this.flexibility &&
          other.colorValue == this.colorValue &&
          other.iconName == this.iconName &&
          other.isDefault == this.isDefault &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoryEntry> {
  final Value<String> id;
  final Value<String?> parentId;
  final Value<String> name;
  final Value<String> type;
  final Value<String> spendingClassification;
  final Value<String> flexibility;
  final Value<int> colorValue;
  final Value<String> iconName;
  final Value<bool> isDefault;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.spendingClassification = const Value.absent(),
    this.flexibility = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.iconName = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    required String id,
    this.parentId = const Value.absent(),
    required String name,
    required String type,
    this.spendingClassification = const Value.absent(),
    this.flexibility = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.iconName = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type);
  static Insertable<CategoryEntry> custom({
    Expression<String>? id,
    Expression<String>? parentId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? spendingClassification,
    Expression<String>? flexibility,
    Expression<int>? colorValue,
    Expression<String>? iconName,
    Expression<bool>? isDefault,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (spendingClassification != null)
        'spending_classification': spendingClassification,
      if (flexibility != null) 'flexibility': flexibility,
      if (colorValue != null) 'color_value': colorValue,
      if (iconName != null) 'icon_name': iconName,
      if (isDefault != null) 'is_default': isDefault,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? parentId,
    Value<String>? name,
    Value<String>? type,
    Value<String>? spendingClassification,
    Value<String>? flexibility,
    Value<int>? colorValue,
    Value<String>? iconName,
    Value<bool>? isDefault,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      type: type ?? this.type,
      spendingClassification:
          spendingClassification ?? this.spendingClassification,
      flexibility: flexibility ?? this.flexibility,
      colorValue: colorValue ?? this.colorValue,
      iconName: iconName ?? this.iconName,
      isDefault: isDefault ?? this.isDefault,
      isArchived: isArchived ?? this.isArchived,
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
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (spendingClassification.present) {
      map['spending_classification'] = Variable<String>(
        spendingClassification.value,
      );
    }
    if (flexibility.present) {
      map['flexibility'] = Variable<String>(flexibility.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
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
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('spendingClassification: $spendingClassification, ')
          ..write('flexibility: $flexibility, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconName: $iconName, ')
          ..write('isDefault: $isDefault, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTableTable extends TagsTable
    with TableInfo<$TagsTableTable, TagEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTableTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF64748B),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, colorValue, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<TagEntry> instance, {
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
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TagsTableTable createAlias(String alias) {
    return $TagsTableTable(attachedDatabase, alias);
  }
}

class TagEntry extends DataClass implements Insertable<TagEntry> {
  final String id;
  final String name;
  final int colorValue;
  final DateTime createdAt;
  const TagEntry({
    required this.id,
    required this.name,
    required this.colorValue,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color_value'] = Variable<int>(colorValue);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TagsTableCompanion toCompanion(bool nullToAbsent) {
    return TagsTableCompanion(
      id: Value(id),
      name: Value(name),
      colorValue: Value(colorValue),
      createdAt: Value(createdAt),
    );
  }

  factory TagEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'colorValue': serializer.toJson<int>(colorValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TagEntry copyWith({
    String? id,
    String? name,
    int? colorValue,
    DateTime? createdAt,
  }) => TagEntry(
    id: id ?? this.id,
    name: name ?? this.name,
    colorValue: colorValue ?? this.colorValue,
    createdAt: createdAt ?? this.createdAt,
  );
  TagEntry copyWithCompanion(TagsTableCompanion data) {
    return TagEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, colorValue, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorValue == this.colorValue &&
          other.createdAt == this.createdAt);
}

class TagsTableCompanion extends UpdateCompanion<TagEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> colorValue;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TagsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsTableCompanion.insert({
    required String id,
    required String name,
    this.colorValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<TagEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? colorValue,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorValue != null) 'color_value': colorValue,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? colorValue,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TagsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
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
    return (StringBuffer('TagsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MerchantsTableTable extends MerchantsTable
    with TableInfo<$MerchantsTableTable, MerchantEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MerchantsTableTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultCategoryIdMeta = const VerificationMeta(
    'defaultCategoryId',
  );
  @override
  late final GeneratedColumn<String> defaultCategoryId =
      GeneratedColumn<String>(
        'default_category_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categories (id)',
        ),
      );
  static const VerificationMeta _isAutoLearnedMeta = const VerificationMeta(
    'isAutoLearned',
  );
  @override
  late final GeneratedColumn<bool> isAutoLearned = GeneratedColumn<bool>(
    'is_auto_learned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_auto_learned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _usageCountMeta = const VerificationMeta(
    'usageCount',
  );
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
    'usage_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    defaultCategoryId,
    isAutoLearned,
    usageCount,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'merchants';
  @override
  VerificationContext validateIntegrity(
    Insertable<MerchantEntry> instance, {
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
    if (data.containsKey('default_category_id')) {
      context.handle(
        _defaultCategoryIdMeta,
        defaultCategoryId.isAcceptableOrUnknown(
          data['default_category_id']!,
          _defaultCategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('is_auto_learned')) {
      context.handle(
        _isAutoLearnedMeta,
        isAutoLearned.isAcceptableOrUnknown(
          data['is_auto_learned']!,
          _isAutoLearnedMeta,
        ),
      );
    }
    if (data.containsKey('usage_count')) {
      context.handle(
        _usageCountMeta,
        usageCount.isAcceptableOrUnknown(data['usage_count']!, _usageCountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MerchantEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MerchantEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      defaultCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_category_id'],
      ),
      isAutoLearned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_auto_learned'],
      )!,
      usageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count'],
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
  $MerchantsTableTable createAlias(String alias) {
    return $MerchantsTableTable(attachedDatabase, alias);
  }
}

class MerchantEntry extends DataClass implements Insertable<MerchantEntry> {
  final String id;
  final String name;
  final String? defaultCategoryId;
  final bool isAutoLearned;
  final int usageCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MerchantEntry({
    required this.id,
    required this.name,
    this.defaultCategoryId,
    required this.isAutoLearned,
    required this.usageCount,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || defaultCategoryId != null) {
      map['default_category_id'] = Variable<String>(defaultCategoryId);
    }
    map['is_auto_learned'] = Variable<bool>(isAutoLearned);
    map['usage_count'] = Variable<int>(usageCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MerchantsTableCompanion toCompanion(bool nullToAbsent) {
    return MerchantsTableCompanion(
      id: Value(id),
      name: Value(name),
      defaultCategoryId: defaultCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultCategoryId),
      isAutoLearned: Value(isAutoLearned),
      usageCount: Value(usageCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MerchantEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MerchantEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      defaultCategoryId: serializer.fromJson<String?>(
        json['defaultCategoryId'],
      ),
      isAutoLearned: serializer.fromJson<bool>(json['isAutoLearned']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'defaultCategoryId': serializer.toJson<String?>(defaultCategoryId),
      'isAutoLearned': serializer.toJson<bool>(isAutoLearned),
      'usageCount': serializer.toJson<int>(usageCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MerchantEntry copyWith({
    String? id,
    String? name,
    Value<String?> defaultCategoryId = const Value.absent(),
    bool? isAutoLearned,
    int? usageCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MerchantEntry(
    id: id ?? this.id,
    name: name ?? this.name,
    defaultCategoryId: defaultCategoryId.present
        ? defaultCategoryId.value
        : this.defaultCategoryId,
    isAutoLearned: isAutoLearned ?? this.isAutoLearned,
    usageCount: usageCount ?? this.usageCount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MerchantEntry copyWithCompanion(MerchantsTableCompanion data) {
    return MerchantEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      defaultCategoryId: data.defaultCategoryId.present
          ? data.defaultCategoryId.value
          : this.defaultCategoryId,
      isAutoLearned: data.isAutoLearned.present
          ? data.isAutoLearned.value
          : this.isAutoLearned,
      usageCount: data.usageCount.present
          ? data.usageCount.value
          : this.usageCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MerchantEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('defaultCategoryId: $defaultCategoryId, ')
          ..write('isAutoLearned: $isAutoLearned, ')
          ..write('usageCount: $usageCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    defaultCategoryId,
    isAutoLearned,
    usageCount,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MerchantEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.defaultCategoryId == this.defaultCategoryId &&
          other.isAutoLearned == this.isAutoLearned &&
          other.usageCount == this.usageCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MerchantsTableCompanion extends UpdateCompanion<MerchantEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> defaultCategoryId;
  final Value<bool> isAutoLearned;
  final Value<int> usageCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MerchantsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.defaultCategoryId = const Value.absent(),
    this.isAutoLearned = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MerchantsTableCompanion.insert({
    required String id,
    required String name,
    this.defaultCategoryId = const Value.absent(),
    this.isAutoLearned = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<MerchantEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? defaultCategoryId,
    Expression<bool>? isAutoLearned,
    Expression<int>? usageCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (defaultCategoryId != null) 'default_category_id': defaultCategoryId,
      if (isAutoLearned != null) 'is_auto_learned': isAutoLearned,
      if (usageCount != null) 'usage_count': usageCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MerchantsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? defaultCategoryId,
    Value<bool>? isAutoLearned,
    Value<int>? usageCount,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MerchantsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultCategoryId: defaultCategoryId ?? this.defaultCategoryId,
      isAutoLearned: isAutoLearned ?? this.isAutoLearned,
      usageCount: usageCount ?? this.usageCount,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (defaultCategoryId.present) {
      map['default_category_id'] = Variable<String>(defaultCategoryId.value);
    }
    if (isAutoLearned.present) {
      map['is_auto_learned'] = Variable<bool>(isAutoLearned.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
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
    return (StringBuffer('MerchantsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('defaultCategoryId: $defaultCategoryId, ')
          ..write('isAutoLearned: $isAutoLearned, ')
          ..write('usageCount: $usageCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTableTable extends TransactionsTable
    with TableInfo<$TransactionsTableTable, TransactionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _merchantIdMeta = const VerificationMeta(
    'merchantId',
  );
  @override
  late final GeneratedColumn<String> merchantId = GeneratedColumn<String>(
    'merchant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES merchants (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isExcludedFromReportsMeta =
      const VerificationMeta('isExcludedFromReports');
  @override
  late final GeneratedColumn<bool> isExcludedFromReports =
      GeneratedColumn<bool>(
        'is_excluded_from_reports',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_excluded_from_reports" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _hasSplitsMeta = const VerificationMeta(
    'hasSplits',
  );
  @override
  late final GeneratedColumn<bool> hasSplits = GeneratedColumn<bool>(
    'has_splits',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_splits" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isRecurringInstanceMeta =
      const VerificationMeta('isRecurringInstance');
  @override
  late final GeneratedColumn<bool> isRecurringInstance = GeneratedColumn<bool>(
    'is_recurring_instance',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_recurring_instance" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _recurringRuleIdMeta = const VerificationMeta(
    'recurringRuleId',
  );
  @override
  late final GeneratedColumn<String> recurringRuleId = GeneratedColumn<String>(
    'recurring_rule_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installmentPlanIdMeta = const VerificationMeta(
    'installmentPlanId',
  );
  @override
  late final GeneratedColumn<String> installmentPlanId =
      GeneratedColumn<String>(
        'installment_plan_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _installmentNumberMeta = const VerificationMeta(
    'installmentNumber',
  );
  @override
  late final GeneratedColumn<int> installmentNumber = GeneratedColumn<int>(
    'installment_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transferLinkIdMeta = const VerificationMeta(
    'transferLinkId',
  );
  @override
  late final GeneratedColumn<String> transferLinkId = GeneratedColumn<String>(
    'transfer_link_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAutoCategorizedMeta = const VerificationMeta(
    'isAutoCategorized',
  );
  @override
  late final GeneratedColumn<bool> isAutoCategorized = GeneratedColumn<bool>(
    'is_auto_categorized',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_auto_categorized" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _importBatchIdMeta = const VerificationMeta(
    'importBatchId',
  );
  @override
  late final GeneratedColumn<String> importBatchId = GeneratedColumn<String>(
    'import_batch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalCurrencyMeta = const VerificationMeta(
    'originalCurrency',
  );
  @override
  late final GeneratedColumn<String> originalCurrency = GeneratedColumn<String>(
    'original_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ILS'),
  );
  static const VerificationMeta _originalAmountMeta = const VerificationMeta(
    'originalAmount',
  );
  @override
  late final GeneratedColumn<double> originalAmount = GeneratedColumn<double>(
    'original_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exchangeRateToIlsMeta = const VerificationMeta(
    'exchangeRateToIls',
  );
  @override
  late final GeneratedColumn<double> exchangeRateToIls =
      GeneratedColumn<double>(
        'exchange_rate_to_ils',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(1.0),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    categoryId,
    merchantId,
    amount,
    type,
    date,
    note,
    isExcludedFromReports,
    hasSplits,
    isRecurringInstance,
    recurringRuleId,
    installmentPlanId,
    installmentNumber,
    transferLinkId,
    isAutoCategorized,
    importBatchId,
    originalCurrency,
    originalAmount,
    exchangeRateToIls,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('merchant_id')) {
      context.handle(
        _merchantIdMeta,
        merchantId.isAcceptableOrUnknown(data['merchant_id']!, _merchantIdMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_excluded_from_reports')) {
      context.handle(
        _isExcludedFromReportsMeta,
        isExcludedFromReports.isAcceptableOrUnknown(
          data['is_excluded_from_reports']!,
          _isExcludedFromReportsMeta,
        ),
      );
    }
    if (data.containsKey('has_splits')) {
      context.handle(
        _hasSplitsMeta,
        hasSplits.isAcceptableOrUnknown(data['has_splits']!, _hasSplitsMeta),
      );
    }
    if (data.containsKey('is_recurring_instance')) {
      context.handle(
        _isRecurringInstanceMeta,
        isRecurringInstance.isAcceptableOrUnknown(
          data['is_recurring_instance']!,
          _isRecurringInstanceMeta,
        ),
      );
    }
    if (data.containsKey('recurring_rule_id')) {
      context.handle(
        _recurringRuleIdMeta,
        recurringRuleId.isAcceptableOrUnknown(
          data['recurring_rule_id']!,
          _recurringRuleIdMeta,
        ),
      );
    }
    if (data.containsKey('installment_plan_id')) {
      context.handle(
        _installmentPlanIdMeta,
        installmentPlanId.isAcceptableOrUnknown(
          data['installment_plan_id']!,
          _installmentPlanIdMeta,
        ),
      );
    }
    if (data.containsKey('installment_number')) {
      context.handle(
        _installmentNumberMeta,
        installmentNumber.isAcceptableOrUnknown(
          data['installment_number']!,
          _installmentNumberMeta,
        ),
      );
    }
    if (data.containsKey('transfer_link_id')) {
      context.handle(
        _transferLinkIdMeta,
        transferLinkId.isAcceptableOrUnknown(
          data['transfer_link_id']!,
          _transferLinkIdMeta,
        ),
      );
    }
    if (data.containsKey('is_auto_categorized')) {
      context.handle(
        _isAutoCategorizedMeta,
        isAutoCategorized.isAcceptableOrUnknown(
          data['is_auto_categorized']!,
          _isAutoCategorizedMeta,
        ),
      );
    }
    if (data.containsKey('import_batch_id')) {
      context.handle(
        _importBatchIdMeta,
        importBatchId.isAcceptableOrUnknown(
          data['import_batch_id']!,
          _importBatchIdMeta,
        ),
      );
    }
    if (data.containsKey('original_currency')) {
      context.handle(
        _originalCurrencyMeta,
        originalCurrency.isAcceptableOrUnknown(
          data['original_currency']!,
          _originalCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('original_amount')) {
      context.handle(
        _originalAmountMeta,
        originalAmount.isAcceptableOrUnknown(
          data['original_amount']!,
          _originalAmountMeta,
        ),
      );
    }
    if (data.containsKey('exchange_rate_to_ils')) {
      context.handle(
        _exchangeRateToIlsMeta,
        exchangeRateToIls.isAcceptableOrUnknown(
          data['exchange_rate_to_ils']!,
          _exchangeRateToIlsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      merchantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isExcludedFromReports: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_excluded_from_reports'],
      )!,
      hasSplits: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_splits'],
      )!,
      isRecurringInstance: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_recurring_instance'],
      )!,
      recurringRuleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurring_rule_id'],
      ),
      installmentPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installment_plan_id'],
      ),
      installmentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installment_number'],
      ),
      transferLinkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_link_id'],
      ),
      isAutoCategorized: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_auto_categorized'],
      )!,
      importBatchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}import_batch_id'],
      ),
      originalCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_currency'],
      )!,
      originalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_amount'],
      ),
      exchangeRateToIls: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exchange_rate_to_ils'],
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
  $TransactionsTableTable createAlias(String alias) {
    return $TransactionsTableTable(attachedDatabase, alias);
  }
}

class TransactionEntry extends DataClass
    implements Insertable<TransactionEntry> {
  final String id;
  final String accountId;
  final String? categoryId;
  final String? merchantId;
  final double amount;
  final String type;
  final DateTime date;
  final String? note;
  final bool isExcludedFromReports;
  final bool hasSplits;
  final bool isRecurringInstance;
  final String? recurringRuleId;
  final String? installmentPlanId;
  final int? installmentNumber;
  final String? transferLinkId;
  final bool isAutoCategorized;
  final String? importBatchId;
  final String originalCurrency;
  final double? originalAmount;
  final double exchangeRateToIls;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TransactionEntry({
    required this.id,
    required this.accountId,
    this.categoryId,
    this.merchantId,
    required this.amount,
    required this.type,
    required this.date,
    this.note,
    required this.isExcludedFromReports,
    required this.hasSplits,
    required this.isRecurringInstance,
    this.recurringRuleId,
    this.installmentPlanId,
    this.installmentNumber,
    this.transferLinkId,
    required this.isAutoCategorized,
    this.importBatchId,
    required this.originalCurrency,
    this.originalAmount,
    required this.exchangeRateToIls,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || merchantId != null) {
      map['merchant_id'] = Variable<String>(merchantId);
    }
    map['amount'] = Variable<double>(amount);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_excluded_from_reports'] = Variable<bool>(isExcludedFromReports);
    map['has_splits'] = Variable<bool>(hasSplits);
    map['is_recurring_instance'] = Variable<bool>(isRecurringInstance);
    if (!nullToAbsent || recurringRuleId != null) {
      map['recurring_rule_id'] = Variable<String>(recurringRuleId);
    }
    if (!nullToAbsent || installmentPlanId != null) {
      map['installment_plan_id'] = Variable<String>(installmentPlanId);
    }
    if (!nullToAbsent || installmentNumber != null) {
      map['installment_number'] = Variable<int>(installmentNumber);
    }
    if (!nullToAbsent || transferLinkId != null) {
      map['transfer_link_id'] = Variable<String>(transferLinkId);
    }
    map['is_auto_categorized'] = Variable<bool>(isAutoCategorized);
    if (!nullToAbsent || importBatchId != null) {
      map['import_batch_id'] = Variable<String>(importBatchId);
    }
    map['original_currency'] = Variable<String>(originalCurrency);
    if (!nullToAbsent || originalAmount != null) {
      map['original_amount'] = Variable<double>(originalAmount);
    }
    map['exchange_rate_to_ils'] = Variable<double>(exchangeRateToIls);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionsTableCompanion(
      id: Value(id),
      accountId: Value(accountId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      amount: Value(amount),
      type: Value(type),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isExcludedFromReports: Value(isExcludedFromReports),
      hasSplits: Value(hasSplits),
      isRecurringInstance: Value(isRecurringInstance),
      recurringRuleId: recurringRuleId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurringRuleId),
      installmentPlanId: installmentPlanId == null && nullToAbsent
          ? const Value.absent()
          : Value(installmentPlanId),
      installmentNumber: installmentNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(installmentNumber),
      transferLinkId: transferLinkId == null && nullToAbsent
          ? const Value.absent()
          : Value(transferLinkId),
      isAutoCategorized: Value(isAutoCategorized),
      importBatchId: importBatchId == null && nullToAbsent
          ? const Value.absent()
          : Value(importBatchId),
      originalCurrency: Value(originalCurrency),
      originalAmount: originalAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(originalAmount),
      exchangeRateToIls: Value(exchangeRateToIls),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TransactionEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionEntry(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      merchantId: serializer.fromJson<String?>(json['merchantId']),
      amount: serializer.fromJson<double>(json['amount']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      isExcludedFromReports: serializer.fromJson<bool>(
        json['isExcludedFromReports'],
      ),
      hasSplits: serializer.fromJson<bool>(json['hasSplits']),
      isRecurringInstance: serializer.fromJson<bool>(
        json['isRecurringInstance'],
      ),
      recurringRuleId: serializer.fromJson<String?>(json['recurringRuleId']),
      installmentPlanId: serializer.fromJson<String?>(
        json['installmentPlanId'],
      ),
      installmentNumber: serializer.fromJson<int?>(json['installmentNumber']),
      transferLinkId: serializer.fromJson<String?>(json['transferLinkId']),
      isAutoCategorized: serializer.fromJson<bool>(json['isAutoCategorized']),
      importBatchId: serializer.fromJson<String?>(json['importBatchId']),
      originalCurrency: serializer.fromJson<String>(json['originalCurrency']),
      originalAmount: serializer.fromJson<double?>(json['originalAmount']),
      exchangeRateToIls: serializer.fromJson<double>(json['exchangeRateToIls']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'merchantId': serializer.toJson<String?>(merchantId),
      'amount': serializer.toJson<double>(amount),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
      'isExcludedFromReports': serializer.toJson<bool>(isExcludedFromReports),
      'hasSplits': serializer.toJson<bool>(hasSplits),
      'isRecurringInstance': serializer.toJson<bool>(isRecurringInstance),
      'recurringRuleId': serializer.toJson<String?>(recurringRuleId),
      'installmentPlanId': serializer.toJson<String?>(installmentPlanId),
      'installmentNumber': serializer.toJson<int?>(installmentNumber),
      'transferLinkId': serializer.toJson<String?>(transferLinkId),
      'isAutoCategorized': serializer.toJson<bool>(isAutoCategorized),
      'importBatchId': serializer.toJson<String?>(importBatchId),
      'originalCurrency': serializer.toJson<String>(originalCurrency),
      'originalAmount': serializer.toJson<double?>(originalAmount),
      'exchangeRateToIls': serializer.toJson<double>(exchangeRateToIls),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TransactionEntry copyWith({
    String? id,
    String? accountId,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> merchantId = const Value.absent(),
    double? amount,
    String? type,
    DateTime? date,
    Value<String?> note = const Value.absent(),
    bool? isExcludedFromReports,
    bool? hasSplits,
    bool? isRecurringInstance,
    Value<String?> recurringRuleId = const Value.absent(),
    Value<String?> installmentPlanId = const Value.absent(),
    Value<int?> installmentNumber = const Value.absent(),
    Value<String?> transferLinkId = const Value.absent(),
    bool? isAutoCategorized,
    Value<String?> importBatchId = const Value.absent(),
    String? originalCurrency,
    Value<double?> originalAmount = const Value.absent(),
    double? exchangeRateToIls,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TransactionEntry(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    merchantId: merchantId.present ? merchantId.value : this.merchantId,
    amount: amount ?? this.amount,
    type: type ?? this.type,
    date: date ?? this.date,
    note: note.present ? note.value : this.note,
    isExcludedFromReports: isExcludedFromReports ?? this.isExcludedFromReports,
    hasSplits: hasSplits ?? this.hasSplits,
    isRecurringInstance: isRecurringInstance ?? this.isRecurringInstance,
    recurringRuleId: recurringRuleId.present
        ? recurringRuleId.value
        : this.recurringRuleId,
    installmentPlanId: installmentPlanId.present
        ? installmentPlanId.value
        : this.installmentPlanId,
    installmentNumber: installmentNumber.present
        ? installmentNumber.value
        : this.installmentNumber,
    transferLinkId: transferLinkId.present
        ? transferLinkId.value
        : this.transferLinkId,
    isAutoCategorized: isAutoCategorized ?? this.isAutoCategorized,
    importBatchId: importBatchId.present
        ? importBatchId.value
        : this.importBatchId,
    originalCurrency: originalCurrency ?? this.originalCurrency,
    originalAmount: originalAmount.present
        ? originalAmount.value
        : this.originalAmount,
    exchangeRateToIls: exchangeRateToIls ?? this.exchangeRateToIls,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TransactionEntry copyWithCompanion(TransactionsTableCompanion data) {
    return TransactionEntry(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      merchantId: data.merchantId.present
          ? data.merchantId.value
          : this.merchantId,
      amount: data.amount.present ? data.amount.value : this.amount,
      type: data.type.present ? data.type.value : this.type,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      isExcludedFromReports: data.isExcludedFromReports.present
          ? data.isExcludedFromReports.value
          : this.isExcludedFromReports,
      hasSplits: data.hasSplits.present ? data.hasSplits.value : this.hasSplits,
      isRecurringInstance: data.isRecurringInstance.present
          ? data.isRecurringInstance.value
          : this.isRecurringInstance,
      recurringRuleId: data.recurringRuleId.present
          ? data.recurringRuleId.value
          : this.recurringRuleId,
      installmentPlanId: data.installmentPlanId.present
          ? data.installmentPlanId.value
          : this.installmentPlanId,
      installmentNumber: data.installmentNumber.present
          ? data.installmentNumber.value
          : this.installmentNumber,
      transferLinkId: data.transferLinkId.present
          ? data.transferLinkId.value
          : this.transferLinkId,
      isAutoCategorized: data.isAutoCategorized.present
          ? data.isAutoCategorized.value
          : this.isAutoCategorized,
      importBatchId: data.importBatchId.present
          ? data.importBatchId.value
          : this.importBatchId,
      originalCurrency: data.originalCurrency.present
          ? data.originalCurrency.value
          : this.originalCurrency,
      originalAmount: data.originalAmount.present
          ? data.originalAmount.value
          : this.originalAmount,
      exchangeRateToIls: data.exchangeRateToIls.present
          ? data.exchangeRateToIls.value
          : this.exchangeRateToIls,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionEntry(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('merchantId: $merchantId, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('isExcludedFromReports: $isExcludedFromReports, ')
          ..write('hasSplits: $hasSplits, ')
          ..write('isRecurringInstance: $isRecurringInstance, ')
          ..write('recurringRuleId: $recurringRuleId, ')
          ..write('installmentPlanId: $installmentPlanId, ')
          ..write('installmentNumber: $installmentNumber, ')
          ..write('transferLinkId: $transferLinkId, ')
          ..write('isAutoCategorized: $isAutoCategorized, ')
          ..write('importBatchId: $importBatchId, ')
          ..write('originalCurrency: $originalCurrency, ')
          ..write('originalAmount: $originalAmount, ')
          ..write('exchangeRateToIls: $exchangeRateToIls, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    accountId,
    categoryId,
    merchantId,
    amount,
    type,
    date,
    note,
    isExcludedFromReports,
    hasSplits,
    isRecurringInstance,
    recurringRuleId,
    installmentPlanId,
    installmentNumber,
    transferLinkId,
    isAutoCategorized,
    importBatchId,
    originalCurrency,
    originalAmount,
    exchangeRateToIls,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionEntry &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.merchantId == this.merchantId &&
          other.amount == this.amount &&
          other.type == this.type &&
          other.date == this.date &&
          other.note == this.note &&
          other.isExcludedFromReports == this.isExcludedFromReports &&
          other.hasSplits == this.hasSplits &&
          other.isRecurringInstance == this.isRecurringInstance &&
          other.recurringRuleId == this.recurringRuleId &&
          other.installmentPlanId == this.installmentPlanId &&
          other.installmentNumber == this.installmentNumber &&
          other.transferLinkId == this.transferLinkId &&
          other.isAutoCategorized == this.isAutoCategorized &&
          other.importBatchId == this.importBatchId &&
          other.originalCurrency == this.originalCurrency &&
          other.originalAmount == this.originalAmount &&
          other.exchangeRateToIls == this.exchangeRateToIls &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionsTableCompanion extends UpdateCompanion<TransactionEntry> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String?> categoryId;
  final Value<String?> merchantId;
  final Value<double> amount;
  final Value<String> type;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<bool> isExcludedFromReports;
  final Value<bool> hasSplits;
  final Value<bool> isRecurringInstance;
  final Value<String?> recurringRuleId;
  final Value<String?> installmentPlanId;
  final Value<int?> installmentNumber;
  final Value<String?> transferLinkId;
  final Value<bool> isAutoCategorized;
  final Value<String?> importBatchId;
  final Value<String> originalCurrency;
  final Value<double?> originalAmount;
  final Value<double> exchangeRateToIls;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TransactionsTableCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.amount = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.isExcludedFromReports = const Value.absent(),
    this.hasSplits = const Value.absent(),
    this.isRecurringInstance = const Value.absent(),
    this.recurringRuleId = const Value.absent(),
    this.installmentPlanId = const Value.absent(),
    this.installmentNumber = const Value.absent(),
    this.transferLinkId = const Value.absent(),
    this.isAutoCategorized = const Value.absent(),
    this.importBatchId = const Value.absent(),
    this.originalCurrency = const Value.absent(),
    this.originalAmount = const Value.absent(),
    this.exchangeRateToIls = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsTableCompanion.insert({
    required String id,
    required String accountId,
    this.categoryId = const Value.absent(),
    this.merchantId = const Value.absent(),
    required double amount,
    required String type,
    required DateTime date,
    this.note = const Value.absent(),
    this.isExcludedFromReports = const Value.absent(),
    this.hasSplits = const Value.absent(),
    this.isRecurringInstance = const Value.absent(),
    this.recurringRuleId = const Value.absent(),
    this.installmentPlanId = const Value.absent(),
    this.installmentNumber = const Value.absent(),
    this.transferLinkId = const Value.absent(),
    this.isAutoCategorized = const Value.absent(),
    this.importBatchId = const Value.absent(),
    this.originalCurrency = const Value.absent(),
    this.originalAmount = const Value.absent(),
    this.exchangeRateToIls = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       amount = Value(amount),
       type = Value(type),
       date = Value(date);
  static Insertable<TransactionEntry> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? categoryId,
    Expression<String>? merchantId,
    Expression<double>? amount,
    Expression<String>? type,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<bool>? isExcludedFromReports,
    Expression<bool>? hasSplits,
    Expression<bool>? isRecurringInstance,
    Expression<String>? recurringRuleId,
    Expression<String>? installmentPlanId,
    Expression<int>? installmentNumber,
    Expression<String>? transferLinkId,
    Expression<bool>? isAutoCategorized,
    Expression<String>? importBatchId,
    Expression<String>? originalCurrency,
    Expression<double>? originalAmount,
    Expression<double>? exchangeRateToIls,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (merchantId != null) 'merchant_id': merchantId,
      if (amount != null) 'amount': amount,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (isExcludedFromReports != null)
        'is_excluded_from_reports': isExcludedFromReports,
      if (hasSplits != null) 'has_splits': hasSplits,
      if (isRecurringInstance != null)
        'is_recurring_instance': isRecurringInstance,
      if (recurringRuleId != null) 'recurring_rule_id': recurringRuleId,
      if (installmentPlanId != null) 'installment_plan_id': installmentPlanId,
      if (installmentNumber != null) 'installment_number': installmentNumber,
      if (transferLinkId != null) 'transfer_link_id': transferLinkId,
      if (isAutoCategorized != null) 'is_auto_categorized': isAutoCategorized,
      if (importBatchId != null) 'import_batch_id': importBatchId,
      if (originalCurrency != null) 'original_currency': originalCurrency,
      if (originalAmount != null) 'original_amount': originalAmount,
      if (exchangeRateToIls != null) 'exchange_rate_to_ils': exchangeRateToIls,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String?>? categoryId,
    Value<String?>? merchantId,
    Value<double>? amount,
    Value<String>? type,
    Value<DateTime>? date,
    Value<String?>? note,
    Value<bool>? isExcludedFromReports,
    Value<bool>? hasSplits,
    Value<bool>? isRecurringInstance,
    Value<String?>? recurringRuleId,
    Value<String?>? installmentPlanId,
    Value<int?>? installmentNumber,
    Value<String?>? transferLinkId,
    Value<bool>? isAutoCategorized,
    Value<String?>? importBatchId,
    Value<String>? originalCurrency,
    Value<double?>? originalAmount,
    Value<double>? exchangeRateToIls,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TransactionsTableCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      merchantId: merchantId ?? this.merchantId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      note: note ?? this.note,
      isExcludedFromReports:
          isExcludedFromReports ?? this.isExcludedFromReports,
      hasSplits: hasSplits ?? this.hasSplits,
      isRecurringInstance: isRecurringInstance ?? this.isRecurringInstance,
      recurringRuleId: recurringRuleId ?? this.recurringRuleId,
      installmentPlanId: installmentPlanId ?? this.installmentPlanId,
      installmentNumber: installmentNumber ?? this.installmentNumber,
      transferLinkId: transferLinkId ?? this.transferLinkId,
      isAutoCategorized: isAutoCategorized ?? this.isAutoCategorized,
      importBatchId: importBatchId ?? this.importBatchId,
      originalCurrency: originalCurrency ?? this.originalCurrency,
      originalAmount: originalAmount ?? this.originalAmount,
      exchangeRateToIls: exchangeRateToIls ?? this.exchangeRateToIls,
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
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (merchantId.present) {
      map['merchant_id'] = Variable<String>(merchantId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isExcludedFromReports.present) {
      map['is_excluded_from_reports'] = Variable<bool>(
        isExcludedFromReports.value,
      );
    }
    if (hasSplits.present) {
      map['has_splits'] = Variable<bool>(hasSplits.value);
    }
    if (isRecurringInstance.present) {
      map['is_recurring_instance'] = Variable<bool>(isRecurringInstance.value);
    }
    if (recurringRuleId.present) {
      map['recurring_rule_id'] = Variable<String>(recurringRuleId.value);
    }
    if (installmentPlanId.present) {
      map['installment_plan_id'] = Variable<String>(installmentPlanId.value);
    }
    if (installmentNumber.present) {
      map['installment_number'] = Variable<int>(installmentNumber.value);
    }
    if (transferLinkId.present) {
      map['transfer_link_id'] = Variable<String>(transferLinkId.value);
    }
    if (isAutoCategorized.present) {
      map['is_auto_categorized'] = Variable<bool>(isAutoCategorized.value);
    }
    if (importBatchId.present) {
      map['import_batch_id'] = Variable<String>(importBatchId.value);
    }
    if (originalCurrency.present) {
      map['original_currency'] = Variable<String>(originalCurrency.value);
    }
    if (originalAmount.present) {
      map['original_amount'] = Variable<double>(originalAmount.value);
    }
    if (exchangeRateToIls.present) {
      map['exchange_rate_to_ils'] = Variable<double>(exchangeRateToIls.value);
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
    return (StringBuffer('TransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('merchantId: $merchantId, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('isExcludedFromReports: $isExcludedFromReports, ')
          ..write('hasSplits: $hasSplits, ')
          ..write('isRecurringInstance: $isRecurringInstance, ')
          ..write('recurringRuleId: $recurringRuleId, ')
          ..write('installmentPlanId: $installmentPlanId, ')
          ..write('installmentNumber: $installmentNumber, ')
          ..write('transferLinkId: $transferLinkId, ')
          ..write('isAutoCategorized: $isAutoCategorized, ')
          ..write('importBatchId: $importBatchId, ')
          ..write('originalCurrency: $originalCurrency, ')
          ..write('originalAmount: $originalAmount, ')
          ..write('exchangeRateToIls: $exchangeRateToIls, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionSplitsTableTable extends TransactionSplitsTable
    with TableInfo<$TransactionSplitsTableTable, TransactionSplitEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionSplitsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transactions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    transactionId,
    categoryId,
    amount,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_splits';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionSplitEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionSplitEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionSplitEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TransactionSplitsTableTable createAlias(String alias) {
    return $TransactionSplitsTableTable(attachedDatabase, alias);
  }
}

class TransactionSplitEntry extends DataClass
    implements Insertable<TransactionSplitEntry> {
  final String id;
  final String transactionId;
  final String categoryId;
  final double amount;
  final String? note;
  final DateTime createdAt;
  const TransactionSplitEntry({
    required this.id,
    required this.transactionId,
    required this.categoryId,
    required this.amount,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['transaction_id'] = Variable<String>(transactionId);
    map['category_id'] = Variable<String>(categoryId);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionSplitsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionSplitsTableCompanion(
      id: Value(id),
      transactionId: Value(transactionId),
      categoryId: Value(categoryId),
      amount: Value(amount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory TransactionSplitEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionSplitEntry(
      id: serializer.fromJson<String>(json['id']),
      transactionId: serializer.fromJson<String>(json['transactionId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      amount: serializer.fromJson<double>(json['amount']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'transactionId': serializer.toJson<String>(transactionId),
      'categoryId': serializer.toJson<String>(categoryId),
      'amount': serializer.toJson<double>(amount),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TransactionSplitEntry copyWith({
    String? id,
    String? transactionId,
    String? categoryId,
    double? amount,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => TransactionSplitEntry(
    id: id ?? this.id,
    transactionId: transactionId ?? this.transactionId,
    categoryId: categoryId ?? this.categoryId,
    amount: amount ?? this.amount,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  TransactionSplitEntry copyWithCompanion(
    TransactionSplitsTableCompanion data,
  ) {
    return TransactionSplitEntry(
      id: data.id.present ? data.id.value : this.id,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionSplitEntry(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, transactionId, categoryId, amount, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionSplitEntry &&
          other.id == this.id &&
          other.transactionId == this.transactionId &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class TransactionSplitsTableCompanion
    extends UpdateCompanion<TransactionSplitEntry> {
  final Value<String> id;
  final Value<String> transactionId;
  final Value<String> categoryId;
  final Value<double> amount;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TransactionSplitsTableCompanion({
    this.id = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionSplitsTableCompanion.insert({
    required String id,
    required String transactionId,
    required String categoryId,
    required double amount,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       transactionId = Value(transactionId),
       categoryId = Value(categoryId),
       amount = Value(amount);
  static Insertable<TransactionSplitEntry> custom({
    Expression<String>? id,
    Expression<String>? transactionId,
    Expression<String>? categoryId,
    Expression<double>? amount,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionId != null) 'transaction_id': transactionId,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionSplitsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? transactionId,
    Value<String>? categoryId,
    Value<double>? amount,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TransactionSplitsTableCompanion(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      note: note ?? this.note,
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
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
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
    return (StringBuffer('TransactionSplitsTableCompanion(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InstallmentPlansTableTable extends InstallmentPlansTable
    with TableInfo<$InstallmentPlansTableTable, InstallmentPlanEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallmentPlansTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _merchantIdMeta = const VerificationMeta(
    'merchantId',
  );
  @override
  late final GeneratedColumn<String> merchantId = GeneratedColumn<String>(
    'merchant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES merchants (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstInstallmentAmountMeta =
      const VerificationMeta('firstInstallmentAmount');
  @override
  late final GeneratedColumn<double> firstInstallmentAmount =
      GeneratedColumn<double>(
        'first_installment_amount',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _numberOfInstallmentsMeta =
      const VerificationMeta('numberOfInstallments');
  @override
  late final GeneratedColumn<int> numberOfInstallments = GeneratedColumn<int>(
    'number_of_installments',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstDueDateMeta = const VerificationMeta(
    'firstDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> firstDueDate = GeneratedColumn<DateTime>(
    'first_due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    categoryId,
    merchantId,
    totalAmount,
    firstInstallmentAmount,
    numberOfInstallments,
    firstDueDate,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installment_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstallmentPlanEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('merchant_id')) {
      context.handle(
        _merchantIdMeta,
        merchantId.isAcceptableOrUnknown(data['merchant_id']!, _merchantIdMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('first_installment_amount')) {
      context.handle(
        _firstInstallmentAmountMeta,
        firstInstallmentAmount.isAcceptableOrUnknown(
          data['first_installment_amount']!,
          _firstInstallmentAmountMeta,
        ),
      );
    }
    if (data.containsKey('number_of_installments')) {
      context.handle(
        _numberOfInstallmentsMeta,
        numberOfInstallments.isAcceptableOrUnknown(
          data['number_of_installments']!,
          _numberOfInstallmentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberOfInstallmentsMeta);
    }
    if (data.containsKey('first_due_date')) {
      context.handle(
        _firstDueDateMeta,
        firstDueDate.isAcceptableOrUnknown(
          data['first_due_date']!,
          _firstDueDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstDueDateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstallmentPlanEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstallmentPlanEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      merchantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_id'],
      ),
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      firstInstallmentAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}first_installment_amount'],
      ),
      numberOfInstallments: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_installments'],
      )!,
      firstDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}first_due_date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InstallmentPlansTableTable createAlias(String alias) {
    return $InstallmentPlansTableTable(attachedDatabase, alias);
  }
}

class InstallmentPlanEntry extends DataClass
    implements Insertable<InstallmentPlanEntry> {
  final String id;
  final String accountId;
  final String? categoryId;
  final String? merchantId;
  final double totalAmount;
  final double? firstInstallmentAmount;
  final int numberOfInstallments;
  final DateTime firstDueDate;
  final String? note;
  final DateTime createdAt;
  const InstallmentPlanEntry({
    required this.id,
    required this.accountId,
    this.categoryId,
    this.merchantId,
    required this.totalAmount,
    this.firstInstallmentAmount,
    required this.numberOfInstallments,
    required this.firstDueDate,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || merchantId != null) {
      map['merchant_id'] = Variable<String>(merchantId);
    }
    map['total_amount'] = Variable<double>(totalAmount);
    if (!nullToAbsent || firstInstallmentAmount != null) {
      map['first_installment_amount'] = Variable<double>(
        firstInstallmentAmount,
      );
    }
    map['number_of_installments'] = Variable<int>(numberOfInstallments);
    map['first_due_date'] = Variable<DateTime>(firstDueDate);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InstallmentPlansTableCompanion toCompanion(bool nullToAbsent) {
    return InstallmentPlansTableCompanion(
      id: Value(id),
      accountId: Value(accountId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      totalAmount: Value(totalAmount),
      firstInstallmentAmount: firstInstallmentAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(firstInstallmentAmount),
      numberOfInstallments: Value(numberOfInstallments),
      firstDueDate: Value(firstDueDate),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory InstallmentPlanEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstallmentPlanEntry(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      merchantId: serializer.fromJson<String?>(json['merchantId']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      firstInstallmentAmount: serializer.fromJson<double?>(
        json['firstInstallmentAmount'],
      ),
      numberOfInstallments: serializer.fromJson<int>(
        json['numberOfInstallments'],
      ),
      firstDueDate: serializer.fromJson<DateTime>(json['firstDueDate']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'merchantId': serializer.toJson<String?>(merchantId),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'firstInstallmentAmount': serializer.toJson<double?>(
        firstInstallmentAmount,
      ),
      'numberOfInstallments': serializer.toJson<int>(numberOfInstallments),
      'firstDueDate': serializer.toJson<DateTime>(firstDueDate),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InstallmentPlanEntry copyWith({
    String? id,
    String? accountId,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> merchantId = const Value.absent(),
    double? totalAmount,
    Value<double?> firstInstallmentAmount = const Value.absent(),
    int? numberOfInstallments,
    DateTime? firstDueDate,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => InstallmentPlanEntry(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    merchantId: merchantId.present ? merchantId.value : this.merchantId,
    totalAmount: totalAmount ?? this.totalAmount,
    firstInstallmentAmount: firstInstallmentAmount.present
        ? firstInstallmentAmount.value
        : this.firstInstallmentAmount,
    numberOfInstallments: numberOfInstallments ?? this.numberOfInstallments,
    firstDueDate: firstDueDate ?? this.firstDueDate,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  InstallmentPlanEntry copyWithCompanion(InstallmentPlansTableCompanion data) {
    return InstallmentPlanEntry(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      merchantId: data.merchantId.present
          ? data.merchantId.value
          : this.merchantId,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      firstInstallmentAmount: data.firstInstallmentAmount.present
          ? data.firstInstallmentAmount.value
          : this.firstInstallmentAmount,
      numberOfInstallments: data.numberOfInstallments.present
          ? data.numberOfInstallments.value
          : this.numberOfInstallments,
      firstDueDate: data.firstDueDate.present
          ? data.firstDueDate.value
          : this.firstDueDate,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallmentPlanEntry(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('merchantId: $merchantId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('firstInstallmentAmount: $firstInstallmentAmount, ')
          ..write('numberOfInstallments: $numberOfInstallments, ')
          ..write('firstDueDate: $firstDueDate, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    categoryId,
    merchantId,
    totalAmount,
    firstInstallmentAmount,
    numberOfInstallments,
    firstDueDate,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallmentPlanEntry &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.merchantId == this.merchantId &&
          other.totalAmount == this.totalAmount &&
          other.firstInstallmentAmount == this.firstInstallmentAmount &&
          other.numberOfInstallments == this.numberOfInstallments &&
          other.firstDueDate == this.firstDueDate &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class InstallmentPlansTableCompanion
    extends UpdateCompanion<InstallmentPlanEntry> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String?> categoryId;
  final Value<String?> merchantId;
  final Value<double> totalAmount;
  final Value<double?> firstInstallmentAmount;
  final Value<int> numberOfInstallments;
  final Value<DateTime> firstDueDate;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InstallmentPlansTableCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.firstInstallmentAmount = const Value.absent(),
    this.numberOfInstallments = const Value.absent(),
    this.firstDueDate = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InstallmentPlansTableCompanion.insert({
    required String id,
    required String accountId,
    this.categoryId = const Value.absent(),
    this.merchantId = const Value.absent(),
    required double totalAmount,
    this.firstInstallmentAmount = const Value.absent(),
    required int numberOfInstallments,
    required DateTime firstDueDate,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       totalAmount = Value(totalAmount),
       numberOfInstallments = Value(numberOfInstallments),
       firstDueDate = Value(firstDueDate);
  static Insertable<InstallmentPlanEntry> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? categoryId,
    Expression<String>? merchantId,
    Expression<double>? totalAmount,
    Expression<double>? firstInstallmentAmount,
    Expression<int>? numberOfInstallments,
    Expression<DateTime>? firstDueDate,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (merchantId != null) 'merchant_id': merchantId,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (firstInstallmentAmount != null)
        'first_installment_amount': firstInstallmentAmount,
      if (numberOfInstallments != null)
        'number_of_installments': numberOfInstallments,
      if (firstDueDate != null) 'first_due_date': firstDueDate,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InstallmentPlansTableCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String?>? categoryId,
    Value<String?>? merchantId,
    Value<double>? totalAmount,
    Value<double?>? firstInstallmentAmount,
    Value<int>? numberOfInstallments,
    Value<DateTime>? firstDueDate,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return InstallmentPlansTableCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      merchantId: merchantId ?? this.merchantId,
      totalAmount: totalAmount ?? this.totalAmount,
      firstInstallmentAmount:
          firstInstallmentAmount ?? this.firstInstallmentAmount,
      numberOfInstallments: numberOfInstallments ?? this.numberOfInstallments,
      firstDueDate: firstDueDate ?? this.firstDueDate,
      note: note ?? this.note,
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
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (merchantId.present) {
      map['merchant_id'] = Variable<String>(merchantId.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (firstInstallmentAmount.present) {
      map['first_installment_amount'] = Variable<double>(
        firstInstallmentAmount.value,
      );
    }
    if (numberOfInstallments.present) {
      map['number_of_installments'] = Variable<int>(numberOfInstallments.value);
    }
    if (firstDueDate.present) {
      map['first_due_date'] = Variable<DateTime>(firstDueDate.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
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
    return (StringBuffer('InstallmentPlansTableCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('merchantId: $merchantId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('firstInstallmentAmount: $firstInstallmentAmount, ')
          ..write('numberOfInstallments: $numberOfInstallments, ')
          ..write('firstDueDate: $firstDueDate, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InstallmentItemsTableTable extends InstallmentItemsTable
    with TableInfo<$InstallmentItemsTableTable, InstallmentItemEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallmentItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installmentPlanIdMeta = const VerificationMeta(
    'installmentPlanId',
  );
  @override
  late final GeneratedColumn<String> installmentPlanId =
      GeneratedColumn<String>(
        'installment_plan_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES installment_plans (id) ON DELETE CASCADE',
        ),
      );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installmentNumberMeta = const VerificationMeta(
    'installmentNumber',
  );
  @override
  late final GeneratedColumn<int> installmentNumber = GeneratedColumn<int>(
    'installment_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPaidMeta = const VerificationMeta('isPaid');
  @override
  late final GeneratedColumn<bool> isPaid = GeneratedColumn<bool>(
    'is_paid',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_paid" IN (0, 1))',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    installmentPlanId,
    transactionId,
    installmentNumber,
    amount,
    dueDate,
    isPaid,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installment_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstallmentItemEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('installment_plan_id')) {
      context.handle(
        _installmentPlanIdMeta,
        installmentPlanId.isAcceptableOrUnknown(
          data['installment_plan_id']!,
          _installmentPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installmentPlanIdMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    }
    if (data.containsKey('installment_number')) {
      context.handle(
        _installmentNumberMeta,
        installmentNumber.isAcceptableOrUnknown(
          data['installment_number']!,
          _installmentNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installmentNumberMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('is_paid')) {
      context.handle(
        _isPaidMeta,
        isPaid.isAcceptableOrUnknown(data['is_paid']!, _isPaidMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstallmentItemEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstallmentItemEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      installmentPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installment_plan_id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      ),
      installmentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installment_number'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      isPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_paid'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InstallmentItemsTableTable createAlias(String alias) {
    return $InstallmentItemsTableTable(attachedDatabase, alias);
  }
}

class InstallmentItemEntry extends DataClass
    implements Insertable<InstallmentItemEntry> {
  final String id;
  final String installmentPlanId;
  final String? transactionId;
  final int installmentNumber;
  final double amount;
  final DateTime dueDate;
  final bool isPaid;
  final DateTime createdAt;
  const InstallmentItemEntry({
    required this.id,
    required this.installmentPlanId,
    this.transactionId,
    required this.installmentNumber,
    required this.amount,
    required this.dueDate,
    required this.isPaid,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['installment_plan_id'] = Variable<String>(installmentPlanId);
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
    }
    map['installment_number'] = Variable<int>(installmentNumber);
    map['amount'] = Variable<double>(amount);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['is_paid'] = Variable<bool>(isPaid);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InstallmentItemsTableCompanion toCompanion(bool nullToAbsent) {
    return InstallmentItemsTableCompanion(
      id: Value(id),
      installmentPlanId: Value(installmentPlanId),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      installmentNumber: Value(installmentNumber),
      amount: Value(amount),
      dueDate: Value(dueDate),
      isPaid: Value(isPaid),
      createdAt: Value(createdAt),
    );
  }

  factory InstallmentItemEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstallmentItemEntry(
      id: serializer.fromJson<String>(json['id']),
      installmentPlanId: serializer.fromJson<String>(json['installmentPlanId']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
      installmentNumber: serializer.fromJson<int>(json['installmentNumber']),
      amount: serializer.fromJson<double>(json['amount']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      isPaid: serializer.fromJson<bool>(json['isPaid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'installmentPlanId': serializer.toJson<String>(installmentPlanId),
      'transactionId': serializer.toJson<String?>(transactionId),
      'installmentNumber': serializer.toJson<int>(installmentNumber),
      'amount': serializer.toJson<double>(amount),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'isPaid': serializer.toJson<bool>(isPaid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InstallmentItemEntry copyWith({
    String? id,
    String? installmentPlanId,
    Value<String?> transactionId = const Value.absent(),
    int? installmentNumber,
    double? amount,
    DateTime? dueDate,
    bool? isPaid,
    DateTime? createdAt,
  }) => InstallmentItemEntry(
    id: id ?? this.id,
    installmentPlanId: installmentPlanId ?? this.installmentPlanId,
    transactionId: transactionId.present
        ? transactionId.value
        : this.transactionId,
    installmentNumber: installmentNumber ?? this.installmentNumber,
    amount: amount ?? this.amount,
    dueDate: dueDate ?? this.dueDate,
    isPaid: isPaid ?? this.isPaid,
    createdAt: createdAt ?? this.createdAt,
  );
  InstallmentItemEntry copyWithCompanion(InstallmentItemsTableCompanion data) {
    return InstallmentItemEntry(
      id: data.id.present ? data.id.value : this.id,
      installmentPlanId: data.installmentPlanId.present
          ? data.installmentPlanId.value
          : this.installmentPlanId,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      installmentNumber: data.installmentNumber.present
          ? data.installmentNumber.value
          : this.installmentNumber,
      amount: data.amount.present ? data.amount.value : this.amount,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      isPaid: data.isPaid.present ? data.isPaid.value : this.isPaid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstallmentItemEntry(')
          ..write('id: $id, ')
          ..write('installmentPlanId: $installmentPlanId, ')
          ..write('transactionId: $transactionId, ')
          ..write('installmentNumber: $installmentNumber, ')
          ..write('amount: $amount, ')
          ..write('dueDate: $dueDate, ')
          ..write('isPaid: $isPaid, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    installmentPlanId,
    transactionId,
    installmentNumber,
    amount,
    dueDate,
    isPaid,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstallmentItemEntry &&
          other.id == this.id &&
          other.installmentPlanId == this.installmentPlanId &&
          other.transactionId == this.transactionId &&
          other.installmentNumber == this.installmentNumber &&
          other.amount == this.amount &&
          other.dueDate == this.dueDate &&
          other.isPaid == this.isPaid &&
          other.createdAt == this.createdAt);
}

class InstallmentItemsTableCompanion
    extends UpdateCompanion<InstallmentItemEntry> {
  final Value<String> id;
  final Value<String> installmentPlanId;
  final Value<String?> transactionId;
  final Value<int> installmentNumber;
  final Value<double> amount;
  final Value<DateTime> dueDate;
  final Value<bool> isPaid;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InstallmentItemsTableCompanion({
    this.id = const Value.absent(),
    this.installmentPlanId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.installmentNumber = const Value.absent(),
    this.amount = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isPaid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InstallmentItemsTableCompanion.insert({
    required String id,
    required String installmentPlanId,
    this.transactionId = const Value.absent(),
    required int installmentNumber,
    required double amount,
    required DateTime dueDate,
    this.isPaid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       installmentPlanId = Value(installmentPlanId),
       installmentNumber = Value(installmentNumber),
       amount = Value(amount),
       dueDate = Value(dueDate);
  static Insertable<InstallmentItemEntry> custom({
    Expression<String>? id,
    Expression<String>? installmentPlanId,
    Expression<String>? transactionId,
    Expression<int>? installmentNumber,
    Expression<double>? amount,
    Expression<DateTime>? dueDate,
    Expression<bool>? isPaid,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (installmentPlanId != null) 'installment_plan_id': installmentPlanId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (installmentNumber != null) 'installment_number': installmentNumber,
      if (amount != null) 'amount': amount,
      if (dueDate != null) 'due_date': dueDate,
      if (isPaid != null) 'is_paid': isPaid,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InstallmentItemsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? installmentPlanId,
    Value<String?>? transactionId,
    Value<int>? installmentNumber,
    Value<double>? amount,
    Value<DateTime>? dueDate,
    Value<bool>? isPaid,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return InstallmentItemsTableCompanion(
      id: id ?? this.id,
      installmentPlanId: installmentPlanId ?? this.installmentPlanId,
      transactionId: transactionId ?? this.transactionId,
      installmentNumber: installmentNumber ?? this.installmentNumber,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      isPaid: isPaid ?? this.isPaid,
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
    if (installmentPlanId.present) {
      map['installment_plan_id'] = Variable<String>(installmentPlanId.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (installmentNumber.present) {
      map['installment_number'] = Variable<int>(installmentNumber.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (isPaid.present) {
      map['is_paid'] = Variable<bool>(isPaid.value);
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
    return (StringBuffer('InstallmentItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('installmentPlanId: $installmentPlanId, ')
          ..write('transactionId: $transactionId, ')
          ..write('installmentNumber: $installmentNumber, ')
          ..write('amount: $amount, ')
          ..write('dueDate: $dueDate, ')
          ..write('isPaid: $isPaid, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecurringRulesTableTable extends RecurringRulesTable
    with TableInfo<$RecurringRulesTableTable, RecurringRuleEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringRulesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _merchantIdMeta = const VerificationMeta(
    'merchantId',
  );
  @override
  late final GeneratedColumn<String> merchantId = GeneratedColumn<String>(
    'merchant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES merchants (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayOfMonthMeta = const VerificationMeta(
    'dayOfMonth',
  );
  @override
  late final GeneratedColumn<int> dayOfMonth = GeneratedColumn<int>(
    'day_of_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _isAutoExecuteMeta = const VerificationMeta(
    'isAutoExecute',
  );
  @override
  late final GeneratedColumn<bool> isAutoExecute = GeneratedColumn<bool>(
    'is_auto_execute',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_auto_execute" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isPausedMeta = const VerificationMeta(
    'isPaused',
  );
  @override
  late final GeneratedColumn<bool> isPaused = GeneratedColumn<bool>(
    'is_paused',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_paused" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastExecutedDateMeta = const VerificationMeta(
    'lastExecutedDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastExecutedDate =
      GeneratedColumn<DateTime>(
        'last_executed_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextExecutionDateMeta = const VerificationMeta(
    'nextExecutionDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextExecutionDate =
      GeneratedColumn<DateTime>(
        'next_execution_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    categoryId,
    merchantId,
    name,
    amount,
    frequency,
    dayOfMonth,
    startDate,
    endDate,
    isAutoExecute,
    isPaused,
    lastExecutedDate,
    nextExecutionDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurringRuleEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('merchant_id')) {
      context.handle(
        _merchantIdMeta,
        merchantId.isAcceptableOrUnknown(data['merchant_id']!, _merchantIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('day_of_month')) {
      context.handle(
        _dayOfMonthMeta,
        dayOfMonth.isAcceptableOrUnknown(
          data['day_of_month']!,
          _dayOfMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dayOfMonthMeta);
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
    if (data.containsKey('is_auto_execute')) {
      context.handle(
        _isAutoExecuteMeta,
        isAutoExecute.isAcceptableOrUnknown(
          data['is_auto_execute']!,
          _isAutoExecuteMeta,
        ),
      );
    }
    if (data.containsKey('is_paused')) {
      context.handle(
        _isPausedMeta,
        isPaused.isAcceptableOrUnknown(data['is_paused']!, _isPausedMeta),
      );
    }
    if (data.containsKey('last_executed_date')) {
      context.handle(
        _lastExecutedDateMeta,
        lastExecutedDate.isAcceptableOrUnknown(
          data['last_executed_date']!,
          _lastExecutedDateMeta,
        ),
      );
    }
    if (data.containsKey('next_execution_date')) {
      context.handle(
        _nextExecutionDateMeta,
        nextExecutionDate.isAcceptableOrUnknown(
          data['next_execution_date']!,
          _nextExecutionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextExecutionDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringRuleEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringRuleEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      merchantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      dayOfMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_month'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      isAutoExecute: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_auto_execute'],
      )!,
      isPaused: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_paused'],
      )!,
      lastExecutedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_executed_date'],
      ),
      nextExecutionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_execution_date'],
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
  $RecurringRulesTableTable createAlias(String alias) {
    return $RecurringRulesTableTable(attachedDatabase, alias);
  }
}

class RecurringRuleEntry extends DataClass
    implements Insertable<RecurringRuleEntry> {
  final String id;
  final String accountId;
  final String? categoryId;
  final String? merchantId;
  final String name;
  final double amount;
  final String frequency;
  final int dayOfMonth;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isAutoExecute;
  final bool isPaused;
  final DateTime? lastExecutedDate;
  final DateTime nextExecutionDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RecurringRuleEntry({
    required this.id,
    required this.accountId,
    this.categoryId,
    this.merchantId,
    required this.name,
    required this.amount,
    required this.frequency,
    required this.dayOfMonth,
    required this.startDate,
    this.endDate,
    required this.isAutoExecute,
    required this.isPaused,
    this.lastExecutedDate,
    required this.nextExecutionDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || merchantId != null) {
      map['merchant_id'] = Variable<String>(merchantId);
    }
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<double>(amount);
    map['frequency'] = Variable<String>(frequency);
    map['day_of_month'] = Variable<int>(dayOfMonth);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['is_auto_execute'] = Variable<bool>(isAutoExecute);
    map['is_paused'] = Variable<bool>(isPaused);
    if (!nullToAbsent || lastExecutedDate != null) {
      map['last_executed_date'] = Variable<DateTime>(lastExecutedDate);
    }
    map['next_execution_date'] = Variable<DateTime>(nextExecutionDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecurringRulesTableCompanion toCompanion(bool nullToAbsent) {
    return RecurringRulesTableCompanion(
      id: Value(id),
      accountId: Value(accountId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      merchantId: merchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantId),
      name: Value(name),
      amount: Value(amount),
      frequency: Value(frequency),
      dayOfMonth: Value(dayOfMonth),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      isAutoExecute: Value(isAutoExecute),
      isPaused: Value(isPaused),
      lastExecutedDate: lastExecutedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastExecutedDate),
      nextExecutionDate: Value(nextExecutionDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RecurringRuleEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringRuleEntry(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      merchantId: serializer.fromJson<String?>(json['merchantId']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
      frequency: serializer.fromJson<String>(json['frequency']),
      dayOfMonth: serializer.fromJson<int>(json['dayOfMonth']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      isAutoExecute: serializer.fromJson<bool>(json['isAutoExecute']),
      isPaused: serializer.fromJson<bool>(json['isPaused']),
      lastExecutedDate: serializer.fromJson<DateTime?>(
        json['lastExecutedDate'],
      ),
      nextExecutionDate: serializer.fromJson<DateTime>(
        json['nextExecutionDate'],
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
      'accountId': serializer.toJson<String>(accountId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'merchantId': serializer.toJson<String?>(merchantId),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
      'frequency': serializer.toJson<String>(frequency),
      'dayOfMonth': serializer.toJson<int>(dayOfMonth),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'isAutoExecute': serializer.toJson<bool>(isAutoExecute),
      'isPaused': serializer.toJson<bool>(isPaused),
      'lastExecutedDate': serializer.toJson<DateTime?>(lastExecutedDate),
      'nextExecutionDate': serializer.toJson<DateTime>(nextExecutionDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RecurringRuleEntry copyWith({
    String? id,
    String? accountId,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> merchantId = const Value.absent(),
    String? name,
    double? amount,
    String? frequency,
    int? dayOfMonth,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    bool? isAutoExecute,
    bool? isPaused,
    Value<DateTime?> lastExecutedDate = const Value.absent(),
    DateTime? nextExecutionDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RecurringRuleEntry(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    merchantId: merchantId.present ? merchantId.value : this.merchantId,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    frequency: frequency ?? this.frequency,
    dayOfMonth: dayOfMonth ?? this.dayOfMonth,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    isAutoExecute: isAutoExecute ?? this.isAutoExecute,
    isPaused: isPaused ?? this.isPaused,
    lastExecutedDate: lastExecutedDate.present
        ? lastExecutedDate.value
        : this.lastExecutedDate,
    nextExecutionDate: nextExecutionDate ?? this.nextExecutionDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RecurringRuleEntry copyWithCompanion(RecurringRulesTableCompanion data) {
    return RecurringRuleEntry(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      merchantId: data.merchantId.present
          ? data.merchantId.value
          : this.merchantId,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      dayOfMonth: data.dayOfMonth.present
          ? data.dayOfMonth.value
          : this.dayOfMonth,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      isAutoExecute: data.isAutoExecute.present
          ? data.isAutoExecute.value
          : this.isAutoExecute,
      isPaused: data.isPaused.present ? data.isPaused.value : this.isPaused,
      lastExecutedDate: data.lastExecutedDate.present
          ? data.lastExecutedDate.value
          : this.lastExecutedDate,
      nextExecutionDate: data.nextExecutionDate.present
          ? data.nextExecutionDate.value
          : this.nextExecutionDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringRuleEntry(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('merchantId: $merchantId, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('frequency: $frequency, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isAutoExecute: $isAutoExecute, ')
          ..write('isPaused: $isPaused, ')
          ..write('lastExecutedDate: $lastExecutedDate, ')
          ..write('nextExecutionDate: $nextExecutionDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    categoryId,
    merchantId,
    name,
    amount,
    frequency,
    dayOfMonth,
    startDate,
    endDate,
    isAutoExecute,
    isPaused,
    lastExecutedDate,
    nextExecutionDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringRuleEntry &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.merchantId == this.merchantId &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.frequency == this.frequency &&
          other.dayOfMonth == this.dayOfMonth &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.isAutoExecute == this.isAutoExecute &&
          other.isPaused == this.isPaused &&
          other.lastExecutedDate == this.lastExecutedDate &&
          other.nextExecutionDate == this.nextExecutionDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RecurringRulesTableCompanion extends UpdateCompanion<RecurringRuleEntry> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String?> categoryId;
  final Value<String?> merchantId;
  final Value<String> name;
  final Value<double> amount;
  final Value<String> frequency;
  final Value<int> dayOfMonth;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<bool> isAutoExecute;
  final Value<bool> isPaused;
  final Value<DateTime?> lastExecutedDate;
  final Value<DateTime> nextExecutionDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RecurringRulesTableCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.merchantId = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.frequency = const Value.absent(),
    this.dayOfMonth = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isAutoExecute = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.lastExecutedDate = const Value.absent(),
    this.nextExecutionDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurringRulesTableCompanion.insert({
    required String id,
    required String accountId,
    this.categoryId = const Value.absent(),
    this.merchantId = const Value.absent(),
    required String name,
    required double amount,
    required String frequency,
    required int dayOfMonth,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.isAutoExecute = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.lastExecutedDate = const Value.absent(),
    required DateTime nextExecutionDate,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       name = Value(name),
       amount = Value(amount),
       frequency = Value(frequency),
       dayOfMonth = Value(dayOfMonth),
       startDate = Value(startDate),
       nextExecutionDate = Value(nextExecutionDate);
  static Insertable<RecurringRuleEntry> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? categoryId,
    Expression<String>? merchantId,
    Expression<String>? name,
    Expression<double>? amount,
    Expression<String>? frequency,
    Expression<int>? dayOfMonth,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? isAutoExecute,
    Expression<bool>? isPaused,
    Expression<DateTime>? lastExecutedDate,
    Expression<DateTime>? nextExecutionDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (merchantId != null) 'merchant_id': merchantId,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (frequency != null) 'frequency': frequency,
      if (dayOfMonth != null) 'day_of_month': dayOfMonth,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (isAutoExecute != null) 'is_auto_execute': isAutoExecute,
      if (isPaused != null) 'is_paused': isPaused,
      if (lastExecutedDate != null) 'last_executed_date': lastExecutedDate,
      if (nextExecutionDate != null) 'next_execution_date': nextExecutionDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurringRulesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String?>? categoryId,
    Value<String?>? merchantId,
    Value<String>? name,
    Value<double>? amount,
    Value<String>? frequency,
    Value<int>? dayOfMonth,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<bool>? isAutoExecute,
    Value<bool>? isPaused,
    Value<DateTime?>? lastExecutedDate,
    Value<DateTime>? nextExecutionDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RecurringRulesTableCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      merchantId: merchantId ?? this.merchantId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      frequency: frequency ?? this.frequency,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isAutoExecute: isAutoExecute ?? this.isAutoExecute,
      isPaused: isPaused ?? this.isPaused,
      lastExecutedDate: lastExecutedDate ?? this.lastExecutedDate,
      nextExecutionDate: nextExecutionDate ?? this.nextExecutionDate,
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
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (merchantId.present) {
      map['merchant_id'] = Variable<String>(merchantId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (dayOfMonth.present) {
      map['day_of_month'] = Variable<int>(dayOfMonth.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (isAutoExecute.present) {
      map['is_auto_execute'] = Variable<bool>(isAutoExecute.value);
    }
    if (isPaused.present) {
      map['is_paused'] = Variable<bool>(isPaused.value);
    }
    if (lastExecutedDate.present) {
      map['last_executed_date'] = Variable<DateTime>(lastExecutedDate.value);
    }
    if (nextExecutionDate.present) {
      map['next_execution_date'] = Variable<DateTime>(nextExecutionDate.value);
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
    return (StringBuffer('RecurringRulesTableCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('merchantId: $merchantId, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('frequency: $frequency, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isAutoExecute: $isAutoExecute, ')
          ..write('isPaused: $isPaused, ')
          ..write('lastExecutedDate: $lastExecutedDate, ')
          ..write('nextExecutionDate: $nextExecutionDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransferLinksTableTable extends TransferLinksTable
    with TableInfo<$TransferLinksTableTable, TransferLinkEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransferLinksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTransactionIdMeta =
      const VerificationMeta('sourceTransactionId');
  @override
  late final GeneratedColumn<String> sourceTransactionId =
      GeneratedColumn<String>(
        'source_transaction_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _destinationTransactionIdMeta =
      const VerificationMeta('destinationTransactionId');
  @override
  late final GeneratedColumn<String> destinationTransactionId =
      GeneratedColumn<String>(
        'destination_transaction_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _sourceAccountIdMeta = const VerificationMeta(
    'sourceAccountId',
  );
  @override
  late final GeneratedColumn<String> sourceAccountId = GeneratedColumn<String>(
    'source_account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _destinationAccountIdMeta =
      const VerificationMeta('destinationAccountId');
  @override
  late final GeneratedColumn<String> destinationAccountId =
      GeneratedColumn<String>(
        'destination_account_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES accounts (id) ON DELETE CASCADE',
        ),
      );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exchangeRateMeta = const VerificationMeta(
    'exchangeRate',
  );
  @override
  late final GeneratedColumn<double> exchangeRate = GeneratedColumn<double>(
    'exchange_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceTransactionId,
    destinationTransactionId,
    sourceAccountId,
    destinationAccountId,
    amount,
    exchangeRate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transfer_links';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransferLinkEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_transaction_id')) {
      context.handle(
        _sourceTransactionIdMeta,
        sourceTransactionId.isAcceptableOrUnknown(
          data['source_transaction_id']!,
          _sourceTransactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceTransactionIdMeta);
    }
    if (data.containsKey('destination_transaction_id')) {
      context.handle(
        _destinationTransactionIdMeta,
        destinationTransactionId.isAcceptableOrUnknown(
          data['destination_transaction_id']!,
          _destinationTransactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationTransactionIdMeta);
    }
    if (data.containsKey('source_account_id')) {
      context.handle(
        _sourceAccountIdMeta,
        sourceAccountId.isAcceptableOrUnknown(
          data['source_account_id']!,
          _sourceAccountIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceAccountIdMeta);
    }
    if (data.containsKey('destination_account_id')) {
      context.handle(
        _destinationAccountIdMeta,
        destinationAccountId.isAcceptableOrUnknown(
          data['destination_account_id']!,
          _destinationAccountIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationAccountIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('exchange_rate')) {
      context.handle(
        _exchangeRateMeta,
        exchangeRate.isAcceptableOrUnknown(
          data['exchange_rate']!,
          _exchangeRateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransferLinkEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransferLinkEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_transaction_id'],
      )!,
      destinationTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_transaction_id'],
      )!,
      sourceAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_account_id'],
      )!,
      destinationAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_account_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      exchangeRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exchange_rate'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TransferLinksTableTable createAlias(String alias) {
    return $TransferLinksTableTable(attachedDatabase, alias);
  }
}

class TransferLinkEntry extends DataClass
    implements Insertable<TransferLinkEntry> {
  final String id;
  final String sourceTransactionId;
  final String destinationTransactionId;
  final String sourceAccountId;
  final String destinationAccountId;
  final double amount;
  final double exchangeRate;
  final DateTime createdAt;
  const TransferLinkEntry({
    required this.id,
    required this.sourceTransactionId,
    required this.destinationTransactionId,
    required this.sourceAccountId,
    required this.destinationAccountId,
    required this.amount,
    required this.exchangeRate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_transaction_id'] = Variable<String>(sourceTransactionId);
    map['destination_transaction_id'] = Variable<String>(
      destinationTransactionId,
    );
    map['source_account_id'] = Variable<String>(sourceAccountId);
    map['destination_account_id'] = Variable<String>(destinationAccountId);
    map['amount'] = Variable<double>(amount);
    map['exchange_rate'] = Variable<double>(exchangeRate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransferLinksTableCompanion toCompanion(bool nullToAbsent) {
    return TransferLinksTableCompanion(
      id: Value(id),
      sourceTransactionId: Value(sourceTransactionId),
      destinationTransactionId: Value(destinationTransactionId),
      sourceAccountId: Value(sourceAccountId),
      destinationAccountId: Value(destinationAccountId),
      amount: Value(amount),
      exchangeRate: Value(exchangeRate),
      createdAt: Value(createdAt),
    );
  }

  factory TransferLinkEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransferLinkEntry(
      id: serializer.fromJson<String>(json['id']),
      sourceTransactionId: serializer.fromJson<String>(
        json['sourceTransactionId'],
      ),
      destinationTransactionId: serializer.fromJson<String>(
        json['destinationTransactionId'],
      ),
      sourceAccountId: serializer.fromJson<String>(json['sourceAccountId']),
      destinationAccountId: serializer.fromJson<String>(
        json['destinationAccountId'],
      ),
      amount: serializer.fromJson<double>(json['amount']),
      exchangeRate: serializer.fromJson<double>(json['exchangeRate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceTransactionId': serializer.toJson<String>(sourceTransactionId),
      'destinationTransactionId': serializer.toJson<String>(
        destinationTransactionId,
      ),
      'sourceAccountId': serializer.toJson<String>(sourceAccountId),
      'destinationAccountId': serializer.toJson<String>(destinationAccountId),
      'amount': serializer.toJson<double>(amount),
      'exchangeRate': serializer.toJson<double>(exchangeRate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TransferLinkEntry copyWith({
    String? id,
    String? sourceTransactionId,
    String? destinationTransactionId,
    String? sourceAccountId,
    String? destinationAccountId,
    double? amount,
    double? exchangeRate,
    DateTime? createdAt,
  }) => TransferLinkEntry(
    id: id ?? this.id,
    sourceTransactionId: sourceTransactionId ?? this.sourceTransactionId,
    destinationTransactionId:
        destinationTransactionId ?? this.destinationTransactionId,
    sourceAccountId: sourceAccountId ?? this.sourceAccountId,
    destinationAccountId: destinationAccountId ?? this.destinationAccountId,
    amount: amount ?? this.amount,
    exchangeRate: exchangeRate ?? this.exchangeRate,
    createdAt: createdAt ?? this.createdAt,
  );
  TransferLinkEntry copyWithCompanion(TransferLinksTableCompanion data) {
    return TransferLinkEntry(
      id: data.id.present ? data.id.value : this.id,
      sourceTransactionId: data.sourceTransactionId.present
          ? data.sourceTransactionId.value
          : this.sourceTransactionId,
      destinationTransactionId: data.destinationTransactionId.present
          ? data.destinationTransactionId.value
          : this.destinationTransactionId,
      sourceAccountId: data.sourceAccountId.present
          ? data.sourceAccountId.value
          : this.sourceAccountId,
      destinationAccountId: data.destinationAccountId.present
          ? data.destinationAccountId.value
          : this.destinationAccountId,
      amount: data.amount.present ? data.amount.value : this.amount,
      exchangeRate: data.exchangeRate.present
          ? data.exchangeRate.value
          : this.exchangeRate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransferLinkEntry(')
          ..write('id: $id, ')
          ..write('sourceTransactionId: $sourceTransactionId, ')
          ..write('destinationTransactionId: $destinationTransactionId, ')
          ..write('sourceAccountId: $sourceAccountId, ')
          ..write('destinationAccountId: $destinationAccountId, ')
          ..write('amount: $amount, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceTransactionId,
    destinationTransactionId,
    sourceAccountId,
    destinationAccountId,
    amount,
    exchangeRate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferLinkEntry &&
          other.id == this.id &&
          other.sourceTransactionId == this.sourceTransactionId &&
          other.destinationTransactionId == this.destinationTransactionId &&
          other.sourceAccountId == this.sourceAccountId &&
          other.destinationAccountId == this.destinationAccountId &&
          other.amount == this.amount &&
          other.exchangeRate == this.exchangeRate &&
          other.createdAt == this.createdAt);
}

class TransferLinksTableCompanion extends UpdateCompanion<TransferLinkEntry> {
  final Value<String> id;
  final Value<String> sourceTransactionId;
  final Value<String> destinationTransactionId;
  final Value<String> sourceAccountId;
  final Value<String> destinationAccountId;
  final Value<double> amount;
  final Value<double> exchangeRate;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TransferLinksTableCompanion({
    this.id = const Value.absent(),
    this.sourceTransactionId = const Value.absent(),
    this.destinationTransactionId = const Value.absent(),
    this.sourceAccountId = const Value.absent(),
    this.destinationAccountId = const Value.absent(),
    this.amount = const Value.absent(),
    this.exchangeRate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransferLinksTableCompanion.insert({
    required String id,
    required String sourceTransactionId,
    required String destinationTransactionId,
    required String sourceAccountId,
    required String destinationAccountId,
    required double amount,
    this.exchangeRate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceTransactionId = Value(sourceTransactionId),
       destinationTransactionId = Value(destinationTransactionId),
       sourceAccountId = Value(sourceAccountId),
       destinationAccountId = Value(destinationAccountId),
       amount = Value(amount);
  static Insertable<TransferLinkEntry> custom({
    Expression<String>? id,
    Expression<String>? sourceTransactionId,
    Expression<String>? destinationTransactionId,
    Expression<String>? sourceAccountId,
    Expression<String>? destinationAccountId,
    Expression<double>? amount,
    Expression<double>? exchangeRate,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceTransactionId != null)
        'source_transaction_id': sourceTransactionId,
      if (destinationTransactionId != null)
        'destination_transaction_id': destinationTransactionId,
      if (sourceAccountId != null) 'source_account_id': sourceAccountId,
      if (destinationAccountId != null)
        'destination_account_id': destinationAccountId,
      if (amount != null) 'amount': amount,
      if (exchangeRate != null) 'exchange_rate': exchangeRate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransferLinksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceTransactionId,
    Value<String>? destinationTransactionId,
    Value<String>? sourceAccountId,
    Value<String>? destinationAccountId,
    Value<double>? amount,
    Value<double>? exchangeRate,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TransferLinksTableCompanion(
      id: id ?? this.id,
      sourceTransactionId: sourceTransactionId ?? this.sourceTransactionId,
      destinationTransactionId:
          destinationTransactionId ?? this.destinationTransactionId,
      sourceAccountId: sourceAccountId ?? this.sourceAccountId,
      destinationAccountId: destinationAccountId ?? this.destinationAccountId,
      amount: amount ?? this.amount,
      exchangeRate: exchangeRate ?? this.exchangeRate,
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
    if (sourceTransactionId.present) {
      map['source_transaction_id'] = Variable<String>(
        sourceTransactionId.value,
      );
    }
    if (destinationTransactionId.present) {
      map['destination_transaction_id'] = Variable<String>(
        destinationTransactionId.value,
      );
    }
    if (sourceAccountId.present) {
      map['source_account_id'] = Variable<String>(sourceAccountId.value);
    }
    if (destinationAccountId.present) {
      map['destination_account_id'] = Variable<String>(
        destinationAccountId.value,
      );
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (exchangeRate.present) {
      map['exchange_rate'] = Variable<double>(exchangeRate.value);
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
    return (StringBuffer('TransferLinksTableCompanion(')
          ..write('id: $id, ')
          ..write('sourceTransactionId: $sourceTransactionId, ')
          ..write('destinationTransactionId: $destinationTransactionId, ')
          ..write('sourceAccountId: $sourceAccountId, ')
          ..write('destinationAccountId: $destinationAccountId, ')
          ..write('amount: $amount, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTableTable extends BudgetsTable
    with TableInfo<$BudgetsTableTable, BudgetEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isRolloverEnabledMeta = const VerificationMeta(
    'isRolloverEnabled',
  );
  @override
  late final GeneratedColumn<bool> isRolloverEnabled = GeneratedColumn<bool>(
    'is_rollover_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_rollover_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _maxRolloverAmountMeta = const VerificationMeta(
    'maxRolloverAmount',
  );
  @override
  late final GeneratedColumn<double> maxRolloverAmount =
      GeneratedColumn<double>(
        'max_rollover_amount',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isDynamicMeta = const VerificationMeta(
    'isDynamic',
  );
  @override
  late final GeneratedColumn<bool> isDynamic = GeneratedColumn<bool>(
    'is_dynamic',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dynamic" IN (0, 1))',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    amount,
    isRolloverEnabled,
    maxRolloverAmount,
    isDynamic,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('is_rollover_enabled')) {
      context.handle(
        _isRolloverEnabledMeta,
        isRolloverEnabled.isAcceptableOrUnknown(
          data['is_rollover_enabled']!,
          _isRolloverEnabledMeta,
        ),
      );
    }
    if (data.containsKey('max_rollover_amount')) {
      context.handle(
        _maxRolloverAmountMeta,
        maxRolloverAmount.isAcceptableOrUnknown(
          data['max_rollover_amount']!,
          _maxRolloverAmountMeta,
        ),
      );
    }
    if (data.containsKey('is_dynamic')) {
      context.handle(
        _isDynamicMeta,
        isDynamic.isAcceptableOrUnknown(data['is_dynamic']!, _isDynamicMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      isRolloverEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_rollover_enabled'],
      )!,
      maxRolloverAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_rollover_amount'],
      ),
      isDynamic: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dynamic'],
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
  $BudgetsTableTable createAlias(String alias) {
    return $BudgetsTableTable(attachedDatabase, alias);
  }
}

class BudgetEntry extends DataClass implements Insertable<BudgetEntry> {
  final String id;
  final String categoryId;
  final double amount;
  final bool isRolloverEnabled;
  final double? maxRolloverAmount;
  final bool isDynamic;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BudgetEntry({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.isRolloverEnabled,
    this.maxRolloverAmount,
    required this.isDynamic,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['amount'] = Variable<double>(amount);
    map['is_rollover_enabled'] = Variable<bool>(isRolloverEnabled);
    if (!nullToAbsent || maxRolloverAmount != null) {
      map['max_rollover_amount'] = Variable<double>(maxRolloverAmount);
    }
    map['is_dynamic'] = Variable<bool>(isDynamic);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BudgetsTableCompanion toCompanion(bool nullToAbsent) {
    return BudgetsTableCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      amount: Value(amount),
      isRolloverEnabled: Value(isRolloverEnabled),
      maxRolloverAmount: maxRolloverAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(maxRolloverAmount),
      isDynamic: Value(isDynamic),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BudgetEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetEntry(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      amount: serializer.fromJson<double>(json['amount']),
      isRolloverEnabled: serializer.fromJson<bool>(json['isRolloverEnabled']),
      maxRolloverAmount: serializer.fromJson<double?>(
        json['maxRolloverAmount'],
      ),
      isDynamic: serializer.fromJson<bool>(json['isDynamic']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'amount': serializer.toJson<double>(amount),
      'isRolloverEnabled': serializer.toJson<bool>(isRolloverEnabled),
      'maxRolloverAmount': serializer.toJson<double?>(maxRolloverAmount),
      'isDynamic': serializer.toJson<bool>(isDynamic),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BudgetEntry copyWith({
    String? id,
    String? categoryId,
    double? amount,
    bool? isRolloverEnabled,
    Value<double?> maxRolloverAmount = const Value.absent(),
    bool? isDynamic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BudgetEntry(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    amount: amount ?? this.amount,
    isRolloverEnabled: isRolloverEnabled ?? this.isRolloverEnabled,
    maxRolloverAmount: maxRolloverAmount.present
        ? maxRolloverAmount.value
        : this.maxRolloverAmount,
    isDynamic: isDynamic ?? this.isDynamic,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BudgetEntry copyWithCompanion(BudgetsTableCompanion data) {
    return BudgetEntry(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      isRolloverEnabled: data.isRolloverEnabled.present
          ? data.isRolloverEnabled.value
          : this.isRolloverEnabled,
      maxRolloverAmount: data.maxRolloverAmount.present
          ? data.maxRolloverAmount.value
          : this.maxRolloverAmount,
      isDynamic: data.isDynamic.present ? data.isDynamic.value : this.isDynamic,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetEntry(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('isRolloverEnabled: $isRolloverEnabled, ')
          ..write('maxRolloverAmount: $maxRolloverAmount, ')
          ..write('isDynamic: $isDynamic, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    amount,
    isRolloverEnabled,
    maxRolloverAmount,
    isDynamic,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetEntry &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount &&
          other.isRolloverEnabled == this.isRolloverEnabled &&
          other.maxRolloverAmount == this.maxRolloverAmount &&
          other.isDynamic == this.isDynamic &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BudgetsTableCompanion extends UpdateCompanion<BudgetEntry> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<double> amount;
  final Value<bool> isRolloverEnabled;
  final Value<double?> maxRolloverAmount;
  final Value<bool> isDynamic;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BudgetsTableCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.isRolloverEnabled = const Value.absent(),
    this.maxRolloverAmount = const Value.absent(),
    this.isDynamic = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetsTableCompanion.insert({
    required String id,
    required String categoryId,
    required double amount,
    this.isRolloverEnabled = const Value.absent(),
    this.maxRolloverAmount = const Value.absent(),
    this.isDynamic = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoryId = Value(categoryId),
       amount = Value(amount);
  static Insertable<BudgetEntry> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<double>? amount,
    Expression<bool>? isRolloverEnabled,
    Expression<double>? maxRolloverAmount,
    Expression<bool>? isDynamic,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (isRolloverEnabled != null) 'is_rollover_enabled': isRolloverEnabled,
      if (maxRolloverAmount != null) 'max_rollover_amount': maxRolloverAmount,
      if (isDynamic != null) 'is_dynamic': isDynamic,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? categoryId,
    Value<double>? amount,
    Value<bool>? isRolloverEnabled,
    Value<double?>? maxRolloverAmount,
    Value<bool>? isDynamic,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BudgetsTableCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      isRolloverEnabled: isRolloverEnabled ?? this.isRolloverEnabled,
      maxRolloverAmount: maxRolloverAmount ?? this.maxRolloverAmount,
      isDynamic: isDynamic ?? this.isDynamic,
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
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (isRolloverEnabled.present) {
      map['is_rollover_enabled'] = Variable<bool>(isRolloverEnabled.value);
    }
    if (maxRolloverAmount.present) {
      map['max_rollover_amount'] = Variable<double>(maxRolloverAmount.value);
    }
    if (isDynamic.present) {
      map['is_dynamic'] = Variable<bool>(isDynamic.value);
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
    return (StringBuffer('BudgetsTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('isRolloverEnabled: $isRolloverEnabled, ')
          ..write('maxRolloverAmount: $maxRolloverAmount, ')
          ..write('isDynamic: $isDynamic, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetPeriodsTableTable extends BudgetPeriodsTable
    with TableInfo<$BudgetPeriodsTableTable, BudgetPeriodEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetPeriodsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _budgetIdMeta = const VerificationMeta(
    'budgetId',
  );
  @override
  late final GeneratedColumn<String> budgetId = GeneratedColumn<String>(
    'budget_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES budgets (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _monthYearMeta = const VerificationMeta(
    'monthYear',
  );
  @override
  late final GeneratedColumn<String> monthYear = GeneratedColumn<String>(
    'month_year',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allocatedAmountMeta = const VerificationMeta(
    'allocatedAmount',
  );
  @override
  late final GeneratedColumn<double> allocatedAmount = GeneratedColumn<double>(
    'allocated_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rolloverAmountMeta = const VerificationMeta(
    'rolloverAmount',
  );
  @override
  late final GeneratedColumn<double> rolloverAmount = GeneratedColumn<double>(
    'rollover_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _actualSpentMeta = const VerificationMeta(
    'actualSpent',
  );
  @override
  late final GeneratedColumn<double> actualSpent = GeneratedColumn<double>(
    'actual_spent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    budgetId,
    monthYear,
    allocatedAmount,
    rolloverAmount,
    actualSpent,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_periods';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetPeriodEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('budget_id')) {
      context.handle(
        _budgetIdMeta,
        budgetId.isAcceptableOrUnknown(data['budget_id']!, _budgetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_budgetIdMeta);
    }
    if (data.containsKey('month_year')) {
      context.handle(
        _monthYearMeta,
        monthYear.isAcceptableOrUnknown(data['month_year']!, _monthYearMeta),
      );
    } else if (isInserting) {
      context.missing(_monthYearMeta);
    }
    if (data.containsKey('allocated_amount')) {
      context.handle(
        _allocatedAmountMeta,
        allocatedAmount.isAcceptableOrUnknown(
          data['allocated_amount']!,
          _allocatedAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_allocatedAmountMeta);
    }
    if (data.containsKey('rollover_amount')) {
      context.handle(
        _rolloverAmountMeta,
        rolloverAmount.isAcceptableOrUnknown(
          data['rollover_amount']!,
          _rolloverAmountMeta,
        ),
      );
    }
    if (data.containsKey('actual_spent')) {
      context.handle(
        _actualSpentMeta,
        actualSpent.isAcceptableOrUnknown(
          data['actual_spent']!,
          _actualSpentMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetPeriodEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetPeriodEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      budgetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}budget_id'],
      )!,
      monthYear: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_year'],
      )!,
      allocatedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}allocated_amount'],
      )!,
      rolloverAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rollover_amount'],
      )!,
      actualSpent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}actual_spent'],
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
  $BudgetPeriodsTableTable createAlias(String alias) {
    return $BudgetPeriodsTableTable(attachedDatabase, alias);
  }
}

class BudgetPeriodEntry extends DataClass
    implements Insertable<BudgetPeriodEntry> {
  final String id;
  final String budgetId;
  final String monthYear;
  final double allocatedAmount;
  final double rolloverAmount;
  final double actualSpent;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BudgetPeriodEntry({
    required this.id,
    required this.budgetId,
    required this.monthYear,
    required this.allocatedAmount,
    required this.rolloverAmount,
    required this.actualSpent,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['budget_id'] = Variable<String>(budgetId);
    map['month_year'] = Variable<String>(monthYear);
    map['allocated_amount'] = Variable<double>(allocatedAmount);
    map['rollover_amount'] = Variable<double>(rolloverAmount);
    map['actual_spent'] = Variable<double>(actualSpent);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BudgetPeriodsTableCompanion toCompanion(bool nullToAbsent) {
    return BudgetPeriodsTableCompanion(
      id: Value(id),
      budgetId: Value(budgetId),
      monthYear: Value(monthYear),
      allocatedAmount: Value(allocatedAmount),
      rolloverAmount: Value(rolloverAmount),
      actualSpent: Value(actualSpent),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BudgetPeriodEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetPeriodEntry(
      id: serializer.fromJson<String>(json['id']),
      budgetId: serializer.fromJson<String>(json['budgetId']),
      monthYear: serializer.fromJson<String>(json['monthYear']),
      allocatedAmount: serializer.fromJson<double>(json['allocatedAmount']),
      rolloverAmount: serializer.fromJson<double>(json['rolloverAmount']),
      actualSpent: serializer.fromJson<double>(json['actualSpent']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'budgetId': serializer.toJson<String>(budgetId),
      'monthYear': serializer.toJson<String>(monthYear),
      'allocatedAmount': serializer.toJson<double>(allocatedAmount),
      'rolloverAmount': serializer.toJson<double>(rolloverAmount),
      'actualSpent': serializer.toJson<double>(actualSpent),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BudgetPeriodEntry copyWith({
    String? id,
    String? budgetId,
    String? monthYear,
    double? allocatedAmount,
    double? rolloverAmount,
    double? actualSpent,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BudgetPeriodEntry(
    id: id ?? this.id,
    budgetId: budgetId ?? this.budgetId,
    monthYear: monthYear ?? this.monthYear,
    allocatedAmount: allocatedAmount ?? this.allocatedAmount,
    rolloverAmount: rolloverAmount ?? this.rolloverAmount,
    actualSpent: actualSpent ?? this.actualSpent,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BudgetPeriodEntry copyWithCompanion(BudgetPeriodsTableCompanion data) {
    return BudgetPeriodEntry(
      id: data.id.present ? data.id.value : this.id,
      budgetId: data.budgetId.present ? data.budgetId.value : this.budgetId,
      monthYear: data.monthYear.present ? data.monthYear.value : this.monthYear,
      allocatedAmount: data.allocatedAmount.present
          ? data.allocatedAmount.value
          : this.allocatedAmount,
      rolloverAmount: data.rolloverAmount.present
          ? data.rolloverAmount.value
          : this.rolloverAmount,
      actualSpent: data.actualSpent.present
          ? data.actualSpent.value
          : this.actualSpent,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetPeriodEntry(')
          ..write('id: $id, ')
          ..write('budgetId: $budgetId, ')
          ..write('monthYear: $monthYear, ')
          ..write('allocatedAmount: $allocatedAmount, ')
          ..write('rolloverAmount: $rolloverAmount, ')
          ..write('actualSpent: $actualSpent, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    budgetId,
    monthYear,
    allocatedAmount,
    rolloverAmount,
    actualSpent,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetPeriodEntry &&
          other.id == this.id &&
          other.budgetId == this.budgetId &&
          other.monthYear == this.monthYear &&
          other.allocatedAmount == this.allocatedAmount &&
          other.rolloverAmount == this.rolloverAmount &&
          other.actualSpent == this.actualSpent &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BudgetPeriodsTableCompanion extends UpdateCompanion<BudgetPeriodEntry> {
  final Value<String> id;
  final Value<String> budgetId;
  final Value<String> monthYear;
  final Value<double> allocatedAmount;
  final Value<double> rolloverAmount;
  final Value<double> actualSpent;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BudgetPeriodsTableCompanion({
    this.id = const Value.absent(),
    this.budgetId = const Value.absent(),
    this.monthYear = const Value.absent(),
    this.allocatedAmount = const Value.absent(),
    this.rolloverAmount = const Value.absent(),
    this.actualSpent = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetPeriodsTableCompanion.insert({
    required String id,
    required String budgetId,
    required String monthYear,
    required double allocatedAmount,
    this.rolloverAmount = const Value.absent(),
    this.actualSpent = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       budgetId = Value(budgetId),
       monthYear = Value(monthYear),
       allocatedAmount = Value(allocatedAmount);
  static Insertable<BudgetPeriodEntry> custom({
    Expression<String>? id,
    Expression<String>? budgetId,
    Expression<String>? monthYear,
    Expression<double>? allocatedAmount,
    Expression<double>? rolloverAmount,
    Expression<double>? actualSpent,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (budgetId != null) 'budget_id': budgetId,
      if (monthYear != null) 'month_year': monthYear,
      if (allocatedAmount != null) 'allocated_amount': allocatedAmount,
      if (rolloverAmount != null) 'rollover_amount': rolloverAmount,
      if (actualSpent != null) 'actual_spent': actualSpent,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetPeriodsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? budgetId,
    Value<String>? monthYear,
    Value<double>? allocatedAmount,
    Value<double>? rolloverAmount,
    Value<double>? actualSpent,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BudgetPeriodsTableCompanion(
      id: id ?? this.id,
      budgetId: budgetId ?? this.budgetId,
      monthYear: monthYear ?? this.monthYear,
      allocatedAmount: allocatedAmount ?? this.allocatedAmount,
      rolloverAmount: rolloverAmount ?? this.rolloverAmount,
      actualSpent: actualSpent ?? this.actualSpent,
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
    if (budgetId.present) {
      map['budget_id'] = Variable<String>(budgetId.value);
    }
    if (monthYear.present) {
      map['month_year'] = Variable<String>(monthYear.value);
    }
    if (allocatedAmount.present) {
      map['allocated_amount'] = Variable<double>(allocatedAmount.value);
    }
    if (rolloverAmount.present) {
      map['rollover_amount'] = Variable<double>(rolloverAmount.value);
    }
    if (actualSpent.present) {
      map['actual_spent'] = Variable<double>(actualSpent.value);
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
    return (StringBuffer('BudgetPeriodsTableCompanion(')
          ..write('id: $id, ')
          ..write('budgetId: $budgetId, ')
          ..write('monthYear: $monthYear, ')
          ..write('allocatedAmount: $allocatedAmount, ')
          ..write('rolloverAmount: $rolloverAmount, ')
          ..write('actualSpent: $actualSpent, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ImportBatchesTableTable extends ImportBatchesTable
    with TableInfo<$ImportBatchesTableTable, ImportBatchEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImportBatchesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceNameMeta = const VerificationMeta(
    'sourceName',
  );
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
    'source_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _totalRowsMeta = const VerificationMeta(
    'totalRows',
  );
  @override
  late final GeneratedColumn<int> totalRows = GeneratedColumn<int>(
    'total_rows',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _importedRowsMeta = const VerificationMeta(
    'importedRows',
  );
  @override
  late final GeneratedColumn<int> importedRows = GeneratedColumn<int>(
    'imported_rows',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _duplicatesSkippedMeta = const VerificationMeta(
    'duplicatesSkipped',
  );
  @override
  late final GeneratedColumn<int> duplicatesSkipped = GeneratedColumn<int>(
    'duplicates_skipped',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('completed'),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceName,
    fileName,
    importedAt,
    totalRows,
    importedRows,
    duplicatesSkipped,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'import_batches';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImportBatchEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_name')) {
      context.handle(
        _sourceNameMeta,
        sourceName.isAcceptableOrUnknown(data['source_name']!, _sourceNameMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceNameMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    }
    if (data.containsKey('total_rows')) {
      context.handle(
        _totalRowsMeta,
        totalRows.isAcceptableOrUnknown(data['total_rows']!, _totalRowsMeta),
      );
    }
    if (data.containsKey('imported_rows')) {
      context.handle(
        _importedRowsMeta,
        importedRows.isAcceptableOrUnknown(
          data['imported_rows']!,
          _importedRowsMeta,
        ),
      );
    }
    if (data.containsKey('duplicates_skipped')) {
      context.handle(
        _duplicatesSkippedMeta,
        duplicatesSkipped.isAcceptableOrUnknown(
          data['duplicates_skipped']!,
          _duplicatesSkippedMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImportBatchEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImportBatchEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_name'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}imported_at'],
      )!,
      totalRows: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_rows'],
      )!,
      importedRows: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}imported_rows'],
      )!,
      duplicatesSkipped: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duplicates_skipped'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ImportBatchesTableTable createAlias(String alias) {
    return $ImportBatchesTableTable(attachedDatabase, alias);
  }
}

class ImportBatchEntry extends DataClass
    implements Insertable<ImportBatchEntry> {
  final String id;
  final String sourceName;
  final String fileName;
  final DateTime importedAt;
  final int totalRows;
  final int importedRows;
  final int duplicatesSkipped;
  final String status;
  final DateTime createdAt;
  const ImportBatchEntry({
    required this.id,
    required this.sourceName,
    required this.fileName,
    required this.importedAt,
    required this.totalRows,
    required this.importedRows,
    required this.duplicatesSkipped,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_name'] = Variable<String>(sourceName);
    map['file_name'] = Variable<String>(fileName);
    map['imported_at'] = Variable<DateTime>(importedAt);
    map['total_rows'] = Variable<int>(totalRows);
    map['imported_rows'] = Variable<int>(importedRows);
    map['duplicates_skipped'] = Variable<int>(duplicatesSkipped);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ImportBatchesTableCompanion toCompanion(bool nullToAbsent) {
    return ImportBatchesTableCompanion(
      id: Value(id),
      sourceName: Value(sourceName),
      fileName: Value(fileName),
      importedAt: Value(importedAt),
      totalRows: Value(totalRows),
      importedRows: Value(importedRows),
      duplicatesSkipped: Value(duplicatesSkipped),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory ImportBatchEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImportBatchEntry(
      id: serializer.fromJson<String>(json['id']),
      sourceName: serializer.fromJson<String>(json['sourceName']),
      fileName: serializer.fromJson<String>(json['fileName']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
      totalRows: serializer.fromJson<int>(json['totalRows']),
      importedRows: serializer.fromJson<int>(json['importedRows']),
      duplicatesSkipped: serializer.fromJson<int>(json['duplicatesSkipped']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceName': serializer.toJson<String>(sourceName),
      'fileName': serializer.toJson<String>(fileName),
      'importedAt': serializer.toJson<DateTime>(importedAt),
      'totalRows': serializer.toJson<int>(totalRows),
      'importedRows': serializer.toJson<int>(importedRows),
      'duplicatesSkipped': serializer.toJson<int>(duplicatesSkipped),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ImportBatchEntry copyWith({
    String? id,
    String? sourceName,
    String? fileName,
    DateTime? importedAt,
    int? totalRows,
    int? importedRows,
    int? duplicatesSkipped,
    String? status,
    DateTime? createdAt,
  }) => ImportBatchEntry(
    id: id ?? this.id,
    sourceName: sourceName ?? this.sourceName,
    fileName: fileName ?? this.fileName,
    importedAt: importedAt ?? this.importedAt,
    totalRows: totalRows ?? this.totalRows,
    importedRows: importedRows ?? this.importedRows,
    duplicatesSkipped: duplicatesSkipped ?? this.duplicatesSkipped,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  ImportBatchEntry copyWithCompanion(ImportBatchesTableCompanion data) {
    return ImportBatchEntry(
      id: data.id.present ? data.id.value : this.id,
      sourceName: data.sourceName.present
          ? data.sourceName.value
          : this.sourceName,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
      totalRows: data.totalRows.present ? data.totalRows.value : this.totalRows,
      importedRows: data.importedRows.present
          ? data.importedRows.value
          : this.importedRows,
      duplicatesSkipped: data.duplicatesSkipped.present
          ? data.duplicatesSkipped.value
          : this.duplicatesSkipped,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImportBatchEntry(')
          ..write('id: $id, ')
          ..write('sourceName: $sourceName, ')
          ..write('fileName: $fileName, ')
          ..write('importedAt: $importedAt, ')
          ..write('totalRows: $totalRows, ')
          ..write('importedRows: $importedRows, ')
          ..write('duplicatesSkipped: $duplicatesSkipped, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceName,
    fileName,
    importedAt,
    totalRows,
    importedRows,
    duplicatesSkipped,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImportBatchEntry &&
          other.id == this.id &&
          other.sourceName == this.sourceName &&
          other.fileName == this.fileName &&
          other.importedAt == this.importedAt &&
          other.totalRows == this.totalRows &&
          other.importedRows == this.importedRows &&
          other.duplicatesSkipped == this.duplicatesSkipped &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class ImportBatchesTableCompanion extends UpdateCompanion<ImportBatchEntry> {
  final Value<String> id;
  final Value<String> sourceName;
  final Value<String> fileName;
  final Value<DateTime> importedAt;
  final Value<int> totalRows;
  final Value<int> importedRows;
  final Value<int> duplicatesSkipped;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ImportBatchesTableCompanion({
    this.id = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.fileName = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.totalRows = const Value.absent(),
    this.importedRows = const Value.absent(),
    this.duplicatesSkipped = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImportBatchesTableCompanion.insert({
    required String id,
    required String sourceName,
    required String fileName,
    this.importedAt = const Value.absent(),
    this.totalRows = const Value.absent(),
    this.importedRows = const Value.absent(),
    this.duplicatesSkipped = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceName = Value(sourceName),
       fileName = Value(fileName);
  static Insertable<ImportBatchEntry> custom({
    Expression<String>? id,
    Expression<String>? sourceName,
    Expression<String>? fileName,
    Expression<DateTime>? importedAt,
    Expression<int>? totalRows,
    Expression<int>? importedRows,
    Expression<int>? duplicatesSkipped,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceName != null) 'source_name': sourceName,
      if (fileName != null) 'file_name': fileName,
      if (importedAt != null) 'imported_at': importedAt,
      if (totalRows != null) 'total_rows': totalRows,
      if (importedRows != null) 'imported_rows': importedRows,
      if (duplicatesSkipped != null) 'duplicates_skipped': duplicatesSkipped,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImportBatchesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceName,
    Value<String>? fileName,
    Value<DateTime>? importedAt,
    Value<int>? totalRows,
    Value<int>? importedRows,
    Value<int>? duplicatesSkipped,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ImportBatchesTableCompanion(
      id: id ?? this.id,
      sourceName: sourceName ?? this.sourceName,
      fileName: fileName ?? this.fileName,
      importedAt: importedAt ?? this.importedAt,
      totalRows: totalRows ?? this.totalRows,
      importedRows: importedRows ?? this.importedRows,
      duplicatesSkipped: duplicatesSkipped ?? this.duplicatesSkipped,
      status: status ?? this.status,
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
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (totalRows.present) {
      map['total_rows'] = Variable<int>(totalRows.value);
    }
    if (importedRows.present) {
      map['imported_rows'] = Variable<int>(importedRows.value);
    }
    if (duplicatesSkipped.present) {
      map['duplicates_skipped'] = Variable<int>(duplicatesSkipped.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
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
    return (StringBuffer('ImportBatchesTableCompanion(')
          ..write('id: $id, ')
          ..write('sourceName: $sourceName, ')
          ..write('fileName: $fileName, ')
          ..write('importedAt: $importedAt, ')
          ..write('totalRows: $totalRows, ')
          ..write('importedRows: $importedRows, ')
          ..write('duplicatesSkipped: $duplicatesSkipped, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ImportMappingsTableTable extends ImportMappingsTable
    with TableInfo<$ImportMappingsTableTable, ImportMappingEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImportMappingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceNameMeta = const VerificationMeta(
    'sourceName',
  );
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
    'source_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mappingConfigJsonMeta = const VerificationMeta(
    'mappingConfigJson',
  );
  @override
  late final GeneratedColumn<String> mappingConfigJson =
      GeneratedColumn<String>(
        'mapping_config_json',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceName,
    mappingConfigJson,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'import_mappings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImportMappingEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_name')) {
      context.handle(
        _sourceNameMeta,
        sourceName.isAcceptableOrUnknown(data['source_name']!, _sourceNameMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceNameMeta);
    }
    if (data.containsKey('mapping_config_json')) {
      context.handle(
        _mappingConfigJsonMeta,
        mappingConfigJson.isAcceptableOrUnknown(
          data['mapping_config_json']!,
          _mappingConfigJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mappingConfigJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImportMappingEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImportMappingEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_name'],
      )!,
      mappingConfigJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mapping_config_json'],
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
  $ImportMappingsTableTable createAlias(String alias) {
    return $ImportMappingsTableTable(attachedDatabase, alias);
  }
}

class ImportMappingEntry extends DataClass
    implements Insertable<ImportMappingEntry> {
  final String id;
  final String sourceName;
  final String mappingConfigJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ImportMappingEntry({
    required this.id,
    required this.sourceName,
    required this.mappingConfigJson,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_name'] = Variable<String>(sourceName);
    map['mapping_config_json'] = Variable<String>(mappingConfigJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ImportMappingsTableCompanion toCompanion(bool nullToAbsent) {
    return ImportMappingsTableCompanion(
      id: Value(id),
      sourceName: Value(sourceName),
      mappingConfigJson: Value(mappingConfigJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ImportMappingEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImportMappingEntry(
      id: serializer.fromJson<String>(json['id']),
      sourceName: serializer.fromJson<String>(json['sourceName']),
      mappingConfigJson: serializer.fromJson<String>(json['mappingConfigJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceName': serializer.toJson<String>(sourceName),
      'mappingConfigJson': serializer.toJson<String>(mappingConfigJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ImportMappingEntry copyWith({
    String? id,
    String? sourceName,
    String? mappingConfigJson,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ImportMappingEntry(
    id: id ?? this.id,
    sourceName: sourceName ?? this.sourceName,
    mappingConfigJson: mappingConfigJson ?? this.mappingConfigJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ImportMappingEntry copyWithCompanion(ImportMappingsTableCompanion data) {
    return ImportMappingEntry(
      id: data.id.present ? data.id.value : this.id,
      sourceName: data.sourceName.present
          ? data.sourceName.value
          : this.sourceName,
      mappingConfigJson: data.mappingConfigJson.present
          ? data.mappingConfigJson.value
          : this.mappingConfigJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImportMappingEntry(')
          ..write('id: $id, ')
          ..write('sourceName: $sourceName, ')
          ..write('mappingConfigJson: $mappingConfigJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sourceName, mappingConfigJson, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImportMappingEntry &&
          other.id == this.id &&
          other.sourceName == this.sourceName &&
          other.mappingConfigJson == this.mappingConfigJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ImportMappingsTableCompanion extends UpdateCompanion<ImportMappingEntry> {
  final Value<String> id;
  final Value<String> sourceName;
  final Value<String> mappingConfigJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ImportMappingsTableCompanion({
    this.id = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.mappingConfigJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImportMappingsTableCompanion.insert({
    required String id,
    required String sourceName,
    required String mappingConfigJson,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceName = Value(sourceName),
       mappingConfigJson = Value(mappingConfigJson);
  static Insertable<ImportMappingEntry> custom({
    Expression<String>? id,
    Expression<String>? sourceName,
    Expression<String>? mappingConfigJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceName != null) 'source_name': sourceName,
      if (mappingConfigJson != null) 'mapping_config_json': mappingConfigJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImportMappingsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceName,
    Value<String>? mappingConfigJson,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ImportMappingsTableCompanion(
      id: id ?? this.id,
      sourceName: sourceName ?? this.sourceName,
      mappingConfigJson: mappingConfigJson ?? this.mappingConfigJson,
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
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (mappingConfigJson.present) {
      map['mapping_config_json'] = Variable<String>(mappingConfigJson.value);
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
    return (StringBuffer('ImportMappingsTableCompanion(')
          ..write('id: $id, ')
          ..write('sourceName: $sourceName, ')
          ..write('mappingConfigJson: $mappingConfigJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SecuritiesTableTable extends SecuritiesTable
    with TableInfo<$SecuritiesTableTable, SecurityEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SecuritiesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tickerMeta = const VerificationMeta('ticker');
  @override
  late final GeneratedColumn<String> ticker = GeneratedColumn<String>(
    'ticker',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _securityTypeMeta = const VerificationMeta(
    'securityType',
  );
  @override
  late final GeneratedColumn<String> securityType = GeneratedColumn<String>(
    'security_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exchangeMeta = const VerificationMeta(
    'exchange',
  );
  @override
  late final GeneratedColumn<String> exchange = GeneratedColumn<String>(
    'exchange',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _currentPriceMeta = const VerificationMeta(
    'currentPrice',
  );
  @override
  late final GeneratedColumn<double> currentPrice = GeneratedColumn<double>(
    'current_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _lastPriceUpdateMeta = const VerificationMeta(
    'lastPriceUpdate',
  );
  @override
  late final GeneratedColumn<DateTime> lastPriceUpdate =
      GeneratedColumn<DateTime>(
        'last_price_update',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isBenchmarkMeta = const VerificationMeta(
    'isBenchmark',
  );
  @override
  late final GeneratedColumn<bool> isBenchmark = GeneratedColumn<bool>(
    'is_benchmark',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_benchmark" IN (0, 1))',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ticker,
    name,
    securityType,
    exchange,
    currency,
    currentPrice,
    lastPriceUpdate,
    isBenchmark,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'securities';
  @override
  VerificationContext validateIntegrity(
    Insertable<SecurityEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ticker')) {
      context.handle(
        _tickerMeta,
        ticker.isAcceptableOrUnknown(data['ticker']!, _tickerMeta),
      );
    } else if (isInserting) {
      context.missing(_tickerMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('security_type')) {
      context.handle(
        _securityTypeMeta,
        securityType.isAcceptableOrUnknown(
          data['security_type']!,
          _securityTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_securityTypeMeta);
    }
    if (data.containsKey('exchange')) {
      context.handle(
        _exchangeMeta,
        exchange.isAcceptableOrUnknown(data['exchange']!, _exchangeMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('current_price')) {
      context.handle(
        _currentPriceMeta,
        currentPrice.isAcceptableOrUnknown(
          data['current_price']!,
          _currentPriceMeta,
        ),
      );
    }
    if (data.containsKey('last_price_update')) {
      context.handle(
        _lastPriceUpdateMeta,
        lastPriceUpdate.isAcceptableOrUnknown(
          data['last_price_update']!,
          _lastPriceUpdateMeta,
        ),
      );
    }
    if (data.containsKey('is_benchmark')) {
      context.handle(
        _isBenchmarkMeta,
        isBenchmark.isAcceptableOrUnknown(
          data['is_benchmark']!,
          _isBenchmarkMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SecurityEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SecurityEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ticker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ticker'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      securityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}security_type'],
      )!,
      exchange: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exchange'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      currentPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_price'],
      )!,
      lastPriceUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_price_update'],
      ),
      isBenchmark: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_benchmark'],
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
  $SecuritiesTableTable createAlias(String alias) {
    return $SecuritiesTableTable(attachedDatabase, alias);
  }
}

class SecurityEntry extends DataClass implements Insertable<SecurityEntry> {
  final String id;
  final String ticker;
  final String name;
  final String securityType;
  final String? exchange;
  final String currency;
  final double currentPrice;
  final DateTime? lastPriceUpdate;
  final bool isBenchmark;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SecurityEntry({
    required this.id,
    required this.ticker,
    required this.name,
    required this.securityType,
    this.exchange,
    required this.currency,
    required this.currentPrice,
    this.lastPriceUpdate,
    required this.isBenchmark,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ticker'] = Variable<String>(ticker);
    map['name'] = Variable<String>(name);
    map['security_type'] = Variable<String>(securityType);
    if (!nullToAbsent || exchange != null) {
      map['exchange'] = Variable<String>(exchange);
    }
    map['currency'] = Variable<String>(currency);
    map['current_price'] = Variable<double>(currentPrice);
    if (!nullToAbsent || lastPriceUpdate != null) {
      map['last_price_update'] = Variable<DateTime>(lastPriceUpdate);
    }
    map['is_benchmark'] = Variable<bool>(isBenchmark);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SecuritiesTableCompanion toCompanion(bool nullToAbsent) {
    return SecuritiesTableCompanion(
      id: Value(id),
      ticker: Value(ticker),
      name: Value(name),
      securityType: Value(securityType),
      exchange: exchange == null && nullToAbsent
          ? const Value.absent()
          : Value(exchange),
      currency: Value(currency),
      currentPrice: Value(currentPrice),
      lastPriceUpdate: lastPriceUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPriceUpdate),
      isBenchmark: Value(isBenchmark),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SecurityEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SecurityEntry(
      id: serializer.fromJson<String>(json['id']),
      ticker: serializer.fromJson<String>(json['ticker']),
      name: serializer.fromJson<String>(json['name']),
      securityType: serializer.fromJson<String>(json['securityType']),
      exchange: serializer.fromJson<String?>(json['exchange']),
      currency: serializer.fromJson<String>(json['currency']),
      currentPrice: serializer.fromJson<double>(json['currentPrice']),
      lastPriceUpdate: serializer.fromJson<DateTime?>(json['lastPriceUpdate']),
      isBenchmark: serializer.fromJson<bool>(json['isBenchmark']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ticker': serializer.toJson<String>(ticker),
      'name': serializer.toJson<String>(name),
      'securityType': serializer.toJson<String>(securityType),
      'exchange': serializer.toJson<String?>(exchange),
      'currency': serializer.toJson<String>(currency),
      'currentPrice': serializer.toJson<double>(currentPrice),
      'lastPriceUpdate': serializer.toJson<DateTime?>(lastPriceUpdate),
      'isBenchmark': serializer.toJson<bool>(isBenchmark),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SecurityEntry copyWith({
    String? id,
    String? ticker,
    String? name,
    String? securityType,
    Value<String?> exchange = const Value.absent(),
    String? currency,
    double? currentPrice,
    Value<DateTime?> lastPriceUpdate = const Value.absent(),
    bool? isBenchmark,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SecurityEntry(
    id: id ?? this.id,
    ticker: ticker ?? this.ticker,
    name: name ?? this.name,
    securityType: securityType ?? this.securityType,
    exchange: exchange.present ? exchange.value : this.exchange,
    currency: currency ?? this.currency,
    currentPrice: currentPrice ?? this.currentPrice,
    lastPriceUpdate: lastPriceUpdate.present
        ? lastPriceUpdate.value
        : this.lastPriceUpdate,
    isBenchmark: isBenchmark ?? this.isBenchmark,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SecurityEntry copyWithCompanion(SecuritiesTableCompanion data) {
    return SecurityEntry(
      id: data.id.present ? data.id.value : this.id,
      ticker: data.ticker.present ? data.ticker.value : this.ticker,
      name: data.name.present ? data.name.value : this.name,
      securityType: data.securityType.present
          ? data.securityType.value
          : this.securityType,
      exchange: data.exchange.present ? data.exchange.value : this.exchange,
      currency: data.currency.present ? data.currency.value : this.currency,
      currentPrice: data.currentPrice.present
          ? data.currentPrice.value
          : this.currentPrice,
      lastPriceUpdate: data.lastPriceUpdate.present
          ? data.lastPriceUpdate.value
          : this.lastPriceUpdate,
      isBenchmark: data.isBenchmark.present
          ? data.isBenchmark.value
          : this.isBenchmark,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SecurityEntry(')
          ..write('id: $id, ')
          ..write('ticker: $ticker, ')
          ..write('name: $name, ')
          ..write('securityType: $securityType, ')
          ..write('exchange: $exchange, ')
          ..write('currency: $currency, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('lastPriceUpdate: $lastPriceUpdate, ')
          ..write('isBenchmark: $isBenchmark, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ticker,
    name,
    securityType,
    exchange,
    currency,
    currentPrice,
    lastPriceUpdate,
    isBenchmark,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SecurityEntry &&
          other.id == this.id &&
          other.ticker == this.ticker &&
          other.name == this.name &&
          other.securityType == this.securityType &&
          other.exchange == this.exchange &&
          other.currency == this.currency &&
          other.currentPrice == this.currentPrice &&
          other.lastPriceUpdate == this.lastPriceUpdate &&
          other.isBenchmark == this.isBenchmark &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SecuritiesTableCompanion extends UpdateCompanion<SecurityEntry> {
  final Value<String> id;
  final Value<String> ticker;
  final Value<String> name;
  final Value<String> securityType;
  final Value<String?> exchange;
  final Value<String> currency;
  final Value<double> currentPrice;
  final Value<DateTime?> lastPriceUpdate;
  final Value<bool> isBenchmark;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SecuritiesTableCompanion({
    this.id = const Value.absent(),
    this.ticker = const Value.absent(),
    this.name = const Value.absent(),
    this.securityType = const Value.absent(),
    this.exchange = const Value.absent(),
    this.currency = const Value.absent(),
    this.currentPrice = const Value.absent(),
    this.lastPriceUpdate = const Value.absent(),
    this.isBenchmark = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SecuritiesTableCompanion.insert({
    required String id,
    required String ticker,
    required String name,
    required String securityType,
    this.exchange = const Value.absent(),
    this.currency = const Value.absent(),
    this.currentPrice = const Value.absent(),
    this.lastPriceUpdate = const Value.absent(),
    this.isBenchmark = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ticker = Value(ticker),
       name = Value(name),
       securityType = Value(securityType);
  static Insertable<SecurityEntry> custom({
    Expression<String>? id,
    Expression<String>? ticker,
    Expression<String>? name,
    Expression<String>? securityType,
    Expression<String>? exchange,
    Expression<String>? currency,
    Expression<double>? currentPrice,
    Expression<DateTime>? lastPriceUpdate,
    Expression<bool>? isBenchmark,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ticker != null) 'ticker': ticker,
      if (name != null) 'name': name,
      if (securityType != null) 'security_type': securityType,
      if (exchange != null) 'exchange': exchange,
      if (currency != null) 'currency': currency,
      if (currentPrice != null) 'current_price': currentPrice,
      if (lastPriceUpdate != null) 'last_price_update': lastPriceUpdate,
      if (isBenchmark != null) 'is_benchmark': isBenchmark,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SecuritiesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? ticker,
    Value<String>? name,
    Value<String>? securityType,
    Value<String?>? exchange,
    Value<String>? currency,
    Value<double>? currentPrice,
    Value<DateTime?>? lastPriceUpdate,
    Value<bool>? isBenchmark,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SecuritiesTableCompanion(
      id: id ?? this.id,
      ticker: ticker ?? this.ticker,
      name: name ?? this.name,
      securityType: securityType ?? this.securityType,
      exchange: exchange ?? this.exchange,
      currency: currency ?? this.currency,
      currentPrice: currentPrice ?? this.currentPrice,
      lastPriceUpdate: lastPriceUpdate ?? this.lastPriceUpdate,
      isBenchmark: isBenchmark ?? this.isBenchmark,
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
    if (ticker.present) {
      map['ticker'] = Variable<String>(ticker.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (securityType.present) {
      map['security_type'] = Variable<String>(securityType.value);
    }
    if (exchange.present) {
      map['exchange'] = Variable<String>(exchange.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (currentPrice.present) {
      map['current_price'] = Variable<double>(currentPrice.value);
    }
    if (lastPriceUpdate.present) {
      map['last_price_update'] = Variable<DateTime>(lastPriceUpdate.value);
    }
    if (isBenchmark.present) {
      map['is_benchmark'] = Variable<bool>(isBenchmark.value);
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
    return (StringBuffer('SecuritiesTableCompanion(')
          ..write('id: $id, ')
          ..write('ticker: $ticker, ')
          ..write('name: $name, ')
          ..write('securityType: $securityType, ')
          ..write('exchange: $exchange, ')
          ..write('currency: $currency, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('lastPriceUpdate: $lastPriceUpdate, ')
          ..write('isBenchmark: $isBenchmark, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HoldingsTableTable extends HoldingsTable
    with TableInfo<$HoldingsTableTable, HoldingEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HoldingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _securityIdMeta = const VerificationMeta(
    'securityId',
  );
  @override
  late final GeneratedColumn<String> securityId = GeneratedColumn<String>(
    'security_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES securities (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _averageCostBasisMeta = const VerificationMeta(
    'averageCostBasis',
  );
  @override
  late final GeneratedColumn<double> averageCostBasis = GeneratedColumn<double>(
    'average_cost_basis',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    securityId,
    quantity,
    averageCostBasis,
    currency,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'holdings';
  @override
  VerificationContext validateIntegrity(
    Insertable<HoldingEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('security_id')) {
      context.handle(
        _securityIdMeta,
        securityId.isAcceptableOrUnknown(data['security_id']!, _securityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_securityIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('average_cost_basis')) {
      context.handle(
        _averageCostBasisMeta,
        averageCostBasis.isAcceptableOrUnknown(
          data['average_cost_basis']!,
          _averageCostBasisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_averageCostBasisMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HoldingEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HoldingEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      securityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}security_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      averageCostBasis: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}average_cost_basis'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
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
  $HoldingsTableTable createAlias(String alias) {
    return $HoldingsTableTable(attachedDatabase, alias);
  }
}

class HoldingEntry extends DataClass implements Insertable<HoldingEntry> {
  final String id;
  final String securityId;
  final double quantity;
  final double averageCostBasis;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  const HoldingEntry({
    required this.id,
    required this.securityId,
    required this.quantity,
    required this.averageCostBasis,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['security_id'] = Variable<String>(securityId);
    map['quantity'] = Variable<double>(quantity);
    map['average_cost_basis'] = Variable<double>(averageCostBasis);
    map['currency'] = Variable<String>(currency);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HoldingsTableCompanion toCompanion(bool nullToAbsent) {
    return HoldingsTableCompanion(
      id: Value(id),
      securityId: Value(securityId),
      quantity: Value(quantity),
      averageCostBasis: Value(averageCostBasis),
      currency: Value(currency),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HoldingEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HoldingEntry(
      id: serializer.fromJson<String>(json['id']),
      securityId: serializer.fromJson<String>(json['securityId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      averageCostBasis: serializer.fromJson<double>(json['averageCostBasis']),
      currency: serializer.fromJson<String>(json['currency']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'securityId': serializer.toJson<String>(securityId),
      'quantity': serializer.toJson<double>(quantity),
      'averageCostBasis': serializer.toJson<double>(averageCostBasis),
      'currency': serializer.toJson<String>(currency),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HoldingEntry copyWith({
    String? id,
    String? securityId,
    double? quantity,
    double? averageCostBasis,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => HoldingEntry(
    id: id ?? this.id,
    securityId: securityId ?? this.securityId,
    quantity: quantity ?? this.quantity,
    averageCostBasis: averageCostBasis ?? this.averageCostBasis,
    currency: currency ?? this.currency,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  HoldingEntry copyWithCompanion(HoldingsTableCompanion data) {
    return HoldingEntry(
      id: data.id.present ? data.id.value : this.id,
      securityId: data.securityId.present
          ? data.securityId.value
          : this.securityId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      averageCostBasis: data.averageCostBasis.present
          ? data.averageCostBasis.value
          : this.averageCostBasis,
      currency: data.currency.present ? data.currency.value : this.currency,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HoldingEntry(')
          ..write('id: $id, ')
          ..write('securityId: $securityId, ')
          ..write('quantity: $quantity, ')
          ..write('averageCostBasis: $averageCostBasis, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    securityId,
    quantity,
    averageCostBasis,
    currency,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HoldingEntry &&
          other.id == this.id &&
          other.securityId == this.securityId &&
          other.quantity == this.quantity &&
          other.averageCostBasis == this.averageCostBasis &&
          other.currency == this.currency &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HoldingsTableCompanion extends UpdateCompanion<HoldingEntry> {
  final Value<String> id;
  final Value<String> securityId;
  final Value<double> quantity;
  final Value<double> averageCostBasis;
  final Value<String> currency;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const HoldingsTableCompanion({
    this.id = const Value.absent(),
    this.securityId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.averageCostBasis = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HoldingsTableCompanion.insert({
    required String id,
    required String securityId,
    required double quantity,
    required double averageCostBasis,
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       securityId = Value(securityId),
       quantity = Value(quantity),
       averageCostBasis = Value(averageCostBasis);
  static Insertable<HoldingEntry> custom({
    Expression<String>? id,
    Expression<String>? securityId,
    Expression<double>? quantity,
    Expression<double>? averageCostBasis,
    Expression<String>? currency,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (securityId != null) 'security_id': securityId,
      if (quantity != null) 'quantity': quantity,
      if (averageCostBasis != null) 'average_cost_basis': averageCostBasis,
      if (currency != null) 'currency': currency,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HoldingsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? securityId,
    Value<double>? quantity,
    Value<double>? averageCostBasis,
    Value<String>? currency,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return HoldingsTableCompanion(
      id: id ?? this.id,
      securityId: securityId ?? this.securityId,
      quantity: quantity ?? this.quantity,
      averageCostBasis: averageCostBasis ?? this.averageCostBasis,
      currency: currency ?? this.currency,
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
    if (securityId.present) {
      map['security_id'] = Variable<String>(securityId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (averageCostBasis.present) {
      map['average_cost_basis'] = Variable<double>(averageCostBasis.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
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
    return (StringBuffer('HoldingsTableCompanion(')
          ..write('id: $id, ')
          ..write('securityId: $securityId, ')
          ..write('quantity: $quantity, ')
          ..write('averageCostBasis: $averageCostBasis, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvestmentTransactionsTableTable extends InvestmentTransactionsTable
    with
        TableInfo<
          $InvestmentTransactionsTableTable,
          InvestmentTransactionEntry
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvestmentTransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _securityIdMeta = const VerificationMeta(
    'securityId',
  );
  @override
  late final GeneratedColumn<String> securityId = GeneratedColumn<String>(
    'security_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES securities (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _holdingIdMeta = const VerificationMeta(
    'holdingId',
  );
  @override
  late final GeneratedColumn<String> holdingId = GeneratedColumn<String>(
    'holding_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES holdings (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricePerUnitMeta = const VerificationMeta(
    'pricePerUnit',
  );
  @override
  late final GeneratedColumn<double> pricePerUnit = GeneratedColumn<double>(
    'price_per_unit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feeMeta = const VerificationMeta('fee');
  @override
  late final GeneratedColumn<double> fee = GeneratedColumn<double>(
    'fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
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
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _exchangeRateToIlsMeta = const VerificationMeta(
    'exchangeRateToIls',
  );
  @override
  late final GeneratedColumn<double> exchangeRateToIls =
      GeneratedColumn<double>(
        'exchange_rate_to_ils',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(1.0),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    securityId,
    holdingId,
    type,
    quantity,
    pricePerUnit,
    fee,
    date,
    currency,
    exchangeRateToIls,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'investment_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvestmentTransactionEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('security_id')) {
      context.handle(
        _securityIdMeta,
        securityId.isAcceptableOrUnknown(data['security_id']!, _securityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_securityIdMeta);
    }
    if (data.containsKey('holding_id')) {
      context.handle(
        _holdingIdMeta,
        holdingId.isAcceptableOrUnknown(data['holding_id']!, _holdingIdMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('price_per_unit')) {
      context.handle(
        _pricePerUnitMeta,
        pricePerUnit.isAcceptableOrUnknown(
          data['price_per_unit']!,
          _pricePerUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricePerUnitMeta);
    }
    if (data.containsKey('fee')) {
      context.handle(
        _feeMeta,
        fee.isAcceptableOrUnknown(data['fee']!, _feeMeta),
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
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('exchange_rate_to_ils')) {
      context.handle(
        _exchangeRateToIlsMeta,
        exchangeRateToIls.isAcceptableOrUnknown(
          data['exchange_rate_to_ils']!,
          _exchangeRateToIlsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvestmentTransactionEntry map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvestmentTransactionEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      securityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}security_id'],
      )!,
      holdingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}holding_id'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      pricePerUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_per_unit'],
      )!,
      fee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fee'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      exchangeRateToIls: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exchange_rate_to_ils'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InvestmentTransactionsTableTable createAlias(String alias) {
    return $InvestmentTransactionsTableTable(attachedDatabase, alias);
  }
}

class InvestmentTransactionEntry extends DataClass
    implements Insertable<InvestmentTransactionEntry> {
  final String id;
  final String securityId;
  final String? holdingId;
  final String type;
  final double quantity;
  final double pricePerUnit;
  final double fee;
  final DateTime date;
  final String currency;
  final double exchangeRateToIls;
  final DateTime createdAt;
  const InvestmentTransactionEntry({
    required this.id,
    required this.securityId,
    this.holdingId,
    required this.type,
    required this.quantity,
    required this.pricePerUnit,
    required this.fee,
    required this.date,
    required this.currency,
    required this.exchangeRateToIls,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['security_id'] = Variable<String>(securityId);
    if (!nullToAbsent || holdingId != null) {
      map['holding_id'] = Variable<String>(holdingId);
    }
    map['type'] = Variable<String>(type);
    map['quantity'] = Variable<double>(quantity);
    map['price_per_unit'] = Variable<double>(pricePerUnit);
    map['fee'] = Variable<double>(fee);
    map['date'] = Variable<DateTime>(date);
    map['currency'] = Variable<String>(currency);
    map['exchange_rate_to_ils'] = Variable<double>(exchangeRateToIls);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InvestmentTransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return InvestmentTransactionsTableCompanion(
      id: Value(id),
      securityId: Value(securityId),
      holdingId: holdingId == null && nullToAbsent
          ? const Value.absent()
          : Value(holdingId),
      type: Value(type),
      quantity: Value(quantity),
      pricePerUnit: Value(pricePerUnit),
      fee: Value(fee),
      date: Value(date),
      currency: Value(currency),
      exchangeRateToIls: Value(exchangeRateToIls),
      createdAt: Value(createdAt),
    );
  }

  factory InvestmentTransactionEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvestmentTransactionEntry(
      id: serializer.fromJson<String>(json['id']),
      securityId: serializer.fromJson<String>(json['securityId']),
      holdingId: serializer.fromJson<String?>(json['holdingId']),
      type: serializer.fromJson<String>(json['type']),
      quantity: serializer.fromJson<double>(json['quantity']),
      pricePerUnit: serializer.fromJson<double>(json['pricePerUnit']),
      fee: serializer.fromJson<double>(json['fee']),
      date: serializer.fromJson<DateTime>(json['date']),
      currency: serializer.fromJson<String>(json['currency']),
      exchangeRateToIls: serializer.fromJson<double>(json['exchangeRateToIls']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'securityId': serializer.toJson<String>(securityId),
      'holdingId': serializer.toJson<String?>(holdingId),
      'type': serializer.toJson<String>(type),
      'quantity': serializer.toJson<double>(quantity),
      'pricePerUnit': serializer.toJson<double>(pricePerUnit),
      'fee': serializer.toJson<double>(fee),
      'date': serializer.toJson<DateTime>(date),
      'currency': serializer.toJson<String>(currency),
      'exchangeRateToIls': serializer.toJson<double>(exchangeRateToIls),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InvestmentTransactionEntry copyWith({
    String? id,
    String? securityId,
    Value<String?> holdingId = const Value.absent(),
    String? type,
    double? quantity,
    double? pricePerUnit,
    double? fee,
    DateTime? date,
    String? currency,
    double? exchangeRateToIls,
    DateTime? createdAt,
  }) => InvestmentTransactionEntry(
    id: id ?? this.id,
    securityId: securityId ?? this.securityId,
    holdingId: holdingId.present ? holdingId.value : this.holdingId,
    type: type ?? this.type,
    quantity: quantity ?? this.quantity,
    pricePerUnit: pricePerUnit ?? this.pricePerUnit,
    fee: fee ?? this.fee,
    date: date ?? this.date,
    currency: currency ?? this.currency,
    exchangeRateToIls: exchangeRateToIls ?? this.exchangeRateToIls,
    createdAt: createdAt ?? this.createdAt,
  );
  InvestmentTransactionEntry copyWithCompanion(
    InvestmentTransactionsTableCompanion data,
  ) {
    return InvestmentTransactionEntry(
      id: data.id.present ? data.id.value : this.id,
      securityId: data.securityId.present
          ? data.securityId.value
          : this.securityId,
      holdingId: data.holdingId.present ? data.holdingId.value : this.holdingId,
      type: data.type.present ? data.type.value : this.type,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      pricePerUnit: data.pricePerUnit.present
          ? data.pricePerUnit.value
          : this.pricePerUnit,
      fee: data.fee.present ? data.fee.value : this.fee,
      date: data.date.present ? data.date.value : this.date,
      currency: data.currency.present ? data.currency.value : this.currency,
      exchangeRateToIls: data.exchangeRateToIls.present
          ? data.exchangeRateToIls.value
          : this.exchangeRateToIls,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentTransactionEntry(')
          ..write('id: $id, ')
          ..write('securityId: $securityId, ')
          ..write('holdingId: $holdingId, ')
          ..write('type: $type, ')
          ..write('quantity: $quantity, ')
          ..write('pricePerUnit: $pricePerUnit, ')
          ..write('fee: $fee, ')
          ..write('date: $date, ')
          ..write('currency: $currency, ')
          ..write('exchangeRateToIls: $exchangeRateToIls, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    securityId,
    holdingId,
    type,
    quantity,
    pricePerUnit,
    fee,
    date,
    currency,
    exchangeRateToIls,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvestmentTransactionEntry &&
          other.id == this.id &&
          other.securityId == this.securityId &&
          other.holdingId == this.holdingId &&
          other.type == this.type &&
          other.quantity == this.quantity &&
          other.pricePerUnit == this.pricePerUnit &&
          other.fee == this.fee &&
          other.date == this.date &&
          other.currency == this.currency &&
          other.exchangeRateToIls == this.exchangeRateToIls &&
          other.createdAt == this.createdAt);
}

class InvestmentTransactionsTableCompanion
    extends UpdateCompanion<InvestmentTransactionEntry> {
  final Value<String> id;
  final Value<String> securityId;
  final Value<String?> holdingId;
  final Value<String> type;
  final Value<double> quantity;
  final Value<double> pricePerUnit;
  final Value<double> fee;
  final Value<DateTime> date;
  final Value<String> currency;
  final Value<double> exchangeRateToIls;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InvestmentTransactionsTableCompanion({
    this.id = const Value.absent(),
    this.securityId = const Value.absent(),
    this.holdingId = const Value.absent(),
    this.type = const Value.absent(),
    this.quantity = const Value.absent(),
    this.pricePerUnit = const Value.absent(),
    this.fee = const Value.absent(),
    this.date = const Value.absent(),
    this.currency = const Value.absent(),
    this.exchangeRateToIls = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvestmentTransactionsTableCompanion.insert({
    required String id,
    required String securityId,
    this.holdingId = const Value.absent(),
    required String type,
    required double quantity,
    required double pricePerUnit,
    this.fee = const Value.absent(),
    required DateTime date,
    this.currency = const Value.absent(),
    this.exchangeRateToIls = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       securityId = Value(securityId),
       type = Value(type),
       quantity = Value(quantity),
       pricePerUnit = Value(pricePerUnit),
       date = Value(date);
  static Insertable<InvestmentTransactionEntry> custom({
    Expression<String>? id,
    Expression<String>? securityId,
    Expression<String>? holdingId,
    Expression<String>? type,
    Expression<double>? quantity,
    Expression<double>? pricePerUnit,
    Expression<double>? fee,
    Expression<DateTime>? date,
    Expression<String>? currency,
    Expression<double>? exchangeRateToIls,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (securityId != null) 'security_id': securityId,
      if (holdingId != null) 'holding_id': holdingId,
      if (type != null) 'type': type,
      if (quantity != null) 'quantity': quantity,
      if (pricePerUnit != null) 'price_per_unit': pricePerUnit,
      if (fee != null) 'fee': fee,
      if (date != null) 'date': date,
      if (currency != null) 'currency': currency,
      if (exchangeRateToIls != null) 'exchange_rate_to_ils': exchangeRateToIls,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvestmentTransactionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? securityId,
    Value<String?>? holdingId,
    Value<String>? type,
    Value<double>? quantity,
    Value<double>? pricePerUnit,
    Value<double>? fee,
    Value<DateTime>? date,
    Value<String>? currency,
    Value<double>? exchangeRateToIls,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return InvestmentTransactionsTableCompanion(
      id: id ?? this.id,
      securityId: securityId ?? this.securityId,
      holdingId: holdingId ?? this.holdingId,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      fee: fee ?? this.fee,
      date: date ?? this.date,
      currency: currency ?? this.currency,
      exchangeRateToIls: exchangeRateToIls ?? this.exchangeRateToIls,
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
    if (securityId.present) {
      map['security_id'] = Variable<String>(securityId.value);
    }
    if (holdingId.present) {
      map['holding_id'] = Variable<String>(holdingId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (pricePerUnit.present) {
      map['price_per_unit'] = Variable<double>(pricePerUnit.value);
    }
    if (fee.present) {
      map['fee'] = Variable<double>(fee.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (exchangeRateToIls.present) {
      map['exchange_rate_to_ils'] = Variable<double>(exchangeRateToIls.value);
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
    return (StringBuffer('InvestmentTransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('securityId: $securityId, ')
          ..write('holdingId: $holdingId, ')
          ..write('type: $type, ')
          ..write('quantity: $quantity, ')
          ..write('pricePerUnit: $pricePerUnit, ')
          ..write('fee: $fee, ')
          ..write('date: $date, ')
          ..write('currency: $currency, ')
          ..write('exchangeRateToIls: $exchangeRateToIls, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PensionAssetsTableTable extends PensionAssetsTable
    with TableInfo<$PensionAssetsTableTable, PensionAssetEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PensionAssetsTableTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerNameMeta = const VerificationMeta(
    'providerName',
  );
  @override
  late final GeneratedColumn<String> providerName = GeneratedColumn<String>(
    'provider_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _policyNumberMeta = const VerificationMeta(
    'policyNumber',
  );
  @override
  late final GeneratedColumn<String> policyNumber = GeneratedColumn<String>(
    'policy_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trackNameMeta = const VerificationMeta(
    'trackName',
  );
  @override
  late final GeneratedColumn<String> trackName = GeneratedColumn<String>(
    'track_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentBalanceMeta = const VerificationMeta(
    'currentBalance',
  );
  @override
  late final GeneratedColumn<double> currentBalance = GeneratedColumn<double>(
    'current_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _monthlyDepositEmployeeMeta =
      const VerificationMeta('monthlyDepositEmployee');
  @override
  late final GeneratedColumn<double> monthlyDepositEmployee =
      GeneratedColumn<double>(
        'monthly_deposit_employee',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _monthlyDepositEmployerMeta =
      const VerificationMeta('monthlyDepositEmployer');
  @override
  late final GeneratedColumn<double> monthlyDepositEmployer =
      GeneratedColumn<double>(
        'monthly_deposit_employer',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _lastUpdatedDateMeta = const VerificationMeta(
    'lastUpdatedDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedDate =
      GeneratedColumn<DateTime>(
        'last_updated_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    providerName,
    policyNumber,
    trackName,
    currentBalance,
    monthlyDepositEmployee,
    monthlyDepositEmployer,
    lastUpdatedDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pension_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<PensionAssetEntry> instance, {
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
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('provider_name')) {
      context.handle(
        _providerNameMeta,
        providerName.isAcceptableOrUnknown(
          data['provider_name']!,
          _providerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_providerNameMeta);
    }
    if (data.containsKey('policy_number')) {
      context.handle(
        _policyNumberMeta,
        policyNumber.isAcceptableOrUnknown(
          data['policy_number']!,
          _policyNumberMeta,
        ),
      );
    }
    if (data.containsKey('track_name')) {
      context.handle(
        _trackNameMeta,
        trackName.isAcceptableOrUnknown(data['track_name']!, _trackNameMeta),
      );
    }
    if (data.containsKey('current_balance')) {
      context.handle(
        _currentBalanceMeta,
        currentBalance.isAcceptableOrUnknown(
          data['current_balance']!,
          _currentBalanceMeta,
        ),
      );
    }
    if (data.containsKey('monthly_deposit_employee')) {
      context.handle(
        _monthlyDepositEmployeeMeta,
        monthlyDepositEmployee.isAcceptableOrUnknown(
          data['monthly_deposit_employee']!,
          _monthlyDepositEmployeeMeta,
        ),
      );
    }
    if (data.containsKey('monthly_deposit_employer')) {
      context.handle(
        _monthlyDepositEmployerMeta,
        monthlyDepositEmployer.isAcceptableOrUnknown(
          data['monthly_deposit_employer']!,
          _monthlyDepositEmployerMeta,
        ),
      );
    }
    if (data.containsKey('last_updated_date')) {
      context.handle(
        _lastUpdatedDateMeta,
        lastUpdatedDate.isAcceptableOrUnknown(
          data['last_updated_date']!,
          _lastUpdatedDateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PensionAssetEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PensionAssetEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      providerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_name'],
      )!,
      policyNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}policy_number'],
      ),
      trackName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}track_name'],
      ),
      currentBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_balance'],
      )!,
      monthlyDepositEmployee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monthly_deposit_employee'],
      )!,
      monthlyDepositEmployer: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monthly_deposit_employer'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
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
  $PensionAssetsTableTable createAlias(String alias) {
    return $PensionAssetsTableTable(attachedDatabase, alias);
  }
}

class PensionAssetEntry extends DataClass
    implements Insertable<PensionAssetEntry> {
  final String id;
  final String name;
  final String type;
  final String providerName;
  final String? policyNumber;
  final String? trackName;
  final double currentBalance;
  final double monthlyDepositEmployee;
  final double monthlyDepositEmployer;
  final DateTime lastUpdatedDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PensionAssetEntry({
    required this.id,
    required this.name,
    required this.type,
    required this.providerName,
    this.policyNumber,
    this.trackName,
    required this.currentBalance,
    required this.monthlyDepositEmployee,
    required this.monthlyDepositEmployer,
    required this.lastUpdatedDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['provider_name'] = Variable<String>(providerName);
    if (!nullToAbsent || policyNumber != null) {
      map['policy_number'] = Variable<String>(policyNumber);
    }
    if (!nullToAbsent || trackName != null) {
      map['track_name'] = Variable<String>(trackName);
    }
    map['current_balance'] = Variable<double>(currentBalance);
    map['monthly_deposit_employee'] = Variable<double>(monthlyDepositEmployee);
    map['monthly_deposit_employer'] = Variable<double>(monthlyDepositEmployer);
    map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PensionAssetsTableCompanion toCompanion(bool nullToAbsent) {
    return PensionAssetsTableCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      providerName: Value(providerName),
      policyNumber: policyNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(policyNumber),
      trackName: trackName == null && nullToAbsent
          ? const Value.absent()
          : Value(trackName),
      currentBalance: Value(currentBalance),
      monthlyDepositEmployee: Value(monthlyDepositEmployee),
      monthlyDepositEmployer: Value(monthlyDepositEmployer),
      lastUpdatedDate: Value(lastUpdatedDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PensionAssetEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PensionAssetEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      providerName: serializer.fromJson<String>(json['providerName']),
      policyNumber: serializer.fromJson<String?>(json['policyNumber']),
      trackName: serializer.fromJson<String?>(json['trackName']),
      currentBalance: serializer.fromJson<double>(json['currentBalance']),
      monthlyDepositEmployee: serializer.fromJson<double>(
        json['monthlyDepositEmployee'],
      ),
      monthlyDepositEmployer: serializer.fromJson<double>(
        json['monthlyDepositEmployer'],
      ),
      lastUpdatedDate: serializer.fromJson<DateTime>(json['lastUpdatedDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'providerName': serializer.toJson<String>(providerName),
      'policyNumber': serializer.toJson<String?>(policyNumber),
      'trackName': serializer.toJson<String?>(trackName),
      'currentBalance': serializer.toJson<double>(currentBalance),
      'monthlyDepositEmployee': serializer.toJson<double>(
        monthlyDepositEmployee,
      ),
      'monthlyDepositEmployer': serializer.toJson<double>(
        monthlyDepositEmployer,
      ),
      'lastUpdatedDate': serializer.toJson<DateTime>(lastUpdatedDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PensionAssetEntry copyWith({
    String? id,
    String? name,
    String? type,
    String? providerName,
    Value<String?> policyNumber = const Value.absent(),
    Value<String?> trackName = const Value.absent(),
    double? currentBalance,
    double? monthlyDepositEmployee,
    double? monthlyDepositEmployer,
    DateTime? lastUpdatedDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PensionAssetEntry(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    providerName: providerName ?? this.providerName,
    policyNumber: policyNumber.present ? policyNumber.value : this.policyNumber,
    trackName: trackName.present ? trackName.value : this.trackName,
    currentBalance: currentBalance ?? this.currentBalance,
    monthlyDepositEmployee:
        monthlyDepositEmployee ?? this.monthlyDepositEmployee,
    monthlyDepositEmployer:
        monthlyDepositEmployer ?? this.monthlyDepositEmployer,
    lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PensionAssetEntry copyWithCompanion(PensionAssetsTableCompanion data) {
    return PensionAssetEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      providerName: data.providerName.present
          ? data.providerName.value
          : this.providerName,
      policyNumber: data.policyNumber.present
          ? data.policyNumber.value
          : this.policyNumber,
      trackName: data.trackName.present ? data.trackName.value : this.trackName,
      currentBalance: data.currentBalance.present
          ? data.currentBalance.value
          : this.currentBalance,
      monthlyDepositEmployee: data.monthlyDepositEmployee.present
          ? data.monthlyDepositEmployee.value
          : this.monthlyDepositEmployee,
      monthlyDepositEmployer: data.monthlyDepositEmployer.present
          ? data.monthlyDepositEmployer.value
          : this.monthlyDepositEmployer,
      lastUpdatedDate: data.lastUpdatedDate.present
          ? data.lastUpdatedDate.value
          : this.lastUpdatedDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PensionAssetEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('providerName: $providerName, ')
          ..write('policyNumber: $policyNumber, ')
          ..write('trackName: $trackName, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('monthlyDepositEmployee: $monthlyDepositEmployee, ')
          ..write('monthlyDepositEmployer: $monthlyDepositEmployer, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    providerName,
    policyNumber,
    trackName,
    currentBalance,
    monthlyDepositEmployee,
    monthlyDepositEmployer,
    lastUpdatedDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PensionAssetEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.providerName == this.providerName &&
          other.policyNumber == this.policyNumber &&
          other.trackName == this.trackName &&
          other.currentBalance == this.currentBalance &&
          other.monthlyDepositEmployee == this.monthlyDepositEmployee &&
          other.monthlyDepositEmployer == this.monthlyDepositEmployer &&
          other.lastUpdatedDate == this.lastUpdatedDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PensionAssetsTableCompanion extends UpdateCompanion<PensionAssetEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> providerName;
  final Value<String?> policyNumber;
  final Value<String?> trackName;
  final Value<double> currentBalance;
  final Value<double> monthlyDepositEmployee;
  final Value<double> monthlyDepositEmployer;
  final Value<DateTime> lastUpdatedDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PensionAssetsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.providerName = const Value.absent(),
    this.policyNumber = const Value.absent(),
    this.trackName = const Value.absent(),
    this.currentBalance = const Value.absent(),
    this.monthlyDepositEmployee = const Value.absent(),
    this.monthlyDepositEmployer = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PensionAssetsTableCompanion.insert({
    required String id,
    required String name,
    required String type,
    required String providerName,
    this.policyNumber = const Value.absent(),
    this.trackName = const Value.absent(),
    this.currentBalance = const Value.absent(),
    this.monthlyDepositEmployee = const Value.absent(),
    this.monthlyDepositEmployer = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       providerName = Value(providerName);
  static Insertable<PensionAssetEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? providerName,
    Expression<String>? policyNumber,
    Expression<String>? trackName,
    Expression<double>? currentBalance,
    Expression<double>? monthlyDepositEmployee,
    Expression<double>? monthlyDepositEmployer,
    Expression<DateTime>? lastUpdatedDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (providerName != null) 'provider_name': providerName,
      if (policyNumber != null) 'policy_number': policyNumber,
      if (trackName != null) 'track_name': trackName,
      if (currentBalance != null) 'current_balance': currentBalance,
      if (monthlyDepositEmployee != null)
        'monthly_deposit_employee': monthlyDepositEmployee,
      if (monthlyDepositEmployer != null)
        'monthly_deposit_employer': monthlyDepositEmployer,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PensionAssetsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<String>? providerName,
    Value<String?>? policyNumber,
    Value<String?>? trackName,
    Value<double>? currentBalance,
    Value<double>? monthlyDepositEmployee,
    Value<double>? monthlyDepositEmployer,
    Value<DateTime>? lastUpdatedDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PensionAssetsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      providerName: providerName ?? this.providerName,
      policyNumber: policyNumber ?? this.policyNumber,
      trackName: trackName ?? this.trackName,
      currentBalance: currentBalance ?? this.currentBalance,
      monthlyDepositEmployee:
          monthlyDepositEmployee ?? this.monthlyDepositEmployee,
      monthlyDepositEmployer:
          monthlyDepositEmployer ?? this.monthlyDepositEmployer,
      lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (providerName.present) {
      map['provider_name'] = Variable<String>(providerName.value);
    }
    if (policyNumber.present) {
      map['policy_number'] = Variable<String>(policyNumber.value);
    }
    if (trackName.present) {
      map['track_name'] = Variable<String>(trackName.value);
    }
    if (currentBalance.present) {
      map['current_balance'] = Variable<double>(currentBalance.value);
    }
    if (monthlyDepositEmployee.present) {
      map['monthly_deposit_employee'] = Variable<double>(
        monthlyDepositEmployee.value,
      );
    }
    if (monthlyDepositEmployer.present) {
      map['monthly_deposit_employer'] = Variable<double>(
        monthlyDepositEmployer.value,
      );
    }
    if (lastUpdatedDate.present) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate.value);
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
    return (StringBuffer('PensionAssetsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('providerName: $providerName, ')
          ..write('policyNumber: $policyNumber, ')
          ..write('trackName: $trackName, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('monthlyDepositEmployee: $monthlyDepositEmployee, ')
          ..write('monthlyDepositEmployer: $monthlyDepositEmployer, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PensionSnapshotsTableTable extends PensionSnapshotsTable
    with TableInfo<$PensionSnapshotsTableTable, PensionSnapshotEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PensionSnapshotsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pensionAssetIdMeta = const VerificationMeta(
    'pensionAssetId',
  );
  @override
  late final GeneratedColumn<String> pensionAssetId = GeneratedColumn<String>(
    'pension_asset_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pension_assets (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snapshotDateMeta = const VerificationMeta(
    'snapshotDate',
  );
  @override
  late final GeneratedColumn<DateTime> snapshotDate = GeneratedColumn<DateTime>(
    'snapshot_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pensionAssetId,
    balance,
    snapshotDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pension_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<PensionSnapshotEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pension_asset_id')) {
      context.handle(
        _pensionAssetIdMeta,
        pensionAssetId.isAcceptableOrUnknown(
          data['pension_asset_id']!,
          _pensionAssetIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pensionAssetIdMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('snapshot_date')) {
      context.handle(
        _snapshotDateMeta,
        snapshotDate.isAcceptableOrUnknown(
          data['snapshot_date']!,
          _snapshotDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_snapshotDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PensionSnapshotEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PensionSnapshotEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pensionAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pension_asset_id'],
      )!,
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      snapshotDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}snapshot_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PensionSnapshotsTableTable createAlias(String alias) {
    return $PensionSnapshotsTableTable(attachedDatabase, alias);
  }
}

class PensionSnapshotEntry extends DataClass
    implements Insertable<PensionSnapshotEntry> {
  final String id;
  final String pensionAssetId;
  final double balance;
  final DateTime snapshotDate;
  final DateTime createdAt;
  const PensionSnapshotEntry({
    required this.id,
    required this.pensionAssetId,
    required this.balance,
    required this.snapshotDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pension_asset_id'] = Variable<String>(pensionAssetId);
    map['balance'] = Variable<double>(balance);
    map['snapshot_date'] = Variable<DateTime>(snapshotDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PensionSnapshotsTableCompanion toCompanion(bool nullToAbsent) {
    return PensionSnapshotsTableCompanion(
      id: Value(id),
      pensionAssetId: Value(pensionAssetId),
      balance: Value(balance),
      snapshotDate: Value(snapshotDate),
      createdAt: Value(createdAt),
    );
  }

  factory PensionSnapshotEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PensionSnapshotEntry(
      id: serializer.fromJson<String>(json['id']),
      pensionAssetId: serializer.fromJson<String>(json['pensionAssetId']),
      balance: serializer.fromJson<double>(json['balance']),
      snapshotDate: serializer.fromJson<DateTime>(json['snapshotDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pensionAssetId': serializer.toJson<String>(pensionAssetId),
      'balance': serializer.toJson<double>(balance),
      'snapshotDate': serializer.toJson<DateTime>(snapshotDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PensionSnapshotEntry copyWith({
    String? id,
    String? pensionAssetId,
    double? balance,
    DateTime? snapshotDate,
    DateTime? createdAt,
  }) => PensionSnapshotEntry(
    id: id ?? this.id,
    pensionAssetId: pensionAssetId ?? this.pensionAssetId,
    balance: balance ?? this.balance,
    snapshotDate: snapshotDate ?? this.snapshotDate,
    createdAt: createdAt ?? this.createdAt,
  );
  PensionSnapshotEntry copyWithCompanion(PensionSnapshotsTableCompanion data) {
    return PensionSnapshotEntry(
      id: data.id.present ? data.id.value : this.id,
      pensionAssetId: data.pensionAssetId.present
          ? data.pensionAssetId.value
          : this.pensionAssetId,
      balance: data.balance.present ? data.balance.value : this.balance,
      snapshotDate: data.snapshotDate.present
          ? data.snapshotDate.value
          : this.snapshotDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PensionSnapshotEntry(')
          ..write('id: $id, ')
          ..write('pensionAssetId: $pensionAssetId, ')
          ..write('balance: $balance, ')
          ..write('snapshotDate: $snapshotDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pensionAssetId, balance, snapshotDate, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PensionSnapshotEntry &&
          other.id == this.id &&
          other.pensionAssetId == this.pensionAssetId &&
          other.balance == this.balance &&
          other.snapshotDate == this.snapshotDate &&
          other.createdAt == this.createdAt);
}

class PensionSnapshotsTableCompanion
    extends UpdateCompanion<PensionSnapshotEntry> {
  final Value<String> id;
  final Value<String> pensionAssetId;
  final Value<double> balance;
  final Value<DateTime> snapshotDate;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PensionSnapshotsTableCompanion({
    this.id = const Value.absent(),
    this.pensionAssetId = const Value.absent(),
    this.balance = const Value.absent(),
    this.snapshotDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PensionSnapshotsTableCompanion.insert({
    required String id,
    required String pensionAssetId,
    required double balance,
    required DateTime snapshotDate,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pensionAssetId = Value(pensionAssetId),
       balance = Value(balance),
       snapshotDate = Value(snapshotDate);
  static Insertable<PensionSnapshotEntry> custom({
    Expression<String>? id,
    Expression<String>? pensionAssetId,
    Expression<double>? balance,
    Expression<DateTime>? snapshotDate,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pensionAssetId != null) 'pension_asset_id': pensionAssetId,
      if (balance != null) 'balance': balance,
      if (snapshotDate != null) 'snapshot_date': snapshotDate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PensionSnapshotsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? pensionAssetId,
    Value<double>? balance,
    Value<DateTime>? snapshotDate,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PensionSnapshotsTableCompanion(
      id: id ?? this.id,
      pensionAssetId: pensionAssetId ?? this.pensionAssetId,
      balance: balance ?? this.balance,
      snapshotDate: snapshotDate ?? this.snapshotDate,
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
    if (pensionAssetId.present) {
      map['pension_asset_id'] = Variable<String>(pensionAssetId.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (snapshotDate.present) {
      map['snapshot_date'] = Variable<DateTime>(snapshotDate.value);
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
    return (StringBuffer('PensionSnapshotsTableCompanion(')
          ..write('id: $id, ')
          ..write('pensionAssetId: $pensionAssetId, ')
          ..write('balance: $balance, ')
          ..write('snapshotDate: $snapshotDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssetsTableTable extends AssetsTable
    with TableInfo<$AssetsTableTable, AssetEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetsTableTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetTypeMeta = const VerificationMeta(
    'assetType',
  );
  @override
  late final GeneratedColumn<String> assetType = GeneratedColumn<String>(
    'asset_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedValueMeta = const VerificationMeta(
    'estimatedValue',
  );
  @override
  late final GeneratedColumn<double> estimatedValue = GeneratedColumn<double>(
    'estimated_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastValuationDateMeta = const VerificationMeta(
    'lastValuationDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastValuationDate =
      GeneratedColumn<DateTime>(
        'last_valuation_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    assetType,
    estimatedValue,
    lastValuationDate,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<AssetEntry> instance, {
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
    if (data.containsKey('asset_type')) {
      context.handle(
        _assetTypeMeta,
        assetType.isAcceptableOrUnknown(data['asset_type']!, _assetTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_assetTypeMeta);
    }
    if (data.containsKey('estimated_value')) {
      context.handle(
        _estimatedValueMeta,
        estimatedValue.isAcceptableOrUnknown(
          data['estimated_value']!,
          _estimatedValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedValueMeta);
    }
    if (data.containsKey('last_valuation_date')) {
      context.handle(
        _lastValuationDateMeta,
        lastValuationDate.isAcceptableOrUnknown(
          data['last_valuation_date']!,
          _lastValuationDateMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssetEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssetEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      assetType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_type'],
      )!,
      estimatedValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_value'],
      )!,
      lastValuationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_valuation_date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
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
  $AssetsTableTable createAlias(String alias) {
    return $AssetsTableTable(attachedDatabase, alias);
  }
}

class AssetEntry extends DataClass implements Insertable<AssetEntry> {
  final String id;
  final String name;
  final String assetType;
  final double estimatedValue;
  final DateTime lastValuationDate;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AssetEntry({
    required this.id,
    required this.name,
    required this.assetType,
    required this.estimatedValue,
    required this.lastValuationDate,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['asset_type'] = Variable<String>(assetType);
    map['estimated_value'] = Variable<double>(estimatedValue);
    map['last_valuation_date'] = Variable<DateTime>(lastValuationDate);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AssetsTableCompanion toCompanion(bool nullToAbsent) {
    return AssetsTableCompanion(
      id: Value(id),
      name: Value(name),
      assetType: Value(assetType),
      estimatedValue: Value(estimatedValue),
      lastValuationDate: Value(lastValuationDate),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AssetEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssetEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      assetType: serializer.fromJson<String>(json['assetType']),
      estimatedValue: serializer.fromJson<double>(json['estimatedValue']),
      lastValuationDate: serializer.fromJson<DateTime>(
        json['lastValuationDate'],
      ),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'assetType': serializer.toJson<String>(assetType),
      'estimatedValue': serializer.toJson<double>(estimatedValue),
      'lastValuationDate': serializer.toJson<DateTime>(lastValuationDate),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AssetEntry copyWith({
    String? id,
    String? name,
    String? assetType,
    double? estimatedValue,
    DateTime? lastValuationDate,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AssetEntry(
    id: id ?? this.id,
    name: name ?? this.name,
    assetType: assetType ?? this.assetType,
    estimatedValue: estimatedValue ?? this.estimatedValue,
    lastValuationDate: lastValuationDate ?? this.lastValuationDate,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AssetEntry copyWithCompanion(AssetsTableCompanion data) {
    return AssetEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      assetType: data.assetType.present ? data.assetType.value : this.assetType,
      estimatedValue: data.estimatedValue.present
          ? data.estimatedValue.value
          : this.estimatedValue,
      lastValuationDate: data.lastValuationDate.present
          ? data.lastValuationDate.value
          : this.lastValuationDate,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssetEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('assetType: $assetType, ')
          ..write('estimatedValue: $estimatedValue, ')
          ..write('lastValuationDate: $lastValuationDate, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    assetType,
    estimatedValue,
    lastValuationDate,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssetEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.assetType == this.assetType &&
          other.estimatedValue == this.estimatedValue &&
          other.lastValuationDate == this.lastValuationDate &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AssetsTableCompanion extends UpdateCompanion<AssetEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> assetType;
  final Value<double> estimatedValue;
  final Value<DateTime> lastValuationDate;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AssetsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.assetType = const Value.absent(),
    this.estimatedValue = const Value.absent(),
    this.lastValuationDate = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssetsTableCompanion.insert({
    required String id,
    required String name,
    required String assetType,
    required double estimatedValue,
    this.lastValuationDate = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       assetType = Value(assetType),
       estimatedValue = Value(estimatedValue);
  static Insertable<AssetEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? assetType,
    Expression<double>? estimatedValue,
    Expression<DateTime>? lastValuationDate,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (assetType != null) 'asset_type': assetType,
      if (estimatedValue != null) 'estimated_value': estimatedValue,
      if (lastValuationDate != null) 'last_valuation_date': lastValuationDate,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssetsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? assetType,
    Value<double>? estimatedValue,
    Value<DateTime>? lastValuationDate,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AssetsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      assetType: assetType ?? this.assetType,
      estimatedValue: estimatedValue ?? this.estimatedValue,
      lastValuationDate: lastValuationDate ?? this.lastValuationDate,
      note: note ?? this.note,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (assetType.present) {
      map['asset_type'] = Variable<String>(assetType.value);
    }
    if (estimatedValue.present) {
      map['estimated_value'] = Variable<double>(estimatedValue.value);
    }
    if (lastValuationDate.present) {
      map['last_valuation_date'] = Variable<DateTime>(lastValuationDate.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
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
    return (StringBuffer('AssetsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('assetType: $assetType, ')
          ..write('estimatedValue: $estimatedValue, ')
          ..write('lastValuationDate: $lastValuationDate, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LiabilitiesTableTable extends LiabilitiesTable
    with TableInfo<$LiabilitiesTableTable, LiabilityEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LiabilitiesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetIdMeta = const VerificationMeta(
    'assetId',
  );
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
    'asset_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES assets (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _liabilityTypeMeta = const VerificationMeta(
    'liabilityType',
  );
  @override
  late final GeneratedColumn<String> liabilityType = GeneratedColumn<String>(
    'liability_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _initialPrincipalMeta = const VerificationMeta(
    'initialPrincipal',
  );
  @override
  late final GeneratedColumn<double> initialPrincipal = GeneratedColumn<double>(
    'initial_principal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentPrincipalMeta = const VerificationMeta(
    'currentPrincipal',
  );
  @override
  late final GeneratedColumn<double> currentPrincipal = GeneratedColumn<double>(
    'current_principal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _interestRateMeta = const VerificationMeta(
    'interestRate',
  );
  @override
  late final GeneratedColumn<double> interestRate = GeneratedColumn<double>(
    'interest_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthlyPaymentMeta = const VerificationMeta(
    'monthlyPayment',
  );
  @override
  late final GeneratedColumn<double> monthlyPayment = GeneratedColumn<double>(
    'monthly_payment',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remainingPaymentsMeta = const VerificationMeta(
    'remainingPayments',
  );
  @override
  late final GeneratedColumn<int> remainingPayments = GeneratedColumn<int>(
    'remaining_payments',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
    false,
    type: DriftSqlType.dateTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    assetId,
    name,
    liabilityType,
    initialPrincipal,
    currentPrincipal,
    interestRate,
    monthlyPayment,
    remainingPayments,
    startDate,
    endDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liabilities';
  @override
  VerificationContext validateIntegrity(
    Insertable<LiabilityEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(
        _assetIdMeta,
        assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('liability_type')) {
      context.handle(
        _liabilityTypeMeta,
        liabilityType.isAcceptableOrUnknown(
          data['liability_type']!,
          _liabilityTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_liabilityTypeMeta);
    }
    if (data.containsKey('initial_principal')) {
      context.handle(
        _initialPrincipalMeta,
        initialPrincipal.isAcceptableOrUnknown(
          data['initial_principal']!,
          _initialPrincipalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_initialPrincipalMeta);
    }
    if (data.containsKey('current_principal')) {
      context.handle(
        _currentPrincipalMeta,
        currentPrincipal.isAcceptableOrUnknown(
          data['current_principal']!,
          _currentPrincipalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentPrincipalMeta);
    }
    if (data.containsKey('interest_rate')) {
      context.handle(
        _interestRateMeta,
        interestRate.isAcceptableOrUnknown(
          data['interest_rate']!,
          _interestRateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_interestRateMeta);
    }
    if (data.containsKey('monthly_payment')) {
      context.handle(
        _monthlyPaymentMeta,
        monthlyPayment.isAcceptableOrUnknown(
          data['monthly_payment']!,
          _monthlyPaymentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monthlyPaymentMeta);
    }
    if (data.containsKey('remaining_payments')) {
      context.handle(
        _remainingPaymentsMeta,
        remainingPayments.isAcceptableOrUnknown(
          data['remaining_payments']!,
          _remainingPaymentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_remainingPaymentsMeta);
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
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LiabilityEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LiabilityEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      assetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      liabilityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}liability_type'],
      )!,
      initialPrincipal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}initial_principal'],
      )!,
      currentPrincipal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_principal'],
      )!,
      interestRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interest_rate'],
      )!,
      monthlyPayment: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monthly_payment'],
      )!,
      remainingPayments: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remaining_payments'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
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
  $LiabilitiesTableTable createAlias(String alias) {
    return $LiabilitiesTableTable(attachedDatabase, alias);
  }
}

class LiabilityEntry extends DataClass implements Insertable<LiabilityEntry> {
  final String id;
  final String? assetId;
  final String name;
  final String liabilityType;
  final double initialPrincipal;
  final double currentPrincipal;
  final double interestRate;
  final double monthlyPayment;
  final int remainingPayments;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LiabilityEntry({
    required this.id,
    this.assetId,
    required this.name,
    required this.liabilityType,
    required this.initialPrincipal,
    required this.currentPrincipal,
    required this.interestRate,
    required this.monthlyPayment,
    required this.remainingPayments,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || assetId != null) {
      map['asset_id'] = Variable<String>(assetId);
    }
    map['name'] = Variable<String>(name);
    map['liability_type'] = Variable<String>(liabilityType);
    map['initial_principal'] = Variable<double>(initialPrincipal);
    map['current_principal'] = Variable<double>(currentPrincipal);
    map['interest_rate'] = Variable<double>(interestRate);
    map['monthly_payment'] = Variable<double>(monthlyPayment);
    map['remaining_payments'] = Variable<int>(remainingPayments);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LiabilitiesTableCompanion toCompanion(bool nullToAbsent) {
    return LiabilitiesTableCompanion(
      id: Value(id),
      assetId: assetId == null && nullToAbsent
          ? const Value.absent()
          : Value(assetId),
      name: Value(name),
      liabilityType: Value(liabilityType),
      initialPrincipal: Value(initialPrincipal),
      currentPrincipal: Value(currentPrincipal),
      interestRate: Value(interestRate),
      monthlyPayment: Value(monthlyPayment),
      remainingPayments: Value(remainingPayments),
      startDate: Value(startDate),
      endDate: Value(endDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LiabilityEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LiabilityEntry(
      id: serializer.fromJson<String>(json['id']),
      assetId: serializer.fromJson<String?>(json['assetId']),
      name: serializer.fromJson<String>(json['name']),
      liabilityType: serializer.fromJson<String>(json['liabilityType']),
      initialPrincipal: serializer.fromJson<double>(json['initialPrincipal']),
      currentPrincipal: serializer.fromJson<double>(json['currentPrincipal']),
      interestRate: serializer.fromJson<double>(json['interestRate']),
      monthlyPayment: serializer.fromJson<double>(json['monthlyPayment']),
      remainingPayments: serializer.fromJson<int>(json['remainingPayments']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'assetId': serializer.toJson<String?>(assetId),
      'name': serializer.toJson<String>(name),
      'liabilityType': serializer.toJson<String>(liabilityType),
      'initialPrincipal': serializer.toJson<double>(initialPrincipal),
      'currentPrincipal': serializer.toJson<double>(currentPrincipal),
      'interestRate': serializer.toJson<double>(interestRate),
      'monthlyPayment': serializer.toJson<double>(monthlyPayment),
      'remainingPayments': serializer.toJson<int>(remainingPayments),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LiabilityEntry copyWith({
    String? id,
    Value<String?> assetId = const Value.absent(),
    String? name,
    String? liabilityType,
    double? initialPrincipal,
    double? currentPrincipal,
    double? interestRate,
    double? monthlyPayment,
    int? remainingPayments,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LiabilityEntry(
    id: id ?? this.id,
    assetId: assetId.present ? assetId.value : this.assetId,
    name: name ?? this.name,
    liabilityType: liabilityType ?? this.liabilityType,
    initialPrincipal: initialPrincipal ?? this.initialPrincipal,
    currentPrincipal: currentPrincipal ?? this.currentPrincipal,
    interestRate: interestRate ?? this.interestRate,
    monthlyPayment: monthlyPayment ?? this.monthlyPayment,
    remainingPayments: remainingPayments ?? this.remainingPayments,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LiabilityEntry copyWithCompanion(LiabilitiesTableCompanion data) {
    return LiabilityEntry(
      id: data.id.present ? data.id.value : this.id,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      name: data.name.present ? data.name.value : this.name,
      liabilityType: data.liabilityType.present
          ? data.liabilityType.value
          : this.liabilityType,
      initialPrincipal: data.initialPrincipal.present
          ? data.initialPrincipal.value
          : this.initialPrincipal,
      currentPrincipal: data.currentPrincipal.present
          ? data.currentPrincipal.value
          : this.currentPrincipal,
      interestRate: data.interestRate.present
          ? data.interestRate.value
          : this.interestRate,
      monthlyPayment: data.monthlyPayment.present
          ? data.monthlyPayment.value
          : this.monthlyPayment,
      remainingPayments: data.remainingPayments.present
          ? data.remainingPayments.value
          : this.remainingPayments,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LiabilityEntry(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('name: $name, ')
          ..write('liabilityType: $liabilityType, ')
          ..write('initialPrincipal: $initialPrincipal, ')
          ..write('currentPrincipal: $currentPrincipal, ')
          ..write('interestRate: $interestRate, ')
          ..write('monthlyPayment: $monthlyPayment, ')
          ..write('remainingPayments: $remainingPayments, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    assetId,
    name,
    liabilityType,
    initialPrincipal,
    currentPrincipal,
    interestRate,
    monthlyPayment,
    remainingPayments,
    startDate,
    endDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LiabilityEntry &&
          other.id == this.id &&
          other.assetId == this.assetId &&
          other.name == this.name &&
          other.liabilityType == this.liabilityType &&
          other.initialPrincipal == this.initialPrincipal &&
          other.currentPrincipal == this.currentPrincipal &&
          other.interestRate == this.interestRate &&
          other.monthlyPayment == this.monthlyPayment &&
          other.remainingPayments == this.remainingPayments &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LiabilitiesTableCompanion extends UpdateCompanion<LiabilityEntry> {
  final Value<String> id;
  final Value<String?> assetId;
  final Value<String> name;
  final Value<String> liabilityType;
  final Value<double> initialPrincipal;
  final Value<double> currentPrincipal;
  final Value<double> interestRate;
  final Value<double> monthlyPayment;
  final Value<int> remainingPayments;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LiabilitiesTableCompanion({
    this.id = const Value.absent(),
    this.assetId = const Value.absent(),
    this.name = const Value.absent(),
    this.liabilityType = const Value.absent(),
    this.initialPrincipal = const Value.absent(),
    this.currentPrincipal = const Value.absent(),
    this.interestRate = const Value.absent(),
    this.monthlyPayment = const Value.absent(),
    this.remainingPayments = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LiabilitiesTableCompanion.insert({
    required String id,
    this.assetId = const Value.absent(),
    required String name,
    required String liabilityType,
    required double initialPrincipal,
    required double currentPrincipal,
    required double interestRate,
    required double monthlyPayment,
    required int remainingPayments,
    required DateTime startDate,
    required DateTime endDate,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       liabilityType = Value(liabilityType),
       initialPrincipal = Value(initialPrincipal),
       currentPrincipal = Value(currentPrincipal),
       interestRate = Value(interestRate),
       monthlyPayment = Value(monthlyPayment),
       remainingPayments = Value(remainingPayments),
       startDate = Value(startDate),
       endDate = Value(endDate);
  static Insertable<LiabilityEntry> custom({
    Expression<String>? id,
    Expression<String>? assetId,
    Expression<String>? name,
    Expression<String>? liabilityType,
    Expression<double>? initialPrincipal,
    Expression<double>? currentPrincipal,
    Expression<double>? interestRate,
    Expression<double>? monthlyPayment,
    Expression<int>? remainingPayments,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assetId != null) 'asset_id': assetId,
      if (name != null) 'name': name,
      if (liabilityType != null) 'liability_type': liabilityType,
      if (initialPrincipal != null) 'initial_principal': initialPrincipal,
      if (currentPrincipal != null) 'current_principal': currentPrincipal,
      if (interestRate != null) 'interest_rate': interestRate,
      if (monthlyPayment != null) 'monthly_payment': monthlyPayment,
      if (remainingPayments != null) 'remaining_payments': remainingPayments,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LiabilitiesTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? assetId,
    Value<String>? name,
    Value<String>? liabilityType,
    Value<double>? initialPrincipal,
    Value<double>? currentPrincipal,
    Value<double>? interestRate,
    Value<double>? monthlyPayment,
    Value<int>? remainingPayments,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LiabilitiesTableCompanion(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      name: name ?? this.name,
      liabilityType: liabilityType ?? this.liabilityType,
      initialPrincipal: initialPrincipal ?? this.initialPrincipal,
      currentPrincipal: currentPrincipal ?? this.currentPrincipal,
      interestRate: interestRate ?? this.interestRate,
      monthlyPayment: monthlyPayment ?? this.monthlyPayment,
      remainingPayments: remainingPayments ?? this.remainingPayments,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
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
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (liabilityType.present) {
      map['liability_type'] = Variable<String>(liabilityType.value);
    }
    if (initialPrincipal.present) {
      map['initial_principal'] = Variable<double>(initialPrincipal.value);
    }
    if (currentPrincipal.present) {
      map['current_principal'] = Variable<double>(currentPrincipal.value);
    }
    if (interestRate.present) {
      map['interest_rate'] = Variable<double>(interestRate.value);
    }
    if (monthlyPayment.present) {
      map['monthly_payment'] = Variable<double>(monthlyPayment.value);
    }
    if (remainingPayments.present) {
      map['remaining_payments'] = Variable<int>(remainingPayments.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
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
    return (StringBuffer('LiabilitiesTableCompanion(')
          ..write('id: $id, ')
          ..write('assetId: $assetId, ')
          ..write('name: $name, ')
          ..write('liabilityType: $liabilityType, ')
          ..write('initialPrincipal: $initialPrincipal, ')
          ..write('currentPrincipal: $currentPrincipal, ')
          ..write('interestRate: $interestRate, ')
          ..write('monthlyPayment: $monthlyPayment, ')
          ..write('remainingPayments: $remainingPayments, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LoanSchedulesTableTable extends LoanSchedulesTable
    with TableInfo<$LoanSchedulesTableTable, LoanScheduleEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoanSchedulesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _liabilityIdMeta = const VerificationMeta(
    'liabilityId',
  );
  @override
  late final GeneratedColumn<String> liabilityId = GeneratedColumn<String>(
    'liability_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES liabilities (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _paymentNumberMeta = const VerificationMeta(
    'paymentNumber',
  );
  @override
  late final GeneratedColumn<int> paymentNumber = GeneratedColumn<int>(
    'payment_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentDateMeta = const VerificationMeta(
    'paymentDate',
  );
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
    'payment_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _principalComponentMeta =
      const VerificationMeta('principalComponent');
  @override
  late final GeneratedColumn<double> principalComponent =
      GeneratedColumn<double>(
        'principal_component',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _interestComponentMeta = const VerificationMeta(
    'interestComponent',
  );
  @override
  late final GeneratedColumn<double> interestComponent =
      GeneratedColumn<double>(
        'interest_component',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _remainingBalanceMeta = const VerificationMeta(
    'remainingBalance',
  );
  @override
  late final GeneratedColumn<double> remainingBalance = GeneratedColumn<double>(
    'remaining_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPaidMeta = const VerificationMeta('isPaid');
  @override
  late final GeneratedColumn<bool> isPaid = GeneratedColumn<bool>(
    'is_paid',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_paid" IN (0, 1))',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    liabilityId,
    paymentNumber,
    paymentDate,
    principalComponent,
    interestComponent,
    remainingBalance,
    isPaid,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loan_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<LoanScheduleEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('liability_id')) {
      context.handle(
        _liabilityIdMeta,
        liabilityId.isAcceptableOrUnknown(
          data['liability_id']!,
          _liabilityIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_liabilityIdMeta);
    }
    if (data.containsKey('payment_number')) {
      context.handle(
        _paymentNumberMeta,
        paymentNumber.isAcceptableOrUnknown(
          data['payment_number']!,
          _paymentNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentNumberMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
        _paymentDateMeta,
        paymentDate.isAcceptableOrUnknown(
          data['payment_date']!,
          _paymentDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('principal_component')) {
      context.handle(
        _principalComponentMeta,
        principalComponent.isAcceptableOrUnknown(
          data['principal_component']!,
          _principalComponentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_principalComponentMeta);
    }
    if (data.containsKey('interest_component')) {
      context.handle(
        _interestComponentMeta,
        interestComponent.isAcceptableOrUnknown(
          data['interest_component']!,
          _interestComponentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_interestComponentMeta);
    }
    if (data.containsKey('remaining_balance')) {
      context.handle(
        _remainingBalanceMeta,
        remainingBalance.isAcceptableOrUnknown(
          data['remaining_balance']!,
          _remainingBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_remainingBalanceMeta);
    }
    if (data.containsKey('is_paid')) {
      context.handle(
        _isPaidMeta,
        isPaid.isAcceptableOrUnknown(data['is_paid']!, _isPaidMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoanScheduleEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoanScheduleEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      liabilityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}liability_id'],
      )!,
      paymentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_number'],
      )!,
      paymentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}payment_date'],
      )!,
      principalComponent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}principal_component'],
      )!,
      interestComponent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interest_component'],
      )!,
      remainingBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}remaining_balance'],
      )!,
      isPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_paid'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LoanSchedulesTableTable createAlias(String alias) {
    return $LoanSchedulesTableTable(attachedDatabase, alias);
  }
}

class LoanScheduleEntry extends DataClass
    implements Insertable<LoanScheduleEntry> {
  final String id;
  final String liabilityId;
  final int paymentNumber;
  final DateTime paymentDate;
  final double principalComponent;
  final double interestComponent;
  final double remainingBalance;
  final bool isPaid;
  final DateTime createdAt;
  const LoanScheduleEntry({
    required this.id,
    required this.liabilityId,
    required this.paymentNumber,
    required this.paymentDate,
    required this.principalComponent,
    required this.interestComponent,
    required this.remainingBalance,
    required this.isPaid,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['liability_id'] = Variable<String>(liabilityId);
    map['payment_number'] = Variable<int>(paymentNumber);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    map['principal_component'] = Variable<double>(principalComponent);
    map['interest_component'] = Variable<double>(interestComponent);
    map['remaining_balance'] = Variable<double>(remainingBalance);
    map['is_paid'] = Variable<bool>(isPaid);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LoanSchedulesTableCompanion toCompanion(bool nullToAbsent) {
    return LoanSchedulesTableCompanion(
      id: Value(id),
      liabilityId: Value(liabilityId),
      paymentNumber: Value(paymentNumber),
      paymentDate: Value(paymentDate),
      principalComponent: Value(principalComponent),
      interestComponent: Value(interestComponent),
      remainingBalance: Value(remainingBalance),
      isPaid: Value(isPaid),
      createdAt: Value(createdAt),
    );
  }

  factory LoanScheduleEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoanScheduleEntry(
      id: serializer.fromJson<String>(json['id']),
      liabilityId: serializer.fromJson<String>(json['liabilityId']),
      paymentNumber: serializer.fromJson<int>(json['paymentNumber']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      principalComponent: serializer.fromJson<double>(
        json['principalComponent'],
      ),
      interestComponent: serializer.fromJson<double>(json['interestComponent']),
      remainingBalance: serializer.fromJson<double>(json['remainingBalance']),
      isPaid: serializer.fromJson<bool>(json['isPaid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'liabilityId': serializer.toJson<String>(liabilityId),
      'paymentNumber': serializer.toJson<int>(paymentNumber),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'principalComponent': serializer.toJson<double>(principalComponent),
      'interestComponent': serializer.toJson<double>(interestComponent),
      'remainingBalance': serializer.toJson<double>(remainingBalance),
      'isPaid': serializer.toJson<bool>(isPaid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LoanScheduleEntry copyWith({
    String? id,
    String? liabilityId,
    int? paymentNumber,
    DateTime? paymentDate,
    double? principalComponent,
    double? interestComponent,
    double? remainingBalance,
    bool? isPaid,
    DateTime? createdAt,
  }) => LoanScheduleEntry(
    id: id ?? this.id,
    liabilityId: liabilityId ?? this.liabilityId,
    paymentNumber: paymentNumber ?? this.paymentNumber,
    paymentDate: paymentDate ?? this.paymentDate,
    principalComponent: principalComponent ?? this.principalComponent,
    interestComponent: interestComponent ?? this.interestComponent,
    remainingBalance: remainingBalance ?? this.remainingBalance,
    isPaid: isPaid ?? this.isPaid,
    createdAt: createdAt ?? this.createdAt,
  );
  LoanScheduleEntry copyWithCompanion(LoanSchedulesTableCompanion data) {
    return LoanScheduleEntry(
      id: data.id.present ? data.id.value : this.id,
      liabilityId: data.liabilityId.present
          ? data.liabilityId.value
          : this.liabilityId,
      paymentNumber: data.paymentNumber.present
          ? data.paymentNumber.value
          : this.paymentNumber,
      paymentDate: data.paymentDate.present
          ? data.paymentDate.value
          : this.paymentDate,
      principalComponent: data.principalComponent.present
          ? data.principalComponent.value
          : this.principalComponent,
      interestComponent: data.interestComponent.present
          ? data.interestComponent.value
          : this.interestComponent,
      remainingBalance: data.remainingBalance.present
          ? data.remainingBalance.value
          : this.remainingBalance,
      isPaid: data.isPaid.present ? data.isPaid.value : this.isPaid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoanScheduleEntry(')
          ..write('id: $id, ')
          ..write('liabilityId: $liabilityId, ')
          ..write('paymentNumber: $paymentNumber, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('principalComponent: $principalComponent, ')
          ..write('interestComponent: $interestComponent, ')
          ..write('remainingBalance: $remainingBalance, ')
          ..write('isPaid: $isPaid, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    liabilityId,
    paymentNumber,
    paymentDate,
    principalComponent,
    interestComponent,
    remainingBalance,
    isPaid,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoanScheduleEntry &&
          other.id == this.id &&
          other.liabilityId == this.liabilityId &&
          other.paymentNumber == this.paymentNumber &&
          other.paymentDate == this.paymentDate &&
          other.principalComponent == this.principalComponent &&
          other.interestComponent == this.interestComponent &&
          other.remainingBalance == this.remainingBalance &&
          other.isPaid == this.isPaid &&
          other.createdAt == this.createdAt);
}

class LoanSchedulesTableCompanion extends UpdateCompanion<LoanScheduleEntry> {
  final Value<String> id;
  final Value<String> liabilityId;
  final Value<int> paymentNumber;
  final Value<DateTime> paymentDate;
  final Value<double> principalComponent;
  final Value<double> interestComponent;
  final Value<double> remainingBalance;
  final Value<bool> isPaid;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LoanSchedulesTableCompanion({
    this.id = const Value.absent(),
    this.liabilityId = const Value.absent(),
    this.paymentNumber = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.principalComponent = const Value.absent(),
    this.interestComponent = const Value.absent(),
    this.remainingBalance = const Value.absent(),
    this.isPaid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LoanSchedulesTableCompanion.insert({
    required String id,
    required String liabilityId,
    required int paymentNumber,
    required DateTime paymentDate,
    required double principalComponent,
    required double interestComponent,
    required double remainingBalance,
    this.isPaid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       liabilityId = Value(liabilityId),
       paymentNumber = Value(paymentNumber),
       paymentDate = Value(paymentDate),
       principalComponent = Value(principalComponent),
       interestComponent = Value(interestComponent),
       remainingBalance = Value(remainingBalance);
  static Insertable<LoanScheduleEntry> custom({
    Expression<String>? id,
    Expression<String>? liabilityId,
    Expression<int>? paymentNumber,
    Expression<DateTime>? paymentDate,
    Expression<double>? principalComponent,
    Expression<double>? interestComponent,
    Expression<double>? remainingBalance,
    Expression<bool>? isPaid,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (liabilityId != null) 'liability_id': liabilityId,
      if (paymentNumber != null) 'payment_number': paymentNumber,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (principalComponent != null) 'principal_component': principalComponent,
      if (interestComponent != null) 'interest_component': interestComponent,
      if (remainingBalance != null) 'remaining_balance': remainingBalance,
      if (isPaid != null) 'is_paid': isPaid,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LoanSchedulesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? liabilityId,
    Value<int>? paymentNumber,
    Value<DateTime>? paymentDate,
    Value<double>? principalComponent,
    Value<double>? interestComponent,
    Value<double>? remainingBalance,
    Value<bool>? isPaid,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LoanSchedulesTableCompanion(
      id: id ?? this.id,
      liabilityId: liabilityId ?? this.liabilityId,
      paymentNumber: paymentNumber ?? this.paymentNumber,
      paymentDate: paymentDate ?? this.paymentDate,
      principalComponent: principalComponent ?? this.principalComponent,
      interestComponent: interestComponent ?? this.interestComponent,
      remainingBalance: remainingBalance ?? this.remainingBalance,
      isPaid: isPaid ?? this.isPaid,
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
    if (liabilityId.present) {
      map['liability_id'] = Variable<String>(liabilityId.value);
    }
    if (paymentNumber.present) {
      map['payment_number'] = Variable<int>(paymentNumber.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (principalComponent.present) {
      map['principal_component'] = Variable<double>(principalComponent.value);
    }
    if (interestComponent.present) {
      map['interest_component'] = Variable<double>(interestComponent.value);
    }
    if (remainingBalance.present) {
      map['remaining_balance'] = Variable<double>(remainingBalance.value);
    }
    if (isPaid.present) {
      map['is_paid'] = Variable<bool>(isPaid.value);
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
    return (StringBuffer('LoanSchedulesTableCompanion(')
          ..write('id: $id, ')
          ..write('liabilityId: $liabilityId, ')
          ..write('paymentNumber: $paymentNumber, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('principalComponent: $principalComponent, ')
          ..write('interestComponent: $interestComponent, ')
          ..write('remainingBalance: $remainingBalance, ')
          ..write('isPaid: $isPaid, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExchangeRatesTableTable extends ExchangeRatesTable
    with TableInfo<$ExchangeRatesTableTable, ExchangeRateEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExchangeRatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseCurrencyMeta = const VerificationMeta(
    'baseCurrency',
  );
  @override
  late final GeneratedColumn<String> baseCurrency = GeneratedColumn<String>(
    'base_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetCurrencyMeta = const VerificationMeta(
    'targetCurrency',
  );
  @override
  late final GeneratedColumn<String> targetCurrency = GeneratedColumn<String>(
    'target_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ILS'),
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    baseCurrency,
    targetCurrency,
    rate,
    timestamp,
    source,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exchange_rates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExchangeRateEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('base_currency')) {
      context.handle(
        _baseCurrencyMeta,
        baseCurrency.isAcceptableOrUnknown(
          data['base_currency']!,
          _baseCurrencyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_baseCurrencyMeta);
    }
    if (data.containsKey('target_currency')) {
      context.handle(
        _targetCurrencyMeta,
        targetCurrency.isAcceptableOrUnknown(
          data['target_currency']!,
          _targetCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExchangeRateEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExchangeRateEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      baseCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency'],
      )!,
      targetCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_currency'],
      )!,
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExchangeRatesTableTable createAlias(String alias) {
    return $ExchangeRatesTableTable(attachedDatabase, alias);
  }
}

class ExchangeRateEntry extends DataClass
    implements Insertable<ExchangeRateEntry> {
  final String id;
  final String baseCurrency;
  final String targetCurrency;
  final double rate;
  final DateTime timestamp;
  final String source;
  final DateTime createdAt;
  const ExchangeRateEntry({
    required this.id,
    required this.baseCurrency,
    required this.targetCurrency,
    required this.rate,
    required this.timestamp,
    required this.source,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['base_currency'] = Variable<String>(baseCurrency);
    map['target_currency'] = Variable<String>(targetCurrency);
    map['rate'] = Variable<double>(rate);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExchangeRatesTableCompanion toCompanion(bool nullToAbsent) {
    return ExchangeRatesTableCompanion(
      id: Value(id),
      baseCurrency: Value(baseCurrency),
      targetCurrency: Value(targetCurrency),
      rate: Value(rate),
      timestamp: Value(timestamp),
      source: Value(source),
      createdAt: Value(createdAt),
    );
  }

  factory ExchangeRateEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExchangeRateEntry(
      id: serializer.fromJson<String>(json['id']),
      baseCurrency: serializer.fromJson<String>(json['baseCurrency']),
      targetCurrency: serializer.fromJson<String>(json['targetCurrency']),
      rate: serializer.fromJson<double>(json['rate']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'baseCurrency': serializer.toJson<String>(baseCurrency),
      'targetCurrency': serializer.toJson<String>(targetCurrency),
      'rate': serializer.toJson<double>(rate),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ExchangeRateEntry copyWith({
    String? id,
    String? baseCurrency,
    String? targetCurrency,
    double? rate,
    DateTime? timestamp,
    String? source,
    DateTime? createdAt,
  }) => ExchangeRateEntry(
    id: id ?? this.id,
    baseCurrency: baseCurrency ?? this.baseCurrency,
    targetCurrency: targetCurrency ?? this.targetCurrency,
    rate: rate ?? this.rate,
    timestamp: timestamp ?? this.timestamp,
    source: source ?? this.source,
    createdAt: createdAt ?? this.createdAt,
  );
  ExchangeRateEntry copyWithCompanion(ExchangeRatesTableCompanion data) {
    return ExchangeRateEntry(
      id: data.id.present ? data.id.value : this.id,
      baseCurrency: data.baseCurrency.present
          ? data.baseCurrency.value
          : this.baseCurrency,
      targetCurrency: data.targetCurrency.present
          ? data.targetCurrency.value
          : this.targetCurrency,
      rate: data.rate.present ? data.rate.value : this.rate,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRateEntry(')
          ..write('id: $id, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('targetCurrency: $targetCurrency, ')
          ..write('rate: $rate, ')
          ..write('timestamp: $timestamp, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    baseCurrency,
    targetCurrency,
    rate,
    timestamp,
    source,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExchangeRateEntry &&
          other.id == this.id &&
          other.baseCurrency == this.baseCurrency &&
          other.targetCurrency == this.targetCurrency &&
          other.rate == this.rate &&
          other.timestamp == this.timestamp &&
          other.source == this.source &&
          other.createdAt == this.createdAt);
}

class ExchangeRatesTableCompanion extends UpdateCompanion<ExchangeRateEntry> {
  final Value<String> id;
  final Value<String> baseCurrency;
  final Value<String> targetCurrency;
  final Value<double> rate;
  final Value<DateTime> timestamp;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ExchangeRatesTableCompanion({
    this.id = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.targetCurrency = const Value.absent(),
    this.rate = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExchangeRatesTableCompanion.insert({
    required String id,
    required String baseCurrency,
    this.targetCurrency = const Value.absent(),
    required double rate,
    this.timestamp = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       baseCurrency = Value(baseCurrency),
       rate = Value(rate);
  static Insertable<ExchangeRateEntry> custom({
    Expression<String>? id,
    Expression<String>? baseCurrency,
    Expression<String>? targetCurrency,
    Expression<double>? rate,
    Expression<DateTime>? timestamp,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (targetCurrency != null) 'target_currency': targetCurrency,
      if (rate != null) 'rate': rate,
      if (timestamp != null) 'timestamp': timestamp,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExchangeRatesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? baseCurrency,
    Value<String>? targetCurrency,
    Value<double>? rate,
    Value<DateTime>? timestamp,
    Value<String>? source,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ExchangeRatesTableCompanion(
      id: id ?? this.id,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      targetCurrency: targetCurrency ?? this.targetCurrency,
      rate: rate ?? this.rate,
      timestamp: timestamp ?? this.timestamp,
      source: source ?? this.source,
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
    if (baseCurrency.present) {
      map['base_currency'] = Variable<String>(baseCurrency.value);
    }
    if (targetCurrency.present) {
      map['target_currency'] = Variable<String>(targetCurrency.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
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
    return (StringBuffer('ExchangeRatesTableCompanion(')
          ..write('id: $id, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('targetCurrency: $targetCurrency, ')
          ..write('rate: $rate, ')
          ..write('timestamp: $timestamp, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PriceQuotesTableTable extends PriceQuotesTable
    with TableInfo<$PriceQuotesTableTable, PriceQuoteEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PriceQuotesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tickerMeta = const VerificationMeta('ticker');
  @override
  late final GeneratedColumn<String> ticker = GeneratedColumn<String>(
    'ticker',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changePercentMeta = const VerificationMeta(
    'changePercent',
  );
  @override
  late final GeneratedColumn<double> changePercent = GeneratedColumn<double>(
    'change_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('finnhub'),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ticker,
    price,
    changePercent,
    timestamp,
    source,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<PriceQuoteEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ticker')) {
      context.handle(
        _tickerMeta,
        ticker.isAcceptableOrUnknown(data['ticker']!, _tickerMeta),
      );
    } else if (isInserting) {
      context.missing(_tickerMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('change_percent')) {
      context.handle(
        _changePercentMeta,
        changePercent.isAcceptableOrUnknown(
          data['change_percent']!,
          _changePercentMeta,
        ),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PriceQuoteEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceQuoteEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ticker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ticker'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      changePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}change_percent'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PriceQuotesTableTable createAlias(String alias) {
    return $PriceQuotesTableTable(attachedDatabase, alias);
  }
}

class PriceQuoteEntry extends DataClass implements Insertable<PriceQuoteEntry> {
  final String id;
  final String ticker;
  final double price;
  final double changePercent;
  final DateTime timestamp;
  final String source;
  final DateTime createdAt;
  const PriceQuoteEntry({
    required this.id,
    required this.ticker,
    required this.price,
    required this.changePercent,
    required this.timestamp,
    required this.source,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ticker'] = Variable<String>(ticker);
    map['price'] = Variable<double>(price);
    map['change_percent'] = Variable<double>(changePercent);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PriceQuotesTableCompanion toCompanion(bool nullToAbsent) {
    return PriceQuotesTableCompanion(
      id: Value(id),
      ticker: Value(ticker),
      price: Value(price),
      changePercent: Value(changePercent),
      timestamp: Value(timestamp),
      source: Value(source),
      createdAt: Value(createdAt),
    );
  }

  factory PriceQuoteEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PriceQuoteEntry(
      id: serializer.fromJson<String>(json['id']),
      ticker: serializer.fromJson<String>(json['ticker']),
      price: serializer.fromJson<double>(json['price']),
      changePercent: serializer.fromJson<double>(json['changePercent']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ticker': serializer.toJson<String>(ticker),
      'price': serializer.toJson<double>(price),
      'changePercent': serializer.toJson<double>(changePercent),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PriceQuoteEntry copyWith({
    String? id,
    String? ticker,
    double? price,
    double? changePercent,
    DateTime? timestamp,
    String? source,
    DateTime? createdAt,
  }) => PriceQuoteEntry(
    id: id ?? this.id,
    ticker: ticker ?? this.ticker,
    price: price ?? this.price,
    changePercent: changePercent ?? this.changePercent,
    timestamp: timestamp ?? this.timestamp,
    source: source ?? this.source,
    createdAt: createdAt ?? this.createdAt,
  );
  PriceQuoteEntry copyWithCompanion(PriceQuotesTableCompanion data) {
    return PriceQuoteEntry(
      id: data.id.present ? data.id.value : this.id,
      ticker: data.ticker.present ? data.ticker.value : this.ticker,
      price: data.price.present ? data.price.value : this.price,
      changePercent: data.changePercent.present
          ? data.changePercent.value
          : this.changePercent,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PriceQuoteEntry(')
          ..write('id: $id, ')
          ..write('ticker: $ticker, ')
          ..write('price: $price, ')
          ..write('changePercent: $changePercent, ')
          ..write('timestamp: $timestamp, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ticker,
    price,
    changePercent,
    timestamp,
    source,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PriceQuoteEntry &&
          other.id == this.id &&
          other.ticker == this.ticker &&
          other.price == this.price &&
          other.changePercent == this.changePercent &&
          other.timestamp == this.timestamp &&
          other.source == this.source &&
          other.createdAt == this.createdAt);
}

class PriceQuotesTableCompanion extends UpdateCompanion<PriceQuoteEntry> {
  final Value<String> id;
  final Value<String> ticker;
  final Value<double> price;
  final Value<double> changePercent;
  final Value<DateTime> timestamp;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PriceQuotesTableCompanion({
    this.id = const Value.absent(),
    this.ticker = const Value.absent(),
    this.price = const Value.absent(),
    this.changePercent = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PriceQuotesTableCompanion.insert({
    required String id,
    required String ticker,
    required double price,
    this.changePercent = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ticker = Value(ticker),
       price = Value(price);
  static Insertable<PriceQuoteEntry> custom({
    Expression<String>? id,
    Expression<String>? ticker,
    Expression<double>? price,
    Expression<double>? changePercent,
    Expression<DateTime>? timestamp,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ticker != null) 'ticker': ticker,
      if (price != null) 'price': price,
      if (changePercent != null) 'change_percent': changePercent,
      if (timestamp != null) 'timestamp': timestamp,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PriceQuotesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? ticker,
    Value<double>? price,
    Value<double>? changePercent,
    Value<DateTime>? timestamp,
    Value<String>? source,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PriceQuotesTableCompanion(
      id: id ?? this.id,
      ticker: ticker ?? this.ticker,
      price: price ?? this.price,
      changePercent: changePercent ?? this.changePercent,
      timestamp: timestamp ?? this.timestamp,
      source: source ?? this.source,
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
    if (ticker.present) {
      map['ticker'] = Variable<String>(ticker.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (changePercent.present) {
      map['change_percent'] = Variable<double>(changePercent.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
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
    return (StringBuffer('PriceQuotesTableCompanion(')
          ..write('id: $id, ')
          ..write('ticker: $ticker, ')
          ..write('price: $price, ')
          ..write('changePercent: $changePercent, ')
          ..write('timestamp: $timestamp, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NetWorthSnapshotsTableTable extends NetWorthSnapshotsTable
    with TableInfo<$NetWorthSnapshotsTableTable, NetWorthSnapshotEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NetWorthSnapshotsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snapshotDateMeta = const VerificationMeta(
    'snapshotDate',
  );
  @override
  late final GeneratedColumn<DateTime> snapshotDate = GeneratedColumn<DateTime>(
    'snapshot_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalLiquidAssetsMeta = const VerificationMeta(
    'totalLiquidAssets',
  );
  @override
  late final GeneratedColumn<double> totalLiquidAssets =
      GeneratedColumn<double>(
        'total_liquid_assets',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _totalInvestmentsMeta = const VerificationMeta(
    'totalInvestments',
  );
  @override
  late final GeneratedColumn<double> totalInvestments = GeneratedColumn<double>(
    'total_investments',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPensionMeta = const VerificationMeta(
    'totalPension',
  );
  @override
  late final GeneratedColumn<double> totalPension = GeneratedColumn<double>(
    'total_pension',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalRealEstateMeta = const VerificationMeta(
    'totalRealEstate',
  );
  @override
  late final GeneratedColumn<double> totalRealEstate = GeneratedColumn<double>(
    'total_real_estate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalLiabilitiesMeta = const VerificationMeta(
    'totalLiabilities',
  );
  @override
  late final GeneratedColumn<double> totalLiabilities = GeneratedColumn<double>(
    'total_liabilities',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _netWorthMeta = const VerificationMeta(
    'netWorth',
  );
  @override
  late final GeneratedColumn<double> netWorth = GeneratedColumn<double>(
    'net_worth',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    snapshotDate,
    totalLiquidAssets,
    totalInvestments,
    totalPension,
    totalRealEstate,
    totalLiabilities,
    netWorth,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'net_worth_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<NetWorthSnapshotEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('snapshot_date')) {
      context.handle(
        _snapshotDateMeta,
        snapshotDate.isAcceptableOrUnknown(
          data['snapshot_date']!,
          _snapshotDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_snapshotDateMeta);
    }
    if (data.containsKey('total_liquid_assets')) {
      context.handle(
        _totalLiquidAssetsMeta,
        totalLiquidAssets.isAcceptableOrUnknown(
          data['total_liquid_assets']!,
          _totalLiquidAssetsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalLiquidAssetsMeta);
    }
    if (data.containsKey('total_investments')) {
      context.handle(
        _totalInvestmentsMeta,
        totalInvestments.isAcceptableOrUnknown(
          data['total_investments']!,
          _totalInvestmentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalInvestmentsMeta);
    }
    if (data.containsKey('total_pension')) {
      context.handle(
        _totalPensionMeta,
        totalPension.isAcceptableOrUnknown(
          data['total_pension']!,
          _totalPensionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalPensionMeta);
    }
    if (data.containsKey('total_real_estate')) {
      context.handle(
        _totalRealEstateMeta,
        totalRealEstate.isAcceptableOrUnknown(
          data['total_real_estate']!,
          _totalRealEstateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalRealEstateMeta);
    }
    if (data.containsKey('total_liabilities')) {
      context.handle(
        _totalLiabilitiesMeta,
        totalLiabilities.isAcceptableOrUnknown(
          data['total_liabilities']!,
          _totalLiabilitiesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalLiabilitiesMeta);
    }
    if (data.containsKey('net_worth')) {
      context.handle(
        _netWorthMeta,
        netWorth.isAcceptableOrUnknown(data['net_worth']!, _netWorthMeta),
      );
    } else if (isInserting) {
      context.missing(_netWorthMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NetWorthSnapshotEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NetWorthSnapshotEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      snapshotDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}snapshot_date'],
      )!,
      totalLiquidAssets: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_liquid_assets'],
      )!,
      totalInvestments: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_investments'],
      )!,
      totalPension: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_pension'],
      )!,
      totalRealEstate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_real_estate'],
      )!,
      totalLiabilities: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_liabilities'],
      )!,
      netWorth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_worth'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NetWorthSnapshotsTableTable createAlias(String alias) {
    return $NetWorthSnapshotsTableTable(attachedDatabase, alias);
  }
}

class NetWorthSnapshotEntry extends DataClass
    implements Insertable<NetWorthSnapshotEntry> {
  final String id;
  final DateTime snapshotDate;
  final double totalLiquidAssets;
  final double totalInvestments;
  final double totalPension;
  final double totalRealEstate;
  final double totalLiabilities;
  final double netWorth;
  final DateTime createdAt;
  const NetWorthSnapshotEntry({
    required this.id,
    required this.snapshotDate,
    required this.totalLiquidAssets,
    required this.totalInvestments,
    required this.totalPension,
    required this.totalRealEstate,
    required this.totalLiabilities,
    required this.netWorth,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['snapshot_date'] = Variable<DateTime>(snapshotDate);
    map['total_liquid_assets'] = Variable<double>(totalLiquidAssets);
    map['total_investments'] = Variable<double>(totalInvestments);
    map['total_pension'] = Variable<double>(totalPension);
    map['total_real_estate'] = Variable<double>(totalRealEstate);
    map['total_liabilities'] = Variable<double>(totalLiabilities);
    map['net_worth'] = Variable<double>(netWorth);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NetWorthSnapshotsTableCompanion toCompanion(bool nullToAbsent) {
    return NetWorthSnapshotsTableCompanion(
      id: Value(id),
      snapshotDate: Value(snapshotDate),
      totalLiquidAssets: Value(totalLiquidAssets),
      totalInvestments: Value(totalInvestments),
      totalPension: Value(totalPension),
      totalRealEstate: Value(totalRealEstate),
      totalLiabilities: Value(totalLiabilities),
      netWorth: Value(netWorth),
      createdAt: Value(createdAt),
    );
  }

  factory NetWorthSnapshotEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NetWorthSnapshotEntry(
      id: serializer.fromJson<String>(json['id']),
      snapshotDate: serializer.fromJson<DateTime>(json['snapshotDate']),
      totalLiquidAssets: serializer.fromJson<double>(json['totalLiquidAssets']),
      totalInvestments: serializer.fromJson<double>(json['totalInvestments']),
      totalPension: serializer.fromJson<double>(json['totalPension']),
      totalRealEstate: serializer.fromJson<double>(json['totalRealEstate']),
      totalLiabilities: serializer.fromJson<double>(json['totalLiabilities']),
      netWorth: serializer.fromJson<double>(json['netWorth']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'snapshotDate': serializer.toJson<DateTime>(snapshotDate),
      'totalLiquidAssets': serializer.toJson<double>(totalLiquidAssets),
      'totalInvestments': serializer.toJson<double>(totalInvestments),
      'totalPension': serializer.toJson<double>(totalPension),
      'totalRealEstate': serializer.toJson<double>(totalRealEstate),
      'totalLiabilities': serializer.toJson<double>(totalLiabilities),
      'netWorth': serializer.toJson<double>(netWorth),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  NetWorthSnapshotEntry copyWith({
    String? id,
    DateTime? snapshotDate,
    double? totalLiquidAssets,
    double? totalInvestments,
    double? totalPension,
    double? totalRealEstate,
    double? totalLiabilities,
    double? netWorth,
    DateTime? createdAt,
  }) => NetWorthSnapshotEntry(
    id: id ?? this.id,
    snapshotDate: snapshotDate ?? this.snapshotDate,
    totalLiquidAssets: totalLiquidAssets ?? this.totalLiquidAssets,
    totalInvestments: totalInvestments ?? this.totalInvestments,
    totalPension: totalPension ?? this.totalPension,
    totalRealEstate: totalRealEstate ?? this.totalRealEstate,
    totalLiabilities: totalLiabilities ?? this.totalLiabilities,
    netWorth: netWorth ?? this.netWorth,
    createdAt: createdAt ?? this.createdAt,
  );
  NetWorthSnapshotEntry copyWithCompanion(
    NetWorthSnapshotsTableCompanion data,
  ) {
    return NetWorthSnapshotEntry(
      id: data.id.present ? data.id.value : this.id,
      snapshotDate: data.snapshotDate.present
          ? data.snapshotDate.value
          : this.snapshotDate,
      totalLiquidAssets: data.totalLiquidAssets.present
          ? data.totalLiquidAssets.value
          : this.totalLiquidAssets,
      totalInvestments: data.totalInvestments.present
          ? data.totalInvestments.value
          : this.totalInvestments,
      totalPension: data.totalPension.present
          ? data.totalPension.value
          : this.totalPension,
      totalRealEstate: data.totalRealEstate.present
          ? data.totalRealEstate.value
          : this.totalRealEstate,
      totalLiabilities: data.totalLiabilities.present
          ? data.totalLiabilities.value
          : this.totalLiabilities,
      netWorth: data.netWorth.present ? data.netWorth.value : this.netWorth,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NetWorthSnapshotEntry(')
          ..write('id: $id, ')
          ..write('snapshotDate: $snapshotDate, ')
          ..write('totalLiquidAssets: $totalLiquidAssets, ')
          ..write('totalInvestments: $totalInvestments, ')
          ..write('totalPension: $totalPension, ')
          ..write('totalRealEstate: $totalRealEstate, ')
          ..write('totalLiabilities: $totalLiabilities, ')
          ..write('netWorth: $netWorth, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    snapshotDate,
    totalLiquidAssets,
    totalInvestments,
    totalPension,
    totalRealEstate,
    totalLiabilities,
    netWorth,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NetWorthSnapshotEntry &&
          other.id == this.id &&
          other.snapshotDate == this.snapshotDate &&
          other.totalLiquidAssets == this.totalLiquidAssets &&
          other.totalInvestments == this.totalInvestments &&
          other.totalPension == this.totalPension &&
          other.totalRealEstate == this.totalRealEstate &&
          other.totalLiabilities == this.totalLiabilities &&
          other.netWorth == this.netWorth &&
          other.createdAt == this.createdAt);
}

class NetWorthSnapshotsTableCompanion
    extends UpdateCompanion<NetWorthSnapshotEntry> {
  final Value<String> id;
  final Value<DateTime> snapshotDate;
  final Value<double> totalLiquidAssets;
  final Value<double> totalInvestments;
  final Value<double> totalPension;
  final Value<double> totalRealEstate;
  final Value<double> totalLiabilities;
  final Value<double> netWorth;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NetWorthSnapshotsTableCompanion({
    this.id = const Value.absent(),
    this.snapshotDate = const Value.absent(),
    this.totalLiquidAssets = const Value.absent(),
    this.totalInvestments = const Value.absent(),
    this.totalPension = const Value.absent(),
    this.totalRealEstate = const Value.absent(),
    this.totalLiabilities = const Value.absent(),
    this.netWorth = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NetWorthSnapshotsTableCompanion.insert({
    required String id,
    required DateTime snapshotDate,
    required double totalLiquidAssets,
    required double totalInvestments,
    required double totalPension,
    required double totalRealEstate,
    required double totalLiabilities,
    required double netWorth,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       snapshotDate = Value(snapshotDate),
       totalLiquidAssets = Value(totalLiquidAssets),
       totalInvestments = Value(totalInvestments),
       totalPension = Value(totalPension),
       totalRealEstate = Value(totalRealEstate),
       totalLiabilities = Value(totalLiabilities),
       netWorth = Value(netWorth);
  static Insertable<NetWorthSnapshotEntry> custom({
    Expression<String>? id,
    Expression<DateTime>? snapshotDate,
    Expression<double>? totalLiquidAssets,
    Expression<double>? totalInvestments,
    Expression<double>? totalPension,
    Expression<double>? totalRealEstate,
    Expression<double>? totalLiabilities,
    Expression<double>? netWorth,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (snapshotDate != null) 'snapshot_date': snapshotDate,
      if (totalLiquidAssets != null) 'total_liquid_assets': totalLiquidAssets,
      if (totalInvestments != null) 'total_investments': totalInvestments,
      if (totalPension != null) 'total_pension': totalPension,
      if (totalRealEstate != null) 'total_real_estate': totalRealEstate,
      if (totalLiabilities != null) 'total_liabilities': totalLiabilities,
      if (netWorth != null) 'net_worth': netWorth,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NetWorthSnapshotsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? snapshotDate,
    Value<double>? totalLiquidAssets,
    Value<double>? totalInvestments,
    Value<double>? totalPension,
    Value<double>? totalRealEstate,
    Value<double>? totalLiabilities,
    Value<double>? netWorth,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NetWorthSnapshotsTableCompanion(
      id: id ?? this.id,
      snapshotDate: snapshotDate ?? this.snapshotDate,
      totalLiquidAssets: totalLiquidAssets ?? this.totalLiquidAssets,
      totalInvestments: totalInvestments ?? this.totalInvestments,
      totalPension: totalPension ?? this.totalPension,
      totalRealEstate: totalRealEstate ?? this.totalRealEstate,
      totalLiabilities: totalLiabilities ?? this.totalLiabilities,
      netWorth: netWorth ?? this.netWorth,
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
    if (snapshotDate.present) {
      map['snapshot_date'] = Variable<DateTime>(snapshotDate.value);
    }
    if (totalLiquidAssets.present) {
      map['total_liquid_assets'] = Variable<double>(totalLiquidAssets.value);
    }
    if (totalInvestments.present) {
      map['total_investments'] = Variable<double>(totalInvestments.value);
    }
    if (totalPension.present) {
      map['total_pension'] = Variable<double>(totalPension.value);
    }
    if (totalRealEstate.present) {
      map['total_real_estate'] = Variable<double>(totalRealEstate.value);
    }
    if (totalLiabilities.present) {
      map['total_liabilities'] = Variable<double>(totalLiabilities.value);
    }
    if (netWorth.present) {
      map['net_worth'] = Variable<double>(netWorth.value);
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
    return (StringBuffer('NetWorthSnapshotsTableCompanion(')
          ..write('id: $id, ')
          ..write('snapshotDate: $snapshotDate, ')
          ..write('totalLiquidAssets: $totalLiquidAssets, ')
          ..write('totalInvestments: $totalInvestments, ')
          ..write('totalPension: $totalPension, ')
          ..write('totalRealEstate: $totalRealEstate, ')
          ..write('totalLiabilities: $totalLiabilities, ')
          ..write('netWorth: $netWorth, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTableTable extends AppSettingsTable
    with TableInfo<$AppSettingsTableTable, AppSettingEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseCurrencyMeta = const VerificationMeta(
    'baseCurrency',
  );
  @override
  late final GeneratedColumn<String> baseCurrency = GeneratedColumn<String>(
    'base_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ILS'),
  );
  static const VerificationMeta _isBiometricEnabledMeta =
      const VerificationMeta('isBiometricEnabled');
  @override
  late final GeneratedColumn<bool> isBiometricEnabled = GeneratedColumn<bool>(
    'is_biometric_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_biometric_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _autoLockTimeoutSecondsMeta =
      const VerificationMeta('autoLockTimeoutSeconds');
  @override
  late final GeneratedColumn<int> autoLockTimeoutSeconds = GeneratedColumn<int>(
    'auto_lock_timeout_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(300),
  );
  static const VerificationMeta _lastBackupDateMeta = const VerificationMeta(
    'lastBackupDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastBackupDate =
      GeneratedColumn<DateTime>(
        'last_backup_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isAutoBackupEnabledMeta =
      const VerificationMeta('isAutoBackupEnabled');
  @override
  late final GeneratedColumn<bool> isAutoBackupEnabled = GeneratedColumn<bool>(
    'is_auto_backup_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_auto_backup_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _backupFrequencyMeta = const VerificationMeta(
    'backupFrequency',
  );
  @override
  late final GeneratedColumn<String> backupFrequency = GeneratedColumn<String>(
    'backup_frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('weekly'),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('light'),
  );
  static const VerificationMeta _customSettingsJsonMeta =
      const VerificationMeta('customSettingsJson');
  @override
  late final GeneratedColumn<String> customSettingsJson =
      GeneratedColumn<String>(
        'custom_settings_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    baseCurrency,
    isBiometricEnabled,
    autoLockTimeoutSeconds,
    lastBackupDate,
    isAutoBackupEnabled,
    backupFrequency,
    themeMode,
    customSettingsJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('base_currency')) {
      context.handle(
        _baseCurrencyMeta,
        baseCurrency.isAcceptableOrUnknown(
          data['base_currency']!,
          _baseCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('is_biometric_enabled')) {
      context.handle(
        _isBiometricEnabledMeta,
        isBiometricEnabled.isAcceptableOrUnknown(
          data['is_biometric_enabled']!,
          _isBiometricEnabledMeta,
        ),
      );
    }
    if (data.containsKey('auto_lock_timeout_seconds')) {
      context.handle(
        _autoLockTimeoutSecondsMeta,
        autoLockTimeoutSeconds.isAcceptableOrUnknown(
          data['auto_lock_timeout_seconds']!,
          _autoLockTimeoutSecondsMeta,
        ),
      );
    }
    if (data.containsKey('last_backup_date')) {
      context.handle(
        _lastBackupDateMeta,
        lastBackupDate.isAcceptableOrUnknown(
          data['last_backup_date']!,
          _lastBackupDateMeta,
        ),
      );
    }
    if (data.containsKey('is_auto_backup_enabled')) {
      context.handle(
        _isAutoBackupEnabledMeta,
        isAutoBackupEnabled.isAcceptableOrUnknown(
          data['is_auto_backup_enabled']!,
          _isAutoBackupEnabledMeta,
        ),
      );
    }
    if (data.containsKey('backup_frequency')) {
      context.handle(
        _backupFrequencyMeta,
        backupFrequency.isAcceptableOrUnknown(
          data['backup_frequency']!,
          _backupFrequencyMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('custom_settings_json')) {
      context.handle(
        _customSettingsJsonMeta,
        customSettingsJson.isAcceptableOrUnknown(
          data['custom_settings_json']!,
          _customSettingsJsonMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      baseCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency'],
      )!,
      isBiometricEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_biometric_enabled'],
      )!,
      autoLockTimeoutSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_lock_timeout_seconds'],
      )!,
      lastBackupDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup_date'],
      ),
      isAutoBackupEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_auto_backup_enabled'],
      )!,
      backupFrequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backup_frequency'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      customSettingsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_settings_json'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTableTable createAlias(String alias) {
    return $AppSettingsTableTable(attachedDatabase, alias);
  }
}

class AppSettingEntry extends DataClass implements Insertable<AppSettingEntry> {
  final String id;
  final String baseCurrency;
  final bool isBiometricEnabled;
  final int autoLockTimeoutSeconds;
  final DateTime? lastBackupDate;
  final bool isAutoBackupEnabled;
  final String backupFrequency;
  final String themeMode;
  final String? customSettingsJson;
  final DateTime updatedAt;
  const AppSettingEntry({
    required this.id,
    required this.baseCurrency,
    required this.isBiometricEnabled,
    required this.autoLockTimeoutSeconds,
    this.lastBackupDate,
    required this.isAutoBackupEnabled,
    required this.backupFrequency,
    required this.themeMode,
    this.customSettingsJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['base_currency'] = Variable<String>(baseCurrency);
    map['is_biometric_enabled'] = Variable<bool>(isBiometricEnabled);
    map['auto_lock_timeout_seconds'] = Variable<int>(autoLockTimeoutSeconds);
    if (!nullToAbsent || lastBackupDate != null) {
      map['last_backup_date'] = Variable<DateTime>(lastBackupDate);
    }
    map['is_auto_backup_enabled'] = Variable<bool>(isAutoBackupEnabled);
    map['backup_frequency'] = Variable<String>(backupFrequency);
    map['theme_mode'] = Variable<String>(themeMode);
    if (!nullToAbsent || customSettingsJson != null) {
      map['custom_settings_json'] = Variable<String>(customSettingsJson);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTableCompanion(
      id: Value(id),
      baseCurrency: Value(baseCurrency),
      isBiometricEnabled: Value(isBiometricEnabled),
      autoLockTimeoutSeconds: Value(autoLockTimeoutSeconds),
      lastBackupDate: lastBackupDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupDate),
      isAutoBackupEnabled: Value(isAutoBackupEnabled),
      backupFrequency: Value(backupFrequency),
      themeMode: Value(themeMode),
      customSettingsJson: customSettingsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(customSettingsJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSettingEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingEntry(
      id: serializer.fromJson<String>(json['id']),
      baseCurrency: serializer.fromJson<String>(json['baseCurrency']),
      isBiometricEnabled: serializer.fromJson<bool>(json['isBiometricEnabled']),
      autoLockTimeoutSeconds: serializer.fromJson<int>(
        json['autoLockTimeoutSeconds'],
      ),
      lastBackupDate: serializer.fromJson<DateTime?>(json['lastBackupDate']),
      isAutoBackupEnabled: serializer.fromJson<bool>(
        json['isAutoBackupEnabled'],
      ),
      backupFrequency: serializer.fromJson<String>(json['backupFrequency']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      customSettingsJson: serializer.fromJson<String?>(
        json['customSettingsJson'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'baseCurrency': serializer.toJson<String>(baseCurrency),
      'isBiometricEnabled': serializer.toJson<bool>(isBiometricEnabled),
      'autoLockTimeoutSeconds': serializer.toJson<int>(autoLockTimeoutSeconds),
      'lastBackupDate': serializer.toJson<DateTime?>(lastBackupDate),
      'isAutoBackupEnabled': serializer.toJson<bool>(isAutoBackupEnabled),
      'backupFrequency': serializer.toJson<String>(backupFrequency),
      'themeMode': serializer.toJson<String>(themeMode),
      'customSettingsJson': serializer.toJson<String?>(customSettingsJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSettingEntry copyWith({
    String? id,
    String? baseCurrency,
    bool? isBiometricEnabled,
    int? autoLockTimeoutSeconds,
    Value<DateTime?> lastBackupDate = const Value.absent(),
    bool? isAutoBackupEnabled,
    String? backupFrequency,
    String? themeMode,
    Value<String?> customSettingsJson = const Value.absent(),
    DateTime? updatedAt,
  }) => AppSettingEntry(
    id: id ?? this.id,
    baseCurrency: baseCurrency ?? this.baseCurrency,
    isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
    autoLockTimeoutSeconds:
        autoLockTimeoutSeconds ?? this.autoLockTimeoutSeconds,
    lastBackupDate: lastBackupDate.present
        ? lastBackupDate.value
        : this.lastBackupDate,
    isAutoBackupEnabled: isAutoBackupEnabled ?? this.isAutoBackupEnabled,
    backupFrequency: backupFrequency ?? this.backupFrequency,
    themeMode: themeMode ?? this.themeMode,
    customSettingsJson: customSettingsJson.present
        ? customSettingsJson.value
        : this.customSettingsJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppSettingEntry copyWithCompanion(AppSettingsTableCompanion data) {
    return AppSettingEntry(
      id: data.id.present ? data.id.value : this.id,
      baseCurrency: data.baseCurrency.present
          ? data.baseCurrency.value
          : this.baseCurrency,
      isBiometricEnabled: data.isBiometricEnabled.present
          ? data.isBiometricEnabled.value
          : this.isBiometricEnabled,
      autoLockTimeoutSeconds: data.autoLockTimeoutSeconds.present
          ? data.autoLockTimeoutSeconds.value
          : this.autoLockTimeoutSeconds,
      lastBackupDate: data.lastBackupDate.present
          ? data.lastBackupDate.value
          : this.lastBackupDate,
      isAutoBackupEnabled: data.isAutoBackupEnabled.present
          ? data.isAutoBackupEnabled.value
          : this.isAutoBackupEnabled,
      backupFrequency: data.backupFrequency.present
          ? data.backupFrequency.value
          : this.backupFrequency,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      customSettingsJson: data.customSettingsJson.present
          ? data.customSettingsJson.value
          : this.customSettingsJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingEntry(')
          ..write('id: $id, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('isBiometricEnabled: $isBiometricEnabled, ')
          ..write('autoLockTimeoutSeconds: $autoLockTimeoutSeconds, ')
          ..write('lastBackupDate: $lastBackupDate, ')
          ..write('isAutoBackupEnabled: $isAutoBackupEnabled, ')
          ..write('backupFrequency: $backupFrequency, ')
          ..write('themeMode: $themeMode, ')
          ..write('customSettingsJson: $customSettingsJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    baseCurrency,
    isBiometricEnabled,
    autoLockTimeoutSeconds,
    lastBackupDate,
    isAutoBackupEnabled,
    backupFrequency,
    themeMode,
    customSettingsJson,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingEntry &&
          other.id == this.id &&
          other.baseCurrency == this.baseCurrency &&
          other.isBiometricEnabled == this.isBiometricEnabled &&
          other.autoLockTimeoutSeconds == this.autoLockTimeoutSeconds &&
          other.lastBackupDate == this.lastBackupDate &&
          other.isAutoBackupEnabled == this.isAutoBackupEnabled &&
          other.backupFrequency == this.backupFrequency &&
          other.themeMode == this.themeMode &&
          other.customSettingsJson == this.customSettingsJson &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsTableCompanion extends UpdateCompanion<AppSettingEntry> {
  final Value<String> id;
  final Value<String> baseCurrency;
  final Value<bool> isBiometricEnabled;
  final Value<int> autoLockTimeoutSeconds;
  final Value<DateTime?> lastBackupDate;
  final Value<bool> isAutoBackupEnabled;
  final Value<String> backupFrequency;
  final Value<String> themeMode;
  final Value<String?> customSettingsJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsTableCompanion({
    this.id = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.isBiometricEnabled = const Value.absent(),
    this.autoLockTimeoutSeconds = const Value.absent(),
    this.lastBackupDate = const Value.absent(),
    this.isAutoBackupEnabled = const Value.absent(),
    this.backupFrequency = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.customSettingsJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsTableCompanion.insert({
    required String id,
    this.baseCurrency = const Value.absent(),
    this.isBiometricEnabled = const Value.absent(),
    this.autoLockTimeoutSeconds = const Value.absent(),
    this.lastBackupDate = const Value.absent(),
    this.isAutoBackupEnabled = const Value.absent(),
    this.backupFrequency = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.customSettingsJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<AppSettingEntry> custom({
    Expression<String>? id,
    Expression<String>? baseCurrency,
    Expression<bool>? isBiometricEnabled,
    Expression<int>? autoLockTimeoutSeconds,
    Expression<DateTime>? lastBackupDate,
    Expression<bool>? isAutoBackupEnabled,
    Expression<String>? backupFrequency,
    Expression<String>? themeMode,
    Expression<String>? customSettingsJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (isBiometricEnabled != null)
        'is_biometric_enabled': isBiometricEnabled,
      if (autoLockTimeoutSeconds != null)
        'auto_lock_timeout_seconds': autoLockTimeoutSeconds,
      if (lastBackupDate != null) 'last_backup_date': lastBackupDate,
      if (isAutoBackupEnabled != null)
        'is_auto_backup_enabled': isAutoBackupEnabled,
      if (backupFrequency != null) 'backup_frequency': backupFrequency,
      if (themeMode != null) 'theme_mode': themeMode,
      if (customSettingsJson != null)
        'custom_settings_json': customSettingsJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? baseCurrency,
    Value<bool>? isBiometricEnabled,
    Value<int>? autoLockTimeoutSeconds,
    Value<DateTime?>? lastBackupDate,
    Value<bool>? isAutoBackupEnabled,
    Value<String>? backupFrequency,
    Value<String>? themeMode,
    Value<String?>? customSettingsJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsTableCompanion(
      id: id ?? this.id,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      autoLockTimeoutSeconds:
          autoLockTimeoutSeconds ?? this.autoLockTimeoutSeconds,
      lastBackupDate: lastBackupDate ?? this.lastBackupDate,
      isAutoBackupEnabled: isAutoBackupEnabled ?? this.isAutoBackupEnabled,
      backupFrequency: backupFrequency ?? this.backupFrequency,
      themeMode: themeMode ?? this.themeMode,
      customSettingsJson: customSettingsJson ?? this.customSettingsJson,
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
    if (baseCurrency.present) {
      map['base_currency'] = Variable<String>(baseCurrency.value);
    }
    if (isBiometricEnabled.present) {
      map['is_biometric_enabled'] = Variable<bool>(isBiometricEnabled.value);
    }
    if (autoLockTimeoutSeconds.present) {
      map['auto_lock_timeout_seconds'] = Variable<int>(
        autoLockTimeoutSeconds.value,
      );
    }
    if (lastBackupDate.present) {
      map['last_backup_date'] = Variable<DateTime>(lastBackupDate.value);
    }
    if (isAutoBackupEnabled.present) {
      map['is_auto_backup_enabled'] = Variable<bool>(isAutoBackupEnabled.value);
    }
    if (backupFrequency.present) {
      map['backup_frequency'] = Variable<String>(backupFrequency.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (customSettingsJson.present) {
      map['custom_settings_json'] = Variable<String>(customSettingsJson.value);
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
    return (StringBuffer('AppSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('isBiometricEnabled: $isBiometricEnabled, ')
          ..write('autoLockTimeoutSeconds: $autoLockTimeoutSeconds, ')
          ..write('lastBackupDate: $lastBackupDate, ')
          ..write('isAutoBackupEnabled: $isAutoBackupEnabled, ')
          ..write('backupFrequency: $backupFrequency, ')
          ..write('themeMode: $themeMode, ')
          ..write('customSettingsJson: $customSettingsJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountsTableTable accountsTable = $AccountsTableTable(this);
  late final $CategoriesTableTable categoriesTable = $CategoriesTableTable(
    this,
  );
  late final $TagsTableTable tagsTable = $TagsTableTable(this);
  late final $MerchantsTableTable merchantsTable = $MerchantsTableTable(this);
  late final $TransactionsTableTable transactionsTable =
      $TransactionsTableTable(this);
  late final $TransactionSplitsTableTable transactionSplitsTable =
      $TransactionSplitsTableTable(this);
  late final $InstallmentPlansTableTable installmentPlansTable =
      $InstallmentPlansTableTable(this);
  late final $InstallmentItemsTableTable installmentItemsTable =
      $InstallmentItemsTableTable(this);
  late final $RecurringRulesTableTable recurringRulesTable =
      $RecurringRulesTableTable(this);
  late final $TransferLinksTableTable transferLinksTable =
      $TransferLinksTableTable(this);
  late final $BudgetsTableTable budgetsTable = $BudgetsTableTable(this);
  late final $BudgetPeriodsTableTable budgetPeriodsTable =
      $BudgetPeriodsTableTable(this);
  late final $ImportBatchesTableTable importBatchesTable =
      $ImportBatchesTableTable(this);
  late final $ImportMappingsTableTable importMappingsTable =
      $ImportMappingsTableTable(this);
  late final $SecuritiesTableTable securitiesTable = $SecuritiesTableTable(
    this,
  );
  late final $HoldingsTableTable holdingsTable = $HoldingsTableTable(this);
  late final $InvestmentTransactionsTableTable investmentTransactionsTable =
      $InvestmentTransactionsTableTable(this);
  late final $PensionAssetsTableTable pensionAssetsTable =
      $PensionAssetsTableTable(this);
  late final $PensionSnapshotsTableTable pensionSnapshotsTable =
      $PensionSnapshotsTableTable(this);
  late final $AssetsTableTable assetsTable = $AssetsTableTable(this);
  late final $LiabilitiesTableTable liabilitiesTable = $LiabilitiesTableTable(
    this,
  );
  late final $LoanSchedulesTableTable loanSchedulesTable =
      $LoanSchedulesTableTable(this);
  late final $ExchangeRatesTableTable exchangeRatesTable =
      $ExchangeRatesTableTable(this);
  late final $PriceQuotesTableTable priceQuotesTable = $PriceQuotesTableTable(
    this,
  );
  late final $NetWorthSnapshotsTableTable netWorthSnapshotsTable =
      $NetWorthSnapshotsTableTable(this);
  late final $AppSettingsTableTable appSettingsTable = $AppSettingsTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accountsTable,
    categoriesTable,
    tagsTable,
    merchantsTable,
    transactionsTable,
    transactionSplitsTable,
    installmentPlansTable,
    installmentItemsTable,
    recurringRulesTable,
    transferLinksTable,
    budgetsTable,
    budgetPeriodsTable,
    importBatchesTable,
    importMappingsTable,
    securitiesTable,
    holdingsTable,
    investmentTransactionsTable,
    pensionAssetsTable,
    pensionSnapshotsTable,
    assetsTable,
    liabilitiesTable,
    loanSchedulesTable,
    exchangeRatesTable,
    priceQuotesTable,
    netWorthSnapshotsTable,
    appSettingsTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'merchants',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'transactions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transaction_splits', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installment_plans', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installment_plans', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'merchants',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installment_plans', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installment_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installment_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_rules', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_rules', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'merchants',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurring_rules', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transfer_links', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transfer_links', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('budgets', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'budgets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('budget_periods', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'securities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('holdings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'securities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('investment_transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'holdings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('investment_transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pension_assets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pension_snapshots', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'assets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('liabilities', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'liabilities',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('loan_schedules', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$AccountsTableTableCreateCompanionBuilder =
    AccountsTableCompanion Function({
      required String id,
      required String name,
      required String type,
      Value<String> currency,
      Value<double> initialBalance,
      Value<double> currentBalance,
      Value<String?> linkedAccountId,
      Value<int?> billingDayOfMonth,
      Value<int> colorValue,
      Value<String> iconName,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AccountsTableTableUpdateCompanionBuilder =
    AccountsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<String> currency,
      Value<double> initialBalance,
      Value<double> currentBalance,
      Value<String?> linkedAccountId,
      Value<int?> billingDayOfMonth,
      Value<int> colorValue,
      Value<String> iconName,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$AccountsTableTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTableTable, AccountEntry> {
  $$AccountsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTableTable _linkedAccountIdTable(_$AppDatabase db) =>
      db.accountsTable.createAlias(
        $_aliasNameGenerator(
          db.accountsTable.linkedAccountId,
          db.accountsTable.id,
        ),
      );

  $$AccountsTableTableProcessedTableManager? get linkedAccountId {
    final $_column = $_itemColumn<String>('linked_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableTableManager(
      $_db,
      $_db.accountsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_linkedAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransactionsTableTable, List<TransactionEntry>>
  _transactionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionsTable,
        aliasName: $_aliasNameGenerator(
          db.accountsTable.id,
          db.transactionsTable.accountId,
        ),
      );

  $$TransactionsTableTableProcessedTableManager get transactionsTableRefs {
    final manager = $$TransactionsTableTableTableManager(
      $_db,
      $_db.transactionsTable,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallmentPlansTableTable,
    List<InstallmentPlanEntry>
  >
  _installmentPlansTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.installmentPlansTable,
        aliasName: $_aliasNameGenerator(
          db.accountsTable.id,
          db.installmentPlansTable.accountId,
        ),
      );

  $$InstallmentPlansTableTableProcessedTableManager
  get installmentPlansTableRefs {
    final manager = $$InstallmentPlansTableTableTableManager(
      $_db,
      $_db.installmentPlansTable,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installmentPlansTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RecurringRulesTableTable,
    List<RecurringRuleEntry>
  >
  _recurringRulesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurringRulesTable,
        aliasName: $_aliasNameGenerator(
          db.accountsTable.id,
          db.recurringRulesTable.accountId,
        ),
      );

  $$RecurringRulesTableTableProcessedTableManager get recurringRulesTableRefs {
    final manager = $$RecurringRulesTableTableTableManager(
      $_db,
      $_db.recurringRulesTable,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringRulesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TransferLinksTableTable, List<TransferLinkEntry>>
  _sourceTransferLinksTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transferLinksTable,
    aliasName: $_aliasNameGenerator(
      db.accountsTable.id,
      db.transferLinksTable.sourceAccountId,
    ),
  );

  $$TransferLinksTableTableProcessedTableManager get sourceTransferLinks {
    final manager =
        $$TransferLinksTableTableTableManager(
          $_db,
          $_db.transferLinksTable,
        ).filter(
          (f) => f.sourceAccountId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _sourceTransferLinksTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TransferLinksTableTable, List<TransferLinkEntry>>
  _destinationTransferLinksTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transferLinksTable,
        aliasName: $_aliasNameGenerator(
          db.accountsTable.id,
          db.transferLinksTable.destinationAccountId,
        ),
      );

  $$TransferLinksTableTableProcessedTableManager get destinationTransferLinks {
    final manager =
        $$TransferLinksTableTableTableManager(
          $_db,
          $_db.transferLinksTable,
        ).filter(
          (f) =>
              f.destinationAccountId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _destinationTransferLinksTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTableTable> {
  $$AccountsTableTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get initialBalance => $composableBuilder(
    column: $table.initialBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get billingDayOfMonth => $composableBuilder(
    column: $table.billingDayOfMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
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

  $$AccountsTableTableFilterComposer get linkedAccountId {
    final $$AccountsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableFilterComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transactionsTableRefs(
    Expression<bool> Function($$TransactionsTableTableFilterComposer f) f,
  ) {
    final $$TransactionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableFilterComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installmentPlansTableRefs(
    Expression<bool> Function($$InstallmentPlansTableTableFilterComposer f) f,
  ) {
    final $$InstallmentPlansTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installmentPlansTable,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallmentPlansTableTableFilterComposer(
                $db: $db,
                $table: $db.installmentPlansTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> recurringRulesTableRefs(
    Expression<bool> Function($$RecurringRulesTableTableFilterComposer f) f,
  ) {
    final $$RecurringRulesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringRulesTable,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringRulesTableTableFilterComposer(
            $db: $db,
            $table: $db.recurringRulesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sourceTransferLinks(
    Expression<bool> Function($$TransferLinksTableTableFilterComposer f) f,
  ) {
    final $$TransferLinksTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transferLinksTable,
      getReferencedColumn: (t) => t.sourceAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferLinksTableTableFilterComposer(
            $db: $db,
            $table: $db.transferLinksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> destinationTransferLinks(
    Expression<bool> Function($$TransferLinksTableTableFilterComposer f) f,
  ) {
    final $$TransferLinksTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transferLinksTable,
      getReferencedColumn: (t) => t.destinationAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferLinksTableTableFilterComposer(
            $db: $db,
            $table: $db.transferLinksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTableTable> {
  $$AccountsTableTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get initialBalance => $composableBuilder(
    column: $table.initialBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get billingDayOfMonth => $composableBuilder(
    column: $table.billingDayOfMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
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

  $$AccountsTableTableOrderingComposer get linkedAccountId {
    final $$AccountsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableOrderingComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTableTable> {
  $$AccountsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get initialBalance => $composableBuilder(
    column: $table.initialBalance,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get billingDayOfMonth => $composableBuilder(
    column: $table.billingDayOfMonth,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AccountsTableTableAnnotationComposer get linkedAccountId {
    final $$AccountsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transactionsTableRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionsTable,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> installmentPlansTableRefs<T extends Object>(
    Expression<T> Function($$InstallmentPlansTableTableAnnotationComposer a) f,
  ) {
    final $$InstallmentPlansTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installmentPlansTable,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallmentPlansTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installmentPlansTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> recurringRulesTableRefs<T extends Object>(
    Expression<T> Function($$RecurringRulesTableTableAnnotationComposer a) f,
  ) {
    final $$RecurringRulesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurringRulesTable,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringRulesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringRulesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> sourceTransferLinks<T extends Object>(
    Expression<T> Function($$TransferLinksTableTableAnnotationComposer a) f,
  ) {
    final $$TransferLinksTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transferLinksTable,
          getReferencedColumn: (t) => t.sourceAccountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransferLinksTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transferLinksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> destinationTransferLinks<T extends Object>(
    Expression<T> Function($$TransferLinksTableTableAnnotationComposer a) f,
  ) {
    final $$TransferLinksTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transferLinksTable,
          getReferencedColumn: (t) => t.destinationAccountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransferLinksTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transferLinksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AccountsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTableTable,
          AccountEntry,
          $$AccountsTableTableFilterComposer,
          $$AccountsTableTableOrderingComposer,
          $$AccountsTableTableAnnotationComposer,
          $$AccountsTableTableCreateCompanionBuilder,
          $$AccountsTableTableUpdateCompanionBuilder,
          (AccountEntry, $$AccountsTableTableReferences),
          AccountEntry,
          PrefetchHooks Function({
            bool linkedAccountId,
            bool transactionsTableRefs,
            bool installmentPlansTableRefs,
            bool recurringRulesTableRefs,
            bool sourceTransferLinks,
            bool destinationTransferLinks,
          })
        > {
  $$AccountsTableTableTableManager(_$AppDatabase db, $AccountsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double> initialBalance = const Value.absent(),
                Value<double> currentBalance = const Value.absent(),
                Value<String?> linkedAccountId = const Value.absent(),
                Value<int?> billingDayOfMonth = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsTableCompanion(
                id: id,
                name: name,
                type: type,
                currency: currency,
                initialBalance: initialBalance,
                currentBalance: currentBalance,
                linkedAccountId: linkedAccountId,
                billingDayOfMonth: billingDayOfMonth,
                colorValue: colorValue,
                iconName: iconName,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                Value<String> currency = const Value.absent(),
                Value<double> initialBalance = const Value.absent(),
                Value<double> currentBalance = const Value.absent(),
                Value<String?> linkedAccountId = const Value.absent(),
                Value<int?> billingDayOfMonth = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsTableCompanion.insert(
                id: id,
                name: name,
                type: type,
                currency: currency,
                initialBalance: initialBalance,
                currentBalance: currentBalance,
                linkedAccountId: linkedAccountId,
                billingDayOfMonth: billingDayOfMonth,
                colorValue: colorValue,
                iconName: iconName,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccountsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                linkedAccountId = false,
                transactionsTableRefs = false,
                installmentPlansTableRefs = false,
                recurringRulesTableRefs = false,
                sourceTransferLinks = false,
                destinationTransferLinks = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionsTableRefs) db.transactionsTable,
                    if (installmentPlansTableRefs) db.installmentPlansTable,
                    if (recurringRulesTableRefs) db.recurringRulesTable,
                    if (sourceTransferLinks) db.transferLinksTable,
                    if (destinationTransferLinks) db.transferLinksTable,
                  ],
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
                        if (linkedAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.linkedAccountId,
                                    referencedTable:
                                        $$AccountsTableTableReferences
                                            ._linkedAccountIdTable(db),
                                    referencedColumn:
                                        $$AccountsTableTableReferences
                                            ._linkedAccountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionsTableRefs)
                        await $_getPrefetchedData<
                          AccountEntry,
                          $AccountsTableTable,
                          TransactionEntry
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableTableReferences
                              ._transactionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installmentPlansTableRefs)
                        await $_getPrefetchedData<
                          AccountEntry,
                          $AccountsTableTable,
                          InstallmentPlanEntry
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableTableReferences
                              ._installmentPlansTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installmentPlansTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recurringRulesTableRefs)
                        await $_getPrefetchedData<
                          AccountEntry,
                          $AccountsTableTable,
                          RecurringRuleEntry
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableTableReferences
                              ._recurringRulesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringRulesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sourceTransferLinks)
                        await $_getPrefetchedData<
                          AccountEntry,
                          $AccountsTableTable,
                          TransferLinkEntry
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableTableReferences
                              ._sourceTransferLinksTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).sourceTransferLinks,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceAccountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (destinationTransferLinks)
                        await $_getPrefetchedData<
                          AccountEntry,
                          $AccountsTableTable,
                          TransferLinkEntry
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableTableReferences
                              ._destinationTransferLinksTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).destinationTransferLinks,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.destinationAccountId == item.id,
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

typedef $$AccountsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTableTable,
      AccountEntry,
      $$AccountsTableTableFilterComposer,
      $$AccountsTableTableOrderingComposer,
      $$AccountsTableTableAnnotationComposer,
      $$AccountsTableTableCreateCompanionBuilder,
      $$AccountsTableTableUpdateCompanionBuilder,
      (AccountEntry, $$AccountsTableTableReferences),
      AccountEntry,
      PrefetchHooks Function({
        bool linkedAccountId,
        bool transactionsTableRefs,
        bool installmentPlansTableRefs,
        bool recurringRulesTableRefs,
        bool sourceTransferLinks,
        bool destinationTransferLinks,
      })
    >;
typedef $$CategoriesTableTableCreateCompanionBuilder =
    CategoriesTableCompanion Function({
      required String id,
      Value<String?> parentId,
      required String name,
      required String type,
      Value<String> spendingClassification,
      Value<String> flexibility,
      Value<int> colorValue,
      Value<String> iconName,
      Value<bool> isDefault,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$CategoriesTableTableUpdateCompanionBuilder =
    CategoriesTableCompanion Function({
      Value<String> id,
      Value<String?> parentId,
      Value<String> name,
      Value<String> type,
      Value<String> spendingClassification,
      Value<String> flexibility,
      Value<int> colorValue,
      Value<String> iconName,
      Value<bool> isDefault,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$CategoriesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $CategoriesTableTable, CategoryEntry> {
  $$CategoriesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTableTable _parentIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(
          db.categoriesTable.parentId,
          db.categoriesTable.id,
        ),
      );

  $$CategoriesTableTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<String>('parent_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MerchantsTableTable, List<MerchantEntry>>
  _merchantsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.merchantsTable,
    aliasName: $_aliasNameGenerator(
      db.categoriesTable.id,
      db.merchantsTable.defaultCategoryId,
    ),
  );

  $$MerchantsTableTableProcessedTableManager get merchantsTableRefs {
    final manager = $$MerchantsTableTableTableManager($_db, $_db.merchantsTable)
        .filter(
          (f) => f.defaultCategoryId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_merchantsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TransactionsTableTable, List<TransactionEntry>>
  _transactionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionsTable,
        aliasName: $_aliasNameGenerator(
          db.categoriesTable.id,
          db.transactionsTable.categoryId,
        ),
      );

  $$TransactionsTableTableProcessedTableManager get transactionsTableRefs {
    final manager = $$TransactionsTableTableTableManager(
      $_db,
      $_db.transactionsTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TransactionSplitsTableTable,
    List<TransactionSplitEntry>
  >
  _transactionSplitsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionSplitsTable,
        aliasName: $_aliasNameGenerator(
          db.categoriesTable.id,
          db.transactionSplitsTable.categoryId,
        ),
      );

  $$TransactionSplitsTableTableProcessedTableManager
  get transactionSplitsTableRefs {
    final manager = $$TransactionSplitsTableTableTableManager(
      $_db,
      $_db.transactionSplitsTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionSplitsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallmentPlansTableTable,
    List<InstallmentPlanEntry>
  >
  _installmentPlansTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.installmentPlansTable,
        aliasName: $_aliasNameGenerator(
          db.categoriesTable.id,
          db.installmentPlansTable.categoryId,
        ),
      );

  $$InstallmentPlansTableTableProcessedTableManager
  get installmentPlansTableRefs {
    final manager = $$InstallmentPlansTableTableTableManager(
      $_db,
      $_db.installmentPlansTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installmentPlansTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RecurringRulesTableTable,
    List<RecurringRuleEntry>
  >
  _recurringRulesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurringRulesTable,
        aliasName: $_aliasNameGenerator(
          db.categoriesTable.id,
          db.recurringRulesTable.categoryId,
        ),
      );

  $$RecurringRulesTableTableProcessedTableManager get recurringRulesTableRefs {
    final manager = $$RecurringRulesTableTableTableManager(
      $_db,
      $_db.recurringRulesTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringRulesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BudgetsTableTable, List<BudgetEntry>>
  _budgetsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.budgetsTable,
    aliasName: $_aliasNameGenerator(
      db.categoriesTable.id,
      db.budgetsTable.categoryId,
    ),
  );

  $$BudgetsTableTableProcessedTableManager get budgetsTableRefs {
    final manager = $$BudgetsTableTableTableManager(
      $_db,
      $_db.budgetsTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spendingClassification => $composableBuilder(
    column: $table.spendingClassification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flexibility => $composableBuilder(
    column: $table.flexibility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
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

  $$CategoriesTableTableFilterComposer get parentId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> merchantsTableRefs(
    Expression<bool> Function($$MerchantsTableTableFilterComposer f) f,
  ) {
    final $$MerchantsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.merchantsTable,
      getReferencedColumn: (t) => t.defaultCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MerchantsTableTableFilterComposer(
            $db: $db,
            $table: $db.merchantsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transactionsTableRefs(
    Expression<bool> Function($$TransactionsTableTableFilterComposer f) f,
  ) {
    final $$TransactionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableFilterComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transactionSplitsTableRefs(
    Expression<bool> Function($$TransactionSplitsTableTableFilterComposer f) f,
  ) {
    final $$TransactionSplitsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionSplitsTable,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionSplitsTableTableFilterComposer(
                $db: $db,
                $table: $db.transactionSplitsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> installmentPlansTableRefs(
    Expression<bool> Function($$InstallmentPlansTableTableFilterComposer f) f,
  ) {
    final $$InstallmentPlansTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installmentPlansTable,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallmentPlansTableTableFilterComposer(
                $db: $db,
                $table: $db.installmentPlansTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> recurringRulesTableRefs(
    Expression<bool> Function($$RecurringRulesTableTableFilterComposer f) f,
  ) {
    final $$RecurringRulesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringRulesTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringRulesTableTableFilterComposer(
            $db: $db,
            $table: $db.recurringRulesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> budgetsTableRefs(
    Expression<bool> Function($$BudgetsTableTableFilterComposer f) f,
  ) {
    final $$BudgetsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetsTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetsTableTableFilterComposer(
            $db: $db,
            $table: $db.budgetsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spendingClassification => $composableBuilder(
    column: $table.spendingClassification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flexibility => $composableBuilder(
    column: $table.flexibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
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

  $$CategoriesTableTableOrderingComposer get parentId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableAnnotationComposer({
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get spendingClassification => $composableBuilder(
    column: $table.spendingClassification,
    builder: (column) => column,
  );

  GeneratedColumn<String> get flexibility => $composableBuilder(
    column: $table.flexibility,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CategoriesTableTableAnnotationComposer get parentId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> merchantsTableRefs<T extends Object>(
    Expression<T> Function($$MerchantsTableTableAnnotationComposer a) f,
  ) {
    final $$MerchantsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.merchantsTable,
      getReferencedColumn: (t) => t.defaultCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MerchantsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.merchantsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transactionsTableRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionsTable,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> transactionSplitsTableRefs<T extends Object>(
    Expression<T> Function($$TransactionSplitsTableTableAnnotationComposer a) f,
  ) {
    final $$TransactionSplitsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionSplitsTable,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionSplitsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionSplitsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> installmentPlansTableRefs<T extends Object>(
    Expression<T> Function($$InstallmentPlansTableTableAnnotationComposer a) f,
  ) {
    final $$InstallmentPlansTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installmentPlansTable,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallmentPlansTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installmentPlansTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> recurringRulesTableRefs<T extends Object>(
    Expression<T> Function($$RecurringRulesTableTableAnnotationComposer a) f,
  ) {
    final $$RecurringRulesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurringRulesTable,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringRulesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringRulesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> budgetsTableRefs<T extends Object>(
    Expression<T> Function($$BudgetsTableTableAnnotationComposer a) f,
  ) {
    final $$BudgetsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetsTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTableTable,
          CategoryEntry,
          $$CategoriesTableTableFilterComposer,
          $$CategoriesTableTableOrderingComposer,
          $$CategoriesTableTableAnnotationComposer,
          $$CategoriesTableTableCreateCompanionBuilder,
          $$CategoriesTableTableUpdateCompanionBuilder,
          (CategoryEntry, $$CategoriesTableTableReferences),
          CategoryEntry,
          PrefetchHooks Function({
            bool parentId,
            bool merchantsTableRefs,
            bool transactionsTableRefs,
            bool transactionSplitsTableRefs,
            bool installmentPlansTableRefs,
            bool recurringRulesTableRefs,
            bool budgetsTableRefs,
          })
        > {
  $$CategoriesTableTableTableManager(
    _$AppDatabase db,
    $CategoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> spendingClassification = const Value.absent(),
                Value<String> flexibility = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTableCompanion(
                id: id,
                parentId: parentId,
                name: name,
                type: type,
                spendingClassification: spendingClassification,
                flexibility: flexibility,
                colorValue: colorValue,
                iconName: iconName,
                isDefault: isDefault,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> parentId = const Value.absent(),
                required String name,
                required String type,
                Value<String> spendingClassification = const Value.absent(),
                Value<String> flexibility = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTableCompanion.insert(
                id: id,
                parentId: parentId,
                name: name,
                type: type,
                spendingClassification: spendingClassification,
                flexibility: flexibility,
                colorValue: colorValue,
                iconName: iconName,
                isDefault: isDefault,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                parentId = false,
                merchantsTableRefs = false,
                transactionsTableRefs = false,
                transactionSplitsTableRefs = false,
                installmentPlansTableRefs = false,
                recurringRulesTableRefs = false,
                budgetsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (merchantsTableRefs) db.merchantsTable,
                    if (transactionsTableRefs) db.transactionsTable,
                    if (transactionSplitsTableRefs) db.transactionSplitsTable,
                    if (installmentPlansTableRefs) db.installmentPlansTable,
                    if (recurringRulesTableRefs) db.recurringRulesTable,
                    if (budgetsTableRefs) db.budgetsTable,
                  ],
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
                        if (parentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.parentId,
                                    referencedTable:
                                        $$CategoriesTableTableReferences
                                            ._parentIdTable(db),
                                    referencedColumn:
                                        $$CategoriesTableTableReferences
                                            ._parentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (merchantsTableRefs)
                        await $_getPrefetchedData<
                          CategoryEntry,
                          $CategoriesTableTable,
                          MerchantEntry
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableTableReferences
                              ._merchantsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).merchantsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.defaultCategoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (transactionsTableRefs)
                        await $_getPrefetchedData<
                          CategoryEntry,
                          $CategoriesTableTable,
                          TransactionEntry
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableTableReferences
                              ._transactionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (transactionSplitsTableRefs)
                        await $_getPrefetchedData<
                          CategoryEntry,
                          $CategoriesTableTable,
                          TransactionSplitEntry
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableTableReferences
                              ._transactionSplitsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionSplitsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installmentPlansTableRefs)
                        await $_getPrefetchedData<
                          CategoryEntry,
                          $CategoriesTableTable,
                          InstallmentPlanEntry
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableTableReferences
                              ._installmentPlansTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installmentPlansTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recurringRulesTableRefs)
                        await $_getPrefetchedData<
                          CategoryEntry,
                          $CategoriesTableTable,
                          RecurringRuleEntry
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableTableReferences
                              ._recurringRulesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringRulesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (budgetsTableRefs)
                        await $_getPrefetchedData<
                          CategoryEntry,
                          $CategoriesTableTable,
                          BudgetEntry
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableTableReferences
                              ._budgetsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).budgetsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
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

typedef $$CategoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTableTable,
      CategoryEntry,
      $$CategoriesTableTableFilterComposer,
      $$CategoriesTableTableOrderingComposer,
      $$CategoriesTableTableAnnotationComposer,
      $$CategoriesTableTableCreateCompanionBuilder,
      $$CategoriesTableTableUpdateCompanionBuilder,
      (CategoryEntry, $$CategoriesTableTableReferences),
      CategoryEntry,
      PrefetchHooks Function({
        bool parentId,
        bool merchantsTableRefs,
        bool transactionsTableRefs,
        bool transactionSplitsTableRefs,
        bool installmentPlansTableRefs,
        bool recurringRulesTableRefs,
        bool budgetsTableRefs,
      })
    >;
typedef $$TagsTableTableCreateCompanionBuilder =
    TagsTableCompanion Function({
      required String id,
      required String name,
      Value<int> colorValue,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$TagsTableTableUpdateCompanionBuilder =
    TagsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> colorValue,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$TagsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TagsTableTable> {
  $$TagsTableTableFilterComposer({
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

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TagsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TagsTableTable> {
  $$TagsTableTableOrderingComposer({
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

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTableTable> {
  $$TagsTableTableAnnotationComposer({
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

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TagsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTableTable,
          TagEntry,
          $$TagsTableTableFilterComposer,
          $$TagsTableTableOrderingComposer,
          $$TagsTableTableAnnotationComposer,
          $$TagsTableTableCreateCompanionBuilder,
          $$TagsTableTableUpdateCompanionBuilder,
          (TagEntry, BaseReferences<_$AppDatabase, $TagsTableTable, TagEntry>),
          TagEntry,
          PrefetchHooks Function()
        > {
  $$TagsTableTableTableManager(_$AppDatabase db, $TagsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsTableCompanion(
                id: id,
                name: name,
                colorValue: colorValue,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int> colorValue = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsTableCompanion.insert(
                id: id,
                name: name,
                colorValue: colorValue,
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

typedef $$TagsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTableTable,
      TagEntry,
      $$TagsTableTableFilterComposer,
      $$TagsTableTableOrderingComposer,
      $$TagsTableTableAnnotationComposer,
      $$TagsTableTableCreateCompanionBuilder,
      $$TagsTableTableUpdateCompanionBuilder,
      (TagEntry, BaseReferences<_$AppDatabase, $TagsTableTable, TagEntry>),
      TagEntry,
      PrefetchHooks Function()
    >;
typedef $$MerchantsTableTableCreateCompanionBuilder =
    MerchantsTableCompanion Function({
      required String id,
      required String name,
      Value<String?> defaultCategoryId,
      Value<bool> isAutoLearned,
      Value<int> usageCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$MerchantsTableTableUpdateCompanionBuilder =
    MerchantsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> defaultCategoryId,
      Value<bool> isAutoLearned,
      Value<int> usageCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$MerchantsTableTableReferences
    extends BaseReferences<_$AppDatabase, $MerchantsTableTable, MerchantEntry> {
  $$MerchantsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTableTable _defaultCategoryIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(
          db.merchantsTable.defaultCategoryId,
          db.categoriesTable.id,
        ),
      );

  $$CategoriesTableTableProcessedTableManager? get defaultCategoryId {
    final $_column = $_itemColumn<String>('default_category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defaultCategoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransactionsTableTable, List<TransactionEntry>>
  _transactionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionsTable,
        aliasName: $_aliasNameGenerator(
          db.merchantsTable.id,
          db.transactionsTable.merchantId,
        ),
      );

  $$TransactionsTableTableProcessedTableManager get transactionsTableRefs {
    final manager = $$TransactionsTableTableTableManager(
      $_db,
      $_db.transactionsTable,
    ).filter((f) => f.merchantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstallmentPlansTableTable,
    List<InstallmentPlanEntry>
  >
  _installmentPlansTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.installmentPlansTable,
        aliasName: $_aliasNameGenerator(
          db.merchantsTable.id,
          db.installmentPlansTable.merchantId,
        ),
      );

  $$InstallmentPlansTableTableProcessedTableManager
  get installmentPlansTableRefs {
    final manager = $$InstallmentPlansTableTableTableManager(
      $_db,
      $_db.installmentPlansTable,
    ).filter((f) => f.merchantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installmentPlansTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RecurringRulesTableTable,
    List<RecurringRuleEntry>
  >
  _recurringRulesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurringRulesTable,
        aliasName: $_aliasNameGenerator(
          db.merchantsTable.id,
          db.recurringRulesTable.merchantId,
        ),
      );

  $$RecurringRulesTableTableProcessedTableManager get recurringRulesTableRefs {
    final manager = $$RecurringRulesTableTableTableManager(
      $_db,
      $_db.recurringRulesTable,
    ).filter((f) => f.merchantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringRulesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MerchantsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MerchantsTableTable> {
  $$MerchantsTableTableFilterComposer({
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

  ColumnFilters<bool> get isAutoLearned => $composableBuilder(
    column: $table.isAutoLearned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
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

  $$CategoriesTableTableFilterComposer get defaultCategoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transactionsTableRefs(
    Expression<bool> Function($$TransactionsTableTableFilterComposer f) f,
  ) {
    final $$TransactionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.merchantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableFilterComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installmentPlansTableRefs(
    Expression<bool> Function($$InstallmentPlansTableTableFilterComposer f) f,
  ) {
    final $$InstallmentPlansTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installmentPlansTable,
          getReferencedColumn: (t) => t.merchantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallmentPlansTableTableFilterComposer(
                $db: $db,
                $table: $db.installmentPlansTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> recurringRulesTableRefs(
    Expression<bool> Function($$RecurringRulesTableTableFilterComposer f) f,
  ) {
    final $$RecurringRulesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringRulesTable,
      getReferencedColumn: (t) => t.merchantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringRulesTableTableFilterComposer(
            $db: $db,
            $table: $db.recurringRulesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MerchantsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MerchantsTableTable> {
  $$MerchantsTableTableOrderingComposer({
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

  ColumnOrderings<bool> get isAutoLearned => $composableBuilder(
    column: $table.isAutoLearned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
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

  $$CategoriesTableTableOrderingComposer get defaultCategoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MerchantsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MerchantsTableTable> {
  $$MerchantsTableTableAnnotationComposer({
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

  GeneratedColumn<bool> get isAutoLearned => $composableBuilder(
    column: $table.isAutoLearned,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CategoriesTableTableAnnotationComposer get defaultCategoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transactionsTableRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionsTable,
          getReferencedColumn: (t) => t.merchantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> installmentPlansTableRefs<T extends Object>(
    Expression<T> Function($$InstallmentPlansTableTableAnnotationComposer a) f,
  ) {
    final $$InstallmentPlansTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installmentPlansTable,
          getReferencedColumn: (t) => t.merchantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallmentPlansTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installmentPlansTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> recurringRulesTableRefs<T extends Object>(
    Expression<T> Function($$RecurringRulesTableTableAnnotationComposer a) f,
  ) {
    final $$RecurringRulesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurringRulesTable,
          getReferencedColumn: (t) => t.merchantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringRulesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringRulesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MerchantsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MerchantsTableTable,
          MerchantEntry,
          $$MerchantsTableTableFilterComposer,
          $$MerchantsTableTableOrderingComposer,
          $$MerchantsTableTableAnnotationComposer,
          $$MerchantsTableTableCreateCompanionBuilder,
          $$MerchantsTableTableUpdateCompanionBuilder,
          (MerchantEntry, $$MerchantsTableTableReferences),
          MerchantEntry,
          PrefetchHooks Function({
            bool defaultCategoryId,
            bool transactionsTableRefs,
            bool installmentPlansTableRefs,
            bool recurringRulesTableRefs,
          })
        > {
  $$MerchantsTableTableTableManager(
    _$AppDatabase db,
    $MerchantsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MerchantsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MerchantsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MerchantsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> defaultCategoryId = const Value.absent(),
                Value<bool> isAutoLearned = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MerchantsTableCompanion(
                id: id,
                name: name,
                defaultCategoryId: defaultCategoryId,
                isAutoLearned: isAutoLearned,
                usageCount: usageCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> defaultCategoryId = const Value.absent(),
                Value<bool> isAutoLearned = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MerchantsTableCompanion.insert(
                id: id,
                name: name,
                defaultCategoryId: defaultCategoryId,
                isAutoLearned: isAutoLearned,
                usageCount: usageCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MerchantsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                defaultCategoryId = false,
                transactionsTableRefs = false,
                installmentPlansTableRefs = false,
                recurringRulesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionsTableRefs) db.transactionsTable,
                    if (installmentPlansTableRefs) db.installmentPlansTable,
                    if (recurringRulesTableRefs) db.recurringRulesTable,
                  ],
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
                        if (defaultCategoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.defaultCategoryId,
                                    referencedTable:
                                        $$MerchantsTableTableReferences
                                            ._defaultCategoryIdTable(db),
                                    referencedColumn:
                                        $$MerchantsTableTableReferences
                                            ._defaultCategoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionsTableRefs)
                        await $_getPrefetchedData<
                          MerchantEntry,
                          $MerchantsTableTable,
                          TransactionEntry
                        >(
                          currentTable: table,
                          referencedTable: $$MerchantsTableTableReferences
                              ._transactionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MerchantsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.merchantId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installmentPlansTableRefs)
                        await $_getPrefetchedData<
                          MerchantEntry,
                          $MerchantsTableTable,
                          InstallmentPlanEntry
                        >(
                          currentTable: table,
                          referencedTable: $$MerchantsTableTableReferences
                              ._installmentPlansTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MerchantsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installmentPlansTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.merchantId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recurringRulesTableRefs)
                        await $_getPrefetchedData<
                          MerchantEntry,
                          $MerchantsTableTable,
                          RecurringRuleEntry
                        >(
                          currentTable: table,
                          referencedTable: $$MerchantsTableTableReferences
                              ._recurringRulesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MerchantsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringRulesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.merchantId == item.id,
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

typedef $$MerchantsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MerchantsTableTable,
      MerchantEntry,
      $$MerchantsTableTableFilterComposer,
      $$MerchantsTableTableOrderingComposer,
      $$MerchantsTableTableAnnotationComposer,
      $$MerchantsTableTableCreateCompanionBuilder,
      $$MerchantsTableTableUpdateCompanionBuilder,
      (MerchantEntry, $$MerchantsTableTableReferences),
      MerchantEntry,
      PrefetchHooks Function({
        bool defaultCategoryId,
        bool transactionsTableRefs,
        bool installmentPlansTableRefs,
        bool recurringRulesTableRefs,
      })
    >;
typedef $$TransactionsTableTableCreateCompanionBuilder =
    TransactionsTableCompanion Function({
      required String id,
      required String accountId,
      Value<String?> categoryId,
      Value<String?> merchantId,
      required double amount,
      required String type,
      required DateTime date,
      Value<String?> note,
      Value<bool> isExcludedFromReports,
      Value<bool> hasSplits,
      Value<bool> isRecurringInstance,
      Value<String?> recurringRuleId,
      Value<String?> installmentPlanId,
      Value<int?> installmentNumber,
      Value<String?> transferLinkId,
      Value<bool> isAutoCategorized,
      Value<String?> importBatchId,
      Value<String> originalCurrency,
      Value<double?> originalAmount,
      Value<double> exchangeRateToIls,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$TransactionsTableTableUpdateCompanionBuilder =
    TransactionsTableCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String?> categoryId,
      Value<String?> merchantId,
      Value<double> amount,
      Value<String> type,
      Value<DateTime> date,
      Value<String?> note,
      Value<bool> isExcludedFromReports,
      Value<bool> hasSplits,
      Value<bool> isRecurringInstance,
      Value<String?> recurringRuleId,
      Value<String?> installmentPlanId,
      Value<int?> installmentNumber,
      Value<String?> transferLinkId,
      Value<bool> isAutoCategorized,
      Value<String?> importBatchId,
      Value<String> originalCurrency,
      Value<double?> originalAmount,
      Value<double> exchangeRateToIls,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$TransactionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionEntry
        > {
  $$TransactionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTableTable _accountIdTable(_$AppDatabase db) =>
      db.accountsTable.createAlias(
        $_aliasNameGenerator(
          db.transactionsTable.accountId,
          db.accountsTable.id,
        ),
      );

  $$AccountsTableTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableTableManager(
      $_db,
      $_db.accountsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(
          db.transactionsTable.categoryId,
          db.categoriesTable.id,
        ),
      );

  $$CategoriesTableTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MerchantsTableTable _merchantIdTable(_$AppDatabase db) =>
      db.merchantsTable.createAlias(
        $_aliasNameGenerator(
          db.transactionsTable.merchantId,
          db.merchantsTable.id,
        ),
      );

  $$MerchantsTableTableProcessedTableManager? get merchantId {
    final $_column = $_itemColumn<String>('merchant_id');
    if ($_column == null) return null;
    final manager = $$MerchantsTableTableTableManager(
      $_db,
      $_db.merchantsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_merchantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $TransactionSplitsTableTable,
    List<TransactionSplitEntry>
  >
  _transactionSplitsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionSplitsTable,
        aliasName: $_aliasNameGenerator(
          db.transactionsTable.id,
          db.transactionSplitsTable.transactionId,
        ),
      );

  $$TransactionSplitsTableTableProcessedTableManager
  get transactionSplitsTableRefs {
    final manager = $$TransactionSplitsTableTableTableManager(
      $_db,
      $_db.transactionSplitsTable,
    ).filter((f) => f.transactionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionSplitsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableFilterComposer({
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

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isExcludedFromReports => $composableBuilder(
    column: $table.isExcludedFromReports,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasSplits => $composableBuilder(
    column: $table.hasSplits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRecurringInstance => $composableBuilder(
    column: $table.isRecurringInstance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurringRuleId => $composableBuilder(
    column: $table.recurringRuleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get installmentPlanId => $composableBuilder(
    column: $table.installmentPlanId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get installmentNumber => $composableBuilder(
    column: $table.installmentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferLinkId => $composableBuilder(
    column: $table.transferLinkId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAutoCategorized => $composableBuilder(
    column: $table.isAutoCategorized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get importBatchId => $composableBuilder(
    column: $table.importBatchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalCurrency => $composableBuilder(
    column: $table.originalCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originalAmount => $composableBuilder(
    column: $table.originalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get exchangeRateToIls => $composableBuilder(
    column: $table.exchangeRateToIls,
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

  $$AccountsTableTableFilterComposer get accountId {
    final $$AccountsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableFilterComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MerchantsTableTableFilterComposer get merchantId {
    final $$MerchantsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.merchantsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MerchantsTableTableFilterComposer(
            $db: $db,
            $table: $db.merchantsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transactionSplitsTableRefs(
    Expression<bool> Function($$TransactionSplitsTableTableFilterComposer f) f,
  ) {
    final $$TransactionSplitsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionSplitsTable,
          getReferencedColumn: (t) => t.transactionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionSplitsTableTableFilterComposer(
                $db: $db,
                $table: $db.transactionSplitsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableOrderingComposer({
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

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isExcludedFromReports => $composableBuilder(
    column: $table.isExcludedFromReports,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasSplits => $composableBuilder(
    column: $table.hasSplits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRecurringInstance => $composableBuilder(
    column: $table.isRecurringInstance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurringRuleId => $composableBuilder(
    column: $table.recurringRuleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get installmentPlanId => $composableBuilder(
    column: $table.installmentPlanId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get installmentNumber => $composableBuilder(
    column: $table.installmentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferLinkId => $composableBuilder(
    column: $table.transferLinkId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAutoCategorized => $composableBuilder(
    column: $table.isAutoCategorized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get importBatchId => $composableBuilder(
    column: $table.importBatchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalCurrency => $composableBuilder(
    column: $table.originalCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalAmount => $composableBuilder(
    column: $table.originalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get exchangeRateToIls => $composableBuilder(
    column: $table.exchangeRateToIls,
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

  $$AccountsTableTableOrderingComposer get accountId {
    final $$AccountsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableOrderingComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MerchantsTableTableOrderingComposer get merchantId {
    final $$MerchantsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.merchantsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MerchantsTableTableOrderingComposer(
            $db: $db,
            $table: $db.merchantsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isExcludedFromReports => $composableBuilder(
    column: $table.isExcludedFromReports,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasSplits =>
      $composableBuilder(column: $table.hasSplits, builder: (column) => column);

  GeneratedColumn<bool> get isRecurringInstance => $composableBuilder(
    column: $table.isRecurringInstance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurringRuleId => $composableBuilder(
    column: $table.recurringRuleId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get installmentPlanId => $composableBuilder(
    column: $table.installmentPlanId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get installmentNumber => $composableBuilder(
    column: $table.installmentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transferLinkId => $composableBuilder(
    column: $table.transferLinkId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAutoCategorized => $composableBuilder(
    column: $table.isAutoCategorized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get importBatchId => $composableBuilder(
    column: $table.importBatchId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalCurrency => $composableBuilder(
    column: $table.originalCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<double> get originalAmount => $composableBuilder(
    column: $table.originalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get exchangeRateToIls => $composableBuilder(
    column: $table.exchangeRateToIls,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AccountsTableTableAnnotationComposer get accountId {
    final $$AccountsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MerchantsTableTableAnnotationComposer get merchantId {
    final $$MerchantsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.merchantsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MerchantsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.merchantsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transactionSplitsTableRefs<T extends Object>(
    Expression<T> Function($$TransactionSplitsTableTableAnnotationComposer a) f,
  ) {
    final $$TransactionSplitsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionSplitsTable,
          getReferencedColumn: (t) => t.transactionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionSplitsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionSplitsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TransactionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionEntry,
          $$TransactionsTableTableFilterComposer,
          $$TransactionsTableTableOrderingComposer,
          $$TransactionsTableTableAnnotationComposer,
          $$TransactionsTableTableCreateCompanionBuilder,
          $$TransactionsTableTableUpdateCompanionBuilder,
          (TransactionEntry, $$TransactionsTableTableReferences),
          TransactionEntry,
          PrefetchHooks Function({
            bool accountId,
            bool categoryId,
            bool merchantId,
            bool transactionSplitsTableRefs,
          })
        > {
  $$TransactionsTableTableTableManager(
    _$AppDatabase db,
    $TransactionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> merchantId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isExcludedFromReports = const Value.absent(),
                Value<bool> hasSplits = const Value.absent(),
                Value<bool> isRecurringInstance = const Value.absent(),
                Value<String?> recurringRuleId = const Value.absent(),
                Value<String?> installmentPlanId = const Value.absent(),
                Value<int?> installmentNumber = const Value.absent(),
                Value<String?> transferLinkId = const Value.absent(),
                Value<bool> isAutoCategorized = const Value.absent(),
                Value<String?> importBatchId = const Value.absent(),
                Value<String> originalCurrency = const Value.absent(),
                Value<double?> originalAmount = const Value.absent(),
                Value<double> exchangeRateToIls = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsTableCompanion(
                id: id,
                accountId: accountId,
                categoryId: categoryId,
                merchantId: merchantId,
                amount: amount,
                type: type,
                date: date,
                note: note,
                isExcludedFromReports: isExcludedFromReports,
                hasSplits: hasSplits,
                isRecurringInstance: isRecurringInstance,
                recurringRuleId: recurringRuleId,
                installmentPlanId: installmentPlanId,
                installmentNumber: installmentNumber,
                transferLinkId: transferLinkId,
                isAutoCategorized: isAutoCategorized,
                importBatchId: importBatchId,
                originalCurrency: originalCurrency,
                originalAmount: originalAmount,
                exchangeRateToIls: exchangeRateToIls,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                Value<String?> categoryId = const Value.absent(),
                Value<String?> merchantId = const Value.absent(),
                required double amount,
                required String type,
                required DateTime date,
                Value<String?> note = const Value.absent(),
                Value<bool> isExcludedFromReports = const Value.absent(),
                Value<bool> hasSplits = const Value.absent(),
                Value<bool> isRecurringInstance = const Value.absent(),
                Value<String?> recurringRuleId = const Value.absent(),
                Value<String?> installmentPlanId = const Value.absent(),
                Value<int?> installmentNumber = const Value.absent(),
                Value<String?> transferLinkId = const Value.absent(),
                Value<bool> isAutoCategorized = const Value.absent(),
                Value<String?> importBatchId = const Value.absent(),
                Value<String> originalCurrency = const Value.absent(),
                Value<double?> originalAmount = const Value.absent(),
                Value<double> exchangeRateToIls = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsTableCompanion.insert(
                id: id,
                accountId: accountId,
                categoryId: categoryId,
                merchantId: merchantId,
                amount: amount,
                type: type,
                date: date,
                note: note,
                isExcludedFromReports: isExcludedFromReports,
                hasSplits: hasSplits,
                isRecurringInstance: isRecurringInstance,
                recurringRuleId: recurringRuleId,
                installmentPlanId: installmentPlanId,
                installmentNumber: installmentNumber,
                transferLinkId: transferLinkId,
                isAutoCategorized: isAutoCategorized,
                importBatchId: importBatchId,
                originalCurrency: originalCurrency,
                originalAmount: originalAmount,
                exchangeRateToIls: exchangeRateToIls,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                categoryId = false,
                merchantId = false,
                transactionSplitsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionSplitsTableRefs) db.transactionSplitsTable,
                  ],
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
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable:
                                        $$TransactionsTableTableReferences
                                            ._accountIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$TransactionsTableTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (merchantId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.merchantId,
                                    referencedTable:
                                        $$TransactionsTableTableReferences
                                            ._merchantIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableTableReferences
                                            ._merchantIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionSplitsTableRefs)
                        await $_getPrefetchedData<
                          TransactionEntry,
                          $TransactionsTableTable,
                          TransactionSplitEntry
                        >(
                          currentTable: table,
                          referencedTable: $$TransactionsTableTableReferences
                              ._transactionSplitsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransactionsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionSplitsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.transactionId == item.id,
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

typedef $$TransactionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTableTable,
      TransactionEntry,
      $$TransactionsTableTableFilterComposer,
      $$TransactionsTableTableOrderingComposer,
      $$TransactionsTableTableAnnotationComposer,
      $$TransactionsTableTableCreateCompanionBuilder,
      $$TransactionsTableTableUpdateCompanionBuilder,
      (TransactionEntry, $$TransactionsTableTableReferences),
      TransactionEntry,
      PrefetchHooks Function({
        bool accountId,
        bool categoryId,
        bool merchantId,
        bool transactionSplitsTableRefs,
      })
    >;
typedef $$TransactionSplitsTableTableCreateCompanionBuilder =
    TransactionSplitsTableCompanion Function({
      required String id,
      required String transactionId,
      required String categoryId,
      required double amount,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$TransactionSplitsTableTableUpdateCompanionBuilder =
    TransactionSplitsTableCompanion Function({
      Value<String> id,
      Value<String> transactionId,
      Value<String> categoryId,
      Value<double> amount,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$TransactionSplitsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TransactionSplitsTableTable,
          TransactionSplitEntry
        > {
  $$TransactionSplitsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TransactionsTableTable _transactionIdTable(_$AppDatabase db) =>
      db.transactionsTable.createAlias(
        $_aliasNameGenerator(
          db.transactionSplitsTable.transactionId,
          db.transactionsTable.id,
        ),
      );

  $$TransactionsTableTableProcessedTableManager get transactionId {
    final $_column = $_itemColumn<String>('transaction_id')!;

    final manager = $$TransactionsTableTableTableManager(
      $_db,
      $_db.transactionsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(
          db.transactionSplitsTable.categoryId,
          db.categoriesTable.id,
        ),
      );

  $$CategoriesTableTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionSplitsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionSplitsTableTable> {
  $$TransactionSplitsTableTableFilterComposer({
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

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TransactionsTableTableFilterComposer get transactionId {
    final $$TransactionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableFilterComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionSplitsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionSplitsTableTable> {
  $$TransactionSplitsTableTableOrderingComposer({
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

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TransactionsTableTableOrderingComposer get transactionId {
    final $$TransactionsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableOrderingComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionSplitsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionSplitsTableTable> {
  $$TransactionSplitsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TransactionsTableTableAnnotationComposer get transactionId {
    final $$TransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.transactionId,
          referencedTable: $db.transactionsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionSplitsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionSplitsTableTable,
          TransactionSplitEntry,
          $$TransactionSplitsTableTableFilterComposer,
          $$TransactionSplitsTableTableOrderingComposer,
          $$TransactionSplitsTableTableAnnotationComposer,
          $$TransactionSplitsTableTableCreateCompanionBuilder,
          $$TransactionSplitsTableTableUpdateCompanionBuilder,
          (TransactionSplitEntry, $$TransactionSplitsTableTableReferences),
          TransactionSplitEntry,
          PrefetchHooks Function({bool transactionId, bool categoryId})
        > {
  $$TransactionSplitsTableTableTableManager(
    _$AppDatabase db,
    $TransactionSplitsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionSplitsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TransactionSplitsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TransactionSplitsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> transactionId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionSplitsTableCompanion(
                id: id,
                transactionId: transactionId,
                categoryId: categoryId,
                amount: amount,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String transactionId,
                required String categoryId,
                required double amount,
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionSplitsTableCompanion.insert(
                id: id,
                transactionId: transactionId,
                categoryId: categoryId,
                amount: amount,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionSplitsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionId = false, categoryId = false}) {
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
                    if (transactionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.transactionId,
                                referencedTable:
                                    $$TransactionSplitsTableTableReferences
                                        ._transactionIdTable(db),
                                referencedColumn:
                                    $$TransactionSplitsTableTableReferences
                                        ._transactionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable:
                                    $$TransactionSplitsTableTableReferences
                                        ._categoryIdTable(db),
                                referencedColumn:
                                    $$TransactionSplitsTableTableReferences
                                        ._categoryIdTable(db)
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

typedef $$TransactionSplitsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionSplitsTableTable,
      TransactionSplitEntry,
      $$TransactionSplitsTableTableFilterComposer,
      $$TransactionSplitsTableTableOrderingComposer,
      $$TransactionSplitsTableTableAnnotationComposer,
      $$TransactionSplitsTableTableCreateCompanionBuilder,
      $$TransactionSplitsTableTableUpdateCompanionBuilder,
      (TransactionSplitEntry, $$TransactionSplitsTableTableReferences),
      TransactionSplitEntry,
      PrefetchHooks Function({bool transactionId, bool categoryId})
    >;
typedef $$InstallmentPlansTableTableCreateCompanionBuilder =
    InstallmentPlansTableCompanion Function({
      required String id,
      required String accountId,
      Value<String?> categoryId,
      Value<String?> merchantId,
      required double totalAmount,
      Value<double?> firstInstallmentAmount,
      required int numberOfInstallments,
      required DateTime firstDueDate,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$InstallmentPlansTableTableUpdateCompanionBuilder =
    InstallmentPlansTableCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String?> categoryId,
      Value<String?> merchantId,
      Value<double> totalAmount,
      Value<double?> firstInstallmentAmount,
      Value<int> numberOfInstallments,
      Value<DateTime> firstDueDate,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$InstallmentPlansTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InstallmentPlansTableTable,
          InstallmentPlanEntry
        > {
  $$InstallmentPlansTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTableTable _accountIdTable(_$AppDatabase db) =>
      db.accountsTable.createAlias(
        $_aliasNameGenerator(
          db.installmentPlansTable.accountId,
          db.accountsTable.id,
        ),
      );

  $$AccountsTableTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableTableManager(
      $_db,
      $_db.accountsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(
          db.installmentPlansTable.categoryId,
          db.categoriesTable.id,
        ),
      );

  $$CategoriesTableTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MerchantsTableTable _merchantIdTable(_$AppDatabase db) =>
      db.merchantsTable.createAlias(
        $_aliasNameGenerator(
          db.installmentPlansTable.merchantId,
          db.merchantsTable.id,
        ),
      );

  $$MerchantsTableTableProcessedTableManager? get merchantId {
    final $_column = $_itemColumn<String>('merchant_id');
    if ($_column == null) return null;
    final manager = $$MerchantsTableTableTableManager(
      $_db,
      $_db.merchantsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_merchantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $InstallmentItemsTableTable,
    List<InstallmentItemEntry>
  >
  _installmentItemsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.installmentItemsTable,
        aliasName: $_aliasNameGenerator(
          db.installmentPlansTable.id,
          db.installmentItemsTable.installmentPlanId,
        ),
      );

  $$InstallmentItemsTableTableProcessedTableManager
  get installmentItemsTableRefs {
    final manager =
        $$InstallmentItemsTableTableTableManager(
          $_db,
          $_db.installmentItemsTable,
        ).filter(
          (f) => f.installmentPlanId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _installmentItemsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InstallmentPlansTableTableFilterComposer
    extends Composer<_$AppDatabase, $InstallmentPlansTableTable> {
  $$InstallmentPlansTableTableFilterComposer({
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

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get firstInstallmentAmount => $composableBuilder(
    column: $table.firstInstallmentAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfInstallments => $composableBuilder(
    column: $table.numberOfInstallments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstDueDate => $composableBuilder(
    column: $table.firstDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableTableFilterComposer get accountId {
    final $$AccountsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableFilterComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MerchantsTableTableFilterComposer get merchantId {
    final $$MerchantsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.merchantsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MerchantsTableTableFilterComposer(
            $db: $db,
            $table: $db.merchantsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> installmentItemsTableRefs(
    Expression<bool> Function($$InstallmentItemsTableTableFilterComposer f) f,
  ) {
    final $$InstallmentItemsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installmentItemsTable,
          getReferencedColumn: (t) => t.installmentPlanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallmentItemsTableTableFilterComposer(
                $db: $db,
                $table: $db.installmentItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InstallmentPlansTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InstallmentPlansTableTable> {
  $$InstallmentPlansTableTableOrderingComposer({
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

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get firstInstallmentAmount => $composableBuilder(
    column: $table.firstInstallmentAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfInstallments => $composableBuilder(
    column: $table.numberOfInstallments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstDueDate => $composableBuilder(
    column: $table.firstDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableTableOrderingComposer get accountId {
    final $$AccountsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableOrderingComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MerchantsTableTableOrderingComposer get merchantId {
    final $$MerchantsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.merchantsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MerchantsTableTableOrderingComposer(
            $db: $db,
            $table: $db.merchantsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InstallmentPlansTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InstallmentPlansTableTable> {
  $$InstallmentPlansTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get firstInstallmentAmount => $composableBuilder(
    column: $table.firstInstallmentAmount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberOfInstallments => $composableBuilder(
    column: $table.numberOfInstallments,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get firstDueDate => $composableBuilder(
    column: $table.firstDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AccountsTableTableAnnotationComposer get accountId {
    final $$AccountsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MerchantsTableTableAnnotationComposer get merchantId {
    final $$MerchantsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.merchantsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MerchantsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.merchantsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> installmentItemsTableRefs<T extends Object>(
    Expression<T> Function($$InstallmentItemsTableTableAnnotationComposer a) f,
  ) {
    final $$InstallmentItemsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installmentItemsTable,
          getReferencedColumn: (t) => t.installmentPlanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallmentItemsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installmentItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InstallmentPlansTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InstallmentPlansTableTable,
          InstallmentPlanEntry,
          $$InstallmentPlansTableTableFilterComposer,
          $$InstallmentPlansTableTableOrderingComposer,
          $$InstallmentPlansTableTableAnnotationComposer,
          $$InstallmentPlansTableTableCreateCompanionBuilder,
          $$InstallmentPlansTableTableUpdateCompanionBuilder,
          (InstallmentPlanEntry, $$InstallmentPlansTableTableReferences),
          InstallmentPlanEntry,
          PrefetchHooks Function({
            bool accountId,
            bool categoryId,
            bool merchantId,
            bool installmentItemsTableRefs,
          })
        > {
  $$InstallmentPlansTableTableTableManager(
    _$AppDatabase db,
    $InstallmentPlansTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstallmentPlansTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InstallmentPlansTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InstallmentPlansTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> merchantId = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double?> firstInstallmentAmount = const Value.absent(),
                Value<int> numberOfInstallments = const Value.absent(),
                Value<DateTime> firstDueDate = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InstallmentPlansTableCompanion(
                id: id,
                accountId: accountId,
                categoryId: categoryId,
                merchantId: merchantId,
                totalAmount: totalAmount,
                firstInstallmentAmount: firstInstallmentAmount,
                numberOfInstallments: numberOfInstallments,
                firstDueDate: firstDueDate,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                Value<String?> categoryId = const Value.absent(),
                Value<String?> merchantId = const Value.absent(),
                required double totalAmount,
                Value<double?> firstInstallmentAmount = const Value.absent(),
                required int numberOfInstallments,
                required DateTime firstDueDate,
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InstallmentPlansTableCompanion.insert(
                id: id,
                accountId: accountId,
                categoryId: categoryId,
                merchantId: merchantId,
                totalAmount: totalAmount,
                firstInstallmentAmount: firstInstallmentAmount,
                numberOfInstallments: numberOfInstallments,
                firstDueDate: firstDueDate,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstallmentPlansTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                categoryId = false,
                merchantId = false,
                installmentItemsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (installmentItemsTableRefs) db.installmentItemsTable,
                  ],
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
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable:
                                        $$InstallmentPlansTableTableReferences
                                            ._accountIdTable(db),
                                    referencedColumn:
                                        $$InstallmentPlansTableTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$InstallmentPlansTableTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$InstallmentPlansTableTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (merchantId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.merchantId,
                                    referencedTable:
                                        $$InstallmentPlansTableTableReferences
                                            ._merchantIdTable(db),
                                    referencedColumn:
                                        $$InstallmentPlansTableTableReferences
                                            ._merchantIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (installmentItemsTableRefs)
                        await $_getPrefetchedData<
                          InstallmentPlanEntry,
                          $InstallmentPlansTableTable,
                          InstallmentItemEntry
                        >(
                          currentTable: table,
                          referencedTable:
                              $$InstallmentPlansTableTableReferences
                                  ._installmentItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstallmentPlansTableTableReferences(
                                db,
                                table,
                                p0,
                              ).installmentItemsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.installmentPlanId == item.id,
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

typedef $$InstallmentPlansTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InstallmentPlansTableTable,
      InstallmentPlanEntry,
      $$InstallmentPlansTableTableFilterComposer,
      $$InstallmentPlansTableTableOrderingComposer,
      $$InstallmentPlansTableTableAnnotationComposer,
      $$InstallmentPlansTableTableCreateCompanionBuilder,
      $$InstallmentPlansTableTableUpdateCompanionBuilder,
      (InstallmentPlanEntry, $$InstallmentPlansTableTableReferences),
      InstallmentPlanEntry,
      PrefetchHooks Function({
        bool accountId,
        bool categoryId,
        bool merchantId,
        bool installmentItemsTableRefs,
      })
    >;
typedef $$InstallmentItemsTableTableCreateCompanionBuilder =
    InstallmentItemsTableCompanion Function({
      required String id,
      required String installmentPlanId,
      Value<String?> transactionId,
      required int installmentNumber,
      required double amount,
      required DateTime dueDate,
      Value<bool> isPaid,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$InstallmentItemsTableTableUpdateCompanionBuilder =
    InstallmentItemsTableCompanion Function({
      Value<String> id,
      Value<String> installmentPlanId,
      Value<String?> transactionId,
      Value<int> installmentNumber,
      Value<double> amount,
      Value<DateTime> dueDate,
      Value<bool> isPaid,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$InstallmentItemsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InstallmentItemsTableTable,
          InstallmentItemEntry
        > {
  $$InstallmentItemsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InstallmentPlansTableTable _installmentPlanIdTable(
    _$AppDatabase db,
  ) => db.installmentPlansTable.createAlias(
    $_aliasNameGenerator(
      db.installmentItemsTable.installmentPlanId,
      db.installmentPlansTable.id,
    ),
  );

  $$InstallmentPlansTableTableProcessedTableManager get installmentPlanId {
    final $_column = $_itemColumn<String>('installment_plan_id')!;

    final manager = $$InstallmentPlansTableTableTableManager(
      $_db,
      $_db.installmentPlansTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_installmentPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InstallmentItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $InstallmentItemsTableTable> {
  $$InstallmentItemsTableTableFilterComposer({
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

  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get installmentNumber => $composableBuilder(
    column: $table.installmentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPaid => $composableBuilder(
    column: $table.isPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InstallmentPlansTableTableFilterComposer get installmentPlanId {
    final $$InstallmentPlansTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installmentPlanId,
          referencedTable: $db.installmentPlansTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallmentPlansTableTableFilterComposer(
                $db: $db,
                $table: $db.installmentPlansTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InstallmentItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InstallmentItemsTableTable> {
  $$InstallmentItemsTableTableOrderingComposer({
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

  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get installmentNumber => $composableBuilder(
    column: $table.installmentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPaid => $composableBuilder(
    column: $table.isPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InstallmentPlansTableTableOrderingComposer get installmentPlanId {
    final $$InstallmentPlansTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installmentPlanId,
          referencedTable: $db.installmentPlansTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallmentPlansTableTableOrderingComposer(
                $db: $db,
                $table: $db.installmentPlansTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InstallmentItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InstallmentItemsTableTable> {
  $$InstallmentItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get installmentNumber => $composableBuilder(
    column: $table.installmentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<bool> get isPaid =>
      $composableBuilder(column: $table.isPaid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InstallmentPlansTableTableAnnotationComposer get installmentPlanId {
    final $$InstallmentPlansTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installmentPlanId,
          referencedTable: $db.installmentPlansTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstallmentPlansTableTableAnnotationComposer(
                $db: $db,
                $table: $db.installmentPlansTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InstallmentItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InstallmentItemsTableTable,
          InstallmentItemEntry,
          $$InstallmentItemsTableTableFilterComposer,
          $$InstallmentItemsTableTableOrderingComposer,
          $$InstallmentItemsTableTableAnnotationComposer,
          $$InstallmentItemsTableTableCreateCompanionBuilder,
          $$InstallmentItemsTableTableUpdateCompanionBuilder,
          (InstallmentItemEntry, $$InstallmentItemsTableTableReferences),
          InstallmentItemEntry,
          PrefetchHooks Function({bool installmentPlanId})
        > {
  $$InstallmentItemsTableTableTableManager(
    _$AppDatabase db,
    $InstallmentItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstallmentItemsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InstallmentItemsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InstallmentItemsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> installmentPlanId = const Value.absent(),
                Value<String?> transactionId = const Value.absent(),
                Value<int> installmentNumber = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<bool> isPaid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InstallmentItemsTableCompanion(
                id: id,
                installmentPlanId: installmentPlanId,
                transactionId: transactionId,
                installmentNumber: installmentNumber,
                amount: amount,
                dueDate: dueDate,
                isPaid: isPaid,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String installmentPlanId,
                Value<String?> transactionId = const Value.absent(),
                required int installmentNumber,
                required double amount,
                required DateTime dueDate,
                Value<bool> isPaid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InstallmentItemsTableCompanion.insert(
                id: id,
                installmentPlanId: installmentPlanId,
                transactionId: transactionId,
                installmentNumber: installmentNumber,
                amount: amount,
                dueDate: dueDate,
                isPaid: isPaid,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstallmentItemsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({installmentPlanId = false}) {
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
                    if (installmentPlanId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.installmentPlanId,
                                referencedTable:
                                    $$InstallmentItemsTableTableReferences
                                        ._installmentPlanIdTable(db),
                                referencedColumn:
                                    $$InstallmentItemsTableTableReferences
                                        ._installmentPlanIdTable(db)
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

typedef $$InstallmentItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InstallmentItemsTableTable,
      InstallmentItemEntry,
      $$InstallmentItemsTableTableFilterComposer,
      $$InstallmentItemsTableTableOrderingComposer,
      $$InstallmentItemsTableTableAnnotationComposer,
      $$InstallmentItemsTableTableCreateCompanionBuilder,
      $$InstallmentItemsTableTableUpdateCompanionBuilder,
      (InstallmentItemEntry, $$InstallmentItemsTableTableReferences),
      InstallmentItemEntry,
      PrefetchHooks Function({bool installmentPlanId})
    >;
typedef $$RecurringRulesTableTableCreateCompanionBuilder =
    RecurringRulesTableCompanion Function({
      required String id,
      required String accountId,
      Value<String?> categoryId,
      Value<String?> merchantId,
      required String name,
      required double amount,
      required String frequency,
      required int dayOfMonth,
      required DateTime startDate,
      Value<DateTime?> endDate,
      Value<bool> isAutoExecute,
      Value<bool> isPaused,
      Value<DateTime?> lastExecutedDate,
      required DateTime nextExecutionDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$RecurringRulesTableTableUpdateCompanionBuilder =
    RecurringRulesTableCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<String?> categoryId,
      Value<String?> merchantId,
      Value<String> name,
      Value<double> amount,
      Value<String> frequency,
      Value<int> dayOfMonth,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<bool> isAutoExecute,
      Value<bool> isPaused,
      Value<DateTime?> lastExecutedDate,
      Value<DateTime> nextExecutionDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$RecurringRulesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecurringRulesTableTable,
          RecurringRuleEntry
        > {
  $$RecurringRulesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTableTable _accountIdTable(_$AppDatabase db) =>
      db.accountsTable.createAlias(
        $_aliasNameGenerator(
          db.recurringRulesTable.accountId,
          db.accountsTable.id,
        ),
      );

  $$AccountsTableTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableTableManager(
      $_db,
      $_db.accountsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(
          db.recurringRulesTable.categoryId,
          db.categoriesTable.id,
        ),
      );

  $$CategoriesTableTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MerchantsTableTable _merchantIdTable(_$AppDatabase db) =>
      db.merchantsTable.createAlias(
        $_aliasNameGenerator(
          db.recurringRulesTable.merchantId,
          db.merchantsTable.id,
        ),
      );

  $$MerchantsTableTableProcessedTableManager? get merchantId {
    final $_column = $_itemColumn<String>('merchant_id');
    if ($_column == null) return null;
    final manager = $$MerchantsTableTableTableManager(
      $_db,
      $_db.merchantsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_merchantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecurringRulesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringRulesTableTable> {
  $$RecurringRulesTableTableFilterComposer({
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

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
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

  ColumnFilters<bool> get isAutoExecute => $composableBuilder(
    column: $table.isAutoExecute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPaused => $composableBuilder(
    column: $table.isPaused,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastExecutedDate => $composableBuilder(
    column: $table.lastExecutedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextExecutionDate => $composableBuilder(
    column: $table.nextExecutionDate,
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

  $$AccountsTableTableFilterComposer get accountId {
    final $$AccountsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableFilterComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MerchantsTableTableFilterComposer get merchantId {
    final $$MerchantsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.merchantsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MerchantsTableTableFilterComposer(
            $db: $db,
            $table: $db.merchantsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringRulesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringRulesTableTable> {
  $$RecurringRulesTableTableOrderingComposer({
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

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
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

  ColumnOrderings<bool> get isAutoExecute => $composableBuilder(
    column: $table.isAutoExecute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPaused => $composableBuilder(
    column: $table.isPaused,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastExecutedDate => $composableBuilder(
    column: $table.lastExecutedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextExecutionDate => $composableBuilder(
    column: $table.nextExecutionDate,
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

  $$AccountsTableTableOrderingComposer get accountId {
    final $$AccountsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableOrderingComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MerchantsTableTableOrderingComposer get merchantId {
    final $$MerchantsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.merchantsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MerchantsTableTableOrderingComposer(
            $db: $db,
            $table: $db.merchantsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringRulesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringRulesTableTable> {
  $$RecurringRulesTableTableAnnotationComposer({
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

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get isAutoExecute => $composableBuilder(
    column: $table.isAutoExecute,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPaused =>
      $composableBuilder(column: $table.isPaused, builder: (column) => column);

  GeneratedColumn<DateTime> get lastExecutedDate => $composableBuilder(
    column: $table.lastExecutedDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextExecutionDate => $composableBuilder(
    column: $table.nextExecutionDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AccountsTableTableAnnotationComposer get accountId {
    final $$AccountsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MerchantsTableTableAnnotationComposer get merchantId {
    final $$MerchantsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.merchantId,
      referencedTable: $db.merchantsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MerchantsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.merchantsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringRulesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringRulesTableTable,
          RecurringRuleEntry,
          $$RecurringRulesTableTableFilterComposer,
          $$RecurringRulesTableTableOrderingComposer,
          $$RecurringRulesTableTableAnnotationComposer,
          $$RecurringRulesTableTableCreateCompanionBuilder,
          $$RecurringRulesTableTableUpdateCompanionBuilder,
          (RecurringRuleEntry, $$RecurringRulesTableTableReferences),
          RecurringRuleEntry,
          PrefetchHooks Function({
            bool accountId,
            bool categoryId,
            bool merchantId,
          })
        > {
  $$RecurringRulesTableTableTableManager(
    _$AppDatabase db,
    $RecurringRulesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringRulesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringRulesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecurringRulesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> merchantId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<int> dayOfMonth = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<bool> isAutoExecute = const Value.absent(),
                Value<bool> isPaused = const Value.absent(),
                Value<DateTime?> lastExecutedDate = const Value.absent(),
                Value<DateTime> nextExecutionDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurringRulesTableCompanion(
                id: id,
                accountId: accountId,
                categoryId: categoryId,
                merchantId: merchantId,
                name: name,
                amount: amount,
                frequency: frequency,
                dayOfMonth: dayOfMonth,
                startDate: startDate,
                endDate: endDate,
                isAutoExecute: isAutoExecute,
                isPaused: isPaused,
                lastExecutedDate: lastExecutedDate,
                nextExecutionDate: nextExecutionDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                Value<String?> categoryId = const Value.absent(),
                Value<String?> merchantId = const Value.absent(),
                required String name,
                required double amount,
                required String frequency,
                required int dayOfMonth,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<bool> isAutoExecute = const Value.absent(),
                Value<bool> isPaused = const Value.absent(),
                Value<DateTime?> lastExecutedDate = const Value.absent(),
                required DateTime nextExecutionDate,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurringRulesTableCompanion.insert(
                id: id,
                accountId: accountId,
                categoryId: categoryId,
                merchantId: merchantId,
                name: name,
                amount: amount,
                frequency: frequency,
                dayOfMonth: dayOfMonth,
                startDate: startDate,
                endDate: endDate,
                isAutoExecute: isAutoExecute,
                isPaused: isPaused,
                lastExecutedDate: lastExecutedDate,
                nextExecutionDate: nextExecutionDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecurringRulesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({accountId = false, categoryId = false, merchantId = false}) {
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
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable:
                                        $$RecurringRulesTableTableReferences
                                            ._accountIdTable(db),
                                    referencedColumn:
                                        $$RecurringRulesTableTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$RecurringRulesTableTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$RecurringRulesTableTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (merchantId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.merchantId,
                                    referencedTable:
                                        $$RecurringRulesTableTableReferences
                                            ._merchantIdTable(db),
                                    referencedColumn:
                                        $$RecurringRulesTableTableReferences
                                            ._merchantIdTable(db)
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

typedef $$RecurringRulesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringRulesTableTable,
      RecurringRuleEntry,
      $$RecurringRulesTableTableFilterComposer,
      $$RecurringRulesTableTableOrderingComposer,
      $$RecurringRulesTableTableAnnotationComposer,
      $$RecurringRulesTableTableCreateCompanionBuilder,
      $$RecurringRulesTableTableUpdateCompanionBuilder,
      (RecurringRuleEntry, $$RecurringRulesTableTableReferences),
      RecurringRuleEntry,
      PrefetchHooks Function({bool accountId, bool categoryId, bool merchantId})
    >;
typedef $$TransferLinksTableTableCreateCompanionBuilder =
    TransferLinksTableCompanion Function({
      required String id,
      required String sourceTransactionId,
      required String destinationTransactionId,
      required String sourceAccountId,
      required String destinationAccountId,
      required double amount,
      Value<double> exchangeRate,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$TransferLinksTableTableUpdateCompanionBuilder =
    TransferLinksTableCompanion Function({
      Value<String> id,
      Value<String> sourceTransactionId,
      Value<String> destinationTransactionId,
      Value<String> sourceAccountId,
      Value<String> destinationAccountId,
      Value<double> amount,
      Value<double> exchangeRate,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$TransferLinksTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TransferLinksTableTable,
          TransferLinkEntry
        > {
  $$TransferLinksTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTableTable _sourceAccountIdTable(_$AppDatabase db) =>
      db.accountsTable.createAlias(
        $_aliasNameGenerator(
          db.transferLinksTable.sourceAccountId,
          db.accountsTable.id,
        ),
      );

  $$AccountsTableTableProcessedTableManager get sourceAccountId {
    final $_column = $_itemColumn<String>('source_account_id')!;

    final manager = $$AccountsTableTableTableManager(
      $_db,
      $_db.accountsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTableTable _destinationAccountIdTable(_$AppDatabase db) =>
      db.accountsTable.createAlias(
        $_aliasNameGenerator(
          db.transferLinksTable.destinationAccountId,
          db.accountsTable.id,
        ),
      );

  $$AccountsTableTableProcessedTableManager get destinationAccountId {
    final $_column = $_itemColumn<String>('destination_account_id')!;

    final manager = $$AccountsTableTableTableManager(
      $_db,
      $_db.accountsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _destinationAccountIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransferLinksTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransferLinksTableTable> {
  $$TransferLinksTableTableFilterComposer({
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

  ColumnFilters<String> get sourceTransactionId => $composableBuilder(
    column: $table.sourceTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinationTransactionId => $composableBuilder(
    column: $table.destinationTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableTableFilterComposer get sourceAccountId {
    final $$AccountsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableFilterComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableTableFilterComposer get destinationAccountId {
    final $$AccountsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.destinationAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableFilterComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransferLinksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransferLinksTableTable> {
  $$TransferLinksTableTableOrderingComposer({
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

  ColumnOrderings<String> get sourceTransactionId => $composableBuilder(
    column: $table.sourceTransactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinationTransactionId => $composableBuilder(
    column: $table.destinationTransactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableTableOrderingComposer get sourceAccountId {
    final $$AccountsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableOrderingComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableTableOrderingComposer get destinationAccountId {
    final $$AccountsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.destinationAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableOrderingComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransferLinksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransferLinksTableTable> {
  $$TransferLinksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceTransactionId => $composableBuilder(
    column: $table.sourceTransactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get destinationTransactionId => $composableBuilder(
    column: $table.destinationTransactionId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AccountsTableTableAnnotationComposer get sourceAccountId {
    final $$AccountsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableTableAnnotationComposer get destinationAccountId {
    final $$AccountsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.destinationAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransferLinksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransferLinksTableTable,
          TransferLinkEntry,
          $$TransferLinksTableTableFilterComposer,
          $$TransferLinksTableTableOrderingComposer,
          $$TransferLinksTableTableAnnotationComposer,
          $$TransferLinksTableTableCreateCompanionBuilder,
          $$TransferLinksTableTableUpdateCompanionBuilder,
          (TransferLinkEntry, $$TransferLinksTableTableReferences),
          TransferLinkEntry,
          PrefetchHooks Function({
            bool sourceAccountId,
            bool destinationAccountId,
          })
        > {
  $$TransferLinksTableTableTableManager(
    _$AppDatabase db,
    $TransferLinksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransferLinksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransferLinksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransferLinksTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceTransactionId = const Value.absent(),
                Value<String> destinationTransactionId = const Value.absent(),
                Value<String> sourceAccountId = const Value.absent(),
                Value<String> destinationAccountId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double> exchangeRate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransferLinksTableCompanion(
                id: id,
                sourceTransactionId: sourceTransactionId,
                destinationTransactionId: destinationTransactionId,
                sourceAccountId: sourceAccountId,
                destinationAccountId: destinationAccountId,
                amount: amount,
                exchangeRate: exchangeRate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceTransactionId,
                required String destinationTransactionId,
                required String sourceAccountId,
                required String destinationAccountId,
                required double amount,
                Value<double> exchangeRate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransferLinksTableCompanion.insert(
                id: id,
                sourceTransactionId: sourceTransactionId,
                destinationTransactionId: destinationTransactionId,
                sourceAccountId: sourceAccountId,
                destinationAccountId: destinationAccountId,
                amount: amount,
                exchangeRate: exchangeRate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransferLinksTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sourceAccountId = false, destinationAccountId = false}) {
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
                        if (sourceAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceAccountId,
                                    referencedTable:
                                        $$TransferLinksTableTableReferences
                                            ._sourceAccountIdTable(db),
                                    referencedColumn:
                                        $$TransferLinksTableTableReferences
                                            ._sourceAccountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (destinationAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.destinationAccountId,
                                    referencedTable:
                                        $$TransferLinksTableTableReferences
                                            ._destinationAccountIdTable(db),
                                    referencedColumn:
                                        $$TransferLinksTableTableReferences
                                            ._destinationAccountIdTable(db)
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

typedef $$TransferLinksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransferLinksTableTable,
      TransferLinkEntry,
      $$TransferLinksTableTableFilterComposer,
      $$TransferLinksTableTableOrderingComposer,
      $$TransferLinksTableTableAnnotationComposer,
      $$TransferLinksTableTableCreateCompanionBuilder,
      $$TransferLinksTableTableUpdateCompanionBuilder,
      (TransferLinkEntry, $$TransferLinksTableTableReferences),
      TransferLinkEntry,
      PrefetchHooks Function({bool sourceAccountId, bool destinationAccountId})
    >;
typedef $$BudgetsTableTableCreateCompanionBuilder =
    BudgetsTableCompanion Function({
      required String id,
      required String categoryId,
      required double amount,
      Value<bool> isRolloverEnabled,
      Value<double?> maxRolloverAmount,
      Value<bool> isDynamic,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$BudgetsTableTableUpdateCompanionBuilder =
    BudgetsTableCompanion Function({
      Value<String> id,
      Value<String> categoryId,
      Value<double> amount,
      Value<bool> isRolloverEnabled,
      Value<double?> maxRolloverAmount,
      Value<bool> isDynamic,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$BudgetsTableTableReferences
    extends BaseReferences<_$AppDatabase, $BudgetsTableTable, BudgetEntry> {
  $$BudgetsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(db.budgetsTable.categoryId, db.categoriesTable.id),
      );

  $$CategoriesTableTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BudgetPeriodsTableTable, List<BudgetPeriodEntry>>
  _budgetPeriodsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.budgetPeriodsTable,
        aliasName: $_aliasNameGenerator(
          db.budgetsTable.id,
          db.budgetPeriodsTable.budgetId,
        ),
      );

  $$BudgetPeriodsTableTableProcessedTableManager get budgetPeriodsTableRefs {
    final manager = $$BudgetPeriodsTableTableTableManager(
      $_db,
      $_db.budgetPeriodsTable,
    ).filter((f) => f.budgetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _budgetPeriodsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BudgetsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableFilterComposer({
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

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRolloverEnabled => $composableBuilder(
    column: $table.isRolloverEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxRolloverAmount => $composableBuilder(
    column: $table.maxRolloverAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDynamic => $composableBuilder(
    column: $table.isDynamic,
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

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> budgetPeriodsTableRefs(
    Expression<bool> Function($$BudgetPeriodsTableTableFilterComposer f) f,
  ) {
    final $$BudgetPeriodsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetPeriodsTable,
      getReferencedColumn: (t) => t.budgetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetPeriodsTableTableFilterComposer(
            $db: $db,
            $table: $db.budgetPeriodsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableOrderingComposer({
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

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRolloverEnabled => $composableBuilder(
    column: $table.isRolloverEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxRolloverAmount => $composableBuilder(
    column: $table.maxRolloverAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDynamic => $composableBuilder(
    column: $table.isDynamic,
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

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<bool> get isRolloverEnabled => $composableBuilder(
    column: $table.isRolloverEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxRolloverAmount => $composableBuilder(
    column: $table.maxRolloverAmount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDynamic =>
      $composableBuilder(column: $table.isDynamic, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> budgetPeriodsTableRefs<T extends Object>(
    Expression<T> Function($$BudgetPeriodsTableTableAnnotationComposer a) f,
  ) {
    final $$BudgetPeriodsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.budgetPeriodsTable,
          getReferencedColumn: (t) => t.budgetId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BudgetPeriodsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.budgetPeriodsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BudgetsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetsTableTable,
          BudgetEntry,
          $$BudgetsTableTableFilterComposer,
          $$BudgetsTableTableOrderingComposer,
          $$BudgetsTableTableAnnotationComposer,
          $$BudgetsTableTableCreateCompanionBuilder,
          $$BudgetsTableTableUpdateCompanionBuilder,
          (BudgetEntry, $$BudgetsTableTableReferences),
          BudgetEntry,
          PrefetchHooks Function({bool categoryId, bool budgetPeriodsTableRefs})
        > {
  $$BudgetsTableTableTableManager(_$AppDatabase db, $BudgetsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<bool> isRolloverEnabled = const Value.absent(),
                Value<double?> maxRolloverAmount = const Value.absent(),
                Value<bool> isDynamic = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetsTableCompanion(
                id: id,
                categoryId: categoryId,
                amount: amount,
                isRolloverEnabled: isRolloverEnabled,
                maxRolloverAmount: maxRolloverAmount,
                isDynamic: isDynamic,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String categoryId,
                required double amount,
                Value<bool> isRolloverEnabled = const Value.absent(),
                Value<double?> maxRolloverAmount = const Value.absent(),
                Value<bool> isDynamic = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetsTableCompanion.insert(
                id: id,
                categoryId: categoryId,
                amount: amount,
                isRolloverEnabled: isRolloverEnabled,
                maxRolloverAmount: maxRolloverAmount,
                isDynamic: isDynamic,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({categoryId = false, budgetPeriodsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (budgetPeriodsTableRefs) db.budgetPeriodsTable,
                  ],
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
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$BudgetsTableTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$BudgetsTableTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (budgetPeriodsTableRefs)
                        await $_getPrefetchedData<
                          BudgetEntry,
                          $BudgetsTableTable,
                          BudgetPeriodEntry
                        >(
                          currentTable: table,
                          referencedTable: $$BudgetsTableTableReferences
                              ._budgetPeriodsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BudgetsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).budgetPeriodsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.budgetId == item.id,
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

typedef $$BudgetsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetsTableTable,
      BudgetEntry,
      $$BudgetsTableTableFilterComposer,
      $$BudgetsTableTableOrderingComposer,
      $$BudgetsTableTableAnnotationComposer,
      $$BudgetsTableTableCreateCompanionBuilder,
      $$BudgetsTableTableUpdateCompanionBuilder,
      (BudgetEntry, $$BudgetsTableTableReferences),
      BudgetEntry,
      PrefetchHooks Function({bool categoryId, bool budgetPeriodsTableRefs})
    >;
typedef $$BudgetPeriodsTableTableCreateCompanionBuilder =
    BudgetPeriodsTableCompanion Function({
      required String id,
      required String budgetId,
      required String monthYear,
      required double allocatedAmount,
      Value<double> rolloverAmount,
      Value<double> actualSpent,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$BudgetPeriodsTableTableUpdateCompanionBuilder =
    BudgetPeriodsTableCompanion Function({
      Value<String> id,
      Value<String> budgetId,
      Value<String> monthYear,
      Value<double> allocatedAmount,
      Value<double> rolloverAmount,
      Value<double> actualSpent,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$BudgetPeriodsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BudgetPeriodsTableTable,
          BudgetPeriodEntry
        > {
  $$BudgetPeriodsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BudgetsTableTable _budgetIdTable(_$AppDatabase db) =>
      db.budgetsTable.createAlias(
        $_aliasNameGenerator(
          db.budgetPeriodsTable.budgetId,
          db.budgetsTable.id,
        ),
      );

  $$BudgetsTableTableProcessedTableManager get budgetId {
    final $_column = $_itemColumn<String>('budget_id')!;

    final manager = $$BudgetsTableTableTableManager(
      $_db,
      $_db.budgetsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_budgetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BudgetPeriodsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetPeriodsTableTable> {
  $$BudgetPeriodsTableTableFilterComposer({
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

  ColumnFilters<String> get monthYear => $composableBuilder(
    column: $table.monthYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get allocatedAmount => $composableBuilder(
    column: $table.allocatedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rolloverAmount => $composableBuilder(
    column: $table.rolloverAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get actualSpent => $composableBuilder(
    column: $table.actualSpent,
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

  $$BudgetsTableTableFilterComposer get budgetId {
    final $$BudgetsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.budgetId,
      referencedTable: $db.budgetsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetsTableTableFilterComposer(
            $db: $db,
            $table: $db.budgetsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetPeriodsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetPeriodsTableTable> {
  $$BudgetPeriodsTableTableOrderingComposer({
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

  ColumnOrderings<String> get monthYear => $composableBuilder(
    column: $table.monthYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get allocatedAmount => $composableBuilder(
    column: $table.allocatedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rolloverAmount => $composableBuilder(
    column: $table.rolloverAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get actualSpent => $composableBuilder(
    column: $table.actualSpent,
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

  $$BudgetsTableTableOrderingComposer get budgetId {
    final $$BudgetsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.budgetId,
      referencedTable: $db.budgetsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetsTableTableOrderingComposer(
            $db: $db,
            $table: $db.budgetsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetPeriodsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetPeriodsTableTable> {
  $$BudgetPeriodsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get monthYear =>
      $composableBuilder(column: $table.monthYear, builder: (column) => column);

  GeneratedColumn<double> get allocatedAmount => $composableBuilder(
    column: $table.allocatedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rolloverAmount => $composableBuilder(
    column: $table.rolloverAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get actualSpent => $composableBuilder(
    column: $table.actualSpent,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BudgetsTableTableAnnotationComposer get budgetId {
    final $$BudgetsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.budgetId,
      referencedTable: $db.budgetsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetPeriodsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetPeriodsTableTable,
          BudgetPeriodEntry,
          $$BudgetPeriodsTableTableFilterComposer,
          $$BudgetPeriodsTableTableOrderingComposer,
          $$BudgetPeriodsTableTableAnnotationComposer,
          $$BudgetPeriodsTableTableCreateCompanionBuilder,
          $$BudgetPeriodsTableTableUpdateCompanionBuilder,
          (BudgetPeriodEntry, $$BudgetPeriodsTableTableReferences),
          BudgetPeriodEntry,
          PrefetchHooks Function({bool budgetId})
        > {
  $$BudgetPeriodsTableTableTableManager(
    _$AppDatabase db,
    $BudgetPeriodsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetPeriodsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetPeriodsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetPeriodsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> budgetId = const Value.absent(),
                Value<String> monthYear = const Value.absent(),
                Value<double> allocatedAmount = const Value.absent(),
                Value<double> rolloverAmount = const Value.absent(),
                Value<double> actualSpent = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetPeriodsTableCompanion(
                id: id,
                budgetId: budgetId,
                monthYear: monthYear,
                allocatedAmount: allocatedAmount,
                rolloverAmount: rolloverAmount,
                actualSpent: actualSpent,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String budgetId,
                required String monthYear,
                required double allocatedAmount,
                Value<double> rolloverAmount = const Value.absent(),
                Value<double> actualSpent = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetPeriodsTableCompanion.insert(
                id: id,
                budgetId: budgetId,
                monthYear: monthYear,
                allocatedAmount: allocatedAmount,
                rolloverAmount: rolloverAmount,
                actualSpent: actualSpent,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetPeriodsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({budgetId = false}) {
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
                    if (budgetId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.budgetId,
                                referencedTable:
                                    $$BudgetPeriodsTableTableReferences
                                        ._budgetIdTable(db),
                                referencedColumn:
                                    $$BudgetPeriodsTableTableReferences
                                        ._budgetIdTable(db)
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

typedef $$BudgetPeriodsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetPeriodsTableTable,
      BudgetPeriodEntry,
      $$BudgetPeriodsTableTableFilterComposer,
      $$BudgetPeriodsTableTableOrderingComposer,
      $$BudgetPeriodsTableTableAnnotationComposer,
      $$BudgetPeriodsTableTableCreateCompanionBuilder,
      $$BudgetPeriodsTableTableUpdateCompanionBuilder,
      (BudgetPeriodEntry, $$BudgetPeriodsTableTableReferences),
      BudgetPeriodEntry,
      PrefetchHooks Function({bool budgetId})
    >;
typedef $$ImportBatchesTableTableCreateCompanionBuilder =
    ImportBatchesTableCompanion Function({
      required String id,
      required String sourceName,
      required String fileName,
      Value<DateTime> importedAt,
      Value<int> totalRows,
      Value<int> importedRows,
      Value<int> duplicatesSkipped,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ImportBatchesTableTableUpdateCompanionBuilder =
    ImportBatchesTableCompanion Function({
      Value<String> id,
      Value<String> sourceName,
      Value<String> fileName,
      Value<DateTime> importedAt,
      Value<int> totalRows,
      Value<int> importedRows,
      Value<int> duplicatesSkipped,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ImportBatchesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ImportBatchesTableTable> {
  $$ImportBatchesTableTableFilterComposer({
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

  ColumnFilters<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalRows => $composableBuilder(
    column: $table.totalRows,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get importedRows => $composableBuilder(
    column: $table.importedRows,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duplicatesSkipped => $composableBuilder(
    column: $table.duplicatesSkipped,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ImportBatchesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ImportBatchesTableTable> {
  $$ImportBatchesTableTableOrderingComposer({
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

  ColumnOrderings<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalRows => $composableBuilder(
    column: $table.totalRows,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get importedRows => $composableBuilder(
    column: $table.importedRows,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duplicatesSkipped => $composableBuilder(
    column: $table.duplicatesSkipped,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImportBatchesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImportBatchesTableTable> {
  $$ImportBatchesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalRows =>
      $composableBuilder(column: $table.totalRows, builder: (column) => column);

  GeneratedColumn<int> get importedRows => $composableBuilder(
    column: $table.importedRows,
    builder: (column) => column,
  );

  GeneratedColumn<int> get duplicatesSkipped => $composableBuilder(
    column: $table.duplicatesSkipped,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ImportBatchesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImportBatchesTableTable,
          ImportBatchEntry,
          $$ImportBatchesTableTableFilterComposer,
          $$ImportBatchesTableTableOrderingComposer,
          $$ImportBatchesTableTableAnnotationComposer,
          $$ImportBatchesTableTableCreateCompanionBuilder,
          $$ImportBatchesTableTableUpdateCompanionBuilder,
          (
            ImportBatchEntry,
            BaseReferences<
              _$AppDatabase,
              $ImportBatchesTableTable,
              ImportBatchEntry
            >,
          ),
          ImportBatchEntry,
          PrefetchHooks Function()
        > {
  $$ImportBatchesTableTableTableManager(
    _$AppDatabase db,
    $ImportBatchesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImportBatchesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImportBatchesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImportBatchesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceName = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<int> totalRows = const Value.absent(),
                Value<int> importedRows = const Value.absent(),
                Value<int> duplicatesSkipped = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImportBatchesTableCompanion(
                id: id,
                sourceName: sourceName,
                fileName: fileName,
                importedAt: importedAt,
                totalRows: totalRows,
                importedRows: importedRows,
                duplicatesSkipped: duplicatesSkipped,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceName,
                required String fileName,
                Value<DateTime> importedAt = const Value.absent(),
                Value<int> totalRows = const Value.absent(),
                Value<int> importedRows = const Value.absent(),
                Value<int> duplicatesSkipped = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImportBatchesTableCompanion.insert(
                id: id,
                sourceName: sourceName,
                fileName: fileName,
                importedAt: importedAt,
                totalRows: totalRows,
                importedRows: importedRows,
                duplicatesSkipped: duplicatesSkipped,
                status: status,
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

typedef $$ImportBatchesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImportBatchesTableTable,
      ImportBatchEntry,
      $$ImportBatchesTableTableFilterComposer,
      $$ImportBatchesTableTableOrderingComposer,
      $$ImportBatchesTableTableAnnotationComposer,
      $$ImportBatchesTableTableCreateCompanionBuilder,
      $$ImportBatchesTableTableUpdateCompanionBuilder,
      (
        ImportBatchEntry,
        BaseReferences<
          _$AppDatabase,
          $ImportBatchesTableTable,
          ImportBatchEntry
        >,
      ),
      ImportBatchEntry,
      PrefetchHooks Function()
    >;
typedef $$ImportMappingsTableTableCreateCompanionBuilder =
    ImportMappingsTableCompanion Function({
      required String id,
      required String sourceName,
      required String mappingConfigJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ImportMappingsTableTableUpdateCompanionBuilder =
    ImportMappingsTableCompanion Function({
      Value<String> id,
      Value<String> sourceName,
      Value<String> mappingConfigJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ImportMappingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ImportMappingsTableTable> {
  $$ImportMappingsTableTableFilterComposer({
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

  ColumnFilters<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mappingConfigJson => $composableBuilder(
    column: $table.mappingConfigJson,
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

class $$ImportMappingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ImportMappingsTableTable> {
  $$ImportMappingsTableTableOrderingComposer({
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

  ColumnOrderings<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mappingConfigJson => $composableBuilder(
    column: $table.mappingConfigJson,
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

class $$ImportMappingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImportMappingsTableTable> {
  $$ImportMappingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mappingConfigJson => $composableBuilder(
    column: $table.mappingConfigJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ImportMappingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImportMappingsTableTable,
          ImportMappingEntry,
          $$ImportMappingsTableTableFilterComposer,
          $$ImportMappingsTableTableOrderingComposer,
          $$ImportMappingsTableTableAnnotationComposer,
          $$ImportMappingsTableTableCreateCompanionBuilder,
          $$ImportMappingsTableTableUpdateCompanionBuilder,
          (
            ImportMappingEntry,
            BaseReferences<
              _$AppDatabase,
              $ImportMappingsTableTable,
              ImportMappingEntry
            >,
          ),
          ImportMappingEntry,
          PrefetchHooks Function()
        > {
  $$ImportMappingsTableTableTableManager(
    _$AppDatabase db,
    $ImportMappingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImportMappingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImportMappingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ImportMappingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceName = const Value.absent(),
                Value<String> mappingConfigJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImportMappingsTableCompanion(
                id: id,
                sourceName: sourceName,
                mappingConfigJson: mappingConfigJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceName,
                required String mappingConfigJson,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImportMappingsTableCompanion.insert(
                id: id,
                sourceName: sourceName,
                mappingConfigJson: mappingConfigJson,
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

typedef $$ImportMappingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImportMappingsTableTable,
      ImportMappingEntry,
      $$ImportMappingsTableTableFilterComposer,
      $$ImportMappingsTableTableOrderingComposer,
      $$ImportMappingsTableTableAnnotationComposer,
      $$ImportMappingsTableTableCreateCompanionBuilder,
      $$ImportMappingsTableTableUpdateCompanionBuilder,
      (
        ImportMappingEntry,
        BaseReferences<
          _$AppDatabase,
          $ImportMappingsTableTable,
          ImportMappingEntry
        >,
      ),
      ImportMappingEntry,
      PrefetchHooks Function()
    >;
typedef $$SecuritiesTableTableCreateCompanionBuilder =
    SecuritiesTableCompanion Function({
      required String id,
      required String ticker,
      required String name,
      required String securityType,
      Value<String?> exchange,
      Value<String> currency,
      Value<double> currentPrice,
      Value<DateTime?> lastPriceUpdate,
      Value<bool> isBenchmark,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SecuritiesTableTableUpdateCompanionBuilder =
    SecuritiesTableCompanion Function({
      Value<String> id,
      Value<String> ticker,
      Value<String> name,
      Value<String> securityType,
      Value<String?> exchange,
      Value<String> currency,
      Value<double> currentPrice,
      Value<DateTime?> lastPriceUpdate,
      Value<bool> isBenchmark,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SecuritiesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $SecuritiesTableTable, SecurityEntry> {
  $$SecuritiesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$HoldingsTableTable, List<HoldingEntry>>
  _holdingsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.holdingsTable,
    aliasName: $_aliasNameGenerator(
      db.securitiesTable.id,
      db.holdingsTable.securityId,
    ),
  );

  $$HoldingsTableTableProcessedTableManager get holdingsTableRefs {
    final manager = $$HoldingsTableTableTableManager(
      $_db,
      $_db.holdingsTable,
    ).filter((f) => f.securityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_holdingsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InvestmentTransactionsTableTable,
    List<InvestmentTransactionEntry>
  >
  _investmentTransactionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.investmentTransactionsTable,
        aliasName: $_aliasNameGenerator(
          db.securitiesTable.id,
          db.investmentTransactionsTable.securityId,
        ),
      );

  $$InvestmentTransactionsTableTableProcessedTableManager
  get investmentTransactionsTableRefs {
    final manager = $$InvestmentTransactionsTableTableTableManager(
      $_db,
      $_db.investmentTransactionsTable,
    ).filter((f) => f.securityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _investmentTransactionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SecuritiesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SecuritiesTableTable> {
  $$SecuritiesTableTableFilterComposer({
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

  ColumnFilters<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get securityType => $composableBuilder(
    column: $table.securityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exchange => $composableBuilder(
    column: $table.exchange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPriceUpdate => $composableBuilder(
    column: $table.lastPriceUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBenchmark => $composableBuilder(
    column: $table.isBenchmark,
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

  Expression<bool> holdingsTableRefs(
    Expression<bool> Function($$HoldingsTableTableFilterComposer f) f,
  ) {
    final $$HoldingsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.holdingsTable,
      getReferencedColumn: (t) => t.securityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HoldingsTableTableFilterComposer(
            $db: $db,
            $table: $db.holdingsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> investmentTransactionsTableRefs(
    Expression<bool> Function(
      $$InvestmentTransactionsTableTableFilterComposer f,
    )
    f,
  ) {
    final $$InvestmentTransactionsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.investmentTransactionsTable,
          getReferencedColumn: (t) => t.securityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InvestmentTransactionsTableTableFilterComposer(
                $db: $db,
                $table: $db.investmentTransactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SecuritiesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SecuritiesTableTable> {
  $$SecuritiesTableTableOrderingComposer({
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

  ColumnOrderings<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get securityType => $composableBuilder(
    column: $table.securityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exchange => $composableBuilder(
    column: $table.exchange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPriceUpdate => $composableBuilder(
    column: $table.lastPriceUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBenchmark => $composableBuilder(
    column: $table.isBenchmark,
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

class $$SecuritiesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SecuritiesTableTable> {
  $$SecuritiesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ticker =>
      $composableBuilder(column: $table.ticker, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get securityType => $composableBuilder(
    column: $table.securityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exchange =>
      $composableBuilder(column: $table.exchange, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastPriceUpdate => $composableBuilder(
    column: $table.lastPriceUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBenchmark => $composableBuilder(
    column: $table.isBenchmark,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> holdingsTableRefs<T extends Object>(
    Expression<T> Function($$HoldingsTableTableAnnotationComposer a) f,
  ) {
    final $$HoldingsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.holdingsTable,
      getReferencedColumn: (t) => t.securityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HoldingsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.holdingsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> investmentTransactionsTableRefs<T extends Object>(
    Expression<T> Function(
      $$InvestmentTransactionsTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$InvestmentTransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.investmentTransactionsTable,
          getReferencedColumn: (t) => t.securityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InvestmentTransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.investmentTransactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SecuritiesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SecuritiesTableTable,
          SecurityEntry,
          $$SecuritiesTableTableFilterComposer,
          $$SecuritiesTableTableOrderingComposer,
          $$SecuritiesTableTableAnnotationComposer,
          $$SecuritiesTableTableCreateCompanionBuilder,
          $$SecuritiesTableTableUpdateCompanionBuilder,
          (SecurityEntry, $$SecuritiesTableTableReferences),
          SecurityEntry,
          PrefetchHooks Function({
            bool holdingsTableRefs,
            bool investmentTransactionsTableRefs,
          })
        > {
  $$SecuritiesTableTableTableManager(
    _$AppDatabase db,
    $SecuritiesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SecuritiesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SecuritiesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SecuritiesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ticker = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> securityType = const Value.absent(),
                Value<String?> exchange = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double> currentPrice = const Value.absent(),
                Value<DateTime?> lastPriceUpdate = const Value.absent(),
                Value<bool> isBenchmark = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SecuritiesTableCompanion(
                id: id,
                ticker: ticker,
                name: name,
                securityType: securityType,
                exchange: exchange,
                currency: currency,
                currentPrice: currentPrice,
                lastPriceUpdate: lastPriceUpdate,
                isBenchmark: isBenchmark,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ticker,
                required String name,
                required String securityType,
                Value<String?> exchange = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double> currentPrice = const Value.absent(),
                Value<DateTime?> lastPriceUpdate = const Value.absent(),
                Value<bool> isBenchmark = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SecuritiesTableCompanion.insert(
                id: id,
                ticker: ticker,
                name: name,
                securityType: securityType,
                exchange: exchange,
                currency: currency,
                currentPrice: currentPrice,
                lastPriceUpdate: lastPriceUpdate,
                isBenchmark: isBenchmark,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SecuritiesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                holdingsTableRefs = false,
                investmentTransactionsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (holdingsTableRefs) db.holdingsTable,
                    if (investmentTransactionsTableRefs)
                      db.investmentTransactionsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (holdingsTableRefs)
                        await $_getPrefetchedData<
                          SecurityEntry,
                          $SecuritiesTableTable,
                          HoldingEntry
                        >(
                          currentTable: table,
                          referencedTable: $$SecuritiesTableTableReferences
                              ._holdingsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SecuritiesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).holdingsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.securityId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (investmentTransactionsTableRefs)
                        await $_getPrefetchedData<
                          SecurityEntry,
                          $SecuritiesTableTable,
                          InvestmentTransactionEntry
                        >(
                          currentTable: table,
                          referencedTable: $$SecuritiesTableTableReferences
                              ._investmentTransactionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SecuritiesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).investmentTransactionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.securityId == item.id,
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

typedef $$SecuritiesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SecuritiesTableTable,
      SecurityEntry,
      $$SecuritiesTableTableFilterComposer,
      $$SecuritiesTableTableOrderingComposer,
      $$SecuritiesTableTableAnnotationComposer,
      $$SecuritiesTableTableCreateCompanionBuilder,
      $$SecuritiesTableTableUpdateCompanionBuilder,
      (SecurityEntry, $$SecuritiesTableTableReferences),
      SecurityEntry,
      PrefetchHooks Function({
        bool holdingsTableRefs,
        bool investmentTransactionsTableRefs,
      })
    >;
typedef $$HoldingsTableTableCreateCompanionBuilder =
    HoldingsTableCompanion Function({
      required String id,
      required String securityId,
      required double quantity,
      required double averageCostBasis,
      Value<String> currency,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$HoldingsTableTableUpdateCompanionBuilder =
    HoldingsTableCompanion Function({
      Value<String> id,
      Value<String> securityId,
      Value<double> quantity,
      Value<double> averageCostBasis,
      Value<String> currency,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$HoldingsTableTableReferences
    extends BaseReferences<_$AppDatabase, $HoldingsTableTable, HoldingEntry> {
  $$HoldingsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SecuritiesTableTable _securityIdTable(_$AppDatabase db) =>
      db.securitiesTable.createAlias(
        $_aliasNameGenerator(
          db.holdingsTable.securityId,
          db.securitiesTable.id,
        ),
      );

  $$SecuritiesTableTableProcessedTableManager get securityId {
    final $_column = $_itemColumn<String>('security_id')!;

    final manager = $$SecuritiesTableTableTableManager(
      $_db,
      $_db.securitiesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_securityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $InvestmentTransactionsTableTable,
    List<InvestmentTransactionEntry>
  >
  _investmentTransactionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.investmentTransactionsTable,
        aliasName: $_aliasNameGenerator(
          db.holdingsTable.id,
          db.investmentTransactionsTable.holdingId,
        ),
      );

  $$InvestmentTransactionsTableTableProcessedTableManager
  get investmentTransactionsTableRefs {
    final manager = $$InvestmentTransactionsTableTableTableManager(
      $_db,
      $_db.investmentTransactionsTable,
    ).filter((f) => f.holdingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _investmentTransactionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HoldingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $HoldingsTableTable> {
  $$HoldingsTableTableFilterComposer({
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

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get averageCostBasis => $composableBuilder(
    column: $table.averageCostBasis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
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

  $$SecuritiesTableTableFilterComposer get securityId {
    final $$SecuritiesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.securityId,
      referencedTable: $db.securitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SecuritiesTableTableFilterComposer(
            $db: $db,
            $table: $db.securitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> investmentTransactionsTableRefs(
    Expression<bool> Function(
      $$InvestmentTransactionsTableTableFilterComposer f,
    )
    f,
  ) {
    final $$InvestmentTransactionsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.investmentTransactionsTable,
          getReferencedColumn: (t) => t.holdingId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InvestmentTransactionsTableTableFilterComposer(
                $db: $db,
                $table: $db.investmentTransactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$HoldingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HoldingsTableTable> {
  $$HoldingsTableTableOrderingComposer({
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

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get averageCostBasis => $composableBuilder(
    column: $table.averageCostBasis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
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

  $$SecuritiesTableTableOrderingComposer get securityId {
    final $$SecuritiesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.securityId,
      referencedTable: $db.securitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SecuritiesTableTableOrderingComposer(
            $db: $db,
            $table: $db.securitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HoldingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HoldingsTableTable> {
  $$HoldingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get averageCostBasis => $composableBuilder(
    column: $table.averageCostBasis,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SecuritiesTableTableAnnotationComposer get securityId {
    final $$SecuritiesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.securityId,
      referencedTable: $db.securitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SecuritiesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.securitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> investmentTransactionsTableRefs<T extends Object>(
    Expression<T> Function(
      $$InvestmentTransactionsTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$InvestmentTransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.investmentTransactionsTable,
          getReferencedColumn: (t) => t.holdingId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InvestmentTransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.investmentTransactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$HoldingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HoldingsTableTable,
          HoldingEntry,
          $$HoldingsTableTableFilterComposer,
          $$HoldingsTableTableOrderingComposer,
          $$HoldingsTableTableAnnotationComposer,
          $$HoldingsTableTableCreateCompanionBuilder,
          $$HoldingsTableTableUpdateCompanionBuilder,
          (HoldingEntry, $$HoldingsTableTableReferences),
          HoldingEntry,
          PrefetchHooks Function({
            bool securityId,
            bool investmentTransactionsTableRefs,
          })
        > {
  $$HoldingsTableTableTableManager(_$AppDatabase db, $HoldingsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HoldingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HoldingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HoldingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> securityId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> averageCostBasis = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HoldingsTableCompanion(
                id: id,
                securityId: securityId,
                quantity: quantity,
                averageCostBasis: averageCostBasis,
                currency: currency,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String securityId,
                required double quantity,
                required double averageCostBasis,
                Value<String> currency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HoldingsTableCompanion.insert(
                id: id,
                securityId: securityId,
                quantity: quantity,
                averageCostBasis: averageCostBasis,
                currency: currency,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HoldingsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({securityId = false, investmentTransactionsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (investmentTransactionsTableRefs)
                      db.investmentTransactionsTable,
                  ],
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
                        if (securityId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.securityId,
                                    referencedTable:
                                        $$HoldingsTableTableReferences
                                            ._securityIdTable(db),
                                    referencedColumn:
                                        $$HoldingsTableTableReferences
                                            ._securityIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (investmentTransactionsTableRefs)
                        await $_getPrefetchedData<
                          HoldingEntry,
                          $HoldingsTableTable,
                          InvestmentTransactionEntry
                        >(
                          currentTable: table,
                          referencedTable: $$HoldingsTableTableReferences
                              ._investmentTransactionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HoldingsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).investmentTransactionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.holdingId == item.id,
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

typedef $$HoldingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HoldingsTableTable,
      HoldingEntry,
      $$HoldingsTableTableFilterComposer,
      $$HoldingsTableTableOrderingComposer,
      $$HoldingsTableTableAnnotationComposer,
      $$HoldingsTableTableCreateCompanionBuilder,
      $$HoldingsTableTableUpdateCompanionBuilder,
      (HoldingEntry, $$HoldingsTableTableReferences),
      HoldingEntry,
      PrefetchHooks Function({
        bool securityId,
        bool investmentTransactionsTableRefs,
      })
    >;
typedef $$InvestmentTransactionsTableTableCreateCompanionBuilder =
    InvestmentTransactionsTableCompanion Function({
      required String id,
      required String securityId,
      Value<String?> holdingId,
      required String type,
      required double quantity,
      required double pricePerUnit,
      Value<double> fee,
      required DateTime date,
      Value<String> currency,
      Value<double> exchangeRateToIls,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$InvestmentTransactionsTableTableUpdateCompanionBuilder =
    InvestmentTransactionsTableCompanion Function({
      Value<String> id,
      Value<String> securityId,
      Value<String?> holdingId,
      Value<String> type,
      Value<double> quantity,
      Value<double> pricePerUnit,
      Value<double> fee,
      Value<DateTime> date,
      Value<String> currency,
      Value<double> exchangeRateToIls,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$InvestmentTransactionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InvestmentTransactionsTableTable,
          InvestmentTransactionEntry
        > {
  $$InvestmentTransactionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SecuritiesTableTable _securityIdTable(_$AppDatabase db) =>
      db.securitiesTable.createAlias(
        $_aliasNameGenerator(
          db.investmentTransactionsTable.securityId,
          db.securitiesTable.id,
        ),
      );

  $$SecuritiesTableTableProcessedTableManager get securityId {
    final $_column = $_itemColumn<String>('security_id')!;

    final manager = $$SecuritiesTableTableTableManager(
      $_db,
      $_db.securitiesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_securityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HoldingsTableTable _holdingIdTable(_$AppDatabase db) =>
      db.holdingsTable.createAlias(
        $_aliasNameGenerator(
          db.investmentTransactionsTable.holdingId,
          db.holdingsTable.id,
        ),
      );

  $$HoldingsTableTableProcessedTableManager? get holdingId {
    final $_column = $_itemColumn<String>('holding_id');
    if ($_column == null) return null;
    final manager = $$HoldingsTableTableTableManager(
      $_db,
      $_db.holdingsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_holdingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvestmentTransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $InvestmentTransactionsTableTable> {
  $$InvestmentTransactionsTableTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerUnit => $composableBuilder(
    column: $table.pricePerUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fee => $composableBuilder(
    column: $table.fee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get exchangeRateToIls => $composableBuilder(
    column: $table.exchangeRateToIls,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SecuritiesTableTableFilterComposer get securityId {
    final $$SecuritiesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.securityId,
      referencedTable: $db.securitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SecuritiesTableTableFilterComposer(
            $db: $db,
            $table: $db.securitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HoldingsTableTableFilterComposer get holdingId {
    final $$HoldingsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.holdingId,
      referencedTable: $db.holdingsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HoldingsTableTableFilterComposer(
            $db: $db,
            $table: $db.holdingsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvestmentTransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InvestmentTransactionsTableTable> {
  $$InvestmentTransactionsTableTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerUnit => $composableBuilder(
    column: $table.pricePerUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fee => $composableBuilder(
    column: $table.fee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get exchangeRateToIls => $composableBuilder(
    column: $table.exchangeRateToIls,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SecuritiesTableTableOrderingComposer get securityId {
    final $$SecuritiesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.securityId,
      referencedTable: $db.securitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SecuritiesTableTableOrderingComposer(
            $db: $db,
            $table: $db.securitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HoldingsTableTableOrderingComposer get holdingId {
    final $$HoldingsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.holdingId,
      referencedTable: $db.holdingsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HoldingsTableTableOrderingComposer(
            $db: $db,
            $table: $db.holdingsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvestmentTransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvestmentTransactionsTableTable> {
  $$InvestmentTransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get pricePerUnit => $composableBuilder(
    column: $table.pricePerUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fee =>
      $composableBuilder(column: $table.fee, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get exchangeRateToIls => $composableBuilder(
    column: $table.exchangeRateToIls,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SecuritiesTableTableAnnotationComposer get securityId {
    final $$SecuritiesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.securityId,
      referencedTable: $db.securitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SecuritiesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.securitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HoldingsTableTableAnnotationComposer get holdingId {
    final $$HoldingsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.holdingId,
      referencedTable: $db.holdingsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HoldingsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.holdingsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvestmentTransactionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvestmentTransactionsTableTable,
          InvestmentTransactionEntry,
          $$InvestmentTransactionsTableTableFilterComposer,
          $$InvestmentTransactionsTableTableOrderingComposer,
          $$InvestmentTransactionsTableTableAnnotationComposer,
          $$InvestmentTransactionsTableTableCreateCompanionBuilder,
          $$InvestmentTransactionsTableTableUpdateCompanionBuilder,
          (
            InvestmentTransactionEntry,
            $$InvestmentTransactionsTableTableReferences,
          ),
          InvestmentTransactionEntry,
          PrefetchHooks Function({bool securityId, bool holdingId})
        > {
  $$InvestmentTransactionsTableTableTableManager(
    _$AppDatabase db,
    $InvestmentTransactionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvestmentTransactionsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InvestmentTransactionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InvestmentTransactionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> securityId = const Value.absent(),
                Value<String?> holdingId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> pricePerUnit = const Value.absent(),
                Value<double> fee = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double> exchangeRateToIls = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvestmentTransactionsTableCompanion(
                id: id,
                securityId: securityId,
                holdingId: holdingId,
                type: type,
                quantity: quantity,
                pricePerUnit: pricePerUnit,
                fee: fee,
                date: date,
                currency: currency,
                exchangeRateToIls: exchangeRateToIls,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String securityId,
                Value<String?> holdingId = const Value.absent(),
                required String type,
                required double quantity,
                required double pricePerUnit,
                Value<double> fee = const Value.absent(),
                required DateTime date,
                Value<String> currency = const Value.absent(),
                Value<double> exchangeRateToIls = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvestmentTransactionsTableCompanion.insert(
                id: id,
                securityId: securityId,
                holdingId: holdingId,
                type: type,
                quantity: quantity,
                pricePerUnit: pricePerUnit,
                fee: fee,
                date: date,
                currency: currency,
                exchangeRateToIls: exchangeRateToIls,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvestmentTransactionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({securityId = false, holdingId = false}) {
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
                    if (securityId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.securityId,
                                referencedTable:
                                    $$InvestmentTransactionsTableTableReferences
                                        ._securityIdTable(db),
                                referencedColumn:
                                    $$InvestmentTransactionsTableTableReferences
                                        ._securityIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (holdingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.holdingId,
                                referencedTable:
                                    $$InvestmentTransactionsTableTableReferences
                                        ._holdingIdTable(db),
                                referencedColumn:
                                    $$InvestmentTransactionsTableTableReferences
                                        ._holdingIdTable(db)
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

typedef $$InvestmentTransactionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvestmentTransactionsTableTable,
      InvestmentTransactionEntry,
      $$InvestmentTransactionsTableTableFilterComposer,
      $$InvestmentTransactionsTableTableOrderingComposer,
      $$InvestmentTransactionsTableTableAnnotationComposer,
      $$InvestmentTransactionsTableTableCreateCompanionBuilder,
      $$InvestmentTransactionsTableTableUpdateCompanionBuilder,
      (
        InvestmentTransactionEntry,
        $$InvestmentTransactionsTableTableReferences,
      ),
      InvestmentTransactionEntry,
      PrefetchHooks Function({bool securityId, bool holdingId})
    >;
typedef $$PensionAssetsTableTableCreateCompanionBuilder =
    PensionAssetsTableCompanion Function({
      required String id,
      required String name,
      required String type,
      required String providerName,
      Value<String?> policyNumber,
      Value<String?> trackName,
      Value<double> currentBalance,
      Value<double> monthlyDepositEmployee,
      Value<double> monthlyDepositEmployer,
      Value<DateTime> lastUpdatedDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$PensionAssetsTableTableUpdateCompanionBuilder =
    PensionAssetsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<String> providerName,
      Value<String?> policyNumber,
      Value<String?> trackName,
      Value<double> currentBalance,
      Value<double> monthlyDepositEmployee,
      Value<double> monthlyDepositEmployer,
      Value<DateTime> lastUpdatedDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PensionAssetsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PensionAssetsTableTable,
          PensionAssetEntry
        > {
  $$PensionAssetsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $PensionSnapshotsTableTable,
    List<PensionSnapshotEntry>
  >
  _pensionSnapshotsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pensionSnapshotsTable,
        aliasName: $_aliasNameGenerator(
          db.pensionAssetsTable.id,
          db.pensionSnapshotsTable.pensionAssetId,
        ),
      );

  $$PensionSnapshotsTableTableProcessedTableManager
  get pensionSnapshotsTableRefs {
    final manager = $$PensionSnapshotsTableTableTableManager(
      $_db,
      $_db.pensionSnapshotsTable,
    ).filter((f) => f.pensionAssetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pensionSnapshotsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PensionAssetsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PensionAssetsTableTable> {
  $$PensionAssetsTableTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackName => $composableBuilder(
    column: $table.trackName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monthlyDepositEmployee => $composableBuilder(
    column: $table.monthlyDepositEmployee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monthlyDepositEmployer => $composableBuilder(
    column: $table.monthlyDepositEmployer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
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

  Expression<bool> pensionSnapshotsTableRefs(
    Expression<bool> Function($$PensionSnapshotsTableTableFilterComposer f) f,
  ) {
    final $$PensionSnapshotsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pensionSnapshotsTable,
          getReferencedColumn: (t) => t.pensionAssetId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PensionSnapshotsTableTableFilterComposer(
                $db: $db,
                $table: $db.pensionSnapshotsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PensionAssetsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PensionAssetsTableTable> {
  $$PensionAssetsTableTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackName => $composableBuilder(
    column: $table.trackName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monthlyDepositEmployee => $composableBuilder(
    column: $table.monthlyDepositEmployee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monthlyDepositEmployer => $composableBuilder(
    column: $table.monthlyDepositEmployer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
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

class $$PensionAssetsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PensionAssetsTableTable> {
  $$PensionAssetsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trackName =>
      $composableBuilder(column: $table.trackName, builder: (column) => column);

  GeneratedColumn<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => column,
  );

  GeneratedColumn<double> get monthlyDepositEmployee => $composableBuilder(
    column: $table.monthlyDepositEmployee,
    builder: (column) => column,
  );

  GeneratedColumn<double> get monthlyDepositEmployer => $composableBuilder(
    column: $table.monthlyDepositEmployer,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> pensionSnapshotsTableRefs<T extends Object>(
    Expression<T> Function($$PensionSnapshotsTableTableAnnotationComposer a) f,
  ) {
    final $$PensionSnapshotsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pensionSnapshotsTable,
          getReferencedColumn: (t) => t.pensionAssetId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PensionSnapshotsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pensionSnapshotsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PensionAssetsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PensionAssetsTableTable,
          PensionAssetEntry,
          $$PensionAssetsTableTableFilterComposer,
          $$PensionAssetsTableTableOrderingComposer,
          $$PensionAssetsTableTableAnnotationComposer,
          $$PensionAssetsTableTableCreateCompanionBuilder,
          $$PensionAssetsTableTableUpdateCompanionBuilder,
          (PensionAssetEntry, $$PensionAssetsTableTableReferences),
          PensionAssetEntry,
          PrefetchHooks Function({bool pensionSnapshotsTableRefs})
        > {
  $$PensionAssetsTableTableTableManager(
    _$AppDatabase db,
    $PensionAssetsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PensionAssetsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PensionAssetsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PensionAssetsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> providerName = const Value.absent(),
                Value<String?> policyNumber = const Value.absent(),
                Value<String?> trackName = const Value.absent(),
                Value<double> currentBalance = const Value.absent(),
                Value<double> monthlyDepositEmployee = const Value.absent(),
                Value<double> monthlyDepositEmployer = const Value.absent(),
                Value<DateTime> lastUpdatedDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PensionAssetsTableCompanion(
                id: id,
                name: name,
                type: type,
                providerName: providerName,
                policyNumber: policyNumber,
                trackName: trackName,
                currentBalance: currentBalance,
                monthlyDepositEmployee: monthlyDepositEmployee,
                monthlyDepositEmployer: monthlyDepositEmployer,
                lastUpdatedDate: lastUpdatedDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                required String providerName,
                Value<String?> policyNumber = const Value.absent(),
                Value<String?> trackName = const Value.absent(),
                Value<double> currentBalance = const Value.absent(),
                Value<double> monthlyDepositEmployee = const Value.absent(),
                Value<double> monthlyDepositEmployer = const Value.absent(),
                Value<DateTime> lastUpdatedDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PensionAssetsTableCompanion.insert(
                id: id,
                name: name,
                type: type,
                providerName: providerName,
                policyNumber: policyNumber,
                trackName: trackName,
                currentBalance: currentBalance,
                monthlyDepositEmployee: monthlyDepositEmployee,
                monthlyDepositEmployer: monthlyDepositEmployer,
                lastUpdatedDate: lastUpdatedDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PensionAssetsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pensionSnapshotsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pensionSnapshotsTableRefs) db.pensionSnapshotsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pensionSnapshotsTableRefs)
                    await $_getPrefetchedData<
                      PensionAssetEntry,
                      $PensionAssetsTableTable,
                      PensionSnapshotEntry
                    >(
                      currentTable: table,
                      referencedTable: $$PensionAssetsTableTableReferences
                          ._pensionSnapshotsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PensionAssetsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).pensionSnapshotsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.pensionAssetId == item.id,
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

typedef $$PensionAssetsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PensionAssetsTableTable,
      PensionAssetEntry,
      $$PensionAssetsTableTableFilterComposer,
      $$PensionAssetsTableTableOrderingComposer,
      $$PensionAssetsTableTableAnnotationComposer,
      $$PensionAssetsTableTableCreateCompanionBuilder,
      $$PensionAssetsTableTableUpdateCompanionBuilder,
      (PensionAssetEntry, $$PensionAssetsTableTableReferences),
      PensionAssetEntry,
      PrefetchHooks Function({bool pensionSnapshotsTableRefs})
    >;
typedef $$PensionSnapshotsTableTableCreateCompanionBuilder =
    PensionSnapshotsTableCompanion Function({
      required String id,
      required String pensionAssetId,
      required double balance,
      required DateTime snapshotDate,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PensionSnapshotsTableTableUpdateCompanionBuilder =
    PensionSnapshotsTableCompanion Function({
      Value<String> id,
      Value<String> pensionAssetId,
      Value<double> balance,
      Value<DateTime> snapshotDate,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PensionSnapshotsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PensionSnapshotsTableTable,
          PensionSnapshotEntry
        > {
  $$PensionSnapshotsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PensionAssetsTableTable _pensionAssetIdTable(_$AppDatabase db) =>
      db.pensionAssetsTable.createAlias(
        $_aliasNameGenerator(
          db.pensionSnapshotsTable.pensionAssetId,
          db.pensionAssetsTable.id,
        ),
      );

  $$PensionAssetsTableTableProcessedTableManager get pensionAssetId {
    final $_column = $_itemColumn<String>('pension_asset_id')!;

    final manager = $$PensionAssetsTableTableTableManager(
      $_db,
      $_db.pensionAssetsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pensionAssetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PensionSnapshotsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PensionSnapshotsTableTable> {
  $$PensionSnapshotsTableTableFilterComposer({
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

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get snapshotDate => $composableBuilder(
    column: $table.snapshotDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PensionAssetsTableTableFilterComposer get pensionAssetId {
    final $$PensionAssetsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pensionAssetId,
      referencedTable: $db.pensionAssetsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PensionAssetsTableTableFilterComposer(
            $db: $db,
            $table: $db.pensionAssetsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PensionSnapshotsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PensionSnapshotsTableTable> {
  $$PensionSnapshotsTableTableOrderingComposer({
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

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get snapshotDate => $composableBuilder(
    column: $table.snapshotDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PensionAssetsTableTableOrderingComposer get pensionAssetId {
    final $$PensionAssetsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pensionAssetId,
      referencedTable: $db.pensionAssetsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PensionAssetsTableTableOrderingComposer(
            $db: $db,
            $table: $db.pensionAssetsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PensionSnapshotsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PensionSnapshotsTableTable> {
  $$PensionSnapshotsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<DateTime> get snapshotDate => $composableBuilder(
    column: $table.snapshotDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PensionAssetsTableTableAnnotationComposer get pensionAssetId {
    final $$PensionAssetsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.pensionAssetId,
          referencedTable: $db.pensionAssetsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PensionAssetsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.pensionAssetsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$PensionSnapshotsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PensionSnapshotsTableTable,
          PensionSnapshotEntry,
          $$PensionSnapshotsTableTableFilterComposer,
          $$PensionSnapshotsTableTableOrderingComposer,
          $$PensionSnapshotsTableTableAnnotationComposer,
          $$PensionSnapshotsTableTableCreateCompanionBuilder,
          $$PensionSnapshotsTableTableUpdateCompanionBuilder,
          (PensionSnapshotEntry, $$PensionSnapshotsTableTableReferences),
          PensionSnapshotEntry,
          PrefetchHooks Function({bool pensionAssetId})
        > {
  $$PensionSnapshotsTableTableTableManager(
    _$AppDatabase db,
    $PensionSnapshotsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PensionSnapshotsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PensionSnapshotsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PensionSnapshotsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pensionAssetId = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<DateTime> snapshotDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PensionSnapshotsTableCompanion(
                id: id,
                pensionAssetId: pensionAssetId,
                balance: balance,
                snapshotDate: snapshotDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pensionAssetId,
                required double balance,
                required DateTime snapshotDate,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PensionSnapshotsTableCompanion.insert(
                id: id,
                pensionAssetId: pensionAssetId,
                balance: balance,
                snapshotDate: snapshotDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PensionSnapshotsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pensionAssetId = false}) {
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
                    if (pensionAssetId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pensionAssetId,
                                referencedTable:
                                    $$PensionSnapshotsTableTableReferences
                                        ._pensionAssetIdTable(db),
                                referencedColumn:
                                    $$PensionSnapshotsTableTableReferences
                                        ._pensionAssetIdTable(db)
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

typedef $$PensionSnapshotsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PensionSnapshotsTableTable,
      PensionSnapshotEntry,
      $$PensionSnapshotsTableTableFilterComposer,
      $$PensionSnapshotsTableTableOrderingComposer,
      $$PensionSnapshotsTableTableAnnotationComposer,
      $$PensionSnapshotsTableTableCreateCompanionBuilder,
      $$PensionSnapshotsTableTableUpdateCompanionBuilder,
      (PensionSnapshotEntry, $$PensionSnapshotsTableTableReferences),
      PensionSnapshotEntry,
      PrefetchHooks Function({bool pensionAssetId})
    >;
typedef $$AssetsTableTableCreateCompanionBuilder =
    AssetsTableCompanion Function({
      required String id,
      required String name,
      required String assetType,
      required double estimatedValue,
      Value<DateTime> lastValuationDate,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AssetsTableTableUpdateCompanionBuilder =
    AssetsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> assetType,
      Value<double> estimatedValue,
      Value<DateTime> lastValuationDate,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$AssetsTableTableReferences
    extends BaseReferences<_$AppDatabase, $AssetsTableTable, AssetEntry> {
  $$AssetsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LiabilitiesTableTable, List<LiabilityEntry>>
  _liabilitiesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.liabilitiesTable,
    aliasName: $_aliasNameGenerator(
      db.assetsTable.id,
      db.liabilitiesTable.assetId,
    ),
  );

  $$LiabilitiesTableTableProcessedTableManager get liabilitiesTableRefs {
    final manager = $$LiabilitiesTableTableTableManager(
      $_db,
      $_db.liabilitiesTable,
    ).filter((f) => f.assetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _liabilitiesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AssetsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AssetsTableTable> {
  $$AssetsTableTableFilterComposer({
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

  ColumnFilters<String> get assetType => $composableBuilder(
    column: $table.assetType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedValue => $composableBuilder(
    column: $table.estimatedValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastValuationDate => $composableBuilder(
    column: $table.lastValuationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
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

  Expression<bool> liabilitiesTableRefs(
    Expression<bool> Function($$LiabilitiesTableTableFilterComposer f) f,
  ) {
    final $$LiabilitiesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.liabilitiesTable,
      getReferencedColumn: (t) => t.assetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LiabilitiesTableTableFilterComposer(
            $db: $db,
            $table: $db.liabilitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AssetsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AssetsTableTable> {
  $$AssetsTableTableOrderingComposer({
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

  ColumnOrderings<String> get assetType => $composableBuilder(
    column: $table.assetType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedValue => $composableBuilder(
    column: $table.estimatedValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastValuationDate => $composableBuilder(
    column: $table.lastValuationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
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

class $$AssetsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssetsTableTable> {
  $$AssetsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get assetType =>
      $composableBuilder(column: $table.assetType, builder: (column) => column);

  GeneratedColumn<double> get estimatedValue => $composableBuilder(
    column: $table.estimatedValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastValuationDate => $composableBuilder(
    column: $table.lastValuationDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> liabilitiesTableRefs<T extends Object>(
    Expression<T> Function($$LiabilitiesTableTableAnnotationComposer a) f,
  ) {
    final $$LiabilitiesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.liabilitiesTable,
      getReferencedColumn: (t) => t.assetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LiabilitiesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.liabilitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AssetsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssetsTableTable,
          AssetEntry,
          $$AssetsTableTableFilterComposer,
          $$AssetsTableTableOrderingComposer,
          $$AssetsTableTableAnnotationComposer,
          $$AssetsTableTableCreateCompanionBuilder,
          $$AssetsTableTableUpdateCompanionBuilder,
          (AssetEntry, $$AssetsTableTableReferences),
          AssetEntry,
          PrefetchHooks Function({bool liabilitiesTableRefs})
        > {
  $$AssetsTableTableTableManager(_$AppDatabase db, $AssetsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssetsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssetsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssetsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> assetType = const Value.absent(),
                Value<double> estimatedValue = const Value.absent(),
                Value<DateTime> lastValuationDate = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssetsTableCompanion(
                id: id,
                name: name,
                assetType: assetType,
                estimatedValue: estimatedValue,
                lastValuationDate: lastValuationDate,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String assetType,
                required double estimatedValue,
                Value<DateTime> lastValuationDate = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssetsTableCompanion.insert(
                id: id,
                name: name,
                assetType: assetType,
                estimatedValue: estimatedValue,
                lastValuationDate: lastValuationDate,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AssetsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({liabilitiesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (liabilitiesTableRefs) db.liabilitiesTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (liabilitiesTableRefs)
                    await $_getPrefetchedData<
                      AssetEntry,
                      $AssetsTableTable,
                      LiabilityEntry
                    >(
                      currentTable: table,
                      referencedTable: $$AssetsTableTableReferences
                          ._liabilitiesTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AssetsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).liabilitiesTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.assetId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AssetsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssetsTableTable,
      AssetEntry,
      $$AssetsTableTableFilterComposer,
      $$AssetsTableTableOrderingComposer,
      $$AssetsTableTableAnnotationComposer,
      $$AssetsTableTableCreateCompanionBuilder,
      $$AssetsTableTableUpdateCompanionBuilder,
      (AssetEntry, $$AssetsTableTableReferences),
      AssetEntry,
      PrefetchHooks Function({bool liabilitiesTableRefs})
    >;
typedef $$LiabilitiesTableTableCreateCompanionBuilder =
    LiabilitiesTableCompanion Function({
      required String id,
      Value<String?> assetId,
      required String name,
      required String liabilityType,
      required double initialPrincipal,
      required double currentPrincipal,
      required double interestRate,
      required double monthlyPayment,
      required int remainingPayments,
      required DateTime startDate,
      required DateTime endDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$LiabilitiesTableTableUpdateCompanionBuilder =
    LiabilitiesTableCompanion Function({
      Value<String> id,
      Value<String?> assetId,
      Value<String> name,
      Value<String> liabilityType,
      Value<double> initialPrincipal,
      Value<double> currentPrincipal,
      Value<double> interestRate,
      Value<double> monthlyPayment,
      Value<int> remainingPayments,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$LiabilitiesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $LiabilitiesTableTable, LiabilityEntry> {
  $$LiabilitiesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AssetsTableTable _assetIdTable(_$AppDatabase db) =>
      db.assetsTable.createAlias(
        $_aliasNameGenerator(db.liabilitiesTable.assetId, db.assetsTable.id),
      );

  $$AssetsTableTableProcessedTableManager? get assetId {
    final $_column = $_itemColumn<String>('asset_id');
    if ($_column == null) return null;
    final manager = $$AssetsTableTableTableManager(
      $_db,
      $_db.assetsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LoanSchedulesTableTable, List<LoanScheduleEntry>>
  _loanSchedulesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.loanSchedulesTable,
        aliasName: $_aliasNameGenerator(
          db.liabilitiesTable.id,
          db.loanSchedulesTable.liabilityId,
        ),
      );

  $$LoanSchedulesTableTableProcessedTableManager get loanSchedulesTableRefs {
    final manager = $$LoanSchedulesTableTableTableManager(
      $_db,
      $_db.loanSchedulesTable,
    ).filter((f) => f.liabilityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _loanSchedulesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LiabilitiesTableTableFilterComposer
    extends Composer<_$AppDatabase, $LiabilitiesTableTable> {
  $$LiabilitiesTableTableFilterComposer({
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

  ColumnFilters<String> get liabilityType => $composableBuilder(
    column: $table.liabilityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get initialPrincipal => $composableBuilder(
    column: $table.initialPrincipal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentPrincipal => $composableBuilder(
    column: $table.currentPrincipal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monthlyPayment => $composableBuilder(
    column: $table.monthlyPayment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remainingPayments => $composableBuilder(
    column: $table.remainingPayments,
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AssetsTableTableFilterComposer get assetId {
    final $$AssetsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assetId,
      referencedTable: $db.assetsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableTableFilterComposer(
            $db: $db,
            $table: $db.assetsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> loanSchedulesTableRefs(
    Expression<bool> Function($$LoanSchedulesTableTableFilterComposer f) f,
  ) {
    final $$LoanSchedulesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loanSchedulesTable,
      getReferencedColumn: (t) => t.liabilityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoanSchedulesTableTableFilterComposer(
            $db: $db,
            $table: $db.loanSchedulesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LiabilitiesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LiabilitiesTableTable> {
  $$LiabilitiesTableTableOrderingComposer({
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

  ColumnOrderings<String> get liabilityType => $composableBuilder(
    column: $table.liabilityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get initialPrincipal => $composableBuilder(
    column: $table.initialPrincipal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentPrincipal => $composableBuilder(
    column: $table.currentPrincipal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monthlyPayment => $composableBuilder(
    column: $table.monthlyPayment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remainingPayments => $composableBuilder(
    column: $table.remainingPayments,
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AssetsTableTableOrderingComposer get assetId {
    final $$AssetsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assetId,
      referencedTable: $db.assetsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableTableOrderingComposer(
            $db: $db,
            $table: $db.assetsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LiabilitiesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LiabilitiesTableTable> {
  $$LiabilitiesTableTableAnnotationComposer({
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

  GeneratedColumn<String> get liabilityType => $composableBuilder(
    column: $table.liabilityType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get initialPrincipal => $composableBuilder(
    column: $table.initialPrincipal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentPrincipal => $composableBuilder(
    column: $table.currentPrincipal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get monthlyPayment => $composableBuilder(
    column: $table.monthlyPayment,
    builder: (column) => column,
  );

  GeneratedColumn<int> get remainingPayments => $composableBuilder(
    column: $table.remainingPayments,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AssetsTableTableAnnotationComposer get assetId {
    final $$AssetsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assetId,
      referencedTable: $db.assetsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.assetsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> loanSchedulesTableRefs<T extends Object>(
    Expression<T> Function($$LoanSchedulesTableTableAnnotationComposer a) f,
  ) {
    final $$LoanSchedulesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.loanSchedulesTable,
          getReferencedColumn: (t) => t.liabilityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LoanSchedulesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.loanSchedulesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LiabilitiesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LiabilitiesTableTable,
          LiabilityEntry,
          $$LiabilitiesTableTableFilterComposer,
          $$LiabilitiesTableTableOrderingComposer,
          $$LiabilitiesTableTableAnnotationComposer,
          $$LiabilitiesTableTableCreateCompanionBuilder,
          $$LiabilitiesTableTableUpdateCompanionBuilder,
          (LiabilityEntry, $$LiabilitiesTableTableReferences),
          LiabilityEntry,
          PrefetchHooks Function({bool assetId, bool loanSchedulesTableRefs})
        > {
  $$LiabilitiesTableTableTableManager(
    _$AppDatabase db,
    $LiabilitiesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LiabilitiesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LiabilitiesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LiabilitiesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> assetId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> liabilityType = const Value.absent(),
                Value<double> initialPrincipal = const Value.absent(),
                Value<double> currentPrincipal = const Value.absent(),
                Value<double> interestRate = const Value.absent(),
                Value<double> monthlyPayment = const Value.absent(),
                Value<int> remainingPayments = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LiabilitiesTableCompanion(
                id: id,
                assetId: assetId,
                name: name,
                liabilityType: liabilityType,
                initialPrincipal: initialPrincipal,
                currentPrincipal: currentPrincipal,
                interestRate: interestRate,
                monthlyPayment: monthlyPayment,
                remainingPayments: remainingPayments,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> assetId = const Value.absent(),
                required String name,
                required String liabilityType,
                required double initialPrincipal,
                required double currentPrincipal,
                required double interestRate,
                required double monthlyPayment,
                required int remainingPayments,
                required DateTime startDate,
                required DateTime endDate,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LiabilitiesTableCompanion.insert(
                id: id,
                assetId: assetId,
                name: name,
                liabilityType: liabilityType,
                initialPrincipal: initialPrincipal,
                currentPrincipal: currentPrincipal,
                interestRate: interestRate,
                monthlyPayment: monthlyPayment,
                remainingPayments: remainingPayments,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LiabilitiesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({assetId = false, loanSchedulesTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (loanSchedulesTableRefs) db.loanSchedulesTable,
                  ],
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
                        if (assetId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.assetId,
                                    referencedTable:
                                        $$LiabilitiesTableTableReferences
                                            ._assetIdTable(db),
                                    referencedColumn:
                                        $$LiabilitiesTableTableReferences
                                            ._assetIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (loanSchedulesTableRefs)
                        await $_getPrefetchedData<
                          LiabilityEntry,
                          $LiabilitiesTableTable,
                          LoanScheduleEntry
                        >(
                          currentTable: table,
                          referencedTable: $$LiabilitiesTableTableReferences
                              ._loanSchedulesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LiabilitiesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).loanSchedulesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.liabilityId == item.id,
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

typedef $$LiabilitiesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LiabilitiesTableTable,
      LiabilityEntry,
      $$LiabilitiesTableTableFilterComposer,
      $$LiabilitiesTableTableOrderingComposer,
      $$LiabilitiesTableTableAnnotationComposer,
      $$LiabilitiesTableTableCreateCompanionBuilder,
      $$LiabilitiesTableTableUpdateCompanionBuilder,
      (LiabilityEntry, $$LiabilitiesTableTableReferences),
      LiabilityEntry,
      PrefetchHooks Function({bool assetId, bool loanSchedulesTableRefs})
    >;
typedef $$LoanSchedulesTableTableCreateCompanionBuilder =
    LoanSchedulesTableCompanion Function({
      required String id,
      required String liabilityId,
      required int paymentNumber,
      required DateTime paymentDate,
      required double principalComponent,
      required double interestComponent,
      required double remainingBalance,
      Value<bool> isPaid,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$LoanSchedulesTableTableUpdateCompanionBuilder =
    LoanSchedulesTableCompanion Function({
      Value<String> id,
      Value<String> liabilityId,
      Value<int> paymentNumber,
      Value<DateTime> paymentDate,
      Value<double> principalComponent,
      Value<double> interestComponent,
      Value<double> remainingBalance,
      Value<bool> isPaid,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$LoanSchedulesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LoanSchedulesTableTable,
          LoanScheduleEntry
        > {
  $$LoanSchedulesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LiabilitiesTableTable _liabilityIdTable(_$AppDatabase db) =>
      db.liabilitiesTable.createAlias(
        $_aliasNameGenerator(
          db.loanSchedulesTable.liabilityId,
          db.liabilitiesTable.id,
        ),
      );

  $$LiabilitiesTableTableProcessedTableManager get liabilityId {
    final $_column = $_itemColumn<String>('liability_id')!;

    final manager = $$LiabilitiesTableTableTableManager(
      $_db,
      $_db.liabilitiesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_liabilityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LoanSchedulesTableTableFilterComposer
    extends Composer<_$AppDatabase, $LoanSchedulesTableTable> {
  $$LoanSchedulesTableTableFilterComposer({
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

  ColumnFilters<int> get paymentNumber => $composableBuilder(
    column: $table.paymentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get principalComponent => $composableBuilder(
    column: $table.principalComponent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get interestComponent => $composableBuilder(
    column: $table.interestComponent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get remainingBalance => $composableBuilder(
    column: $table.remainingBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPaid => $composableBuilder(
    column: $table.isPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LiabilitiesTableTableFilterComposer get liabilityId {
    final $$LiabilitiesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.liabilityId,
      referencedTable: $db.liabilitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LiabilitiesTableTableFilterComposer(
            $db: $db,
            $table: $db.liabilitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LoanSchedulesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LoanSchedulesTableTable> {
  $$LoanSchedulesTableTableOrderingComposer({
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

  ColumnOrderings<int> get paymentNumber => $composableBuilder(
    column: $table.paymentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get principalComponent => $composableBuilder(
    column: $table.principalComponent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get interestComponent => $composableBuilder(
    column: $table.interestComponent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get remainingBalance => $composableBuilder(
    column: $table.remainingBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPaid => $composableBuilder(
    column: $table.isPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LiabilitiesTableTableOrderingComposer get liabilityId {
    final $$LiabilitiesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.liabilityId,
      referencedTable: $db.liabilitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LiabilitiesTableTableOrderingComposer(
            $db: $db,
            $table: $db.liabilitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LoanSchedulesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoanSchedulesTableTable> {
  $$LoanSchedulesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get paymentNumber => $composableBuilder(
    column: $table.paymentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get principalComponent => $composableBuilder(
    column: $table.principalComponent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get interestComponent => $composableBuilder(
    column: $table.interestComponent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get remainingBalance => $composableBuilder(
    column: $table.remainingBalance,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPaid =>
      $composableBuilder(column: $table.isPaid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LiabilitiesTableTableAnnotationComposer get liabilityId {
    final $$LiabilitiesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.liabilityId,
      referencedTable: $db.liabilitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LiabilitiesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.liabilitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LoanSchedulesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LoanSchedulesTableTable,
          LoanScheduleEntry,
          $$LoanSchedulesTableTableFilterComposer,
          $$LoanSchedulesTableTableOrderingComposer,
          $$LoanSchedulesTableTableAnnotationComposer,
          $$LoanSchedulesTableTableCreateCompanionBuilder,
          $$LoanSchedulesTableTableUpdateCompanionBuilder,
          (LoanScheduleEntry, $$LoanSchedulesTableTableReferences),
          LoanScheduleEntry,
          PrefetchHooks Function({bool liabilityId})
        > {
  $$LoanSchedulesTableTableTableManager(
    _$AppDatabase db,
    $LoanSchedulesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoanSchedulesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoanSchedulesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoanSchedulesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> liabilityId = const Value.absent(),
                Value<int> paymentNumber = const Value.absent(),
                Value<DateTime> paymentDate = const Value.absent(),
                Value<double> principalComponent = const Value.absent(),
                Value<double> interestComponent = const Value.absent(),
                Value<double> remainingBalance = const Value.absent(),
                Value<bool> isPaid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LoanSchedulesTableCompanion(
                id: id,
                liabilityId: liabilityId,
                paymentNumber: paymentNumber,
                paymentDate: paymentDate,
                principalComponent: principalComponent,
                interestComponent: interestComponent,
                remainingBalance: remainingBalance,
                isPaid: isPaid,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String liabilityId,
                required int paymentNumber,
                required DateTime paymentDate,
                required double principalComponent,
                required double interestComponent,
                required double remainingBalance,
                Value<bool> isPaid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LoanSchedulesTableCompanion.insert(
                id: id,
                liabilityId: liabilityId,
                paymentNumber: paymentNumber,
                paymentDate: paymentDate,
                principalComponent: principalComponent,
                interestComponent: interestComponent,
                remainingBalance: remainingBalance,
                isPaid: isPaid,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LoanSchedulesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({liabilityId = false}) {
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
                    if (liabilityId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.liabilityId,
                                referencedTable:
                                    $$LoanSchedulesTableTableReferences
                                        ._liabilityIdTable(db),
                                referencedColumn:
                                    $$LoanSchedulesTableTableReferences
                                        ._liabilityIdTable(db)
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

typedef $$LoanSchedulesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LoanSchedulesTableTable,
      LoanScheduleEntry,
      $$LoanSchedulesTableTableFilterComposer,
      $$LoanSchedulesTableTableOrderingComposer,
      $$LoanSchedulesTableTableAnnotationComposer,
      $$LoanSchedulesTableTableCreateCompanionBuilder,
      $$LoanSchedulesTableTableUpdateCompanionBuilder,
      (LoanScheduleEntry, $$LoanSchedulesTableTableReferences),
      LoanScheduleEntry,
      PrefetchHooks Function({bool liabilityId})
    >;
typedef $$ExchangeRatesTableTableCreateCompanionBuilder =
    ExchangeRatesTableCompanion Function({
      required String id,
      required String baseCurrency,
      Value<String> targetCurrency,
      required double rate,
      Value<DateTime> timestamp,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ExchangeRatesTableTableUpdateCompanionBuilder =
    ExchangeRatesTableCompanion Function({
      Value<String> id,
      Value<String> baseCurrency,
      Value<String> targetCurrency,
      Value<double> rate,
      Value<DateTime> timestamp,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ExchangeRatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTableTable> {
  $$ExchangeRatesTableTableFilterComposer({
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

  ColumnFilters<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetCurrency => $composableBuilder(
    column: $table.targetCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExchangeRatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTableTable> {
  $$ExchangeRatesTableTableOrderingComposer({
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

  ColumnOrderings<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetCurrency => $composableBuilder(
    column: $table.targetCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExchangeRatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTableTable> {
  $$ExchangeRatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetCurrency => $composableBuilder(
    column: $table.targetCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ExchangeRatesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExchangeRatesTableTable,
          ExchangeRateEntry,
          $$ExchangeRatesTableTableFilterComposer,
          $$ExchangeRatesTableTableOrderingComposer,
          $$ExchangeRatesTableTableAnnotationComposer,
          $$ExchangeRatesTableTableCreateCompanionBuilder,
          $$ExchangeRatesTableTableUpdateCompanionBuilder,
          (
            ExchangeRateEntry,
            BaseReferences<
              _$AppDatabase,
              $ExchangeRatesTableTable,
              ExchangeRateEntry
            >,
          ),
          ExchangeRateEntry,
          PrefetchHooks Function()
        > {
  $$ExchangeRatesTableTableTableManager(
    _$AppDatabase db,
    $ExchangeRatesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExchangeRatesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExchangeRatesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExchangeRatesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                Value<String> targetCurrency = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExchangeRatesTableCompanion(
                id: id,
                baseCurrency: baseCurrency,
                targetCurrency: targetCurrency,
                rate: rate,
                timestamp: timestamp,
                source: source,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String baseCurrency,
                Value<String> targetCurrency = const Value.absent(),
                required double rate,
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExchangeRatesTableCompanion.insert(
                id: id,
                baseCurrency: baseCurrency,
                targetCurrency: targetCurrency,
                rate: rate,
                timestamp: timestamp,
                source: source,
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

typedef $$ExchangeRatesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExchangeRatesTableTable,
      ExchangeRateEntry,
      $$ExchangeRatesTableTableFilterComposer,
      $$ExchangeRatesTableTableOrderingComposer,
      $$ExchangeRatesTableTableAnnotationComposer,
      $$ExchangeRatesTableTableCreateCompanionBuilder,
      $$ExchangeRatesTableTableUpdateCompanionBuilder,
      (
        ExchangeRateEntry,
        BaseReferences<
          _$AppDatabase,
          $ExchangeRatesTableTable,
          ExchangeRateEntry
        >,
      ),
      ExchangeRateEntry,
      PrefetchHooks Function()
    >;
typedef $$PriceQuotesTableTableCreateCompanionBuilder =
    PriceQuotesTableCompanion Function({
      required String id,
      required String ticker,
      required double price,
      Value<double> changePercent,
      Value<DateTime> timestamp,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PriceQuotesTableTableUpdateCompanionBuilder =
    PriceQuotesTableCompanion Function({
      Value<String> id,
      Value<String> ticker,
      Value<double> price,
      Value<double> changePercent,
      Value<DateTime> timestamp,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$PriceQuotesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PriceQuotesTableTable> {
  $$PriceQuotesTableTableFilterComposer({
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

  ColumnFilters<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get changePercent => $composableBuilder(
    column: $table.changePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PriceQuotesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PriceQuotesTableTable> {
  $$PriceQuotesTableTableOrderingComposer({
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

  ColumnOrderings<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get changePercent => $composableBuilder(
    column: $table.changePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PriceQuotesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PriceQuotesTableTable> {
  $$PriceQuotesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ticker =>
      $composableBuilder(column: $table.ticker, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get changePercent => $composableBuilder(
    column: $table.changePercent,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PriceQuotesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PriceQuotesTableTable,
          PriceQuoteEntry,
          $$PriceQuotesTableTableFilterComposer,
          $$PriceQuotesTableTableOrderingComposer,
          $$PriceQuotesTableTableAnnotationComposer,
          $$PriceQuotesTableTableCreateCompanionBuilder,
          $$PriceQuotesTableTableUpdateCompanionBuilder,
          (
            PriceQuoteEntry,
            BaseReferences<
              _$AppDatabase,
              $PriceQuotesTableTable,
              PriceQuoteEntry
            >,
          ),
          PriceQuoteEntry,
          PrefetchHooks Function()
        > {
  $$PriceQuotesTableTableTableManager(
    _$AppDatabase db,
    $PriceQuotesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PriceQuotesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PriceQuotesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PriceQuotesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ticker = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double> changePercent = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PriceQuotesTableCompanion(
                id: id,
                ticker: ticker,
                price: price,
                changePercent: changePercent,
                timestamp: timestamp,
                source: source,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ticker,
                required double price,
                Value<double> changePercent = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PriceQuotesTableCompanion.insert(
                id: id,
                ticker: ticker,
                price: price,
                changePercent: changePercent,
                timestamp: timestamp,
                source: source,
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

typedef $$PriceQuotesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PriceQuotesTableTable,
      PriceQuoteEntry,
      $$PriceQuotesTableTableFilterComposer,
      $$PriceQuotesTableTableOrderingComposer,
      $$PriceQuotesTableTableAnnotationComposer,
      $$PriceQuotesTableTableCreateCompanionBuilder,
      $$PriceQuotesTableTableUpdateCompanionBuilder,
      (
        PriceQuoteEntry,
        BaseReferences<_$AppDatabase, $PriceQuotesTableTable, PriceQuoteEntry>,
      ),
      PriceQuoteEntry,
      PrefetchHooks Function()
    >;
typedef $$NetWorthSnapshotsTableTableCreateCompanionBuilder =
    NetWorthSnapshotsTableCompanion Function({
      required String id,
      required DateTime snapshotDate,
      required double totalLiquidAssets,
      required double totalInvestments,
      required double totalPension,
      required double totalRealEstate,
      required double totalLiabilities,
      required double netWorth,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$NetWorthSnapshotsTableTableUpdateCompanionBuilder =
    NetWorthSnapshotsTableCompanion Function({
      Value<String> id,
      Value<DateTime> snapshotDate,
      Value<double> totalLiquidAssets,
      Value<double> totalInvestments,
      Value<double> totalPension,
      Value<double> totalRealEstate,
      Value<double> totalLiabilities,
      Value<double> netWorth,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$NetWorthSnapshotsTableTableFilterComposer
    extends Composer<_$AppDatabase, $NetWorthSnapshotsTableTable> {
  $$NetWorthSnapshotsTableTableFilterComposer({
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

  ColumnFilters<DateTime> get snapshotDate => $composableBuilder(
    column: $table.snapshotDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalLiquidAssets => $composableBuilder(
    column: $table.totalLiquidAssets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalInvestments => $composableBuilder(
    column: $table.totalInvestments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPension => $composableBuilder(
    column: $table.totalPension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalRealEstate => $composableBuilder(
    column: $table.totalRealEstate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalLiabilities => $composableBuilder(
    column: $table.totalLiabilities,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netWorth => $composableBuilder(
    column: $table.netWorth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NetWorthSnapshotsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NetWorthSnapshotsTableTable> {
  $$NetWorthSnapshotsTableTableOrderingComposer({
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

  ColumnOrderings<DateTime> get snapshotDate => $composableBuilder(
    column: $table.snapshotDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalLiquidAssets => $composableBuilder(
    column: $table.totalLiquidAssets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalInvestments => $composableBuilder(
    column: $table.totalInvestments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPension => $composableBuilder(
    column: $table.totalPension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalRealEstate => $composableBuilder(
    column: $table.totalRealEstate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalLiabilities => $composableBuilder(
    column: $table.totalLiabilities,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netWorth => $composableBuilder(
    column: $table.netWorth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NetWorthSnapshotsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NetWorthSnapshotsTableTable> {
  $$NetWorthSnapshotsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get snapshotDate => $composableBuilder(
    column: $table.snapshotDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalLiquidAssets => $composableBuilder(
    column: $table.totalLiquidAssets,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalInvestments => $composableBuilder(
    column: $table.totalInvestments,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalPension => $composableBuilder(
    column: $table.totalPension,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalRealEstate => $composableBuilder(
    column: $table.totalRealEstate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalLiabilities => $composableBuilder(
    column: $table.totalLiabilities,
    builder: (column) => column,
  );

  GeneratedColumn<double> get netWorth =>
      $composableBuilder(column: $table.netWorth, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NetWorthSnapshotsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NetWorthSnapshotsTableTable,
          NetWorthSnapshotEntry,
          $$NetWorthSnapshotsTableTableFilterComposer,
          $$NetWorthSnapshotsTableTableOrderingComposer,
          $$NetWorthSnapshotsTableTableAnnotationComposer,
          $$NetWorthSnapshotsTableTableCreateCompanionBuilder,
          $$NetWorthSnapshotsTableTableUpdateCompanionBuilder,
          (
            NetWorthSnapshotEntry,
            BaseReferences<
              _$AppDatabase,
              $NetWorthSnapshotsTableTable,
              NetWorthSnapshotEntry
            >,
          ),
          NetWorthSnapshotEntry,
          PrefetchHooks Function()
        > {
  $$NetWorthSnapshotsTableTableTableManager(
    _$AppDatabase db,
    $NetWorthSnapshotsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NetWorthSnapshotsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NetWorthSnapshotsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NetWorthSnapshotsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> snapshotDate = const Value.absent(),
                Value<double> totalLiquidAssets = const Value.absent(),
                Value<double> totalInvestments = const Value.absent(),
                Value<double> totalPension = const Value.absent(),
                Value<double> totalRealEstate = const Value.absent(),
                Value<double> totalLiabilities = const Value.absent(),
                Value<double> netWorth = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NetWorthSnapshotsTableCompanion(
                id: id,
                snapshotDate: snapshotDate,
                totalLiquidAssets: totalLiquidAssets,
                totalInvestments: totalInvestments,
                totalPension: totalPension,
                totalRealEstate: totalRealEstate,
                totalLiabilities: totalLiabilities,
                netWorth: netWorth,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime snapshotDate,
                required double totalLiquidAssets,
                required double totalInvestments,
                required double totalPension,
                required double totalRealEstate,
                required double totalLiabilities,
                required double netWorth,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NetWorthSnapshotsTableCompanion.insert(
                id: id,
                snapshotDate: snapshotDate,
                totalLiquidAssets: totalLiquidAssets,
                totalInvestments: totalInvestments,
                totalPension: totalPension,
                totalRealEstate: totalRealEstate,
                totalLiabilities: totalLiabilities,
                netWorth: netWorth,
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

typedef $$NetWorthSnapshotsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NetWorthSnapshotsTableTable,
      NetWorthSnapshotEntry,
      $$NetWorthSnapshotsTableTableFilterComposer,
      $$NetWorthSnapshotsTableTableOrderingComposer,
      $$NetWorthSnapshotsTableTableAnnotationComposer,
      $$NetWorthSnapshotsTableTableCreateCompanionBuilder,
      $$NetWorthSnapshotsTableTableUpdateCompanionBuilder,
      (
        NetWorthSnapshotEntry,
        BaseReferences<
          _$AppDatabase,
          $NetWorthSnapshotsTableTable,
          NetWorthSnapshotEntry
        >,
      ),
      NetWorthSnapshotEntry,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableTableCreateCompanionBuilder =
    AppSettingsTableCompanion Function({
      required String id,
      Value<String> baseCurrency,
      Value<bool> isBiometricEnabled,
      Value<int> autoLockTimeoutSeconds,
      Value<DateTime?> lastBackupDate,
      Value<bool> isAutoBackupEnabled,
      Value<String> backupFrequency,
      Value<String> themeMode,
      Value<String?> customSettingsJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableTableUpdateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<String> id,
      Value<String> baseCurrency,
      Value<bool> isBiometricEnabled,
      Value<int> autoLockTimeoutSeconds,
      Value<DateTime?> lastBackupDate,
      Value<bool> isAutoBackupEnabled,
      Value<String> backupFrequency,
      Value<String> themeMode,
      Value<String?> customSettingsJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableFilterComposer({
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

  ColumnFilters<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBiometricEnabled => $composableBuilder(
    column: $table.isBiometricEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get autoLockTimeoutSeconds => $composableBuilder(
    column: $table.autoLockTimeoutSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackupDate => $composableBuilder(
    column: $table.lastBackupDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAutoBackupEnabled => $composableBuilder(
    column: $table.isAutoBackupEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backupFrequency => $composableBuilder(
    column: $table.backupFrequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customSettingsJson => $composableBuilder(
    column: $table.customSettingsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableOrderingComposer({
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

  ColumnOrderings<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBiometricEnabled => $composableBuilder(
    column: $table.isBiometricEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get autoLockTimeoutSeconds => $composableBuilder(
    column: $table.autoLockTimeoutSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackupDate => $composableBuilder(
    column: $table.lastBackupDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAutoBackupEnabled => $composableBuilder(
    column: $table.isAutoBackupEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backupFrequency => $composableBuilder(
    column: $table.backupFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customSettingsJson => $composableBuilder(
    column: $table.customSettingsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBiometricEnabled => $composableBuilder(
    column: $table.isBiometricEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get autoLockTimeoutSeconds => $composableBuilder(
    column: $table.autoLockTimeoutSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBackupDate => $composableBuilder(
    column: $table.lastBackupDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAutoBackupEnabled => $composableBuilder(
    column: $table.isAutoBackupEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backupFrequency => $composableBuilder(
    column: $table.backupFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get customSettingsJson => $composableBuilder(
    column: $table.customSettingsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTableTable,
          AppSettingEntry,
          $$AppSettingsTableTableFilterComposer,
          $$AppSettingsTableTableOrderingComposer,
          $$AppSettingsTableTableAnnotationComposer,
          $$AppSettingsTableTableCreateCompanionBuilder,
          $$AppSettingsTableTableUpdateCompanionBuilder,
          (
            AppSettingEntry,
            BaseReferences<
              _$AppDatabase,
              $AppSettingsTableTable,
              AppSettingEntry
            >,
          ),
          AppSettingEntry,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableTableManager(
    _$AppDatabase db,
    $AppSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                Value<bool> isBiometricEnabled = const Value.absent(),
                Value<int> autoLockTimeoutSeconds = const Value.absent(),
                Value<DateTime?> lastBackupDate = const Value.absent(),
                Value<bool> isAutoBackupEnabled = const Value.absent(),
                Value<String> backupFrequency = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String?> customSettingsJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsTableCompanion(
                id: id,
                baseCurrency: baseCurrency,
                isBiometricEnabled: isBiometricEnabled,
                autoLockTimeoutSeconds: autoLockTimeoutSeconds,
                lastBackupDate: lastBackupDate,
                isAutoBackupEnabled: isAutoBackupEnabled,
                backupFrequency: backupFrequency,
                themeMode: themeMode,
                customSettingsJson: customSettingsJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> baseCurrency = const Value.absent(),
                Value<bool> isBiometricEnabled = const Value.absent(),
                Value<int> autoLockTimeoutSeconds = const Value.absent(),
                Value<DateTime?> lastBackupDate = const Value.absent(),
                Value<bool> isAutoBackupEnabled = const Value.absent(),
                Value<String> backupFrequency = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String?> customSettingsJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsTableCompanion.insert(
                id: id,
                baseCurrency: baseCurrency,
                isBiometricEnabled: isBiometricEnabled,
                autoLockTimeoutSeconds: autoLockTimeoutSeconds,
                lastBackupDate: lastBackupDate,
                isAutoBackupEnabled: isAutoBackupEnabled,
                backupFrequency: backupFrequency,
                themeMode: themeMode,
                customSettingsJson: customSettingsJson,
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

typedef $$AppSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTableTable,
      AppSettingEntry,
      $$AppSettingsTableTableFilterComposer,
      $$AppSettingsTableTableOrderingComposer,
      $$AppSettingsTableTableAnnotationComposer,
      $$AppSettingsTableTableCreateCompanionBuilder,
      $$AppSettingsTableTableUpdateCompanionBuilder,
      (
        AppSettingEntry,
        BaseReferences<_$AppDatabase, $AppSettingsTableTable, AppSettingEntry>,
      ),
      AppSettingEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountsTableTableTableManager get accountsTable =>
      $$AccountsTableTableTableManager(_db, _db.accountsTable);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$TagsTableTableTableManager get tagsTable =>
      $$TagsTableTableTableManager(_db, _db.tagsTable);
  $$MerchantsTableTableTableManager get merchantsTable =>
      $$MerchantsTableTableTableManager(_db, _db.merchantsTable);
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(_db, _db.transactionsTable);
  $$TransactionSplitsTableTableTableManager get transactionSplitsTable =>
      $$TransactionSplitsTableTableTableManager(
        _db,
        _db.transactionSplitsTable,
      );
  $$InstallmentPlansTableTableTableManager get installmentPlansTable =>
      $$InstallmentPlansTableTableTableManager(_db, _db.installmentPlansTable);
  $$InstallmentItemsTableTableTableManager get installmentItemsTable =>
      $$InstallmentItemsTableTableTableManager(_db, _db.installmentItemsTable);
  $$RecurringRulesTableTableTableManager get recurringRulesTable =>
      $$RecurringRulesTableTableTableManager(_db, _db.recurringRulesTable);
  $$TransferLinksTableTableTableManager get transferLinksTable =>
      $$TransferLinksTableTableTableManager(_db, _db.transferLinksTable);
  $$BudgetsTableTableTableManager get budgetsTable =>
      $$BudgetsTableTableTableManager(_db, _db.budgetsTable);
  $$BudgetPeriodsTableTableTableManager get budgetPeriodsTable =>
      $$BudgetPeriodsTableTableTableManager(_db, _db.budgetPeriodsTable);
  $$ImportBatchesTableTableTableManager get importBatchesTable =>
      $$ImportBatchesTableTableTableManager(_db, _db.importBatchesTable);
  $$ImportMappingsTableTableTableManager get importMappingsTable =>
      $$ImportMappingsTableTableTableManager(_db, _db.importMappingsTable);
  $$SecuritiesTableTableTableManager get securitiesTable =>
      $$SecuritiesTableTableTableManager(_db, _db.securitiesTable);
  $$HoldingsTableTableTableManager get holdingsTable =>
      $$HoldingsTableTableTableManager(_db, _db.holdingsTable);
  $$InvestmentTransactionsTableTableTableManager
  get investmentTransactionsTable =>
      $$InvestmentTransactionsTableTableTableManager(
        _db,
        _db.investmentTransactionsTable,
      );
  $$PensionAssetsTableTableTableManager get pensionAssetsTable =>
      $$PensionAssetsTableTableTableManager(_db, _db.pensionAssetsTable);
  $$PensionSnapshotsTableTableTableManager get pensionSnapshotsTable =>
      $$PensionSnapshotsTableTableTableManager(_db, _db.pensionSnapshotsTable);
  $$AssetsTableTableTableManager get assetsTable =>
      $$AssetsTableTableTableManager(_db, _db.assetsTable);
  $$LiabilitiesTableTableTableManager get liabilitiesTable =>
      $$LiabilitiesTableTableTableManager(_db, _db.liabilitiesTable);
  $$LoanSchedulesTableTableTableManager get loanSchedulesTable =>
      $$LoanSchedulesTableTableTableManager(_db, _db.loanSchedulesTable);
  $$ExchangeRatesTableTableTableManager get exchangeRatesTable =>
      $$ExchangeRatesTableTableTableManager(_db, _db.exchangeRatesTable);
  $$PriceQuotesTableTableTableManager get priceQuotesTable =>
      $$PriceQuotesTableTableTableManager(_db, _db.priceQuotesTable);
  $$NetWorthSnapshotsTableTableTableManager get netWorthSnapshotsTable =>
      $$NetWorthSnapshotsTableTableTableManager(
        _db,
        _db.netWorthSnapshotsTable,
      );
  $$AppSettingsTableTableTableManager get appSettingsTable =>
      $$AppSettingsTableTableTableManager(_db, _db.appSettingsTable);
}
