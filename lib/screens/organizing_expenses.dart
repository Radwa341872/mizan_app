import 'package:flutter/material.dart';
import 'package:mizan_app/const/Const.dart' as const1;
import 'package:mizan_app/const/const.dart' hide kfontStyle1;
import 'package:mizan_app/database/Sql_helper.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OrganizingExpenses extends StatefulWidget {
  const OrganizingExpenses({super.key});

  @override
  State<OrganizingExpenses> createState() => _OrganizingExpensesState();
}

class _OrganizingExpensesState extends State<OrganizingExpenses> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'ميزان',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontFamily: kfontStyle4,
                ),
              ),
            ),
            SizedBox(height: 50),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
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
                      'في هذه الصفحة يتم عرض افضل نسبة لتنظيم مصروفات من خلال مرتبك',
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
                  right: -29,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    backgroundImage: AssetImage('assets/images/logo (2).png'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kPrimaryColor3,
              ),
              child: Center(
                child: Text(
                  user!.income.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: const1.kfontStyle1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 300,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'مصروفاتك الاساسية الثابتة',
                              style: TextStyle(
                                fontFamily: kfontStyle3,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 5.0,
                            percent: 0.5,
                            progressColor: kPrimaryColor3,
                            backgroundColor: kPrimaryColor2,
                            circularStrokeCap: CircularStrokeCap.square,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '50.0%',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: const1.kfontStyle1,
                                  ),
                                ),
                                Text(
                                  (double.tryParse(user!.income.toString())! *
                                          0.5)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: kPrimaryColor2,
                                    fontFamily: const1.kfontStyle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 200,
                              child: ListView.builder(
                                itemCount: expenses.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundImage: AssetImage(
                                              expenses[index].image,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            expenses[index].expense,
                                            style: TextStyle(
                                              fontFamily: kfontStyle3,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 300,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'مصروفاتك الشخصيه المتغيرة',
                              style: TextStyle(
                                fontFamily: kfontStyle3,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 5.0,
                            percent: 0.3,
                            progressColor: kPrimaryColor3,
                            backgroundColor: kPrimaryColor2,
                            circularStrokeCap: CircularStrokeCap.square,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '30.0%',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: const1.kfontStyle1,
                                  ),
                                ),
                                Text(
                                  (double.tryParse(user!.income.toString())! *
                                          0.3)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: kPrimaryColor2,
                                    fontFamily: const1.kfontStyle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 200,
                              child: ListView.builder(
                                itemCount: expenses2.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundImage: AssetImage(
                                              expenses2[index].image2,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            expenses2[index].expense2,
                                            style: TextStyle(
                                              fontFamily: kfontStyle3,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 300,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'الادخارات والاستثمارات ',
                              style: TextStyle(
                                fontFamily: kfontStyle3,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 20),
                          CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 5.0,
                            percent: 0.2,
                            progressColor: kPrimaryColor3,
                            backgroundColor: kPrimaryColor2,
                            circularStrokeCap: CircularStrokeCap.square,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '20.0%',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: const1.kfontStyle1,
                                  ),
                                ),
                                Text(
                                  (double.tryParse(user!.income.toString())! *
                                          0.2)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: kPrimaryColor2,
                                    fontFamily: const1.kfontStyle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 200,
                              child: ListView.builder(
                                itemCount: expenses3.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundImage: AssetImage(
                                              expenses3[index].image3,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            expenses3[index].expense3,
                                            style: TextStyle(
                                              fontFamily: kfontStyle3,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
