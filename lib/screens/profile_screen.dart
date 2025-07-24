import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:getwidget/getwidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildProfileHeader(),
          _buildStats(),
          _buildMenuItems(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.theme.primaryColor.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
        title: Text(
          'Profil',
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
      ),
      actions: [
        IconButton(
          onPressed: _showSettings,
          icon: const Icon(Icons.settings_rounded),
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: context.theme.primaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.person_rounded,
                    size: 40,
                    color: context.theme.primaryColor,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: context.theme.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.theme.scaffoldBackgroundColor,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Max Mustermann',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'max.mustermann@email.com',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.theme.textTheme.bodySmall?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '4.8',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(23 Bewertungen)',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GFButton(
              onPressed: _editProfile,
              text: 'Bearbeiten',
              type: GFButtonType.outline2x,
              shape: GFButtonShape.pills,
              size: GFSize.SMALL,
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),
    );
  }

  Widget _buildStats() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildStatItem(
                icon: Icons.inventory_2_rounded,
                label: 'Aktive Anzeigen',
                value: '12',
                color: context.theme.primaryColor,
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: _buildStatItem(
                icon: Icons.check_circle_rounded,
                label: 'Verkauft',
                value: '34',
                color: Colors.green,
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: _buildStatItem(
                icon: Icons.favorite_rounded,
                label: 'Favoriten',
                value: '8',
                color: Colors.red,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms, delay: 100.ms).slideY(begin: 0.2),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.theme.textTheme.bodySmall?.color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      MenuItemData(
        icon: Icons.inventory_2_rounded,
        title: 'Meine Anzeigen',
        subtitle: 'Verwalte deine Anzeigen',
        onTap: () => _navigateToMyListings(),
      ),
      MenuItemData(
        icon: Icons.message_rounded,
        title: 'Nachrichten',
        subtitle: 'Chat-Verlauf ansehen',
        onTap: () => _navigateToMessages(),
        badge: '3',
      ),
      MenuItemData(
        icon: Icons.payment_rounded,
        title: 'Zahlungsmethoden',
        subtitle: 'Karten und Konten verwalten',
        onTap: () => _navigateToPayments(),
      ),
      MenuItemData(
        icon: Icons.location_on_rounded,
        title: 'Standort',
        subtitle: 'Suchbereich festlegen',
        onTap: () => _navigateToLocation(),
      ),
      MenuItemData(
        icon: Icons.security_rounded,
        title: 'Sicherheit',
        subtitle: 'Passwort und Privatsphäre',
        onTap: () => _navigateToSecurity(),
      ),
      MenuItemData(
        icon: Icons.help_rounded,
        title: 'Hilfe & Support',
        subtitle: 'FAQ und Kontakt',
        onTap: () => _navigateToHelp(),
      ),
      MenuItemData(
        icon: Icons.info_rounded,
        title: 'Über die App',
        subtitle: 'Version und Rechtliches',
        onTap: () => _navigateToAbout(),
      ),
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                'Einstellungen',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          final itemIndex = index - 1;
          if (itemIndex >= menuItems.length) return null;

          final item = menuItems[itemIndex];
          
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  item.icon,
                  color: context.theme.primaryColor,
                  size: 20,
                ),
              ),
              title: Text(
                item.title,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                item.subtitle,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.theme.textTheme.bodySmall?.color,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        item.badge!,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                ],
              ),
              onTap: item.onTap,
            ),
          ).animate(delay: (itemIndex * 50).ms)
              .fadeIn(duration: 300.ms)
              .slideX(begin: 0.2);
        },
        childCount: menuItems.length + 1,
      ),
    );
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildSettingsBottomSheet(),
    );
  }

  Widget _buildSettingsBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Einstellungen',
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSettingsTile(
                    icon: Icons.dark_mode_rounded,
                    title: 'Dark Mode',
                    subtitle: 'Dunkles Design aktivieren',
                    trailing: Switch(
                      value: _isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          _isDarkMode = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSettingsTile(
                    icon: Icons.notifications_rounded,
                    title: 'Benachrichtigungen',
                    subtitle: 'Push-Nachrichten erhalten',
                    trailing: Switch(
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSettingsTile(
                    icon: Icons.location_on_rounded,
                    title: 'Standort',
                    subtitle: 'GPS für bessere Suche nutzen',
                    trailing: Switch(
                      value: _locationEnabled,
                      onChanged: (value) {
                        setState(() {
                          _locationEnabled = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: GFButton(
                      onPressed: _logout,
                      text: 'Abmelden',
                      type: GFButtonType.outline2x,
                      shape: GFButtonShape.pills,
                      size: GFSize.LARGE,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 1, duration: 300.ms);
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: context.theme.primaryColor,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  void _editProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profil bearbeiten geöffnet'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _navigateToMyListings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Meine Anzeigen geöffnet'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _navigateToMessages() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Nachrichten geöffnet'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _navigateToPayments() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Zahlungsmethoden geöffnet'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _navigateToLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Standort-Einstellungen geöffnet'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _navigateToSecurity() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Sicherheits-Einstellungen geöffnet'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _navigateToHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Hilfe & Support geöffnet'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _navigateToAbout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Über die App geöffnet'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Abmelden'),
        content: const Text('Möchtest du dich wirklich abmelden?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Erfolgreich abgemeldet'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Abmelden'),
          ),
        ],
      ),
    );
  }
}

class MenuItemData {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String? badge;

  MenuItemData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.badge,
  });
}

