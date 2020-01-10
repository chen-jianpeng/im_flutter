import 'package:im_flutter/api/request.dart';

final dio = init();

getChats() async {
  var res = await dio.get("/chats");
  return res.data;
}
