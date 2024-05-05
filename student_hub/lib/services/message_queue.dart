class MessageQueueService {
  static final List<dynamic> _messageQueue = [];

  static void addMessage(dynamic message) {
    _messageQueue.add(message);
  }

  static void removeMessage() {
    _messageQueue.clear();
  }

  static List<dynamic> getMessages() {
    return List.from(_messageQueue.reversed);
  }
}
