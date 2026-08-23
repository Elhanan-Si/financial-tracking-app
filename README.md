# מעקב פיננסי (Financial Tracking App)

אפליקציית ניהול ומעקב פיננסי אישי, מתקדמת, מאובטחת ומקיפה (Offline-First), בנויה ב-**Flutter** עם תמיכה מלאה בריבוי פלטפורמות (**Android**, **iOS**, **Web**, **Windows**).

האפליקציה פועלת באופן מקומי ועצמאי לחלוטין ללא תלות בשרתים חיצוניים, ומאפשרת מעקב מדויק אחר כל מרכיבי העושר הפיננסי: עו"ש, כרטיסי אשראי, השקעות בשוק ההון, פנסיה והשתלמות, נדל"ן, הלוואות, תזרים מזומנים, תקציבים ואנליטיקה פיננסית מתקדמת.

---

## תכונות מרכזיות (Key Features)

### 1. ניהול חשבונות ואמצעי תשלום
- תמיכה בכל סוגי החשבונות: **עו"ש (בנק)**, **כרטיס אשראי**, **מזומן**, ו**ארנק דיגיטלי**.
- חישוב יתרות דינמי בזמן אמת, ארכוב חשבונות, והתאמה אישית של צבעים ואייקונים.

### 2. תנועות, פיצולים וסיווג חכם
- הזנה מהירה של עסקאות עם חיפוש והשלמה אוטומטית של בתי עסק.
- **פיצול עסקאות (Transaction Splits)**: חלוקת קבלה/עסקה בודדת למספר קטגוריות שונות.
- **מנוע סיווג אוטומטי (Auto-Categorization)**: חוקי זיהוי אוטומטיים (Regex ומילות מפתח) והחלת חוקים רטרואקטיבית על עסקאות עבר.
- **סינון מתקדם**: סינון לפי טווחי תאריכים, חשבונות, קטגוריות, תגיות, סכומי מינימום/מקסימום וחיפוש טקסט חופשי.

### 3. העברות פנימיות (Transfers)
- ביצוע העברות בין חשבונות עם תמיכה בהמרת מטבעות ושער חליפין.
- שמירת היסטוריית העברות וביטול העברה המשחזר את יתרות שני החשבונות אוטומטית.

### 4. עסקאות בתשלומים (Installments)
- מעקב אחר פריסת תשלומים עתידית, יתרת חוב לתשלום ומספר התשלום הנוכחי.
- חיוב תשלום ראשון מיידי ואפשרות ביטול תשלומים עתידיים.

### 5. הוראות קבע ומנויים מחזוריים (Recurring)
- ניהול חיובים קבועים (שכירות, ביטוחים, מנויים, הוראות קבע) והכנסות קבועות (משכורת, קצבאות).
- חישוב התחייבות חודשית מנורמלת, ביצוע אוטומטי בתאריך היעד, והשהייה/חידוש של מנויים.

### 6. תכנון ומעקב תקציב חודשי (Budgets & Rollover)
- הגדרת תקציב לכל קטגוריה עם מחוון ניצול בזמן אמת והתרעות חריגה.
- **הצעת תקציב חכמה**: חישוב אוטומטי של תקציב מומלץ על בסיס ממוצע 3 חודשים אחרונים.
- **גלגול תקציב (Rollover)**: העברת יתרות זכות או חוב לחודש העוקב עם הגדרת תקרת צבירה מקסימלית.

### 7. תחזית תזרים מזומנים (Cash Flow Forecast & What-If)
- תחזית יתרות נזילות יומית קדימה ל-**30, 60 או 90 יום**.
- שקלול אוטומטי של מועדי חיוב כרטיסי אשראי, הוראות קבע, מנויים ומשכורות.
- זיהוי סיכוני גירעון (Deficit Risk) ונקודת שפל (Lowest Balance).
- **סימולציות "מה אם" (What-If)**: בדיקת השפעת הוצאה/הכנסה עתידית לפני ביצועה.

### 8. ייבוא דוחות בנק וכרטיסי אשראי בישראל
- פרסור קובצי Excel ו-CSV ממוסדות פיננסיים ישראליים:
  - **בנק לאומי**
  - **בנק פאג"י / הבנק הבינלאומי**
  - **וואן זירו (OneZero)**
  - **ישראכרט (Isracard)**
  - **פורמט CSV כללי** עם זיהוי כותרות אוטומטי בעברית.
- מנוע מניעת כפילויות חכם (Deduplication) ואפשרות ביטול ייבוא מלא (Rollback).

