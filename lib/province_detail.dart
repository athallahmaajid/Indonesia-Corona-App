import 'package:flutter/material.dart';

class ProvinceDetail extends StatelessWidget {
  final provinceMap;
  const ProvinceDetail({Key? key, this.provinceMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${provinceMap["provinsi"]}"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${provinceMap['kasus']}", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height/30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Text("Total Kasus Covid 19 di ${provinceMap['provinsi']}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 128, 0, 0)), overflow: TextOverflow.ellipsis))
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
                          Text("${provinceMap['sembuh']}", style: TextStyle(color: Color.fromARGB(255, 0, 128, 0), fontSize: 22))
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
                          Text("${provinceMap['meninggal']}", style: TextStyle(color: Color.fromARGB(255, 212, 0, 0), fontSize: 22),)
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
