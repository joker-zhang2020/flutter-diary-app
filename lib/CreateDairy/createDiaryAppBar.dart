import 'package:flutter/material.dart';
import '../icons/myIcons.dart';
import 'dart:io';

class DiaryAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DiaryAppBar({Key? key}) : super(key: key);

  @override
  _DiaryAppBarState createState() => _DiaryAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DiaryAppBarState extends State<DiaryAppBar> {
  DateTime today = DateTime.now();
  bool textIsChecked = false;
  bool markdownIsChecked = false;
  bool dairyVisibleIsChecked = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(MyIcons.delete),
      ),
      backgroundColor: const Color(0xFF2F4F4F),
      title: Text.rich(TextSpan(children: [
        TextSpan(
            style: const TextStyle(fontSize: 20),
            text:
            "${today.month.toString().padLeft(2, '0')}月${today.day.toString().padLeft(2, '0')}日"),
        TextSpan(
            style: const TextStyle(fontSize: 15),
            text:
            " / ${today.hour.toString()}:${today.minute.toString()} 今天")
      ])),
      actions: [
        Container(
            child: const Icon(MyIcons.tag),
            padding: const EdgeInsets.all(10.0)),
        PopupMenuButton(
          color: Colors.black87,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    textIsChecked = !textIsChecked;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text("标题"),
                    Checkbox(
                      checkColor: Colors.white,
                      value: textIsChecked,
                      onChanged: (bool? value) {},
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    markdownIsChecked = !markdownIsChecked;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text("Markdown"),
                    Checkbox(
                      checkColor: Colors.white,
                      value: markdownIsChecked,
                      onChanged: (bool? value) {},
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    dairyVisibleIsChecked = !dairyVisibleIsChecked;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text("显示隐藏日记"),
                    Checkbox(
                      checkColor: Colors.white,
                      value: dairyVisibleIsChecked,
                      onChanged: (bool? value) {},
                    )
                  ],
                ),
              ),
              const PopupMenuItem(
                child: Text("隐藏日记"),
              ),
              const PopupMenuItem(
                child: Text("日记模板"),
              ),
              const PopupMenuItem(
                child: Text("上次编辑"),
              ),
              const PopupMenuItem(
                child: Text("放弃编辑"),
              ),
            ];
          },
        ),
      ],
    );
  }
}
