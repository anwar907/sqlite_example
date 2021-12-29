import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final ImageProvider leading;
  final Widget traling;
  final Function onTap;
  final Widget child;
  final String title;
  CustomListTile(
      {@required this.onTap,
      @required this.title,
      @required this.leading,
      this.traling,
      this.child});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Container(
          height: double.infinity,
          width: 50,
          decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.cover, image: leading),
              color: Color(0xFFF9F9F9),
              borderRadius: BorderRadiusDirectional.circular(10.0)),
        ),
        trailing: traling,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: child,
      ),
    );
  }
}
