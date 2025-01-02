import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio_package; // Update this import
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../widgets/animated_background.dart';
import '../widgets/profile_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';
import '../constants/colors.dart';

class ModernCVPage extends StatefulWidget {
  const ModernCVPage({Key? key}) : super(key: key);

  @override
  State<ModernCVPage> createState() => _ModernCVPageState();
}

class _ModernCVPageState extends State<ModernCVPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  double _scrollProgress = 0.0;
  bool _showFloatingButton = false;
  bool _isDownloading = false;
  final dio_package.Dio _dio = dio_package.Dio(); // Create Dio instance

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollProgress = _scrollController.position.pixels /
              _scrollController.position.maxScrollExtent;
          _showFloatingButton = _scrollController.offset > 100;
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _dio.close(); // Close Dio instance
    super.dispose();
  }

  Future<void> _downloadCV() async {
    // URL of your CV file (PDF recommended)
    const String cvUrl = 'https://your-domain.com/path-to-your-cv.pdf';
    
    if (Platform.isAndroid || Platform.isIOS) {
      await _downloadMobile(cvUrl);
    } else {
      await _downloadWeb(cvUrl);
    }
  }

  Future<void> _downloadMobile(String cvUrl) async {
    try {
      setState(() => _isDownloading = true);

      // Request storage permission on Android
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
          if (!status.isGranted) {
            _showMessage('Storage permission is required to download the CV');
            return;
          }
        }
      }

      // Get the download directory
      final directory = Platform.isAndroid
          ? Directory('/storage/emulated/0/Download')
          : await getApplicationDocumentsDirectory();

      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      // Download file
      final fileName = 'abdullahi_burhan_cv.pdf';
      final savePath = '${directory.path}/$fileName';
      
      await _dio.download(
        cvUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            // Update download progress if needed
            final progress = (received / total * 100).toStringAsFixed(0);
            debugPrint('Download progress: $progress%');
          }
        },
      );

      setState(() => _isDownloading = false);
      _showMessage('CV downloaded successfully to Downloads folder');

    } catch (e) {
      setState(() => _isDownloading = false);
      _showMessage('Failed to download CV: ${e.toString()}');
    }
  }

  Future<void> _downloadWeb(String cvUrl) async {
    try {
      final Uri uri = Uri.parse(cvUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        _showMessage('Could not launch CV download');
      }
    } catch (e) {
      _showMessage('Failed to download CV: ${e.toString()}');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: message.contains('Failed') || message.contains('required')
            ? Colors.red
            : AppColors.accent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _showDownloadDialog() async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          title: const Text(
            'Download CV',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          content: const Text(
            'Would you like to download my CV?',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
              ),
              child: const Text('Download'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await _downloadCV();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Profile Section
              const SliverToBoxAdapter(
                child: ProfileSection(),
              ),

              // Skills Section
              const SliverToBoxAdapter(
                child: SkillsSection(),
              ),

              // Experience Section
              const SliverToBoxAdapter(
                child: ExperienceSection(),
              ),

              // Projects Section
              const SliverToBoxAdapter(
                child: ProjectsSection(),
              ),

              // Contact Section
              const SliverToBoxAdapter(
                child: ContactSection(),
              ),

              // Bottom Padding
              SliverPadding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 20,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              value: _scrollProgress,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.accent.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
      
      
    );
  }
}