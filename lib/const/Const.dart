import 'package:flutter/material.dart';
import 'package:mizan_app/Models/Installment_Model.dart';
import 'package:mizan_app/Models/login_Model.dart';
import 'package:mizan_app/database/Sql_helper.dart';
import 'package:mizan_app/database/Sql_helper_table.dart';
import 'package:mizan_app/database/shared_pref.dart';

const kPrimaryColor = Color(0xFFFEF3E2);
const kPrimaryColor2 = Color(0xFFBEC6A0);
const kPrimaryColor3 = Color(0xFF708871);
const kPrimaryColor4 = Color(0xFF606676);
const kfontStyle1 = "Handjet";
const kfontStyle2 = "Lemonada";
const kfontStyle3 = "ReadexPro";
const kfontStyle4 = "ReemKufi";
const kfontStyle5 = 'Gulzar-Regular';

List<String> items1 = [
  'مصر',
  'السعودية',
  'الامارات',
  'البحرين',
  'الكويت',
  'قطر',
  'تونس',
  'سوريا',
  'الجزائر',
  'فلسطين',
  'عُمان',
  'السودان',
  'لبنان',
  'ليبيا',
  'موريتانيا',
  'العراق',
  'الاردن',
  'الصومال',
  'جيبوتى',
  'جزر القمر',
  'المغرب',
];
GlobalKey<FormState> globalKey = GlobalKey();
TextEditingController namecontroller = TextEditingController();
TextEditingController incomecontroller = TextEditingController();
TextEditingController balancecontroller = TextEditingController();
TextEditingController emailcontroller = TextEditingController();
TextEditingController controlleri = TextEditingController();

TextEditingController controllerinstallment = TextEditingController();
TextEditingController controllertime = TextEditingController();
TextEditingController controllerNotes = TextEditingController();

bool issecureincome = true;
bool issecurebalance = true;
String? selectedvalue;
String? name = '';
String? email = '';
String? income;
String? balance;
String selectedCountry = '';
String selectedvalue2 = 'Egypt (EGP)';
String resultText = '0.000';
double enteredAmount = 0.0;

LoginModel? user;
List<Installment>? installments;
Installment? installment;

insert() async {
  user = LoginModel(
    country: selectedCountry,
    email: emailcontroller.text,
    name: namecontroller.text,
    income: double.tryParse(incomecontroller.text) ?? 0.0,
    balance: double.tryParse(balancecontroller.text) ?? 0.0,
  );

  await Sqlhelper().insertOrUpdate(user!);
  await Sharedpref.storeData(key: 'name', value: namecontroller.text);
  await Sharedpref.storeData(key: 'email', value: emailcontroller.text);
  await Sharedpref.storeData(key: 'income', value: incomecontroller.text);
  await Sharedpref.storeData(key: 'balance', value: balancecontroller.text);
  await Sharedpref.storeData(key: 'country', value: selectedCountry);
}

getTheUser() async {
  final data = await Sqlhelper().getUser();
  user = data;
}

List<String> items = [
  'Egypt (EGP)',
  'Saudi Arabia (SAR)',
  'UAE (AED)',
  'Bahrain (BHD)',
  'Kuwait (KWD)',
  'Qatar (QAR)',
  'Tunisia (TND)',
  'Syria (SYP)',
  'Algeria (DZD)',
  'Palestine (ILS)',
  'Oman (OMR)',
  'Sudan (SDG)',
  'Lebanon (LBP)',
  'Libya (LYD)',
  'Mauritania (MRU)',
  'Iraq (IQD)',
  'Jordan (JOD)',
  'Somalia (SOS)',
  'Djibouti (DJF)',
  'Comoros (KMF)',
  'Morocco (MAD)',
  'Germany (EUR)',
  'Japan (JPY)',
  'England (GBP)',
  'Switzerland (CHF)',
  'Australia (AUD)',
];

