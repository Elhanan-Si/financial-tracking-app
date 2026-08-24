import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/financial_info_tooltip.dart';
import '../../../auth_lock/presentation/controllers/auth_controller.dart';
import '../../data/services/backup_service.dart';

class BackupRestoreScreen extends ConsumerStatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  ConsumerState<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends ConsumerState<BackupRestoreScreen> {
  final _restoreController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _restoreController.dispose();
    super.dispose();
  }

  void _exportZipArchive() async {
    setState(() => _isLoading = true);
    try {
      final zipBytes = await ref.read(backupServiceProvider).exportBackupZipArchive();
      final dateStr = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
      final defaultFileName = 'financial_backup_$dateStr.backup';

      final outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'שמור קובץ גיבוי מאובטח',
        fileName: defaultFileName,
        type: FileType.custom,
        allowedExtensions: ['backup', 'zip'],
      );

      if (outputPath != null) {
        final file = File(outputPath);
        await file.writeAsBytes(zipBytes);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('קובץ הגיבוי נשמר בהצלחה בנתיב: $outputPath'),
              backgroundColor: AppColors.income,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה בייצוא קובץ גיבוי: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _pickAndRestoreZipArchive() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['backup', 'zip', 'json'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;

      final file = result.files.single;
      Uint8List? bytes = file.bytes;

      if (bytes == null && file.path != null) {
        final ioFile = File(file.path!);
        if (await ioFile.exists()) {
          bytes = await ioFile.readAsBytes();
        }
      }

      if (bytes == null || bytes.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('לא ניתן לקרוא את קובץ הגיבוי שנבחר'), backgroundColor: AppColors.error),
          );
        }
        return;
      }

      if (!mounted) return;

      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('שחזור נתונים מקובץ גיבוי'),
          content: Text(
            'האם לשחזר את כל נתוני האפליקציה מתוך הקובץ "${file.name}" (${(bytes!.lengthInBytes / 1024).toStringAsFixed(1)} KB)?\n\n'
            'שים לב: פעולה זו תחליף את כלל הנתונים הקיימים במכשיר.',
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('ביטול')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('שחזר כעת'),
            ),
          ],
        ),
      );

      if (confirm != true) return;

      setState(() => _isLoading = true);

      final ext = file.extension?.toLowerCase() ?? '';
      if (ext == 'json') {
        final jsonStr = utf8.decode(bytes);
        await ref.read(backupServiceProvider).restoreFromJsonBackup(jsonStr);
      } else {
        await ref.read(backupServiceProvider).restoreFromBackupZipArchive(bytes);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('כל הנתונים שוחזרו בהצלחה מתוך קובץ הגיבוי!'),
            backgroundColor: AppColors.income,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה בשחזור: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _exportJson() async {
    setState(() => _isLoading = true);
    try {
      final jsonStr = await ref.read(backupServiceProvider).exportFullJsonBackup();
      await Clipboard.setData(ClipboardData(text: jsonStr));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('קובץ הגיבוי המלא הועתק ללוח בהצלחה (כולל חתימת SHA-256)'),
            backgroundColor: AppColors.income,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה בייצוא: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _exportCsv() async {
    setState(() => _isLoading = true);
    try {
      final csvStr = await ref.read(backupServiceProvider).exportTransactionsCsv();
      await Clipboard.setData(ClipboardData(text: csvStr));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('דוח התנועות בפורמט CSV (Excel) הועתק ללוח בהצלחה'),
            backgroundColor: AppColors.income,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה בייצוא CSV: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _restoreJson() async {
    final text = _restoreController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('אנא הדבק תוכן קובץ גיבוי JSON תקין'), backgroundColor: AppColors.error),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('שחזור נתונים מקובץ גיבוי'),
        content: const Text('פעולה זו תחליף את כלל הנתונים הקיימים באפליקציה בנתונים מתוך קובץ הגיבוי. האם להמשיך?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('ביטול')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('שחזר כעת'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(backupServiceProvider).restoreFromJsonBackup(text);
      if (mounted) {
        _restoreController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('כל הנתונים שוחזרו בהצלחה מתוך קובץ הגיבוי!'),
            backgroundColor: AppColors.income,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה בשחזור: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _openResetSheet(String resetType, String title, String warningMessage, Future<void> Function() onConfirmReset) {
    final confirmationController = TextEditingController();
    final pinController = TextEditingController();
    bool confirmedCheck = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (sheetCtx) => StatefulBuilder(
        builder: (dialogCtx, setSheetState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(dialogCtx).viewInsets.bottom + AppSpacing.lg,
              top: AppSpacing.lg,
              left: AppSpacing.lg,
              right: AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.errorLight,
                      child: const Icon(AppIcons.alert, color: AppColors.error),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: AppColors.error),
                      ),
                    ),
                    IconButton(icon: const Icon(AppIcons.close), onPressed: () => Navigator.pop(dialogCtx)),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: AppSpacing.cardPadding,
                  decoration: BoxDecoration(
                    color: AppColors.errorLight,
                    borderRadius: AppSpacing.roundedMd,
                    border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    warningMessage,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.error),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                CheckboxListTile(
                  value: confirmedCheck,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text(
                    'אני מבין ומאשר את משמעות הפעולה לצמיתות',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                  onChanged: (val) => setSheetState(() => confirmedCheck = val ?? false),
                ),
                const SizedBox(height: AppSpacing.xs),
                TextField(
                  controller: confirmationController,
                  decoration: const InputDecoration(
                    labelText: 'הקלד את המילה "אישור" לאימות כפול',
                    hintText: 'אישור',
                  ),
                  onChanged: (_) => setSheetState(() {}),
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: pinController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    labelText: 'הזן קוד PIN לאבטחה (אם הוגדר)',
                    prefixIcon: Icon(AppIcons.security),
                    counterText: '',
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                    onPressed: (!confirmedCheck || confirmationController.text.trim() != 'אישור')
                        ? null
                        : () async {
                            final enteredPin = pinController.text.trim();
                            if (enteredPin.isNotEmpty) {
                              final storage = ref.read(secureStorageServiceProvider);
                              final isValidPin = await storage.verifyUserPin(enteredPin);
                              if (!isValidPin) {
                                if (dialogCtx.mounted) {
                                  ScaffoldMessenger.of(dialogCtx).showSnackBar(
                                    const SnackBar(content: Text('קוד PIN שגוי!'), backgroundColor: AppColors.error),
                                  );
                                }
                                return;
                              }
                            }

                            if (!dialogCtx.mounted) return;
                            Navigator.pop(dialogCtx);
                            setState(() => _isLoading = true);
                            try {
                              await onConfirmReset();
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('האיפוס בוצע בהצלחה'),
                                    backgroundColor: AppColors.income,
                                  ),
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('שגיאה באיפוס: $e'), backgroundColor: AppColors.error),
                                );
                              }
                            } finally {
                              if (mounted) setState(() => _isLoading = false);
                            }
                          },
                    child: const Text('אישור ומחיקה סופית', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('גיבוי, שחזור ואיפוס נתונים'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          // 1. Export Backup Card
          Card(
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.primaryLight,
                        child: Icon(AppIcons.export, color: AppColors.primary),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ייצוא קובץ גיבוי מאובטח (.backup)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                            Text('קובץ דחוס ומוגן המכיל את כלל נתוני החשבונות, התנועות, התקציבים והנכסים עם חתימת SHA-256', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      const FinancialInfoTooltip(
                        title: 'קובץ גיבוי מאובטח (.backup / .zip)',
                        explanation: 'קובץ הגיבוי מאחסן את כל נתוני המערכת בפורמט דחוס ומאובטח עם חתימה קריפטוגרפית (SHA-256).\n\nהקובץ מאפשר העברה פשוטה ובטוחה של כל הנתונים למכשיר חדש או שמירת עותק גיבוי מקומי.',
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _exportZipArchive,
                      icon: const Icon(Icons.archive_outlined, size: 20),
                      label: const Text('ייצא ושמור קובץ גיבוי (.backup)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isLoading ? null : _exportCsv,
                          icon: const Icon(AppIcons.file, size: 16),
                          label: const Text('ייצוא תנועות ל-Excel', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isLoading ? null : _exportJson,
                          icon: const Icon(AppIcons.copy, size: 16),
                          label: const Text('העתק JSON ללוח', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // 2. Restore Backup Card
          Card(
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.warningLight,
                        child: Icon(AppIcons.importData, color: AppColors.warning),
                      ),
                      SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('שחזור נתונים מקובץ גיבוי', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                            Text('טעינה ושחזור מלא מתוך קובץ .backup או .zip שנשמר בעבר', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F766E)),
                      onPressed: _isLoading ? null : _pickAndRestoreZipArchive,
                      icon: const Icon(Icons.folder_open_rounded, size: 20),
                      label: const Text('בחר קובץ גיבוי לשחזור (.backup / .zip)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  ExpansionTile(
                    title: const Text('שחזור מתקדם מלוח ההעתקה (JSON)', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                    children: [
                      TextField(
                        controller: _restoreController,
                        maxLines: 4,
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                        decoration: InputDecoration(
                          hintText: 'הדבק כאן את תוכן קובץ ה-JSON לשחזור...',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _isLoading ? null : _restoreJson,
                          icon: const Icon(AppIcons.refresh, size: 16),
                          label: const Text('שחזר מטקסט JSON שהודבק'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // 3. System Reset Zone (איזור איפוס מערכת מאובטח)
          const Text('איזור איפוס מערכת ומחיקת נתונים', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.error)),
          const SizedBox(height: AppSpacing.xs),
          const Text('כל פעולה באיזור זה מחייבת אישור כפול ואימות אבטחה.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.md),

          // Reset Options
          Card(
            color: AppColors.errorLight.withValues(alpha: 0.15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppColors.error.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(AppIcons.transactions, color: AppColors.error),
                  title: const Text('איפוס תנועות בחשבון בלבד', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text('מוחק את כלל התנועות וההעברות ומאפס יתרות להתחלה', style: TextStyle(fontSize: 11)),
                  trailing: const Icon(AppIcons.chevronEnd, size: 16, color: AppColors.error),
                  onTap: () => _openResetSheet(
                    'transactions',
                    'איפוס תנועות בחשבון בלבד',
                    'אזהרה: כל היסטוריית התנועות, התשלומים, הפיצולים וההעברות תימחק לחלוטין. יתרות החשבונות יוחזרו ליתרה הראשונית.',
                    () => ref.read(backupServiceProvider).resetTransactionsOnly(),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(AppIcons.budgets, color: AppColors.error),
                  title: const Text('איפוס תקציבים ויעדים בלבד', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text('מוחק את כלל יעדי התקציב החודשיים והיסטוריית ה-Rollover', style: TextStyle(fontSize: 11)),
                  trailing: const Icon(AppIcons.chevronEnd, size: 16, color: AppColors.error),
                  onTap: () => _openResetSheet(
                    'budgets',
                    'איפוס תקציבים ויעדים',
                    'אזהרה: כלל התקציבים שהוגדרו לקטגוריות והיסטוריית הצבירה והגלילה (Rollover) יימחקו לחלוטין.',
                    () => ref.read(backupServiceProvider).resetBudgetsOnly(),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(AppIcons.investments, color: AppColors.error),
                  title: const Text('איפוס השקעות, פנסיה ונכסים', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text('מוחק תיקי ניירות ערך, מוצרי פנסיה, נדל"ן ומשכנתאות', style: TextStyle(fontSize: 11)),
                  trailing: const Icon(AppIcons.chevronEnd, size: 16, color: AppColors.error),
                  onTap: () => _openResetSheet(
                    'investments',
                    'איפוס השקעות ונכסים',
                    'אזהרה: כלל תיק ניירות הערך, קרנות ההשתלמות, הפנסיות, הנכסים הלא-סחירים ולוחות הסילוקין יימחקו לצמיתות.',
                    () => ref.read(backupServiceProvider).resetInvestmentsAndAssetsOnly(),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(AppIcons.delete, color: AppColors.error),
                  title: const Text('איפוס כללי מלא (Factory Reset)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.error)),
                  subtitle: const Text('מחיקת כל הנתונים, החשבונות וההגדרות מהמכשיר', style: TextStyle(fontSize: 11, color: AppColors.error)),
                  trailing: const Icon(AppIcons.chevronEnd, size: 16, color: AppColors.error),
                  onTap: () => _openResetSheet(
                    'all',
                    'איפוס כללי מלא (Factory Reset)',
                    'אזהרה חמורה: כל המידע באפליקציה יימחק לצמיתות (חשבונות, עסקאות, תקציבים, נכסים, הגדרות). פעולה זו אינה ניתנת לביטול!',
                    () => ref.read(backupServiceProvider).resetAllData(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
