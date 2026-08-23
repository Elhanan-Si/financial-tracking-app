import 'package:flutter/material.dart';

/// Centralized Icon Registry.
/// STRICT REQUIREMENT: No emojis anywhere in the app!
/// All visual indicators are mapped to consistent, crisp vector Icons.
abstract class AppIcons {
  // Navigation Tabs
  static const IconData dashboard = Icons.dashboard_rounded;
  static const IconData transactions = Icons.receipt_long_rounded;
  static const IconData budgets = Icons.pie_chart_rounded;
  static const IconData investments = Icons.trending_up_rounded;
  static const IconData settings = Icons.settings_rounded;

  // Actions
  static const IconData add = Icons.add_rounded;
  static const IconData edit = Icons.edit_rounded;
  static const IconData delete = Icons.delete_outline_rounded;
  static const IconData search = Icons.search_rounded;
  static const IconData filter = Icons.filter_list_rounded;
  static const IconData sort = Icons.swap_vert_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData check = Icons.check_rounded;
  static const IconData refresh = Icons.refresh_rounded;
  static const IconData share = Icons.share_rounded;
  static const IconData export = Icons.file_upload_outlined;
  static const IconData importData = Icons.file_download_outlined;
  static const IconData copy = Icons.copy_rounded;
  static const IconData file = Icons.description_rounded;
  static const IconData more = Icons.more_vert_rounded;
  static const IconData back = Icons.arrow_back_rounded;
  static const IconData forward = Icons.arrow_forward_rounded;
  static const IconData chevronStart = Icons.chevron_left_rounded;
  static const IconData chevronEnd = Icons.chevron_right_rounded;
  static const IconData expandMore = Icons.keyboard_arrow_down_rounded;
  static const IconData expandLess = Icons.keyboard_arrow_up_rounded;
  static const IconData chevronLeft = Icons.chevron_left_rounded;
  static const IconData chevronRight = Icons.chevron_right_rounded;
  static const IconData help = Icons.help_outline_rounded;

  // Financial Transaction Types
  static const IconData income = Icons.arrow_downward_rounded;
  static const IconData expense = Icons.arrow_upward_rounded;
  static const IconData transfer = Icons.sync_alt_rounded;
  static const IconData split = Icons.call_split_rounded;
  static const IconData installments = Icons.calendar_month_rounded;
  static const IconData recurring = Icons.autorenew_rounded;

  // Account Types
  static const IconData bank = Icons.account_balance_rounded;
  static const IconData creditCard = Icons.credit_card_rounded;
  static const IconData wallet = Icons.account_balance_wallet_rounded;
  static const IconData cash = Icons.payments_rounded;
  static const IconData savings = Icons.savings_rounded;

  // Security & Auth
  static const IconData lock = Icons.lock_outline_rounded;
  static const IconData lockOpen = Icons.lock_open_rounded;
  static const IconData fingerprint = Icons.fingerprint_rounded;
  static const IconData faceAuth = Icons.face_rounded;
  static const IconData pin = Icons.pin_outlined;
  static const IconData security = Icons.shield_outlined;
  static const IconData visibility = Icons.visibility_outlined;
  static const IconData visibilityOff = Icons.visibility_off_outlined;

