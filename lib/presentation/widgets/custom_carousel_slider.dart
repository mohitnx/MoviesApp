import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../constants.dart';

class CarouselIndicator extends StatefulWidget {
  const CarouselIndicator({super.key});

  @override
  State<CarouselIndicator> createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<CarouselIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 13,
          height: 5,
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 13,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 13,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 13,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
