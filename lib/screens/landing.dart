import 'package:flutter/material.dart';
import 'package:flutter_project/assets/app_Colors.dart';
import 'package:flutter_project/assets/app_Style.dart';
import 'package:flutter_project/screens/home.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome To',
                style: AppStyles.h2.copyWith(color: AppColors.white),
              ),
            )),
            Expanded(child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text('English', style: AppStyles.h1.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 50),
                      child: Text(
                          'Quotes',
                          textAlign: TextAlign.center,
                          style: AppStyles.h3.copyWith(
                        height: 0.5,
                            color: AppColors.white,
                      ))),
                ],
              ),
            )),
            Expanded(child: Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomePage()), (_) => false);
                },
                shape: const CircleBorder(),
                fillColor: AppColors.white,
                child: const Icon(Icons.arrow_circle_right_sharp),
                // color: Colors.blue,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
