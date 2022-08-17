import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Widgets/App_Button.dart';
import 'package:flutter_project/Widgets/modal/english_today.dart';
import 'package:flutter_project/assets/app_Colors.dart';
import 'package:flutter_project/assets/app_Fonts.dart';
import 'package:flutter_project/assets/app_Style.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_project/screens/all_words.dart';
import 'package:flutter_project/screens/control.dart';
import 'package:flutter_project/utils/share_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  List<EnglishToday> words = [];
  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1 }) {
    if(len > max || len < min) {
      return [];
    }
    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len){
      int val = random.nextInt(max);
      if(newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len =  prefs.getInt(ShareKeys.counter) ?? 5 ;
    List<String> newList = [];
    List<int> ranks = fixedListRandom(len: len, max: nouns.length);
    for (var index in ranks) {
      newList.add(nouns[index]);
    }
    setState(() {
      words = newList.map((e) => EnglishToday(noun: e)).toList();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text('English Today', style: AppStyles.h2),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: RawMaterialButton(
            onPressed: () =>
              _scaffoldKey.currentState?.openDrawer()
            ,
            shape: const CircleBorder(),
            fillColor: Colors.blueGrey,
            child: const Icon(Icons.menu_open_sharp, color: AppColors.white,),
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children:  [
            Container(
                height: size.height * 1/10,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                child: Text('This is a english course for everyone in around the world. So let take do it',
                    style: AppStyles.h3.copyWith(
                      fontSize: 18,
                    )
                )),
            Container(
              height: size.height * 2/4,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: words.length,
                itemBuilder: (context, index) {
                  String firstLetter = words[index].noun ?? '';
                  firstLetter = firstLetter.substring(0, 1).toUpperCase();
                  String leftLetter = words[index].noun ?? '';
                  leftLetter = leftLetter.substring(1, leftLetter.length);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                    child: Material(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      elevation: 4,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            words[index].isFavorite = !words[index].isFavorite;
                          });
                        },
                        splashColor: Colors.orangeAccent,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.heart_broken_sharp, size: 40, color: words[index].isFavorite ? Colors.deepOrange : Colors.white,),
                              ),
                              RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text:  TextSpan(
                                text: firstLetter,
                                style: const TextStyle(
                                  fontFamily: Fonts.pacifico,
                                  fontSize: 85,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    BoxShadow(
                                      color: AppColors.grey,
                                      offset: Offset(1, 3),
                                      blurRadius: 9,
                                    )
                                  ],
                                ),
                                children: [
                                  TextSpan(
                                    text: leftLetter,
                                    style: const TextStyle(
                                      fontFamily: Fonts.pacifico,
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        BoxShadow(
                                          color: AppColors.grey,
                                          offset: Offset(0, 0),
                                          blurRadius: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ]
                              )),
                              Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: AutoSizeText('"Think of all the beauty still left around you and be happy"',
                                      style: AppStyles.h3.copyWith(letterSpacing: 1),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            //Indicator
            _currentIndex >= 5
                ? buildShowMore()
                : SizedBox(
              height: 20,
              child: Container(
                margin: const EdgeInsets.symmetric( horizontal: 16),
                alignment: Alignment.center,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                  return buildIndicator(index == _currentIndex, size);
                }),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blueGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text('Your Mind',
                 style: AppStyles.h2,
                ),
              ),
              AppButton(label: 'Favorites', onTap: () {print('object');}),
              AppButton(label: 'Your control', onTap: () async{
                _scaffoldKey.currentState?.closeDrawer();
                final res = await Navigator.push(context, MaterialPageRoute(builder: (_) => const Control()));
                if(res != null){
                  getEnglishToday();
                }
              }),

            ],
          ),
        ),
      ),
    );
  }
  Widget buildIndicator(bool isActive, Size size){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: isActive ? size.width * 1/5 : 24,
      decoration: BoxDecoration(
        color: isActive ? Colors.orangeAccent : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black,
            offset: Offset(1,1),
            blurRadius: 3,
          )
        ]
      ),
    );
  }
  Widget buildShowMore() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => AllWords(words: words)));
        },
        child: Text('Show More', style: AppStyles.h4.copyWith(color: Colors.blueAccent)),
      ),
    );
  }
}
