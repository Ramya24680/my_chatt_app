import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatlistScreen extends StatefulWidget {
  final String name;
  final String email;

  final String photoUrl;

  ChatlistScreen({
    super.key,
    required this.name,
    required this.email,
    required this.photoUrl
  });

  @override
  State<ChatlistScreen> createState() => _ChatlistScreenState();
}

class _ChatlistScreenState extends State<ChatlistScreen> {
  TextEditingController smsController = TextEditingController();
  List<String> messages = [];

  void sendMessage() {
    String message = smsController.text;
    if (message.isNotEmpty) {
      setState(() {
        messages.add(message);
        smsController.clear();
      });
    }
  }

  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      print('Picked Image Path: ${image.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,

        actions: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            backgroundImage: NetworkImage(widget.photoUrl),
          ),
          SizedBox(width: 10),
          Text(widget.name),
          Spacer(),
          IconButton(onPressed: () {

            }, icon: Icon(Icons.more_vert_sharp))
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      messages[index],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: smsController,
                            decoration: InputDecoration(
                              hintText: "Type a message here....",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: _pickImage,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue.shade100,
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.send, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

