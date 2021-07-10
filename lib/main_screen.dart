import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:corona_app/main.dart';
import 'package:corona_app/province_detail.dart';
import 'package:corona_app/my_icon_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:corona_app/data.dart';
import 'package:corona_app/country_detail.dart';
import 'package:corona_app/filter.dart';

class LoadingWidget extends StatelessWidget {
  final callbackFunc;
  const LoadingWidget({Key? key, this.callbackFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.callbackFunc();
    return Center(
      child:
        SpinKitThreeBounce(
          color: Colors.blue,
          size: 50.0,

        )
    );
  }
}


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _indonesiaLoading = true;
  var _globalLoading = true;
  var corona;
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  var globalData;

  var provinceData;

  Future<void> _loadIndonesiaData() async{
    corona = await http.get(Uri.parse('https://apicovid19indonesia-v2.vercel.app/api/indonesia/'));
    corona = json.decode(corona.body);
    corona = corona as Map<String, dynamic>;
    setState(() {
      _indonesiaLoading = false;
    });
    _loadProvinceData();
  }
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  Future<void> _loadProvinceData() async {
    provinceData = await http.get(Uri.parse(
        'https://apicovid19indonesia-v2.vercel.app/api/indonesia/provinsi'));
    provinceData = json.decode(provinceData.body);
  }
  Future<void> _loadGlobalData() async {
    globalData = await http.get(Uri.parse("https://covid19.mathdro.id/api"));
    globalData = json.decode(globalData.body);
    setState(() {
      _globalLoading = false;
    });
  }
  // TODO 1 : bikin global covid
  // TODO 2 : bikin daftar rumah sakit
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
              children: [
                (_indonesiaLoading) ? LoadingWidget(callbackFunc: _loadIndonesiaData) :
                  RefreshIndicator(
                    onRefresh: _loadIndonesiaData,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height/10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${filterNumber(corona['positif'])}", style: TextStyle(fontSize: 40,
                                  fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height/30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Total Kasus Covid 19 di Indonesia", style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 128, 0, 0)))
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
                                        Text("Sembuh", style: TextStyle(
                                            color: Color.fromARGB(255, 0, 128, 0),
                                            fontSize: 15))
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("${filterNumber(corona['sembuh'])}", style: TextStyle(color: Color.fromARGB(255, 0, 128, 0), fontSize: 22))
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
                                        Text("${filterNumber(corona['meninggal'])}", style: TextStyle(color: Color.fromARGB(255, 212, 0, 0), fontSize: 22),)
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 90,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(143, 175, 233, 221),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Dirawat", style: TextStyle(color: Color.fromARGB(255, 0, 68, 85)),)
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("${filterNumber(corona['dirawat'])}", style: TextStyle(color: Color.fromARGB(255, 0, 68, 85), fontSize: 22),)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50,),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: provinceMap.length,
                            itemBuilder: (BuildContext context, int index) {
                              String key = provinceMap.keys.elementAt(index);
                              if (index % 2 == 0){
                                return GestureDetector(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    title: Align(
                                        alignment: Alignment(0, -1.2),
                                        child: Text("$key", style: TextStyle(color: Colors.black))),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProvinceDetail(provinceMap: provinceData[index],)));
                                  },
                                );
                              } else {
                                return ListTile(
                                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  title: Align(
                                      alignment: Alignment(0, -1.2),
                                      child: Text("$key")
                                  ),
                                  tileColor: Colors.black12,
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProvinceDetail(provinceMap: provinceData[index],)));
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                (_globalLoading) ? LoadingWidget(callbackFunc: _loadGlobalData) :
                    RefreshIndicator(
                      onRefresh: _loadGlobalData,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height/10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${filterNumber(globalData['confirmed']['value'])}", style: TextStyle(fontSize: 40,
                                    fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Total Kasus Covid 19 di Dunia", style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 128, 0, 0)))
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
                                          Text("Sembuh", style: TextStyle(
                                              color: Color.fromARGB(255, 0, 128, 0),
                                              fontSize: 15))
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("${filterNumber(globalData['recovered']['value'])}", style: TextStyle(color: Color.fromARGB(255, 0, 128, 0), fontSize: 22))
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
                                          Text("${filterNumber(globalData['deaths']['value'])}", style: TextStyle(color: Color.fromARGB(255, 212, 0, 0), fontSize: 22),)
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 15),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: countries.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index % 2 == 0){
                                  return GestureDetector(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      title: Align(
                                          alignment: Alignment(0, -1.2),
                                          child: Text("${countries[index]}", style: TextStyle(color: Colors.black))),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CountryDetail(country: countries[index],)));
                                    },
                                  );
                                } else {
                                  return ListTile(
                                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    title: Align(
                                        alignment: Alignment(0, -1.2),
                                        child: Text("${countries[index]}")
                                    ),
                                    tileColor: Colors.black12,
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CountryDetail(country: countries[index],)));
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
              ]
            )
        // (_isLoading) ? LoadingWidget() :

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // this will be set when a new tab is tapped
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Indonesia',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyIcon.globe),
            label: "Global",
          ),
        ],
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }
}
