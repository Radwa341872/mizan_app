import 'package:flutter/material.dart';
import 'package:mizan_app/Models/login_Model.dart';
import 'package:mizan_app/const/const.dart';
import 'package:mizan_app/database/Sql_helper.dart';
import 'package:mizan_app/database/shared_pref.dart';
import 'package:mizan_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  Future<void> saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', true);
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    Sqlhelper helper = Sqlhelper();
    LoginModel? fetchedUser = await helper.getUser();
    if (fetchedUser != null) {
      setState(() {
        user = fetchedUser;
        namecontroller.text = user!.name;
        emailcontroller.text = user!.email;
        incomecontroller.text = user!.income.toString();
        balancecontroller.text = user!.balance.toString();
        selectedCountry = user!.country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: globalKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(
                  'ميزان',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: kfontStyle2,
                  ),
                ),
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.asset('assets/images/login.gif'),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: namecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'الاسم الكامل',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: kfontStyle3,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يجب ادخال بيانات في هذا المكان ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'البريد الالكتروني',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: kfontStyle3,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يجب ادخال بيانات في هذا المكان ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: incomecontroller,
                        obscureText: issecureincome,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'الدخل الشهرى',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: kfontStyle3,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                issecureincome = !issecureincome;
                              });
                            },
                            icon: Icon(
                              issecureincome
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يجب ادخال بيانات في هذا المكان ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: issecurebalance,
                        controller: balancecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'الرصيد البنكي',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: kfontStyle3,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                issecurebalance = !issecurebalance;
                              });
                            },
                            icon: Icon(
                              issecurebalance
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يجب ادخال بيانات في هذا المكان ';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'اختر دولتك',
                        style: TextStyle(fontSize: 20, fontFamily: kfontStyle3),
                      ),
                      SizedBox(width: 100),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          dropdownColor: kPrimaryColor2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: kPrimaryColor,
                          ),
                          value: selectedvalue,
                          items:
                              items1
                                  .map(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedvalue = value!;
                              selectedCountry = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor3,
                  ),
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      Sharedpref.storeData(
                        key: 'name',
                        value: namecontroller.text,
                      );
                      Sharedpref.storeData(
                        key: 'email',
                        value: emailcontroller.text,
                      );
                      Sharedpref.storeData(
                        key: 'income',
                        value: incomecontroller.text,
                      );
                      Sharedpref.storeData(
                        key: 'balance',
                        value: balancecontroller.text,
                      );
                      insert();
                      saveLoginStatus();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      );
                    }
                  },
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontFamily: kfontStyle1,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
