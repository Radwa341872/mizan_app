import 'package:flutter/material.dart';
import 'package:mizan_app/const/const.dart';
import 'package:mizan_app/database/Sql_helper.dart';
import 'package:mizan_app/screens/currency_exchange.dart';
import 'package:mizan_app/screens/organizing_expenses.dart';
import 'package:mizan_app/screens/personal_info.dart';
import 'package:mizan_app/screens/show_installment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    loadUser();
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'ميزان',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontFamily: kfontStyle4,
          ),
        ),
      ),
      body:
          user == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 35),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Container(
                              height: 80,
                              width: 280,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: kPrimaryColor2,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Text(
                                'اهلا بك في الميزان يا ${user!.name}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: kfontStyle2,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -35,
                            right: -7,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.black,
                              backgroundImage: AssetImage(
                                'assets/images/logo (2).png',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                          itemCount: processes_name.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (processes_name[index].process_name ==
                                        'حساب تحويل العملات الى الدولار') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CurrencyExchange();
                                          },
                                        ),
                                      );
                                    } else if (processes_name[index]
                                            .process_name ==
                                        'عرض الاقساط و مواعيدها') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ShowInstallment();
                                          },
                                        ),
                                      );
                                    } else if (processes_name[index]
                                            .process_name ==
                                        'تنظيم المصروفات بالنسبة لدخلك الشهري ') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return OrganizingExpenses();
                                          },
                                        ),
                                      );
                                    } else if (processes_name[index]
                                            .process_name ==
                                        'البيانات الشخصية') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return PersonalInfo();
                                          },
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 125,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kPrimaryColor3,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              height: 66,
                                              width: 250,
                                              child: Text(
                                                processes_name[index]
                                                    .process_name,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Handjet',
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: AssetImage(
                                              processes_name[index].image,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
