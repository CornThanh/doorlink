class Mail {
  final String sender;
  final String senderEmail;
  final String subject;
  final String snippet;
  final String time;
  final bool isRead;

  Mail({
    required this.sender,
    required this.senderEmail,
    required this.subject,
    required this.snippet,
    required this.time,
    this.isRead = false,
  });
}
