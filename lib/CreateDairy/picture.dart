import 'dart:io';
import 'package:app/CreateDairy/record.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/icons/myIcons.dart';
import 'package:flutter/material.dart';

class PictureChose extends StatefulWidget {
  const PictureChose({Key? key}) : super(key: key);

  @override
  _PictureChoseState createState() => _PictureChoseState();
}

class _PictureChoseState extends State<PictureChose> {
  var _imgPath;

  List<Widget> picture = [];
  List<Map<String,dynamic>> chosePicture = [{
    "name":'相机',
    "weight": MyIcons.camera,
  },{
    "name":'图库',
    "weight": MyIcons.picture,
  },{
    "name":'录音',
    "weight" : MyIcons.record
  },{
    "name":'心情',
    "weight":MyIcons.moon,
  },{
    "name":'画板',
    "weight":MyIcons.blackboard,
  },{
    "name":'标签',
    "weight":MyIcons.tags
  }];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height:110,
      child: ListView(
          scrollDirection:Axis.horizontal,
          children: [
            ...picture,
          InkWell(
                onTap: _askedToLead

                ,child: Container(
              margin:const EdgeInsets.fromLTRB(0, 10, 0, 20),
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: _ImageView(_imgPath) ,
            ))
          ],
      ),
    );
  }

  Future<void> _askedToLead() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: chosePicture.sublist(0,3).map((item){
                  return SimpleDialogOption(
                    onPressed: () {
                        switch(item["name"]){
                          case '相机':_takePhoto();break;
                          case '图库':_openGallery();break;
                          default: _record(context);
                        }
                    },
                    child: Column(children: [
                      Icon(item["weight"]),
                      const SizedBox(height: 4),
                      Text(item["name"])
                    ],) ,
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: chosePicture.sublist(3).map((item){
                return SimpleDialogOption(
                  onPressed: () {  },
                  child: Column(children: [
                    Icon(item["weight"]),
                    const SizedBox(height: 4),
                    Text(item["name"])
                  ],) ,
                );
              }).toList(),)
            ]
          );
        }
    );
  }

  Future<void> _record(context) async{
    await showModalBottomSheet(
        builder: (BuildContext context) {
          return Column(children: [
            Row(children: const [Text('音频文件')]) ,
            const RecordListen(),
            const SizedBox(height: 50,child: Text("点击录音键开始录音，最长五分钟"))
          ]);
          },
        context: context
    );
  }

  Widget _ImageView(imgPath){
    if(imgPath != null){
      picture.add(Container(
      margin:const EdgeInsets.fromLTRB(0, 10, 0, 20),
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Image.file(File(imgPath.path),fit: BoxFit.fitHeight),
    ));
    picture.add(const SizedBox(width:10));
      setState(() {});
    }
    return const Icon(Icons.add);
  }
  final ImagePicker _picker = ImagePicker();

  _takePhoto() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imgPath = image;
    });
  }

  _openGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
  }
}
