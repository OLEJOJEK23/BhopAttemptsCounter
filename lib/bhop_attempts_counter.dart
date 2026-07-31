import 'package:flutter/material.dart';

import 'features/home.dart';

class BhopAttemptsCounter extends StatelessWidget {
  const BhopAttemptsCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bhop attempts counter',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}