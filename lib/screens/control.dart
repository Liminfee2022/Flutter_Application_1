import 'package:flutter/material.dart';
import 'package:flutter_project/utils/share_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../assets/app_Colors.dart';
import '../assets/app_Style.dart';

class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  double sliderValue = 5;

  initDefaultValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKeys.counter) ?? 5;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initDefaultValue();
    print('sdfsdf:: $sliderValue');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text('Your Control', style: AppStyles.h2),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt(ShareKeys.counter, sliderValue.toInt());
              Navigator.pop(context,sliderValue.toInt());
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black87,),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.only( top: 24, bottom: 32),
                child: Text('How much a number word at once?', style: AppStyles.h4,)),
            Text('${sliderValue.toInt()}', style: AppStyles.h4.copyWith(
              fontSize: 150,
              fontWeight: FontWeight.bold,
            ),),
            Slider(value: sliderValue, divisions: 500, onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            }, min: 5.0, max: 100.0,),
            Container(
              padding: const EdgeInsets.only(left: 32, top: 10),
                alignment: Alignment.centerLeft,
                child: const Text('Slice to set', style: AppStyles.h3))
          ],
        ),
      )
    );
  }
}

