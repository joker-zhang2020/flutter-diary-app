import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import '../icons/myIcons.dart';
class RecordListen extends StatefulWidget {
  const RecordListen({Key? key}) : super(key: key);

  @override
  _RecordListenState createState() => _RecordListenState();
}

class _RecordListenState extends State<RecordListen> {
  final FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  bool startRecord = false;
  @override
  void initState() {
    super.initState();
    _myRecorder.openRecorder();
  }

  @override
  void dispose() {
    _myRecorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text( startRecord ? "stop" : "start",style: const TextStyle(fontSize: 26)),
      SizedBox(child: InkWell(onTap: startRecord ? stopRecorder : record,
          child: const Icon(MyIcons.record)),width: 100,height: 100),
          // TextButton(onPressed: startRecord ? stopRecorder : record,child: const Icon(MyIcons.record,size: 30)))
    ]);
  }

  Future<void> record() async {
    await _myRecorder.startRecorder(
      toFile: './foo',
      codec: Codec.aacADTS,
    );
    setState(() {
      startRecord = true;
    });
  }


  Future<void> stopRecorder() async {
    await _myRecorder.stopRecorder();
    setState(() {
      startRecord = false;
    });
  }
}