  // Categories & Merchants
  static const IconData foodDining = Icons.restaurant_rounded;
  static const IconData groceries = Icons.shopping_cart_rounded;
  static const IconData shopping = Icons.shopping_bag_rounded;
  static const IconData housing = Icons.home_rounded;
  static const IconData rent = Icons.apartment_rounded;
  static const IconData utilities = Icons.bolt_rounded;
  static const IconData water = Icons.water_drop_rounded;
  static const IconData gas = Icons.local_gas_station_rounded;
  static const IconData transportation = Icons.directions_car_rounded;
  static const IconData publicTransit = Icons.directions_bus_rounded;
  static const IconData entertainment = Icons.movie_rounded;
  static const IconData healthcare = Icons.medical_services_rounded;
  static const IconData education = Icons.school_rounded;
  static const IconData salary = Icons.monetization_on_rounded;
  static const IconData gift = Icons.card_giftcard_rounded;
  static const IconData travel = Icons.flight_rounded;
  static const IconData fitness = Icons.fitness_center_rounded;
  static const IconData personalCare = Icons.spa_rounded;
  static const IconData insurance = Icons.health_and_safety_rounded;
  static const IconData kids = Icons.child_care_rounded;
  static const IconData pets = Icons.pets_rounded;
  static const IconData taxes = Icons.account_balance_rounded;
  static const IconData charity = Icons.volunteer_activism_rounded;
  static const IconData electronics = Icons.devices_rounded;
  static const IconData business = Icons.business_center_rounded;
  static const IconData uncategorized = Icons.category_rounded;
  static const IconData categories = Icons.category_rounded;
  static const IconData category = Icons.category_rounded;
  static const IconData tag = Icons.label_outline_rounded;
  static const IconData merchant = Icons.storefront_rounded;

  // Assets, Pension, Debts & Investments
  static const IconData stock = Icons.show_chart_rounded;
  static const IconData pension = Icons.elderly_rounded;
  static const IconData providentFund = Icons.account_balance_wallet_outlined;
  static const IconData studyFund = Icons.menu_book_rounded;
  static const IconData realEstate = Icons.real_estate_agent_rounded;
  static const IconData vehicle = Icons.directions_car_filled_rounded;
  static const IconData liability = Icons.money_off_rounded;
  static const IconData mortgage = Icons.home_work_rounded;
  static const IconData loan = Icons.handshake_rounded;
  static const IconData netWorth = Icons.insights_rounded;

  // Insights & Indicators
  static const IconData trendingUp = Icons.trending_up_rounded;
  static const IconData trendingDown = Icons.trending_down_rounded;
  static const IconData trendingFlat = Icons.trending_flat_rounded;
  static const IconData alert = Icons.warning_amber_rounded;
  static const IconData infoCircle = Icons.info_outline_rounded;
  static const IconData successCircle = Icons.check_circle_outline_rounded;
  static const IconData calendar = Icons.calendar_today_rounded;
  static const IconData time = Icons.access_time_rounded;
  static const IconData backup = Icons.backup_rounded;
  static const IconData restore = Icons.settings_backup_restore_rounded;

  /// Helper map to look up an IconData by name string (used in DB serialization)
  static IconData fromString(String? iconName, {IconData fallback = uncategorized}) {
    if (iconName == null || iconName.isEmpty) return fallback;
    return _iconRegistry[iconName] ?? fallback;
  }

  /// Registry mapping string keys to IconData
  static const Map<String, IconData> _iconRegistry = {
    'dashboard': dashboard,
    'transactions': transactions,
    'budgets': budgets,
    'investments': investments,
    'settings': settings,
    'foodDining': foodDining,
    'groceries': groceries,
    'shopping': shopping,
    'housing': housing,
    'rent': rent,
    'utilities': utilities,
    'water': water,
    'gas': gas,
    'transportation': transportation,
    'publicTransit': publicTransit,
    'entertainment': entertainment,
    'healthcare': healthcare,
    'education': education,
    'salary': salary,
    'gift': gift,
    'travel': travel,
    'fitness': fitness,
    'personalCare': personalCare,
    'insurance': insurance,
    'kids': kids,
    'pets': pets,
    'taxes': taxes,
    'charity': charity,
    'electronics': electronics,
    'business': business,
    'uncategorized': uncategorized,
    'bank': bank,
    'creditCard': creditCard,
    'wallet': wallet,
    'cash': cash,
    'stock': stock,
    'pension': pension,
    'providentFund': providentFund,
    'studyFund': studyFund,
    'realEstate': realEstate,
    'vehicle': vehicle,
    'liability': liability,
    'mortgage': mortgage,
    'loan': loan,
  };
}
