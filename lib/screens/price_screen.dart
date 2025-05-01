import 'package:flutter/material.dart';

class PricePredictionScreen extends StatelessWidget {
  const PricePredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(children: [
        Expanded(child: SizedBox()),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: TextField(
            minLines: 1,
            maxLines: 10,
            decoration: InputDecoration(
                suffixIcon:
                    IconButton(onPressed: null, icon: Icon(Icons.send_rounded)),
                contentPadding: EdgeInsets.all(20),
                filled: true,
                fillColor: Theme.of(context).navigationBarTheme.backgroundColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                hintText: 'Chat with CardamomCare',
                border: InputBorder.none),
          ),
        )
      ]),
    ));
  }
}
