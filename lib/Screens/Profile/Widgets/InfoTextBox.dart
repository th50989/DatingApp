import 'package:flutter/material.dart';

class infoTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  const infoTextBox({
    required this.text,
    required this.sectionName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15.0,
        bottom: 15.0,
      ),
      margin: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: const TextStyle(
                  color: Colors.black45,
                ),
              ),
              IconButton(
                onPressed: () {}, 
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: 15,
                ),
              )
            ],
          ),
          Text(
            text,
          ),
        ],
      ),
    );
  }
}