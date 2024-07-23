//Shared_preff_page 2
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class S_Pref extends StatefulWidget {
  const S_Pref({Key? key}) : super(key: key);

  @override
  State<S_Pref> createState() => _S_PrefState();
}

class _S_PrefState extends State<S_Pref> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getDate();
  // }
  //
  // getDate() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var name = preferences.getString("name");
  //   print(name);
  //   int? num = preferences.getInt("intigers");
  //   print(num);
  //   double? dec = preferences.getDouble("dbl");
  //   print(dec);
  //   bool? tf = preferences.getBool("tf");
  //   print(tf);
  //   List<String>? list = preferences.getStringList("s_list");
  //   print(list);
  // }
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            TextField(
              controller: controller1,
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences preferences =
                await SharedPreferences.getInstance();
                preferences
                    .setString("username", controller.text)
                    .then((value) => print(value));
                preferences
                    .setString("password", controller1.text)
                    .then((value) => print(value));
                preferences
                    .setBool("logged", true)
                    .then((value) => print(value));
              },
              child: Text("Log In"),
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences preferences =
                await SharedPreferences.getInstance();
                var n = await preferences.getString("name");
                bool? m = await preferences.getBool("tf");
                double? o = await preferences.getDouble("dbl");
                int? p = await preferences.getInt('intigers');
                List<String>? q = await preferences.getStringList("s_list");
                print(n);
                print(m);
                print(o);
                print(p);
                print(q);
              },
              child: Text("Get Data"),
            ),
          ],
        ),
      ),
    );
  }
}
