import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_chatt_app/chatwith_phone/video_screen.dart';
import 'package:my_chatt_app/new_chatcreate/chat_fullimage.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../chatwith_phone/full_screenImage.dart';

class Chats extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String id;
  final String ChatRoomId;

  Chats({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.id,
    required this.ChatRoomId,
  });

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  String? imageName;
  String? imageUrl;
  File? imageFile;
  File? videoFile;
  String? file;
  bool _isLoading = false;

  TextEditingController messageCon = TextEditingController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    messageCon.addListener(_handleTyping);
  }

  @override
  void dispose() {
    messageCon.removeListener(_handleTyping);
    messageCon.dispose();
    super.dispose();
  }

  void _handleTyping() {
    setState(() {
      _isTyping = messageCon.text.isNotEmpty;
    });
  }

  Future<void> selectImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        imageName = image.name;
        _isLoading = true;
      });
      await uploadImage();
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> selectImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        imageName = image.name;
        _isLoading = true;
      });
      await uploadImage();
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> selectVideoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        videoFile = File(video.path);
        _isLoading = true;
      });
      await uploadVideo();
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> selectVideoFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      setState(() {
        videoFile = File(video.path);
        _isLoading = true;
      });
      await uploadVideo();
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> selectPdf() async {
    FilePickerResult? filepage = await FilePicker.platform.pickFiles();
    if (filepage != null) {
      filepagenew = File(filepage.files.single.path!);
      name = filepage.files.single.name;
      type = name.split('.').last;
      setState(() {});
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
                onTap: () {
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
          .child('new_chatImage')
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

  Future<void> fileupload() async {
    var ref = FirebaseStorage.instance.ref().child('File/${filepagenew!.path}');
    await ref.putFile((File(filepagenew!.path)));
    url = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('chat_pdf')
        .doc()
        .set({"Url": url, "Name": name, "type": type});
    Navigator.pop(context);
  }

  String url = "";
  String name = "";
  String type = "";
  File? filepagenew;

  void sendMessage({required String imagee, required String messageUrl}) {
    final messageText = messageCon.text;
    final formattedTime = DateFormat('h:mm a').format(DateTime.now());

    FirebaseFirestore.instance
        .collection("newChatroom")
        .doc(widget.ChatRoomId)
        .collection('Message')
        .doc()
        .set({
      "message": imagee == 'text' ? messageText : messageUrl,
      "type": imagee,
      "send by": FirebaseAuth.instance.currentUser!.uid,
      "date": DateTime.now(),
      "formattedTime": formattedTime,
      "read": false,  // New field to indicate if the message is read
    }).then((value) {
      if (imagee == 'text') {
        messageCon.clear();
      }
    });
  }

  void markMessageAsRead(DocumentSnapshot messageDoc) {
    if (messageDoc['send by'] != FirebaseAuth.instance.currentUser!.uid && !messageDoc['read']) {
      messageDoc.reference.update({"read": true});
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FullscreenImage1(imageUrl: widget.imageUrl)));
          },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
          ),
          Text(widget.name),
          Spacer(),
          IconButton(onPressed: selectImageFromCamera, icon: Icon(Icons.camera_alt_outlined)),
          IconButton(onPressed: (){}, icon: Icon(Icons.videocam)),
          // IconButton(onPressed: (){
          //
          //   _makePhoneCall(widget.ChatRoomId);
          // }, icon: Icon(Icons.phone)),

          PopupMenuButton(

            icon: Icon(Icons.more_vert_sharp),
            onSelected: (value) {},
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text('New group'),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('Media,link and docs'),
              ),
              PopupMenuItem(
                value: 3,
                child: Text('Search'),
              ),
              PopupMenuItem(
                value: 4,
                child: Text('Mute notification'),
              ),
              PopupMenuItem(
                value: 5,
                child: Text('Disappearing message'),
              ),
              PopupMenuItem(
                value: 6,
                child: Text('Wallpaper'),
              ),
              PopupMenuItem(
                value: 7,
                child: Row(
                  children: [
                    Text('More'),
                    SizedBox(width: 100),
                    PopupMenuButton(
                      icon: Icon(Icons.arrow_right_outlined),
                      onSelected: (value) {},
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Text('Report'),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text('Block'),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text('Clear chat'),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text('Export chat'),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text('Add shortcut'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i2.wp.com/www.techgrapple.com/wp-content/uploads/2016/07/WhatsApp-Chat-theme-iPhone-stock-744.jpg?fit=744%2C1392&ssl=1'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('newChatroom')
                  .doc(widget.ChatRoomId)
                  .collection('Message')
                  .orderBy("date")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(

                    reverse: true, // Reverse the order of messages
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final messageData = snapshot.data!.docs[snapshot.data!.docs.length - 1 - index];
                      final isCurrentUser = messageData['send by'] == FirebaseAuth.instance.currentUser!.uid;
                        final messageDate=messageData['date'];
                      // String ChatRoomId = messageData['phone'];
                      markMessageAsRead(messageData);

                      return Align(
                        alignment: isCurrentUser ? Alignment.topRight : Alignment.topLeft,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: isCurrentUser ? Color(0xff96e1e7) : Colors.grey[300],
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
                                  child: Container(
                                    width: 200,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(messageData['message']),
                                        fit: BoxFit.cover, // Cover the entire container
                                      ),
                                    ),
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
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    messageData['formattedTime'],
                                    style: TextStyle(fontSize: 10, color: Colors.black54),
                                  ),
                                  if (isCurrentUser)
                                    Icon(
                                      messageData['read'] ? Icons.done_all : Icons.done,
                                      size: 16,
                                      color: messageData['read'] ? Colors.blue : Colors.grey,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    // separatorBuilder: (BuildContext context, int index) {
                    // return SizedBox(height: 10);
                  
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageCon,
                    decoration: InputDecoration(
                      hintText: "Type a message here...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.emoji_emotions_outlined),
                        onPressed: () {
                          // Switch to the emoji keyboard
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                      suffixIcon: IconButton(
                        onPressed: showImageSourceDialog,
                        icon: Icon(Icons.file_present),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                        BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xff2596be),
                  // Color(0xff96e1e9),+
                  child: IconButton(
                    onPressed: _isTyping
                        ? () {
                      sendMessage(imagee: 'text', messageUrl: '');
                    }
                        : null,
                    icon: Icon(
                      _isTyping ? Icons.send : Icons.mic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

