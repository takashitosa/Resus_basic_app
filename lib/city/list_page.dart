import 'package:flutter/material.dart' ;
import 'package:resus_basic_app/env.dart';
import 'detail_page.dart';
import 'package:http/http.dart' as http;

class CityListPage extends StatefulWidget {

  const CityListPage({super.key});

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<void> _future;

  @override
  void initState(){
    super.initState();
    _future = Future.delayed(const Duration(seconds: 3));
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = '/api/v1/cities';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };
    final response = http.get(
      Uri.https(host,endpoint),
      headers: headers,
    );
    // ignore: avoid_print
    print(response);
  }
  
@override
Widget build(BuildContext context){
  final cities = [
      '札幌市',
      '仙台市',
      '横浜市',
      '川崎市',
      '名古屋市',
      '京都市',
      '大阪市',
      '堺市',
      '神戸市',
      '岡山市',
      '広島市',
      '北九州市',
      '福岡市',
      '熊本市',
      '那覇市',
      ];
  return Scaffold(
    appBar: AppBar(
      title: const Text('市区町村一覧'),
    ),
    body: FutureBuilder<void>(
      future: _future,
      builder: (context, snapshot){
        switch (snapshot.connectionState){
          //非同期処理が完了するしたことを示す状態
          case ConnectionState.done:
          // 元々のListViewを移動させただけ
          return ListView(
            children: [
              for (final city in cities)
              ListTile(
                title: Text(city),
                subtitle: const Text('政令指定都市'),
                trailing: const Icon(Icons.navigate_next),
                onTap:(){
                  Navigator.of(context).push<void>(
                    MaterialPageRoute(
                      builder: (context) => CityDetailPage(city: city),
                    ),
                  );
                }
              )
            ],
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