Map<String, double> moneyFelow = {
  'Egypt (EGP)': 48.44,
  'Saudi Arabia (SAR)': 3.75,
  'UAE (AED)': 3.67,
  'Bahrain (BHD)': 0.3770,
  'Kuwait (KWD)': 0.31,
  'Qatar (QAR)': 3.65,
  'Tunisia (TND)': 3.04,
  'Syria (SYP)': 14750,
  'Algeria (DZD)': 132.50,
  'Palestine (ILS)': 3.65,
  'Oman (OMR)': 0.39,
  'Sudan (SDG)': 601.50,
  'Lebanon (LBP)': 89500.00,
  'Libya (LYD)': 4.76,
  'Mauritania (MRU)': 39.73,
  'Iraq (IQD)': 1310.00,
  'Jordan (JOD)': 0.71,
  'Somalia (SOS)': 571,
  'Djibouti (DJF)': 177.94,
  'Comoros (KMF)': 443.55,
  'Morocco (MAD)': 9.72,
  'Germany (EUR)': 0.89,
  'Japan (JPY)': 143.28,
  'England (GBP)': 1.4847,
  'Switzerland (CHF)': 0.8435,
  'Australia (AUD)': 1.48,
};

class processesModel {
  String process_name;
  String image;
  processesModel({required this.process_name, required this.image});
}

List<processesModel> processes_name = [
  processesModel(
    process_name: 'حساب تحويل العملات الى الدولار',
    image: 'assets/images/dolar.png',
  ),
  processesModel(
    process_name: 'عرض الاقساط و مواعيدها',
    image: 'assets/images/aqsat.jpg',
  ),
  processesModel(
    process_name: 'تنظيم المصروفات بالنسبة لدخلك الشهري ',
    image: 'assets/images/masrouf.png',
  ),
  processesModel(
    process_name: 'البيانات الشخصية',
    image: 'assets/images/data.jpg',
  ),
];

insertInstallment() async {
  installment = Installment(
    installment: double.parse(controllerinstallment.text),
    time: controllertime.text,
    notes: controllerNotes.text,
  );
  await InstallmentDatabase().insertData(installment!);
}

getInstallment() async {
  installments = await InstallmentDatabase().getData();
}

deleteInstallment(int id) async {
  await InstallmentDatabase().deleteInstallment(id);
  await getInstallment();
}

update(int id) async {
  await InstallmentDatabase().update(
    Installment(
      id: id,
      installment: double.parse(controllerinstallment.text),
      time: controllertime.text,
      notes: controllerNotes.text,
    ),
  );
  getInstallment();
}

class Fixed_expances {
  String image;
  String expense;

  Fixed_expances({required this.image, required this.expense});
}

List<Fixed_expances> expenses = [
  Fixed_expances(
    image: 'assets/images/l1.png',
    expense: 'فواتير الكهرباء والمياه',
  ),
  Fixed_expances(image: 'assets/images/l2.png', expense: 'مصاريف التعليم'),
  Fixed_expances(image: 'assets/images/l3.png', expense: 'الرعاية الصحية'),
  Fixed_expances(image: 'assets/images/l4.png', expense: 'النقل'),
  Fixed_expances(image: 'assets/images/l5.png', expense: 'الاتصالات'),
];

class personal_expances {
  String image2;
  String expense2;

  personal_expances({required this.image2, required this.expense2});
}

List<personal_expances> expenses2 = [
  personal_expances(image2: 'assets/images/l4.png', expense2: 'التسوق'),
  personal_expances(
    image2: 'assets/images/l5.png',
    expense2: 'الانشطة الترفيهية',
  ),
  personal_expances(image2: 'assets/images/l7.png', expense2: 'الرحلات'),
  personal_expances(image2: 'assets/images/l8.png', expense2: 'الهدايا'),
];

class investement_expenses {
  String image3;
  String expense3;

  investement_expenses({required this.image3, required this.expense3});
}

List<investement_expenses> expenses3 = [
  investement_expenses(
    image3: 'assets/images/l9.png',
    expense3: 'زيادة المدخرات',
  ),
  investement_expenses(
    image3: 'assets/images/l10.png',
    expense3: 'تعجيل سداد الديون',
  ),
  investement_expenses(
    image3: 'assets/images/l10.png',
    expense3: 'حالات الطوارئ',
  ),
];
