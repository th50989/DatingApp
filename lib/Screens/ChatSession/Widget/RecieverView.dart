import 'package:flutter/material.dart';

class ReceiverRowView extends StatefulWidget {
  const ReceiverRowView(
      {Key? key, required this.receiverMessage, required this.time})
      : super(key: key);

  final String? receiverMessage;
  final String? time;
  @override
  State<ReceiverRowView> createState() => _ReceiverRowViewState();
}

class _ReceiverRowViewState extends State<ReceiverRowView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Flexible(
          flex: 13,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, top: 1.0, bottom: 9.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFF90C953),
              child: Text('X',
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
          ),
        ),
        Flexible(
          flex: 72,
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 5.0, right: 8.0, top: 8.0, bottom: 2.0),
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 9.0, bottom: 9.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xFF87D4E6),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      widget.receiverMessage!,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                child: Text(
                  widget.time!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 7.0,
                  ),
                ),
              ),
            ],
          ),
          //
        ),
        Flexible(
          flex: 15,
          fit: FlexFit.tight,
          child: Container(
            width: 50.0,
          ),
        ),
      ],
    );
  }
}
