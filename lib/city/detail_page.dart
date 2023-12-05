import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resus_basic_app/env.dart';
import 'package:http/http.dart' as http;

class CityDetailPage extends StatefulWidget {
  const CityDetailPage({super.key, required this.city});
  final String city;

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  late Future<String> _municipalitiresTaxesFuture;

  @override
  void initState(){
    super.initState();
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = '/api/v1/municipality/taxes/perYear';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };
    final param = {
      'prefCode': '14',
      'cityCode': '14137',
    };

    _municipalitiresTaxesFuture = http
    .get(
      Uri.https(host,endpoint,param),
      headers : headers,
    )
    .then((res) => res.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city),
        ),
      body: FutureBuilder<String>(
        future: _municipalitiresTaxesFuture,
        builder:(context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
              final result = jsonDecode(snapshot.data!)
              ['result'] 
                as Map<String, dynamic>;
                final data = result['data'] as List;
                final items = data.cast<Map<String,dynamic>>();
                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (context, index) =>const Divider(),
                  itemBuilder:(context,index)  {
                    final item = items[index];
                    return ListTile(
                      title: Text('${item['year'].toString()}年'),
                      trailing: Text(
                        '${item['value']}円',
                        style: const TextStyle(fontSize: 16),
                        ),
                    );
                  },
                );
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
