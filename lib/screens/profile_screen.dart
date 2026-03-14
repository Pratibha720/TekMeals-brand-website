import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                // This now works because we defined '/login' in main.dart
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              child: const Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// TOP SECTION
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 15),
                const Text("John Doe", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text("johndoe@tekmeals.com", style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// OPTIONS LIST WITH DROPDOWNS (ExpansionTiles)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // EDIT PROFILE DROPDOWN
                _buildExpansionTile(
                  icon: Icons.edit_outlined,
                  title: "Edit Profile",
                  children: [
                    _buildInputField("Full Name", "John Doe"),
                    _buildInputField("Phone Number", "+91 98765 43210"),
                    ElevatedButton(onPressed: () {}, child: const Text("Update Info"))
                  ],
                ),

                // CHANGE PASSWORD DROPDOWN
                _buildExpansionTile(
                  icon: Icons.lock_outline,
                  title: "Change Password",
                  children: [
                    _buildInputField("Current Password", "********", isPassword: true),
                    _buildInputField("New Password", "", isPassword: true),
                    ElevatedButton(onPressed: () {}, child: const Text("Change Password"))
                  ],
                ),

                const SizedBox(height: 10),
                const Divider(),

                // LOGOUT (Still a regular clickable tile)
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile({required IconData icon, required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: const Color(0xFF103931)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        shape: const Border(), // Removes the default lines
        childrenPadding: const EdgeInsets.all(15),
        children: children,
      ),
    );
  }

  Widget _buildInputField(String label, String initialValue, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}