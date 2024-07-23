import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String email;
  final String imageUrl;
   ChatScreen({
     super.key,
   required this.name,
   required this.email,
   required this.imageUrl
   });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageCon=TextEditingController();
  List message=[];
  final ImagePicker _picker =ImagePicker();
  void _pickImage() async {
    final XFile? image=await _picker.pickImage(source: ImageSource.camera);
    if(image !=null)
      {
        print('Picker Image path:${image.path}');
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        actions: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            backgroundImage: NetworkImage(widget.imageUrl),
          ),
          SizedBox(width: 10,),
          Text(widget.name),
          Spacer(),
          IconButton(onPressed: (){

          }, icon:Icon(Icons.more_vert_sharp))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: message.length,
              itemBuilder:(context,index){
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    message[index],
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              );
              })),
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                Expanded(child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                    border: Border.all(color: Colors.blue.shade200)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: messageCon,
                            decoration: InputDecoration(
                              hintText: "Type a message here...",
                              border: InputBorder.none,
                            ),
                          )),
                      IconButton(onPressed: (){},
                          icon:Icon(Icons.camera_alt_outlined)),
                    ],
                  ),
                )),
                SizedBox(width: 10,),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue.shade200,
                  child: IconButton(
                    onPressed: (){
                      String message =messageCon.text;
                      if(message.isNotEmpty){
                        setState(() {
                          // message.add(message);
                          messageCon.clear();
                        });
                      }
                    },
                    icon: Icon(Icons.send,color: Colors.blue,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
