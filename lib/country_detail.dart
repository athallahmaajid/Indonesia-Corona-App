import 'package:corona_app/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:corona_app/filter.dart';

class CountryDetail extends StatefulWidget {
  final country;
  const CountryDetail({Key? key, this.country}) : super(key: key);

  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  var countryData;
  bool _countryLoading = true;

  Future _loadCountryData() async{
    countryData = await http.get(Uri.parse("https://covid19.mathdro.id/api/countries/${widget.country}"));
    countryData = json.decode(countryData.body);
    countryData = countryData as Map<String, dynamic>;
    setState(() {
      _countryLoading = false;
    });
    print(countryData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.country}"),),
      body: (_countryLoading) ? LoadingWidget(callbackFunc: _loadCountryData) :
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${filterNumber(countryData['confirmed']['value'])}", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height/30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Text("Total Kasus Covid 19 di ${widget.country}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 128, 0, 0)), overflow: TextOverflow.ellipsis))
              ],
            ),
            SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 160,
                  height: 90,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(221, 204, 255, 170),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Sembuh", style: TextStyle(color: Color.fromARGB(255, 0, 128, 0), fontSize: 15))
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${filterNumber(countryData['recovered']['value'])}", style: TextStyle(color: Color.fromARGB(255, 0, 128, 0), fontSize: 22))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  height: 90,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(221, 255, 170, 170),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Meninggal", style: TextStyle(color: Color.fromARGB(255, 212, 0, 0)),)
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${filterNumber(countryData['deaths']['value'])}", style: TextStyle(color: Color.fromARGB(255, 212, 0, 0), fontSize: 22),)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

