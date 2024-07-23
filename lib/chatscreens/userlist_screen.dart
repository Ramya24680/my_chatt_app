import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/chatscreens/chatlist_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List n = [];
  String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('ChatApp').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var datas = snapshot.data!.docs[index];
                  String image = "";
                  if (snapshot.data!.docs[index].data()
                      .containsKey("photoUrl")) {
                    image = snapshot.data!.docs[index]['photoUrl'];
                  }
                  DateTime time = DateTime.now();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        color: Colors.blue.shade100,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatlistScreen(
                                    name: snapshot.data!.docs[index]['name'],
                                    email: snapshot.data!.docs[index]['email'],
                                    photoUrl: snapshot.data!.docs[index]['photoUrl'],
                                  ),
                                ));
                          },
                          leading: image == ""
                              ? CircleAvatar(
                            radius: 40,
                            backgroundColor: index == 0
                                ? Color(0xffdbdbd1)
                                : Color(0xffff6c85),
                            child: Text(
                              snapshot.data!.docs[index]['name'][0],
                            ),
                          )
                              : CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(snapshot.data!.docs[index]['photoUrl']),
                          ),
                          title: Text(snapshot.data!.docs[index]['name']),
                          subtitle: Text(snapshot.data!.docs[index]['email']),
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(

                                  title: Text('Confirm Delete'),
                                  content: Text(
                                      'Are you sure you want to delete this user?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("ChatApp")
                                            .doc(datas.id)
                                            .delete();
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'User deleted successfully',
                                            textAlign: TextAlign.center,
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          ),
                                        );
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(Icons.delete),
                          ),
                        )),
                  );
                });
          }),
    );
  }
}
