import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/presentation/widgets/glass_container.dart';
import '../../../../core/presentation/widgets/glass_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: 'My Profile',
      centerTitle: true,
      body: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
          ),
          const SizedBox(height: 16),
          Text(
            'Plant Parent',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'gardener@example.com',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 32),
          GlassContainer(
            child: Column(
              children: [
                _buildProfileItem(Icons.person_outline, 'Edit Profile'),
                const Divider(color: Colors.white10),
                _buildProfileItem(Icons.settings_outlined, 'Settings'),
                const Divider(color: Colors.white10),
                _buildProfileItem(Icons.help_outline, 'Help & Support'),
                const Divider(color: Colors.white10),
                _buildProfileItem(Icons.logout, 'Logout', isDestructive: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(
    IconData icon,
    String title, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.redAccent : Colors.white,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: isDestructive ? Colors.redAccent : Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
      onTap: () {},
    );
  }
}
