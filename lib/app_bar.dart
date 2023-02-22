import 'package:flutter/material.dart';

class App_bar extends StatelessWidget {
  const App_bar({super.key, required this.title, this.showGoBack = false});

  final String title;
  final bool showGoBack;

  @override
  Widget build (BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            bottomLeft: const Radius.circular(10.0),
            bottomRight: const Radius.circular(10.0),
          ),
          boxShadow: <BoxShadow> [
            const BoxShadow(
              color: Colors.white, spreadRadius: 10.0, blurRadius: 20.0)
          ]),
        child: Row(
        children: <Widget>[
          Container(
            child: showGoBack ? IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {Navigator.pop(context);
                },
              padding: EdgeInsets.zero,
            )
            : Container(
                height: 50.0,
    )
    )
          ]),
        ),
    );
  }
}