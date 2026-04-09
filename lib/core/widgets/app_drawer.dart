import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:globalweather/features/auth/presentation/pages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:globalweather/core/theme/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.2),
                ),
                accountName: Text(user?.displayName ?? 'Not logged in'),
                accountEmail: Text(user?.email ?? 'Login is not required'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                  backgroundColor: AppColors.secondaryColor,
                  child: user?.photoURL == null ? const Icon(Icons.person, color: Colors.white) : null,
                ),
              ),
              if (user == null)
                ListTile(
                  leading: const Icon(Icons.login, color: Colors.white),
                  title: const Text('Login', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Close the drawer before navigating
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                )
              else
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: const Text('Logout', style: TextStyle(color: Colors.white)),
                  onTap: () async {
                    await GoogleSignIn().signOut();
                    await FirebaseAuth.instance.signOut();
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
