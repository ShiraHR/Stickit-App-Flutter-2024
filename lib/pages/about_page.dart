import 'package:final_project_3/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void _launchApp(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).colorScheme.background,
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
                child: Column(
              children: [
                const Header(title: 'אודות'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25,),
                  child: Center(
                    child:Padding(padding: EdgeInsets.only(top: 40,),
                    child: Column(children: [
                      Image.asset(
                        './lib/images/game_name.png',
                        width: 200,
                      ),
                      const SizedBox(height: 60),
                      const Text(
                          "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a"),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          myIconButton(
                              const Icon(Icons.mail_rounded), 'mailto:'),
                          const SizedBox(width: 16),
                          myIconButton(const Icon(Icons.sms_rounded), 'sms:'),
                          const SizedBox(width: 16),
                          myIconButton(
                              const Icon(Icons.facebook_sharp), 'fb://'),
                          const SizedBox(width: 16),
                          myIconButton(
                              const Icon(Icons.youtube_searched_for_rounded),
                              'https://www.youtube.com')
                        ],
                      ),
                    ])),
                  ),
                )
              ],
            ))));
  }

  Widget myIconButton(Icon icon, String url) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF90F6B1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        iconSize: 30.0,
        color: Colors.white,
        onPressed: () => _launchApp(url),
        icon: icon,
      ),
    );
  }
}
