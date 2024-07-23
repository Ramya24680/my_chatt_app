
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_chatt_app/chatwith_phone/video_screen.dart';

import 'full_screenImage.dart';

class ChatScreendetail extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String id;
  final String chatroomid;

  ChatScreendetail({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.id,
    required this.chatroomid,
  });

  @override
  State<ChatScreendetail> createState() => _ChatScreendetailState();
}

class _ChatScreendetailState extends State<ChatScreendetail> {
  String? imageName;
  String? imageUrl;
  File? imageFile;
  File? videoFile;
  String ? file;

  TextEditingController messageCon = TextEditingController();

  Future<void> selectImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        imageName = image.name;
      });
      await uploadImage();
    }
  }

  Future<void> selectImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        imageName = image.name;
      });
      await uploadImage();
    }
  }

  Future<void> selectVideoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        videoFile = File(video.path);
      });
      await uploadVideo();
    }
  }

  Future<void> selectVideoFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      setState(() {
        videoFile = File(video.path);
      });
      await uploadVideo();
    }
  }
  Future<void>selectPdf()async{
    FilePickerResult? filepage=
        await FilePicker.platform.pickFiles();
    if(filepage !=null){
      filepagenew=File(filepage.files.single.xFile.path);
      name=filepage.files.single.xFile.name;
      type=name.split('.').last;
      setState(() {

      });
    }
  }

  Future<void> uploadVideo() async {
    if (videoFile == null) return;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('chat_videos')
          .child(DateTime.now().millisecondsSinceEpoch.toString() + '.mp4');

      await ref.putFile(videoFile!);

      final url = await ref.getDownloadURL();

      sendMessage(imagee: 'video', messageUrl: url);
    } catch (error) {
      print(error);
    }
  }

  Future<void> showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text("Select Media Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap: () {
                  Navigator.of(context).pop();
                  selectImageFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
                onTap: () {
                  Navigator.of(context).pop();
                  selectImageFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Video'),
                onTap: () {
                  Navigator.of(context).pop();
                  selectVideoFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text("Record Video"),
                onTap: () {
                  Navigator.of(context).pop();
                  selectVideoFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.picture_as_pdf),
                title: Text("PDF"),
                onTap: (){
                  Navigator.of(context).pop();
                  fileupload();

                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> uploadImage() async {
    if (imageFile == null) return;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('chat_images')
          .child(DateTime.now().millisecondsSinceEpoch.toString() + '.jpg');

      await ref.putFile(imageFile!);

      final url = await ref.getDownloadURL();

      setState(() {
        imageUrl = url;
      });

      sendMessage(imagee: 'image', messageUrl: url);
    } catch (error) {
      print(error);
    }
  }

  Future<void>fileupload()async{
    var ref=FirebaseStorage.instance.ref().child('File/${filepagenew!.path}');
    await ref.putFile((File(filepagenew!.path)));
    url=await ref.getDownloadURL();
    await FirebaseFirestore.instance
    .collection('chat_pdf')
    .doc()
    .set({"Url":url,"Name":name,"type":type});
    Navigator.pop(context);
  }
  String url="";
  String name="";
  String type="";
  File? filepagenew;

  void sendMessage({required String imagee, required String messageUrl}) {
    final messageText = messageCon.text;
    final formattedTime = DateFormat('h:mm a').format(DateTime.now());

    FirebaseFirestore.instance
        .collection("chatroom")
        .doc(widget.chatroomid)
        .collection('chats')
        .doc()
        .set({
      "message": imagee == 'text' ? messageText : messageUrl,
      "type": imagee,
      "send by": FirebaseAuth.instance.currentUser!.uid,
      "date": DateTime.now(),
      "formattedTime": formattedTime,
    }).then((value) {
      if (imagee == 'text') {
        messageCon.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.imageUrl),
          ),
          SizedBox(width: 10),
          Text(widget.name),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_sharp)),
        ],
        backgroundColor: Colors.green,
      ),
      body: Column(children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chatroom')
                .doc(widget.chatroomid)
                .collection('chats')
                .orderBy("date")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final messageData = snapshot.data!.docs[index];
                    final isCurrentUser =
                        messageData['send by'] == FirebaseAuth.instance.currentUser!.uid;

                    return Align(
                      alignment: isCurrentUser ? Alignment.topRight : Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: isCurrentUser ? Colors.green[100] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (messageData['type'] == 'image')
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenImage(
                                        imageUrl: messageData['message'],
                                      ),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  messageData['message'],
                                  width: 150,
                                  height: 150,
                                ),
                              )
                            else if (messageData['type'] == 'video')
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenVideo(
                                        videoUrl: messageData['message'],
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(Icons.play_circle_fill, size: 50),
                              )
                            else
                              Text(messageData['message']),
                            Text(
                              messageData['formattedTime'],
                              style: TextStyle(fontSize: 10, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageCon,
                  decoration: InputDecoration(
                    hintText: "Type a message here...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: showImageSourceDialog,
                icon: Icon(Icons.file_present_sharp),
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green,
                child: IconButton(
                  onPressed: () {
                    sendMessage(imagee: 'text', messageUrl: '');
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
