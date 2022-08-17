import 'package:flutter/material.dart';
import 'package:flutter_project/Widgets/modal/english_today.dart';

import '../assets/app_Style.dart';

class AllWords extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWords({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('All Words', style: AppStyles.h2),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: RawMaterialButton(
            onPressed: (){
              Navigator.pop(context);
            },
            shape: const CircleBorder(),
            fillColor: Colors.blueGrey,
            child: const Icon(Icons.arrow_back, color: Colors.white,),
          ),
        ),
      ),
      body: Container(
        child: GridView.count(
          padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 32),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: words.map((e) => Container(
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            alignment: Alignment.center,
            child: Text(e.noun??'', style: AppStyles.h3),
          )).toList(),
        ),
      )
    );
  }
}
