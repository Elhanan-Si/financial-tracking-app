import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../controllers/import_controller.dart';
import 'import_batches_history_screen.dart';
import 'import_preview_screen.dart';

/// Screen 8: File Upload & Institution Preset Selection
class ImportUploadScreen extends ConsumerStatefulWidget {
  const ImportUploadScreen({super.key});

  @override
  ConsumerState<ImportUploadScreen> createState() => _ImportUploadScreenState();
}

class _ImportUploadScreenState extends ConsumerState<ImportUploadScreen> {
  String _selectedSource = 'Isracard';
  String? _selectedAccountId;
  final TextEditingController _csvTextController = TextEditingController();
  bool _isLoading = false;

  final List<Map<String, String>> _sources = [
    {'id': 'Isracard', 'name': 'ישראכרט / פירוט כרטיס אשראי'},
    {'id': 'Leumi', 'name': 'בנק לאומי / דוח תנועות עו"ש'},
    {'id': 'PAGI', 'name': 'בנק פאג"י / הבנק הבינלאומי (FIBI)'},
    {'id': 'OneZero', 'name': 'בנק OneZero דיגיטלי'},
    {'id': 'Custom', 'name': 'פורמט CSV / Excel מותאם אישית'},
  ];

  @override
  void dispose() {
    _csvTextController.dispose();
    super.dispose();
  }

  void _loadSampleData() {
    switch (_selectedSource) {
      case 'Isracard':
        _csvTextController.text =
            'תאריך רכישה,שם בית עסק,סכום חיוב,ענף,מספר שובר\n'
            '10/08/2026,שופרסל דיל,450.50,מזון וסופר,994821\n'
            '12/08/2026,סופר-פארם,120.00,פארם ובריאות,994822\n'
            '14/08/2026,סונול דלק,250.00,רכב ותחבורה,994823\n'
            '15/08/2026,נטפליקס,54.90,מנויים ופנאי,994824';
        break;
      case 'Leumi':
        _csvTextController.text =
            'תאריך,תיאור,חובה,זכות,אסמכתא\n'
            '01/08/2026,העברה משכורת,,14500.00,1001\n'
            '05/08/2026,ארנונה עירייה,850.00,,1002\n'
            '10/08/2026,חברת החשמל,420.00,,1003\n'
            '12/08/2026,איקאה ריהוט,1100.00,,1004';
        break;
      case 'PAGI':
        _csvTextController.text =
            'תאריך,תיאור פעולה,חובה,זכות,אסמכתא\n'
            '02/08/2026,משכורת חודשית,,12000.00,551\n'
            '08/08/2026,ביטוח בריאות הראל,320.00,,552\n'
            '11/08/2026,קופת חולים מכבי,180.00,,553';
        break;
      case 'OneZero':
        _csvTextController.text =
            'תאריך,בית עסק,סכום,קטגוריה,מספר תנועה\n'
            '03/08/2026,קפה לנדוור,-65.00,מסעדות,8801\n'
            '07/08/2026,וולט משלוחים,-110.00,מסעדות,8802\n'
            '09/08/2026,העברת ביט,+200.00,העברות,8803';
        break;
      default:
        _csvTextController.text =
            'תאריך,תיאור,סכום\n'
            '10/08/2026,קניית מחשב,-3500.00\n'
            '11/08/2026,החזר הוצאות,+500.00';
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsStreamProvider(false));

    return Scaffold(
      appBar: AppBar(
        title: const Text('ייבוא דפי בנק ואשראי'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.time),
            tooltip: 'היסטוריית אצוות וביטולים',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ImportBatchesHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: accountsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('שגיאה בטעינת חשבונות: $err')),
        data: (accounts) {
          if (accounts.isEmpty) {
            return const Center(child: Text('יש ליצור חשבון בנק או כרטיס אשראי תחילה'));
          }

          if (_selectedAccountId == null || !accounts.any((a) => a.id == _selectedAccountId)) {
            _selectedAccountId = accounts.first.id;
          }

          return ListView(
            padding: AppSpacing.screenPadding,
            children: [
              // 1. Target Account Selector
              const Text('1. בחר חשבון יעד לייבוא', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              const SizedBox(height: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedAccountId,
                    isExpanded: true,
                    items: accounts.map((acc) {
                      final icon = AppIcons.fromString(acc.iconName, fallback: AppIcons.bank);
                      return DropdownMenuItem(
                        value: acc.id,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Color(acc.colorValue).withAlpha(40),
                                  child: Icon(icon, size: 14, color: Color(acc.colorValue)),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Text(acc.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Text(
                              CurrencyFormatter.formatILS(acc.currentBalance),
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedAccountId = val;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 2. Source Institution Preset
              const Text('2. בחר מוסד פיננסי / תבנית ייבוא', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              const SizedBox(height: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedSource,
                    isExpanded: true,
                    items: _sources.map((s) {
                      return DropdownMenuItem(
                        value: s['id'],
                        child: Text(s['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedSource = val;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 3. File Input / Raw CSV Paste
              const Text('3. טען קובץ CSV או הדבק נתונים', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                        if (clipboardData?.text != null && clipboardData!.text!.isNotEmpty) {
                          _csvTextController.text = clipboardData.text!;
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('התוכן נטען בהצלחה מלוח ההעתקה'), backgroundColor: AppColors.income),
                            );
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('לוח ההעתקה ריק. הדבק ידנית או לחץ על טען דוגמה')),
                            );
                          }
                        }
                      },
                      icon: const Icon(AppIcons.importData, size: 16),
                      label: const Text('עיין / טען מלוח ההעתקה', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _loadSampleData,
                      icon: const Icon(AppIcons.refresh, size: 16),
                      label: const Text('טען נתוני דוגמה', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              TextField(
                controller: _csvTextController,
                maxLines: 8,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'הדבק כאן את תוכן קובץ ה-CSV המיוצא מהבנק/אשראי...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: AppColors.surface,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Process & Continue Button
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          final csvContent = _csvTextController.text.trim();
                          if (csvContent.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('אנא הדבק תוכן CSV או טען דוגמה')),
                            );
                            return;
                          }

                          setState(() => _isLoading = true);

                          try {
                            final results = await ref.read(importControllerProvider).parseAndEvaluate(
                                  accountId: _selectedAccountId!,
                                  sourceName: _selectedSource,
                                  csvContent: csvContent,
                                );

                            setState(() => _isLoading = false);

                            if (results.isEmpty) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('לא נמצאו שורות תקינות לעיבוד בקובץ')),
                                );
                              }
                              return;
                            }

                            final accName = accounts.firstWhere((a) => a.id == _selectedAccountId).name;

                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImportPreviewScreen(
                                    accountId: _selectedAccountId!,
                                    accountName: accName,
                                    sourceName: _selectedSource,
                                    fileName: 'statement_$_selectedSource.csv',
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            setState(() => _isLoading = false);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('שגיאה בעיבוד הקובץ: $e'), backgroundColor: AppColors.error),
                              );
                            }
                          }
                        },
                  icon: _isLoading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(AppIcons.forward),
                  label: const Text('המשך לתצוגה מקדימה וזיהוי כפילויות', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
