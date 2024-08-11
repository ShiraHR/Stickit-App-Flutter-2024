import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

final smtpServer = gmail('dl0534170316@gmail.com', 'qrkp yvto lbld wzpr');

Future<void> sendEmail(String email, String subject, String text) async {
  final message = Message()
    ..from = const Address('dl0534170316@gmail.com', 'skitick')
    ..recipients.add(email)
    ..subject = subject
    ..text = text;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: $sendReport');
  } on MailerException catch (e) {
    print('Message not sent. \n$e');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

Future<void> sendVerificationEmail(String email, String code) async {
  await sendEmail(email, 'Verification Code', 'Your verification code is: $code');
}

Future<void> sendOrderEmail(String email, String orderDetails, String total) async {
  await sendEmail(email, 'Your Order Details', 'Order Details:\n$orderDetails\n\nTotal: \$$total');
}