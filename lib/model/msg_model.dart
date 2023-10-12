class MessageModel {
  final String type;
  final String msg;
  final String senderName;
  final String senderId;
  final String time;
  MessageModel({
    required this.msg,
    required this.senderId,
    required this.senderName,
    required this.type,
    required this.time,
  });
}
