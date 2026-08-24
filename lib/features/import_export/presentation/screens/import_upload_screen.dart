import 'dart:io';
import 'package:file_picker/file_picker.dart';
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
  Uint8List? _selectedExcelBytes;
  String? _selectedFileName;
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

              // 3. File Input / Excel / CSV Picker
              const Text('3. טען קובץ Excel / CSV או הדבק נתונים', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['xlsx', 'xls', 'csv'],
                            withData: true,
                          );

                          if (result != null && result.files.isNotEmpty) {
                            final file = result.files.single;
                            final ext = file.extension?.toLowerCase() ?? '';
                            Uint8List? bytes = file.bytes;

                            if (bytes == null && file.path != null) {
                              final ioFile = File(file.path!);
                              if (await ioFile.exists()) {
                                bytes = await ioFile.readAsBytes();
                              }
                            }

                            if (bytes != null) {
                              if (ext == 'xlsx' || ext == 'xls') {
                                setState(() {
                                  _selectedExcelBytes = bytes;
                                  _selectedFileName = file.name;
                                  _csvTextController.clear();
                                });
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('נטען בהצלחה קובץ אקסל: ${file.name}'),
                                      backgroundColor: AppColors.income,
                                    ),
                                  );
                                }
                              } else {
                                // CSV
                                final text = String.fromCharCodes(bytes);
                                setState(() {
                                  _selectedExcelBytes = null;
                                  _selectedFileName = file.name;
                                  _csvTextController.text = text;
                                });
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('נטען בהצלחה קובץ CSV: ${file.name}'),
                                      backgroundColor: AppColors.income,
                                    ),
                                  );
                                }
                              }
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('שגיאה בבחירת קובץ: $e'), backgroundColor: AppColors.error),
                            );
                          }
                        }
                      },
                      icon: const Icon(AppIcons.importData, size: 18),
                      label: const Text('בחר קובץ Excel / CSV', style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                      if (clipboardData?.text != null && clipboardData!.text!.isNotEmpty) {
                        setState(() {
                          _selectedExcelBytes = null;
                          _selectedFileName = 'clipboard_data.csv';
                          _csvTextController.text = clipboardData.text!;
                        });
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
                    icon: const Icon(Icons.paste_rounded, size: 16),
                    label: const Text('הדבק מלוח', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),

              // Active Selected File Banner or CSV Text Area
              if (_selectedExcelBytes != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F766E).withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF0F766E).withAlpha(60)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.table_chart_rounded, color: Color(0xFF0F766E), size: 28),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedFileName ?? 'קובץ Excel נטען',
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                            ),
                            Text(
                              'גודל קובץ: ${(_selectedExcelBytes!.lengthInBytes / 1024).toStringAsFixed(1)} KB • מוכן לפענוח',
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () {
                          setState(() {
                            _selectedExcelBytes = null;
                            _selectedFileName = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('עריכת תוכן CSV ידנית:', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    TextButton.icon(
                      onPressed: _loadSampleData,
                      icon: const Icon(AppIcons.refresh, size: 14),
                      label: const Text('טען נתוני דוגמה', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
                TextField(
                  controller: _csvTextController,
                  maxLines: 6,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  decoration: InputDecoration(
                    hintText: 'הדבק כאן את תוכן קובץ ה-CSV או טען קובץ אקסל למעלה...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: AppColors.surface,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),

              // Process & Continue Button
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          final hasExcel = _selectedExcelBytes != null && _selectedExcelBytes!.isNotEmpty;
                          final csvContent = _csvTextController.text.trim();

                          if (!hasExcel && csvContent.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('אנא בחר קובץ Excel / CSV או הדבק נתונים')),
                            );
                            return;
                          }

                          setState(() => _isLoading = true);

                          try {
                            final results = await ref.read(importControllerProvider).parseAndEvaluate(
                                  accountId: _selectedAccountId!,
                                  sourceName: _selectedSource,
                                  csvContent: hasExcel ? null : csvContent,
                                  excelBytes: hasExcel ? _selectedExcelBytes : null,
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
                            final fileName = _selectedFileName ?? (hasExcel ? 'statement_$_selectedSource.xlsx' : 'statement_$_selectedSource.csv');

                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImportPreviewScreen(
                                    accountId: _selectedAccountId!,
                                    accountName: accName,
                                    sourceName: _selectedSource,
                                    fileName: fileName,
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
