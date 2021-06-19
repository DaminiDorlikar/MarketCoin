import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled7/marketCoin.dart';
import 'package:http/http.dart' as http;
import 'package:untitled7/coinResponse.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Icons.attach_money_sharp,
        //splash: Image.asset('Assets/splsh.jpg'),
        nextScreen: MyHome(),
        splashTransition: SplashTransition.sizeTransition,
        duration: 3000,
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(
      Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&pg=&sparkLine=false'),
    );

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
      }
      setState(() {
        coinList;
      });
      return coinList;
    } else {
      throw Exception('Failed to load Coins');
    }
  }

  @override
  void initState() {
    fetchCoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            '💰 COIN MARKET CAP ',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: coinList.length,
        itemBuilder: (context, index) {
          return MarketCoin(
            name: coinList[index].name,
            symbol: coinList[index].symbol,
            imagUurl: coinList[index].imagUurl,
            price: coinList[index].price,
            change: coinList[index].change,
            changePercentage: coinList[index].changePercentage,
          );
        },
      ),
    );
  }
}
