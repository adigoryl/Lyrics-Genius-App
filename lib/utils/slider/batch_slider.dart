import 'package:flutter/material.dart';

class BatchSlider extends StatefulWidget {
  BatchSlider({ Key key }) : super(key: key);

  @override
  BatchSliderState createState() => BatchSliderState();
  int batchSize = 2;

}

class BatchSliderState extends State<BatchSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.only(left: 4),
            child: Text("Batch Size")
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Slider(
                  value: widget.batchSize.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 10,
                  activeColor: Color(0xFF1eb2a6),
                  inactiveColor: Colors.black12,
                  label: widget.batchSize.toString(),
                  onChanged: (double newValue) {
                    setState(() {
                     widget.batchSize = newValue.round();
                    });
                  },
              )
          ),
        ],
    );
  }

}

