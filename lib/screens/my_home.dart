import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<dynamic> all = [];
List<String> found = [];

class _MyHomePageState extends State<MyHomePage> {
  final surahCount = List.generate(114, (index) => index);
  String ayatOfPage = '';
  int pageNo = 1;
  String surahName = '';
  int jozz = 1;
  String ayaTextEmlay = '';
  ImageProvider assetImage = const AssetImage('assets/images/cover.png');
  getData() async {
    ayatOfPage = '';
    ayaTextEmlay = '';
    String temp = await rootBundle.loadString('assets/hafs_smart_v8.json');
    all = jsonDecode(temp) as List;
    for (var item in all) {
      if (item['page'] == pageNo) {
        ayatOfPage += '${item['aya_text']} ';
        surahName = item['sura_name_ar'];
        jozz = item['jozz'];
        ayaTextEmlay += item['aya_text_emlaey'];
        found.add(ayaTextEmlay);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(
          'الجزء $jozz',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        title: Text(
          surahName,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: assetImage,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.green.withOpacity(0.2),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: 604,
                  itemBuilder: (context, index) {
                    return RichText(
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        text: '',
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontFamily: 'HafsSmart',
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: ' ${ayatOfPage}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      getData();
                      setState(() {
                        pageNo == 1 ? pageNo : pageNo--;
                      });
                    },
                    child: const Text(
                      'الصفحة السابقة',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Text(
                    '$pageNo',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        getData();
                        pageNo == 604 ? pageNo : pageNo++;
                      });
                    },
                    child: const Text(
                      'الصفحة التالية',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
