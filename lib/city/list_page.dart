import 'dart:convert';

import 'package:flutter/material.dart' ;
import 'package:resus_basic_app/city/city.dart';
import 'package:resus_basic_app/env.dart';
import 'detail_page.dart';
import 'package:http/http.dart' as http;

class CityListPage extends StatefulWidget {

  const CityListPage({super.key});

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<String> _citiesFuture;

  @override
  void initState(){
    super.initState();
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = '/api/v1/cities';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };
      _citiesFuture = http.get(
      Uri.https(host, endpoint),
      headers: headers,
    )
    .then((res) => res.body);

  }
  
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: const Text('市区町村一覧'),
    ),
    body: FutureBuilder<String>(
      future: _citiesFuture,
      builder: (context, snapshot){
        // ignore: avoid_print
        print(snapshot.data);
        switch (snapshot.connectionState){
          //非同期処理が完了するしたことを示す状態
          case ConnectionState.done:
          //STEP4-6
          // 1-1. snapshot.data1のresultというkeyにデータが入っているのでListとして扱う
          final json = jsonDecode(snapshot.data!)['result'] as List;
          //1-2. Listの各要素はkey, value構造をしているので、key:String, value:dynamicとして変換
          final items = json.cast<Map<String, dynamic>>();
          final cities = items.map(City.fromJson).toList();
          // ListViewをListView.bulderに書き換えてitemのデータを使う
          return ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];
              return ListTile(
                title: Text(city.cityName),
                subtitle: Text(city.bigCityFlag),
                trailing: const Icon(Icons.navigate_next),
                onTap: (){
                  Navigator.of(context).push<void>(
                    MaterialPageRoute(
                      builder: (context) => CityDetailPage(
                        city: city.cityName, 
                      ),
                    ),
                  );
                },
              );
            },
          );
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
        }
        //非同期処理完了までインジケーター表示
        return const Center(
          child:CircularProgressIndicator(),
        );
      },
    )



   );
  }
}