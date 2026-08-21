import 'package:flutter/material.dart';
import 'package:running_app/core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            10,
            16,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // GENERAL
              // =========================
              _buildSectionTitle('General'),
              _buildSettingsCard(
                children: [
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    secondary: _buildIconContainer(
                      Icons.notifications_outlined,
                    ),
                    title: const Text(
                      'Notifications',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      'Receive running reminders',
                    ),
                    value: true,
                    activeColor: AppTheme.primaryColor,
                    onChanged: (value) {},
                  ),

                  _buildDivider(),

                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    secondary: _buildIconContainer(
                      Icons.dark_mode_outlined,
                    ),
                    title: const Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      'Use dark appearance',
                    ),
                    value: false,
                    activeColor: AppTheme.primaryColor,
                    onChanged: (value) {},
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // =========================
              // RUNNING
              // =========================

              _buildSectionTitle('Running'),

              _buildSettingsCard(
                children: [
                  _buildSettingsTile(
                    icon: Icons.straighten,
                    title: 'Distance Unit',
                    subtitle: 'Kilometers',
                    trailing: const Text(
                      'KM',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {},
                  ),

                  _buildDivider(),

                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    secondary: _buildIconContainer(
                      Icons.pause_circle_outline,
                    ),
                    title: const Text(
                      'Auto Pause',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      'Pause when you stop moving',
                    ),
                    value: false,
                    activeColor: AppTheme.primaryColor,
                    onChanged: (value) {},
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // =========================
              // ABOUT
              // =========================

              _buildSectionTitle('About'),

              _buildSettingsCard(
                children: [
                  _buildSettingsTile(
                    icon: Icons.info_outline,
                    title: 'About Running App',
                    subtitle: 'Version 1.0.0',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),

                  _buildDivider(),

                  _buildSettingsTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    subtitle: 'Read our privacy policy',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // =========================
              // VERSION
              // =========================

              Center(
                child: Text(
                  'Running App • v1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // SECTION TITLE
  // =========================

  static Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        bottom: 10,
      ),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  // =========================
  // SETTINGS CARD
  // =========================

  static Widget _buildSettingsCard({
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // =========================
  // SETTINGS TILE
  // =========================

  static Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      leading: _buildIconContainer(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  // =========================
  // ICON CONTAINER
  // =========================

  static Widget _buildIconContainer(IconData icon) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: AppTheme.primaryColor,
        size: 22,
      ),
    );
  }

  // =========================
  // DIVIDER
  // =========================

  static Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      indent: 72,
      endIndent: 16,
      color: Colors.grey.shade200,
    );
  }
}