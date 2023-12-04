import 'package:flutter/material.dart';
import 'package:believeder_app/constant/colors_constant.dart';

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
          flex: 0,
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.only(left: 5.0, top: 1.0, bottom: 9.0),
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
                        left: 5.0, right: 20.0, top: 9.0, bottom: 9.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      widget.receiverMessage!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                child: Text(
                  widget.time!,
                  style: const TextStyle(
                    color: Colors.black,
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
