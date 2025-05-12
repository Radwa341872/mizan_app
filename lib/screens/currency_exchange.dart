import 'package:flutter/material.dart';
import 'package:mizan_app/const/const.dart';

class CurrencyExchange extends StatefulWidget {
  const CurrencyExchange({super.key});

  @override
  State<CurrencyExchange> createState() => _CurrencyExchangeState();
}

class _CurrencyExchangeState extends State<CurrencyExchange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4EFD9),
      body: SingleChildScrollView(
        child: Form(
          key: globalKey,
          child: Padding(
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
                          'في هذه الغرفة يمكنك تحويل العملات الي قيمتها الدولارية',
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
                SizedBox(height: 25),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'اختر العمله المراد تحويلها',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: kfontStyle3,
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    Container(
                      width: 150,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        dropdownColor: kPrimaryColor2,
                        icon: Icon(Icons.arrow_downward),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        value: selectedvalue2,
                        items:
                            items.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: kfontStyle1,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedvalue2 = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Center(
                  child: SizedBox(
                    height: 80,
                    width: 200,
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controlleri,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'ادخل المبلغ ',
                      ),
                      onChanged: (valuee) {
                        setState(() {
                          controlleri.text = valuee;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب ادخال بيانات في هذا المكان ';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      double enteredAmount = double.parse(controlleri.text);
                      double rate = moneyFelow[selectedvalue2] ?? 1.0;

                      double result = enteredAmount / rate;

                      setState(() {
                        resultText = result.toStringAsFixed(3);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'تحويل',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontFamily: kfontStyle3,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${selectedvalue2} (${controlleri.text})= $resultText USD',
                        style: TextStyle(fontSize: 25, fontFamily: kfontStyle3),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
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
