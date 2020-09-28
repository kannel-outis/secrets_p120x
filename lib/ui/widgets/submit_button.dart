import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isLoading;
  final String labelText;
  final Function onPressed;

  const SubmitButton(
      {Key key,
      @required this.isLoading,
      @required this.labelText,
      this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide * .140,
      decoration: BoxDecoration(
          // color: Colors.white,
          ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FlatButton(
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).scaffoldBackgroundColor,
          onPressed: onPressed,
          child: Center(
            child: isLoading == false
                ? Text(labelText ?? "LOGIN")
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).scaffoldBackgroundColor)),
          ),
        ),
      ),
    );
  }
}
