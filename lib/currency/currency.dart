import 'dart:convert';
import 'package:final_project/header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Currency extends StatefulWidget {
  const Currency({Key? key}) : super(key: key);

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency>
    with SingleTickerProviderStateMixin {
  var currency = {};
  List<String> currencies = [
    "USD",
    "EUR",
    "AUD",
    "JPY",
    "GBP",
    "PLN",
    "NZD",
    "CHF",
    "SEK"
  ];
  final colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.grey,
    Colors.teal,
  ];

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchCurrency(String from, String to) async {
    final url =
    Uri.parse('https://frankfurter.app/latest?from=$from&to=$to&lang=tr');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      print(json);
      return json;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Column(
        children: List.generate(currencies.length, (index) {
          return Expanded(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return Opacity(
                  opacity: _animation.value,
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: fetchCurrency(currencies[index], "TRY"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final dateString = snapshot.data?['date'];
                        final formatter = DateFormat('dd.MM.yyyy');
                        final date =
                        DateFormat("yyyy-MM-dd").parse(dateString);
                        final formattedDate = formatter.format(date);
                        print(formattedDate);
                        return Card(
                          color: index % 2 == 0 ? Colors.white : Colors.grey[300],
                          child: ListTile(
                            leading: Text(
                              "1 ${currencies[index]}",
                              style: TextStyle(color: Colors.black),
                            ),
                            title: Text(
                              "${snapshot.data?['rates']['TRY']} TRY",
                              style: TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(
                              "Güncellenen son tarih: $formattedDate",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}