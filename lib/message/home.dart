import 'package:flutter/material.dart';
import 'package:im_flutter/message/body.dart';
import 'package:im_flutter/message/appBar.dart';

class InstaHome extends StatelessWidget {
  final topBar = new AppBar(
    backgroundColor: Colors.white,
    title: Text("Messages"),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Icon(Icons.send),
      )
    ],
  );

  final bottomNavigationBar = Container(
    height: 60,
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
            style: BorderStyle.solid, width: 1.0, color: Colors.black12),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(Colors.black, Icons.home, 'Home'),
        _buildButtonColumn(Colors.black26, Icons.camera_alt, 'Add New'),
        _buildButtonColumn(Colors.black26, Icons.search, 'Search'),
        _buildButtonColumn(Colors.black26, Icons.chat_bubble_outline, 'Inbox'),
        _buildButtonColumn(Colors.black26, Icons.perm_identity, 'Profile'),
      ],
    ),
  );

  static Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 20),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new CustomAppbar(
          title: 'Messages',
          leading: Text(
            "Messages",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          action: Icon(Icons.search),
        ),
        body: new InboxWidget(),
        bottomNavigationBar: bottomNavigationBar);
  }
}
