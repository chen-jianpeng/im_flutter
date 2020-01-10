import 'package:flutter/material.dart';
import 'package:im_flutter/api/message.dart' as api;
import 'package:moment/moment.dart';

class ItemCard extends StatelessWidget {
  Map data = {};

  ItemCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Dismissible(
          key: Key('key${data["id"]}'),
          child: ListTile(
            leading: new CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage:
                  NetworkImage('http://10.94.14.65:1337' + data["avatar"]),
            ),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  data["from"],
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  Moment(data["createTime"]).format('HH:mm'),
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                data["content"],
                style: new TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
          ),
          background: Container(
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              return _deleteConfirm(context);
            } else if (direction == DismissDirection.startToEnd) {
              return _collectConfirm(context);
            } else {
              return false;
            }
          },
        )
      ],
    );
  }

  Future<bool> _deleteConfirm(context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you wish to delete this item?"),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("DELETE")),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _collectConfirm(context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you wish to collect this item?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("COLLECT"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }
}

class InboxWidget extends StatefulWidget {
  @override
  InboxState createState() => new InboxState();
}

class InboxState extends State<InboxWidget> {
  List chats = [];

  Future getChats() async {
    List res = await api.getChats();
    setState(() {
      chats = res;
    });
  }

  @override
  void initState() {
    super.initState();
    getChats();
  }

  @override
  Widget build(BuildContext context) {
    if (this.chats.isEmpty) {
      return new Container();
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (BuildContext context, int index) {
        return new ItemCard(chats[index]);
      },
    );
  }
}