### 9. תיק השקעות ומסחר (Stocks, ETFs & Benchmarks)
- מעקב אחר מניות, קרנות סל (ETFs) ואג"ח.
- חישוב **עלות בסיס ממוצעת (Average Cost Basis)** ורווח/הפסד לא ממומש.
- **הפרדת רווח נכס מול רווח מט"ח (Asset Gain vs Currency Gain)**.
- **מעבר מטבעות בלחיצה אחת (₪ / $)** ותצוגה קבועה של שער הדולר/שקל היציג.
- השוואה למדדי ייחוס עולמיים וישראליים מובילים (S&P 500, NASDAQ, ת"א 125).

### 10. נכסים פנסיוניים (Pension & Study Funds)
- מעקב אחר קרנות פנסיה, קרנות השתלמות וקופות גמל.
- ניהול מעסיקים, דמי ניהול (מצבירה ומהפקדה) ושמירת היסטוריית תמונות מצב.

### 11. נכסים והתחייבויות (Real Estate, Vehicles & Mortgages)
- ניהול נדל"ן, כלי רכב, הלוואות ומשכנתאות.
- **מנוע סילוקין שפיצר (Spitzer Amortization)**: פירוק תשלומי קרן וריבית, חישוב הון עצמי בנכס (Home Equity) ויחס LTV.

### 12. דשבורד שווי נקי (Total & Liquid Net Worth)
- תצוגת שווי נקי כולל (מאזן כללי) מול שווי נזיל בלבד (זמין לשימוש מיידי).
- פילוח נכסים (Asset Allocation) ותיעוד תמונות מצב חודשיות (Snapshots).

### 13. תובנות, אנליטיקה ושיעור חיסכון (Insights & Analytics)
- מודל חלוקת תקציב **50/30/20** (צרכים בסיסיים, מותרות, חיסכון והשקעות).
- חלוקת הוצאות קבועות מול הוצאות משתנות.
- השוואת חודש מול חודש וניתוח מגמות (**Top Increases** מול **Top Reductions**).
- חישוב **שיעור חיסכון חודשי (Savings Rate)**, ממוצעים נעים (3, 6, 12 חודשים), **קצב שריפה (Burn Rate)** וכרית ביטחון (**Runway** בחודשים).

### 14. אבטחה, נעילה ופרטיות (Security & Privacy)
- **נעילת PIN מוצפנת**: גיבוב באמצעות PBKDF2 עם Salt ייחודי.
- **אימות ביומטרי**: תמיכה ב-Fingerprint / Touch ID / Face ID.
- **מסך הסוואה (Privacy Curtain)**: הסתרת תוכן רגיש במעבר לאפליקציות אחרות.
- **נעילה אוטומטית** לאחר זמן אי-פעילות הניתן להגדרה.

### 15. גיבוי, שחזור וייצוא (Backup & Restore)
- ייצוא קובץ גיבוי מוצפן JSON מאומת עם SHA-256 Checksum.
- שחזור נתונים מלא מקובץ גיבוי.
- ייצוא תנועות ל-Excel (CSV מעוצב בעברית).
- איפוס נתונים מאובטח.

### 16. כלי עזר והסברים מובנים (Financial Tooltips)
- סימני שאלה עם הסברים פיננסיים, נוסחאות מתמטיות וטיפים פרקטיים בכל מסכי האפליקציה.
- גלילה פנימית מובנית להסברים ארוכים וכפתור שליטה גלובלי בהגדרות.

---

## ארכיטקטורה וטכנולוגיות (Tech Stack)

- **Framework**: [Flutter](https://flutter.dev/) (Channel: `stable`, SDK >= 3.8.1)
- **Language**: [Dart](https://dart.dev/)
- **State Management**: [Flutter Riverpod](https://riverpod.dev/) (`2.6.1`)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router) (`14.8.1`)
- **Local Database**: [Drift (SQLite)](https://drift.simonbinder.eu/) (`2.24.2`) עם `sqlite3_flutter_libs`
- **Security & Storage**: `flutter_secure_storage`, `local_auth`, `crypto`
- **Charts & UI**: `fl_chart`, `cupertino_icons`
- **Localization**: עברית מלאה (RTL native)

---

## הוראות הרצה מקומית (Local Development)

### דרישות מוקדמות (Prerequisites)
1. **Flutter SDK**: גרסה `3.8.1` ומעלה ([מדריך התקנה](https://docs.flutter.dev/get-started/install)).
2. **Android Studio** / **VS Code** עם תוספי Flutter ו-Dart.
3. עבור פיתוח לאנדרואיד: Android SDK ו-Java JDK 17.
4. עבור פיתוח ל-iOS: מחשב Mac עם Xcode מותקן (או שימוש ב-CI/CD כמפורט בהמשך).

### שלבי הרצה:

1. **שכפול הפרויקט (Clone)**:
   ```bash
   git clone https://github.com/Elhanan-Si/financial-tracking-app.git
   cd financial_tracking-app
   ```

2. **התקנת תלויות**:
   ```bash
   flutter pub get
   ```

3. **הרצת מחולל קוד (Code Generation)**:
   *(נדרש עבור מחלקות Drift ו-Riverpod)*
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **בדיקת תקינות הקוד והרצת טסטים**:
   ```bash
   flutter analyze
   flutter test
   ```

5. **הרצת האפליקציה**:
   ```bash
   # הרצה על מכשיר אנדרואיד / אמולטור
   flutter run -d android

   # הרצה על iOS Simulator (ב-Mac)
   flutter run -d ios

   # הרצה בדפדפן Web
   flutter run -d chrome

   # הרצה כשולחן עבודה Windows
   flutter run -d windows
   ```

---

## הוראות בנייה ל-Production

### 1. בנייה עבור Android

#### הפקת קובץ התקנה ישיר (Release APK):
```bash
flutter build apk --release
```
**מיקום הקובץ שנוצר**: `build/app/outputs/flutter-apk/app-release.apk`

#### הפקת חבילת פרסום לחנות (Android App Bundle - AAB):
```bash
flutter build appbundle --release
```
**מיקום הקובץ שנוצר**: `build/app/outputs/bundle/release/app-release.aab`

---

### 2. בנייה עבור Apple iOS

#### אופציה א': בנייה מקומית (במחשב Mac עם Xcode)
```bash
flutter build ipa --release
```
**מיקום הקובץ שנוצר**: `build/ios/archive/Runner.xcarchive` או `build/ios/ipa/Runner.ipa`

#### אופציה ב': בנייה אוטומטית בענן (GitHub Actions CI/CD)
בפרויקט מוגדר תהליך CI/CD מלא הרץ על גבי שרתי macOS בענן:
1. בצע `push` לקוד לענף `main` ב-GitHub.
2. עבור ללשונית **Actions** בריפוזיטורי ב-GitHub.
3. בחר ב-**"Build iOS (IPA)"** ולחץ על **Run workflow**.
4. בסיום הריצה, הורד את קובץ ה-**`.ipa`** מחלק ה-**Artifacts** בתחתית העמוד.
5. התקן על מכשיר iOS באמצעות [Sideloadly](https://sideloadly.io/) או [AltStore](https://altstore.io/).

---

### 3. בנייה עבור Windows Desktop
```bash
flutter build windows --release
```
**מיקום הקבצים**: `build/windows/x64/runner/Release/`

### 4. בנייה עבור Web
```bash
flutter build web --release
```
**מיקום הקבצים**: `build/web/`

---

## מבנה הפרויקט (Project Structure)

```text
financial_tracking/
├── .github/
│   └── workflows/              # תהליכי CI/CD אוטומטיים עבור iOS ו-Android
│       ├── build_ios.yml
│       └── build_android.yml
├── android/                    # הגדרות וקבצי פלטפורמת Android
├── ios/                        # הגדרות, הרשאות (Face ID) ואייקונים ל-iOS
├── assets/
│   └── icon/                   # קובצי אייקון ומדיה
├── lib/
│   ├── app/                    # הגדרות Router, Theme, ונקודת הכניסה
│   ├── core/                   # קבועים, מחלקות בסיס, Drift Database, ווידג'טים משותפים
│   │   ├── constants/
│   │   ├── database/
│   │   ├── utils/
│   │   └── widgets/
│   └── features/               # מודולים עסקיים בחלוקת Clean Architecture
│       ├── accounts/           # ניהול חשבונות
│       ├── auth_lock/          # אבטחה, PIN וביומטרי
│       ├── auto_categorization/# חוקי סיווג אוטומטיים
│       ├── backup_settings/    # גיבוי, שחזור והגדרות
│       ├── budgets/            # תכנון תקציב ו-Rollover
│       ├── cash_flow/          # תחזית תזרים וסימולציות What-If
│       ├── categories_tags/    # עץ קטגוריות ותגיות
│       ├── import_export/      # פרסרים לבנקים וכרטיסי אשראי
│       ├── insights_analytics/ # אנליטיקה, 50/30/20 ו-Savings Rate
│       ├── installments/       # עסקאות בתשלומים
│       ├── investments/        # תיק השקעות, מניות ומדדים
│       ├── net_worth/          # שווי נקי כולל ונזיל
│       ├── non_market_assets/  # נדל"ן, רכבים ולוח שפיצר
│       ├── pension_assets/     # פנסיה וקרנות השתלמות
│       ├── recurring/          # הוראות קבע ומנויים
│       ├── transactions/       # תנועות, פיצולים וחיפוש
│       └── transfers/          # העברות בין חשבונות
├── scripts/                    # סקריפטים לעיבוד אייקונים ומשימות אוטומציה
├── test/                       # 79 בדיקות יחידה ואינטגרציה
└── pubspec.yaml                # הגדרות חבילות ותלויות
```

---

## בדיקות איכות (Quality & Testing)

הפרויקט כולל כיסוי בדיקות יחידה ואינטגרציה מקיף (79 בדיקות):
```bash
flutter test
```
כל הבדיקות מוודאות את דיוק המנועים המתמטיים, מניעת כפילויות, הצפנת נתונים, פריסת תשלומים, וסימולציות תזרים מזומנים.

---

## רישיון (License)
פרויקט זה פותח לשימוש אישי ומוגן ברישיון פרטי. כל הזכויות שמורות.
