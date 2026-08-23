import 'package:drift/drift.dart';
import '../app_database.dart';

/// Initial Seed Data loaded when database is first created
class InitialSeedData {
  static Future<void> seed(AppDatabase db) async {
    final now = DateTime.now();

    // 1. Initial Categories
    final categories = <CategoriesTableCompanion>[
      // === EXPENSE PARENT CATEGORIES ===
      _createCat(id: 'cat_housing', name: 'דיור ומגורים', type: 'expense', classification: 'needs', flex: 'fixed', color: 0xFF3B82F6, icon: 'housing', isDefault: true),
      _createCat(id: 'cat_housing_rent', parentId: 'cat_housing', name: 'שכר דירה / משכנתא', type: 'expense', classification: 'needs', flex: 'fixed', color: 0xFF3B82F6, icon: 'rent', isDefault: true),
      _createCat(id: 'cat_housing_utilities', parentId: 'cat_housing', name: 'חשמל, מים וגז', type: 'expense', classification: 'needs', flex: 'variable', color: 0xFF3B82F6, icon: 'utilities', isDefault: true),
      _createCat(id: 'cat_housing_taxes', parentId: 'cat_housing', name: 'ארנונה וועד בית', type: 'expense', classification: 'needs', flex: 'fixed', color: 0xFF3B82F6, icon: 'housing', isDefault: true),

      _createCat(id: 'cat_food', name: 'מזון ומצרכים', type: 'expense', classification: 'needs', flex: 'variable', color: 0xFF10B981, icon: 'groceries', isDefault: true),
      _createCat(id: 'cat_food_groceries', parentId: 'cat_food', name: 'סופרמרקט ומכולת', type: 'expense', classification: 'needs', flex: 'variable', color: 0xFF10B981, icon: 'groceries', isDefault: true),
      _createCat(id: 'cat_food_dining', parentId: 'cat_food', name: 'מסעדות ובתי קפה', type: 'expense', classification: 'wants', flex: 'variable', color: 0xFF10B981, icon: 'foodDining', isDefault: true),
      _createCat(id: 'cat_food_deliveries', parentId: 'cat_food', name: 'משלוחי אוכל ו-Wolt', type: 'expense', classification: 'wants', flex: 'variable', color: 0xFF10B981, icon: 'foodDining', isDefault: true),

      _createCat(id: 'cat_transport', name: 'תחבורה ורכב', type: 'expense', classification: 'needs', flex: 'variable', color: 0xFFF59E0B, icon: 'transportation', isDefault: true),
      _createCat(id: 'cat_transport_fuel', parentId: 'cat_transport', name: 'דלק וטעינה', type: 'expense', classification: 'needs', flex: 'variable', color: 0xFFF59E0B, icon: 'gas', isDefault: true),
      _createCat(id: 'cat_transport_public', parentId: 'cat_transport', name: 'תחבורה ציבורית ורכבת', type: 'expense', classification: 'needs', flex: 'variable', color: 0xFFF59E0B, icon: 'publicTransit', isDefault: true),
      _createCat(id: 'cat_transport_insurance', parentId: 'cat_transport', name: 'ביטוח וטסט לרכב', type: 'expense', classification: 'needs', flex: 'fixed', color: 0xFFF59E0B, icon: 'insurance', isDefault: true),
      _createCat(id: 'cat_transport_repairs', parentId: 'cat_transport', name: 'טיפולים ותיקונים', type: 'expense', classification: 'needs', flex: 'variable', color: 0xFFF59E0B, icon: 'transportation', isDefault: true),

      _createCat(id: 'cat_shopping', name: 'קניות והלבשה', type: 'expense', classification: 'wants', flex: 'variable', color: 0xFFEC4899, icon: 'shopping', isDefault: true),
      _createCat(id: 'cat_shopping_clothes', parentId: 'cat_shopping', name: 'ביגוד והנעלה', type: 'expense', classification: 'wants', flex: 'variable', color: 0xFFEC4899, icon: 'shopping', isDefault: true),
      _createCat(id: 'cat_shopping_electronics', parentId: 'cat_shopping', name: 'מוצרי חשמל ואלקטרוניקה', type: 'expense', classification: 'wants', flex: 'variable', color: 0xFFEC4899, icon: 'electronics', isDefault: true),

      _createCat(id: 'cat_leisure', name: 'פנאי ובידור', type: 'expense', classification: 'wants', flex: 'variable', color: 0xFF8B5CF6, icon: 'entertainment', isDefault: true),
      _createCat(id: 'cat_leisure_vacation', parentId: 'cat_leisure', name: 'חופשות וטיסות', type: 'expense', classification: 'wants', flex: 'variable', color: 0xFF8B5CF6, icon: 'travel', isDefault: true),
      _createCat(id: 'cat_leisure_subs', parentId: 'cat_leisure', name: 'מנויים וסטרימינג', type: 'expense', classification: 'wants', flex: 'fixed', color: 0xFF8B5CF6, icon: 'entertainment', isDefault: true),
      _createCat(id: 'cat_leisure_fitness', parentId: 'cat_leisure', name: 'כושר וספורט', type: 'expense', classification: 'wants', flex: 'fixed', color: 0xFF8B5CF6, icon: 'fitness', isDefault: true),

      _createCat(id: 'cat_health', name: 'בריאות ורפואה', type: 'expense', classification: 'needs', flex: 'variable', color: 0xFF06B6D4, icon: 'healthcare', isDefault: true),
      _createCat(id: 'cat_health_pharmacy', parentId: 'cat_health', name: 'תרופות ופארם', type: 'expense', classification: 'needs', flex: 'variable', color: 0xFF06B6D4, icon: 'healthcare', isDefault: true),
      _createCat(id: 'cat_health_insurance', parentId: 'cat_health', name: 'ביטוחי בריאות ושיניים', type: 'expense', classification: 'needs', flex: 'fixed', color: 0xFF06B6D4, icon: 'insurance', isDefault: true),

      _createCat(id: 'cat_education', name: 'חינוך וילדים', type: 'expense', classification: 'needs', flex: 'fixed', color: 0xFFF97316, icon: 'education', isDefault: true),
      _createCat(id: 'cat_education_tuition', parentId: 'cat_education', name: 'שכר לימוד ומסגרות', type: 'expense', classification: 'needs', flex: 'fixed', color: 0xFFF97316, icon: 'education', isDefault: true),
      _createCat(id: 'cat_education_activities', parentId: 'cat_education', name: 'חוגים ופעילויות', type: 'expense', classification: 'wants', flex: 'variable', color: 0xFFF97316, icon: 'kids', isDefault: true),

      _createCat(id: 'cat_finance', name: 'פיננסים ושונות', type: 'expense', classification: 'needs', flex: 'variable', color: 0xFF64748B, icon: 'taxes', isDefault: true),
      _createCat(id: 'cat_finance_fees', parentId: 'cat_finance', name: 'עמלות ודמי ניהול', type: 'expense', classification: 'needs', flex: 'variable', color: 0xFF64748B, icon: 'taxes', isDefault: true),
      _createCat(id: 'cat_finance_gifts', parentId: 'cat_finance', name: 'מתנות ואירועים', type: 'expense', classification: 'wants', flex: 'variable', color: 0xFF64748B, icon: 'gift', isDefault: true),
      _createCat(id: 'cat_finance_charity', parentId: 'cat_finance', name: 'תרומות ומעשרות', type: 'expense', classification: 'wants', flex: 'variable', color: 0xFF64748B, icon: 'charity', isDefault: true),

      // === INCOME PARENT CATEGORIES ===
      _createCat(id: 'cat_income_salary', name: 'הכנסה מעבודה', type: 'income', classification: 'needs', flex: 'fixed', color: 0xFF059669, icon: 'salary', isDefault: true),
      _createCat(id: 'cat_income_primary_salary', parentId: 'cat_income_salary', name: 'משכורת ראשית', type: 'income', classification: 'needs', flex: 'fixed', color: 0xFF059669, icon: 'salary', isDefault: true),
      _createCat(id: 'cat_income_bonus', parentId: 'cat_income_salary', name: 'בונוסים ותמריצים', type: 'income', classification: 'wants', flex: 'variable', color: 0xFF059669, icon: 'gift', isDefault: true),

      _createCat(id: 'cat_income_investments', name: 'השקעות ונכסים', type: 'income', classification: 'wants', flex: 'variable', color: 0xFF0D9488, icon: 'stock', isDefault: true),
      _createCat(id: 'cat_income_dividends', parentId: 'cat_income_investments', name: 'דיבידנדים וריבית', type: 'income', classification: 'wants', flex: 'variable', color: 0xFF0D9488, icon: 'stock', isDefault: true),
      _createCat(id: 'cat_income_rent', parentId: 'cat_income_investments', name: 'שכר דירה מנכס', type: 'income', classification: 'needs', flex: 'fixed', color: 0xFF0D9488, icon: 'realEstate', isDefault: true),

      _createCat(id: 'cat_income_other', name: 'הכנסות אחרות', type: 'income', classification: 'wants', flex: 'variable', color: 0xFF6366F1, icon: 'gift', isDefault: true),
      _createCat(id: 'cat_income_gifts', parentId: 'cat_income_other', name: 'מתנות והחזרים', type: 'income', classification: 'wants', flex: 'variable', color: 0xFF6366F1, icon: 'gift', isDefault: true),
    ];

    for (final cat in categories) {
      await db.into(db.categoriesTable).insertOnConflictUpdate(cat);
    }

    // 2. Default Initial Accounts
    final defaultAccounts = <AccountsTableCompanion>[
      AccountsTableCompanion.insert(
        id: 'acc_main_checking',
        name: 'חשבון עו"ש ראשי',
        type: 'bank',
        currency: const Value('ILS'),
        initialBalance: const Value(0.0),
        currentBalance: const Value(0.0),
        colorValue: const Value(0xFF3B82F6),
        iconName: const Value('bank'),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
      AccountsTableCompanion.insert(
        id: 'acc_main_credit',
        name: 'כרטיס אשראי ראשי',
        type: 'creditCard',
        currency: const Value('ILS'),
        initialBalance: const Value(0.0),
        currentBalance: const Value(0.0),
        linkedAccountId: const Value('acc_main_checking'),
        billingDayOfMonth: const Value(10),
        colorValue: const Value(0xFF8B5CF6),
        iconName: const Value('creditCard'),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
      AccountsTableCompanion.insert(
        id: 'acc_cash_wallet',
        name: 'ארנק מזומן',
        type: 'cash',
        currency: const Value('ILS'),
        initialBalance: const Value(0.0),
        currentBalance: const Value(0.0),
        colorValue: const Value(0xFF10B981),
        iconName: const Value('cash'),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    ];

    for (final acc in defaultAccounts) {
      await db.into(db.accountsTable).insertOnConflictUpdate(acc);
    }

    // 3. Default App Settings
    await db.into(db.appSettingsTable).insertOnConflictUpdate(
      AppSettingsTableCompanion.insert(
        id: 'default_settings',
        baseCurrency: const Value('ILS'),
        isBiometricEnabled: const Value(false),
        autoLockTimeoutSeconds: const Value(300),
        themeMode: const Value('light'),
        updatedAt: Value(now),
      ),
    );
  }

  static CategoriesTableCompanion _createCat({
    required String id,
    String? parentId,
    required String name,
    required String type,
    required String classification,
    required String flex,
    required int color,
    required String icon,
    bool isDefault = false,
  }) {
    return CategoriesTableCompanion.insert(
      id: id,
      parentId: Value(parentId),
      name: name,
      type: type,
      spendingClassification: Value(classification),
      flexibility: Value(flex),
      colorValue: Value(color),
      iconName: Value(icon),
      isDefault: Value(isDefault),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
  }
}
