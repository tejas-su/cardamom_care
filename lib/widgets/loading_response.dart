import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingResponse extends StatelessWidget {
  const LoadingResponse({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Badge(
          backgroundColor: Colors.grey.shade400,
          alignment: Alignment(0.55, 0.8),
          label: Text(
            'Thinking....',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade500,
            highlightColor: Color.fromARGB(255, 245, 245, 245),
            child: Container(
              height: 70,
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width / 1.5),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(8)),
                color: Theme.of(context).highlightColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
