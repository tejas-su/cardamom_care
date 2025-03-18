import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  const Price({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Container(
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(), top: BorderSide(width: 0.1)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today\'s price'),
                    Text(
                      '₹1000',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Down from 2%',
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/cardamom.png',
                fit: BoxFit.fill,
                colorBlendMode: BlendMode.colorDodge,
              )
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide()),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/cardamom.png',
                fit: BoxFit.fill,
                colorBlendMode: BlendMode.colorDodge,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Forecasted price'),
                    Text(
                      '₹1000',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    )));
  }
}
