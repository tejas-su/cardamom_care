import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  const Price({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(children: [
        Expanded(child: SizedBox()),
        Padding(
          padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: TextField(
            decoration: InputDecoration(
                suffixIcon:
                    IconButton(onPressed: null, icon: Icon(Icons.send_rounded)),
                contentPadding: EdgeInsets.all(20),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                hintText: 'Chat with CardamomCare',
                border: InputBorder.none),
          ),
        )
      ]),
    ));
  }
}
