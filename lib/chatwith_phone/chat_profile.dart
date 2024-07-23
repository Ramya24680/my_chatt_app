import 'package:flutter/material.dart';

class ChatContactProfile extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String mail;
  final String imageUrl;
  ChatContactProfile({
    // required phoneNumber, required name, required mail, required String imagewUrl,
    required this.name,
    required this.phoneNumber,
    required this.mail,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(imageUrl),

              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: TextEditingController(text: name),
                decoration: InputDecoration(
                    hintText: "Enter name",
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white))),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: TextEditingController(text: phoneNumber),
                decoration: InputDecoration(
                    hintText: "Enter phone",
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white))),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: TextEditingController(text: mail),
                decoration: InputDecoration(
                    hintText: "Enter email",
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white))),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// class ChatContactProfile extends StatefulWidget {
//   Final String name;
//   Final String email;
//   Final String phone;
//   Final String imageUrl;
//  ChatContactProfile({super.key,
//  required.this.name,});
//  required.this.email,});
//  required.this.phone,});
//  required.this.imageUrl});
//
//   @override
//   State<ChatContactProfile> createState() => _ChatContactProfileState();
// }
//
// class _ChatContactProfileState extends State<ChatContactProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade300,
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(40.0),
//               child: CircleAvatar(
//                 radius: 60,
//               ),
//             ),
//             SizedBox(height: 20,),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//
//                 decoration: InputDecoration(
//                     hintText: "Enter name",
//                     disabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.white)),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.white)),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.white))),
//                 textAlign: TextAlign.left,
//               ),),
//             SizedBox(height: 20,),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//
//                 decoration: InputDecoration(
//                     hintText: "Enter phone",
//                     disabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.white)),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.white)),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.white))),
//                 textAlign: TextAlign.left,
//               ),
//             ),SizedBox(height: 20,),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//
//                 decoration: InputDecoration(
//                     hintText: "Enter email",
//                     disabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.white)),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.white)),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.white))),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
