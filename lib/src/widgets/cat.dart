import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  const Cat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network('https://www.pngarts.com/files/10/Vector-Cat-Cartoon-Face-PNG-Photo.png');
  }
}
