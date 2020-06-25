import 'package:flutter/material.dart';

const modes = [
  '簡単',
  '難しい',
  '激ムズ',
];

class ModeSelectScreen extends StatelessWidget {
  const ModeSelectScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('モードを選択')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: modes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(modes[index]),
              onTap: () => Navigator.of(context).pushNamed('/game'),
            );
          },
        ),
      ),
    );
  }
}
