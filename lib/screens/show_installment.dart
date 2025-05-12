import 'package:flutter/material.dart';
import 'package:mizan_app/const/Const.dart' as const1;
import 'package:mizan_app/const/const.dart' as const2;

class ShowInstallment extends StatefulWidget {
  const ShowInstallment({super.key});

  @override
  State<ShowInstallment> createState() => _ShowInstallmentState();
}

class _ShowInstallmentState extends State<ShowInstallment> {
  @override
  void initState() {
    super.initState();
    loadInstallments();
  }

  void loadInstallments() async {
    await const2.getInstallment();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const1.kPrimaryColor,
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
                  fontFamily: const1.kfontStyle4,
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
                      color: const1.kPrimaryColor2,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      'في هذه الغرفة يتم عرض او اضافه او حذف الاقساط الملتزم بها حاليا',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: const1.kfontStyle2,
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
            Expanded(
              child:
                  (const2.installments?.isNotEmpty ?? false)
                      ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Table(
                            border: TableBorder.all(
                              borderRadius: BorderRadius.circular(20),
                              color: const1.kPrimaryColor3,
                            ),
                            columnWidths: const {
                              0: FlexColumnWidth(),
                              1: FlexColumnWidth(),
                              2: FlexColumnWidth(),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'القسط الشهري',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'الميعاد',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'ملاحظات',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'حذف',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              ...const2.installments!.map((installment) {
                                return TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        installment.installment.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        installment.time,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        installment.notes,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete_rounded,
                                        color: const1.kPrimaryColor3,
                                      ),
                                      onPressed: () async {
                                        if (installment.id != null) {
                                          await const2.deleteInstallment(
                                            installment.id!,
                                          );
                                          await const2.getInstallment();
                                          setState(() {});
                                        }
                                      },
                                    ),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/no quest.gif',
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          backgroundColor: const1.kPrimaryColor2,
                          title: Text(
                            'اضافة قسط جديد',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: const1.kfontStyle1,
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: const2.controllerinstallment,
                                decoration: InputDecoration(
                                  hintText: 'القسط الشهري',
                                ),
                              ),
                              TextField(
                                controller: const2.controllertime,
                                decoration: InputDecoration(
                                  hintText: 'الميعاد',
                                ),
                              ),
                              TextField(
                                controller: const2.controllerNotes,
                                decoration: InputDecoration(
                                  hintText: 'ملاحظات',
                                ),
                              ),
                            ],
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
                                  fontFamily: const1.kfontStyle3,
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const1.kPrimaryColor3,
                              ),
                              onPressed: () async {
                                await const2.insertInstallment();
                                await const2.getInstallment();
                                const2.controllerinstallment.clear();
                                const2.controllertime.clear();
                                const2.controllerNotes.clear();
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Text(
                                'اضافة',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: const1.kfontStyle3,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const1.kPrimaryColor3,
                    ),
                    child: Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
