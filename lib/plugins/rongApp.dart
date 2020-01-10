import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';

void startRongApp() async {
  final _rongAppKey = "bmdehs6pbazks";
  final _rongIMToken =
      "fz7k/UJG3kjuPeuZ/eTZ/nIbXgr1+1BqwtgHeh18/7N0hykWpqtg746LeaIvvZl2qH+KwTeNp1wKM6lyC1YkMORlkxtiiZhC";

  // 初始化 SDK
  RongcloudImPlugin.init(_rongAppKey);

  // 连接 IM
  int rc = await RongcloudImPlugin.connect(_rongIMToken);
  print('connect result');
  print(rc);

  //消息接收回调
  RongcloudImPlugin.onMessageReceived = (Message msg, int left) {
    print("receive message messsageId:" +
        msg.toString() +
        " left:" +
        left.toString());
  };
}
