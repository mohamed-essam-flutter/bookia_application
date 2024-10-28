import 'package:flutter/material.dart';

push({required context, required Widget screen}) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => screen,
  ));
}

pushReplacement({required context, required Widget screen}) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => screen,
  ));
}

pushAndRemoveUntil({required context, required Widget screen}) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => screen),
    (route) => false,
  );
}
