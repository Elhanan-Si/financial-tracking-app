import 'package:flutter/material.dart';

/// Centralized Color Tokens for the Light Theme Financial Tracking App.
/// Strictly designed for clean, premium Light Mode financial interfaces.
abstract class AppColors {
  // Brand & Primary
  static const Color primary = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryDark = Color(0xFF3730A3); // Indigo 800
  static const Color primaryLight = Color(0xFFEEF2FF); // Indigo 50
  static const Color primaryMuted = Color(0xFF818CF8); // Indigo 400

  // Secondary & Accent
  static const Color secondary = Color(0xFF0D9488); // Teal 600
  static const Color secondaryLight = Color(0xFFCCFBF1); // Teal 100
  static const Color secondaryDark = Color(0xFF115E59); // Teal 800

  // Financial Semantics - Income (Positive)
  static const Color income = Color(0xFF059669); // Emerald 600
  static const Color incomeLight = Color(0xFFD1FAE5); // Emerald 100
  static const Color incomeDark = Color(0xFF065F46); // Emerald 800

  // Financial Semantics - Expense (Negative / Debit)
  static const Color expense = Color(0xFFE11D48); // Rose 600
  static const Color expenseLight = Color(0xFFFFE4E6); // Rose 100
  static const Color expenseDark = Color(0xFF9F1239); // Rose 800

  // Financial Semantics - Transfer & Adjustments
  static const Color transfer = Color(0xFF2563EB); // Blue 600
  static const Color transferLight = Color(0xFFDBEAFE); // Blue 100

  // Status & Alerts
  static const Color warning = Color(0xFFD97706); // Amber 600
  static const Color warningLight = Color(0xFFFEF3C7); // Amber 100
  static const Color warningDark = Color(0xFF92400E); // Amber 800
  static const Color info = Color(0xFF0284C7); // Sky 600
  static const Color infoLight = Color(0xFFE0F2FE); // Sky 100
  static const Color success = Color(0xFF16A34A); // Green 600
  static const Color error = Color(0xFFDC2626); // Red 600
  static const Color errorLight = Color(0xFFFEE2E2); // Red 100

  // Backgrounds & Surfaces (Light Theme)
  static const Color background = Color(0xFFF8FAFC); // Slate 50
  static const Color surface = Color(0xFFFFFFFF); // Pure White
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Slate 100
  static const Color card = Color(0xFFFFFFFF);

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0); // Slate 200
  static const Color borderSubtle = Color(0xFFF1F5F9); // Slate 100
  static const Color borderStrong = Color(0xFFCBD5E1); // Slate 300
  static const Color divider = Color(0xFFE2E8F0);

  // Text & Typography
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400
  static const Color textDisabled = Color(0xFFCBD5E1); // Slate 300
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Category Palette (Harmonious & Distinct)
  static const List<Color> categoryPalette = [
    Color(0xFF3B82F6), // Blue
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFFEC4899), // Pink
    Color(0xFF8B5CF6), // Purple
    Color(0xFF06B6D4), // Cyan
    Color(0xFFF97316), // Orange
    Color(0xFF14B8A6), // Teal
    Color(0xFF6366F1), // Indigo
    Color(0xFF84CC16), // Lime
    Color(0xFFEF4444), // Red
    Color(0xFF64748B), // Slate
  ];

  // Budget Progress Shading
  static const Color budgetSafe = Color(0xFF10B981); // 0-70%
  static const Color budgetWarning = Color(0xFFF59E0B); // 70-100%
  static const Color budgetOver = Color(0xFFEF4444); // >100%
}
