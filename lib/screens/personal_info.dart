import 'package:flutter/material.dart';
import 'package:mizan_app/const/Const.dart';
import 'package:mizan_app/database/Sql_helper.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final fetchedUser = await Sqlhelper().getUser();
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

  _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', namecontroller.text);
    await prefs.setString('email', emailcontroller.text);
    await prefs.setString('income', incomecontroller.text);
    await prefs.setString('balance', balancecontroller.text);
    await prefs.setString('country', selectedCountry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 30,
            right: 20,
            child: Text(
              'ميزان',
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontFamily: kfontStyle4,
              ),
            ),
          ),
          Positioned(
            top: 200,
            right: 12,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 500,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kPrimaryColor2,
                  ),
                ),
                Positioned(
                  top: -65,
                  right: 100,
                  child: CircleAvatar(
                    backgroundColor: kPrimaryColor2,
                    radius: 80,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/slogan.gif'),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  right: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        namecontroller.text,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: kfontStyle2,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        emailcontroller.text,
                        style: TextStyle(fontFamily: kfontStyle2),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kPrimaryColor3,
                        ),
                        child: Center(
                          child: Text(
                            selectedCountry,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: kfontStyle2,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 5.0,
                            percent: 0.7,
                            progressColor: kPrimaryColor,
                            backgroundColor: kPrimaryColor4,
                            circularStrokeCap: CircularStrokeCap.square,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  balancecontroller.text,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontFamily: kfontStyle1,
                                  ),
                                ),
                              ],
                            ),
                            footer: Text('الحساب البنكى'),
                          ),
                          SizedBox(width: 35),
                          CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 5.0,
                            percent: 0.7,
                            progressColor: kPrimaryColor,
                            backgroundColor: kPrimaryColor4,
                            circularStrokeCap: CircularStrokeCap.square,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  incomecontroller.text,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontFamily: kfontStyle1,
                                  ),
                                ),
                              ],
                            ),
                            footer: Text('الراتب الشهري'),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                backgroundColor: kPrimaryColor,
                                title: Text(
                                  'تعديل البيانات الشخصية',
                                  style: TextStyle(fontSize: 25),
                                ),
                                content: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(
                                            context,
                                          ).viewInsets.bottom,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: namecontroller,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            labelText: 'الاسم',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontFamily: kfontStyle3,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        TextField(
                                          controller: emailcontroller,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            labelText: 'البريد الالكترونى',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontFamily: kfontStyle3,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        TextField(
                                          controller: incomecontroller,
                                          obscureText: issecureincome,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            labelText: 'الراتب الشهرى',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontFamily: kfontStyle3,
                                            ),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  issecureincome =
                                                      !issecureincome;
                                                });
                                              },
                                              icon: Icon(
                                                issecureincome
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        TextField(
                                          controller: balancecontroller,
                                          obscureText: issecurebalance,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            labelText: 'الحساب البنكى',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontFamily: kfontStyle3,
                                            ),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  issecurebalance =
                                                      !issecurebalance;
                                                });
                                              },
                                              icon: Icon(
                                                issecurebalance
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                'اختر الدولة',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: kfontStyle3,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              child: DropdownButtonFormField<
                                                String
                                              >(
                                                isExpanded: true,
                                                dropdownColor: kPrimaryColor2,
                                                icon: Icon(
                                                  Icons.arrow_downward,
                                                ),
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.2,
                                                        ),
                                                      ),
                                                  filled: true,
                                                  fillColor: Colors.transparent,
                                                ),
                                                value: selectedCountry,
                                                items:
                                                    items1.map((String value) {
                                                      return DropdownMenuItem<
                                                        String
                                                      >(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                kfontStyle1,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedCountry = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'الغاء',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: kfontStyle3,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: kPrimaryColor3,
                                    ),
                                    onPressed: () async {
                                      await insert();
                                      await _saveUserData();
                                      loadUser();
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'حفظ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: kfontStyle3,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                        ),
                        child: Text(
                          'تعديل',
                          style: TextStyle(
                            fontFamily: kfontStyle3,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
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
