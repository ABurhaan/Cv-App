import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Me',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor,
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Name',
                    icon: Icons.person,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value!)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _messageController,
                    label: 'Message',
                    icon: Icons.message,
                    maxLines: 5,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Send Message',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          _buildContactInfo(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.accent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.accent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.accent.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
        filled: true,
        fillColor: AppColors.overlayColor,
      ),
    );
  }

  Widget _buildContactInfo() {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
              spacing: 20,
              runSpacing: 20,
      children: [
        _buildContactItem(
          icon: Icons.email,
          title: 'Email',
          content: 'burhaan11@hotmail.com',
        ),
        _buildContactItem(
          icon: Icons.phone,
          title: 'Phone',
          content: '+252907767700',
        ),
        _buildContactItem(
          icon: Icons.location_on,
          title: 'Location',
          content: 'Galkayo, Somalia',
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColors.accent, size: 30),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          content,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement form submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message sent successfully!'),
          backgroundColor: AppColors.accent,
        ),
      );
    }
  }
}