import 'package:flutter/material.dart';
import 'package:believeder_app/constant/colors_constant.dart';

class SenderRowView extends StatefulWidget {
  const SenderRowView({Key? key, required this.senderMessage, this.time})
      : super(key: key);
  final String? time;
  final String? senderMessage;

  @override
  State<SenderRowView> createState() => _SenderRowViewState();
}

class _SenderRowViewState extends State<SenderRowView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          flex: 15,
          fit: FlexFit.tight,
          child: Container(
            width: 50.0,
          ),
        ),
        Flexible(
          flex: 72,
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 8.0, right: 20.0, top: 8.0, bottom: 2.0),
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 9.0, bottom: 9.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      widget.senderMessage!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(right: 20.0, bottom: 8.0),
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
      ],
    );
  }
}
