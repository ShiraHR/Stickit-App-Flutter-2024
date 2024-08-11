import 'package:flutter/material.dart';

import '../models/user.dart';
import 'about_page.dart';
import 'edit_profile_page.dart';
import 'login_page_one.dart';
import 'terms_page.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              _buildLogo(),
              const SizedBox(height: 24),
              _buildProfileImage(context),
              const SizedBox(height: 30),
              _buildeNameAndGrade(context),
              const SizedBox(height: 16),
              _buildInfoCard(),
              _buildListTile(
                icon: Icons.edit,
                title: 'עריכת פרטי חשבון',
                subtitle: 'עריכת הפרטים שלי',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                              user: user,
                            )),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.info_rounded,
                title: 'אודות Skitick',
                subtitle: 'קצת עלינו, מי אנחנו ולמה קמנו',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
              ),
              _buildListTile(
                  icon: Icons.rule,
                  title: 'תנאי שימוש ופרטיות',
                  subtitle: 'תנאי השימוש ומדיניות הפרטיות שלנו',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsPage()),
                    );
                  }),
              _buildListTile(
                icon: Icons.exit_to_app,
                title: 'יציאה מהחשבון',
                subtitle: '${user.firstName}  ${user.lastName}מחובר כ',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'lib/images/game_name.png',
      height: 40,
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Container(
      width: 128.0,
      height: 128.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 15.0,
        ),
      ),
      child: ClipOval(
        child: Image.network(
          user.imageURL,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildeNameAndGrade(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            user.grade,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        Text(
          user.firstName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: const Color(0xFF90F6B1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildColumn(
                user.album!.numOfGoldStickers + user.album!.numOfSilverStickers,
                'מדבקות \n שאספתי'),
            _buildColumn(user.boardNumber, 'הלוח \n הנוכחי'),
            _buildColumn(user.finishedAlbums.length, 'לוחות \n שסיימתי'),
          ],
        ),
      ),
    );
  }

  Widget _buildColumn(int value, String label) {
    print(value);
    return Expanded(
      child: SizedBox(
        height: 91.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${value}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      trailing: Icon(icon, color: const Color(0xFF90F6B1)),
      leading: const Icon(Icons.arrow_back_ios, size: 18),
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(title),
      ),
      subtitle: Align(
        alignment: Alignment.centerRight,
        child: Text(subtitle),
      ),
      onTap: onTap,
    );
  }
}
