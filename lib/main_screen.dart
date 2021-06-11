import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:corona_app/main.dart';
import 'package:corona_app/province_detail.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  var _isLoading = true;
  var corona;
  var provinceMap = {'DKI Jakarta': 0,
    'Jawa Barat': 1,
    'Jawa Tengah': 2,
    'Jawa Timur': 3,
    'Kalimantan Timur': 4,
    'Sulawesi Selatan': 5,
    'Banten': 6,
    'Bali': 7,
    'Riau': 8,
    'Daerah Istimewa Yogyakarta': 9,
    'Sumatera Barat': 10,
    'Kalimantan Selatan': 11,
    'Sumatera Utara': 12,
    'Papua': 13,
    'Sumatera Selatan': 14,
    'Kalimantan Tengah': 15,
    'Sulawesi Utara': 16,
    'Nusa Tenggara Timur': 17,
    'Bangka Belitung': 18,
    'Sulawesi Tengah': 19,
    'Kalimantan Utara': 20,
    'Lampung': 21,
    'Aceh': 22,
    'Sulawesi Tenggara': 23,
    'Nusa Tenggara Barat': 24,
    'Kepulauan Riau': 25,
    'Papua Barat': 26,
    'Maluku': 27,
    'Kalimantan Barat': 28,
    'Jambi': 29,
    'Bengkulu': 30,
    'Sulawesi Barat': 31,
    'Gorontalo': 32,
    'Maluku Utara': 33};
  var provinceData;

  Future<void> _loadIndonesiaData() async{
    corona = await connectToAPI();
    setState(() {
      _isLoading = false;
    });
    _loadProvinceData();
  }

  @override
  void initState() {
    _loadIndonesiaData();
    super.initState();
  }

  Future<void> _loadProvinceData() async{
    provinceData = await connectToAPI(province: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (_isLoading) ? LoadingWidget() :
        RefreshIndicator(
          onRefresh: _loadIndonesiaData,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${corona['positif']}", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Kasus Covid 19 di Indonesia", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 128, 0, 0)))
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
                              Text("${corona['sembuh']}", style: TextStyle(color: Color.fromARGB(255, 0, 128, 0), fontSize: 22))
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
                              Text("${corona['meninggal']}", style: TextStyle(color: Color.fromARGB(255, 212, 0, 0), fontSize: 22),)
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
                              Text("${corona['dirawat']}", style: TextStyle(color: Color.fromARGB(255, 0, 68, 85), fontSize: 22),)
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
                          title: Text("$key", style: TextStyle(color: Colors.black)),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProvinceDetail(provinceMap: provinceData[index]['attributes'],)));
                        },
                      );
                    } else {
                      return ListTile(
                        title: Text("$key", style: TextStyle(color: Colors.black),),
                        tileColor: Colors.black12,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProvinceDetail(provinceMap: provinceData[index]['attributes'],)));
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: ,
    );
  }
}
