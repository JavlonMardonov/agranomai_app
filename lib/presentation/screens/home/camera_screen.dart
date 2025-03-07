import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:agranom_ai/presentation/screens/home/image_scrren.dart';

class CameraApp extends StatefulWidget {
  /// Default Constructorlate
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController? controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _navigateToChatScreen(String imagePath) async {
    if (!mounted) return;

    // Then navigate to chat screen with the image
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(initialImagePath: imagePath),
      ),
    );
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras!.isEmpty) {
        throw Exception('No cameras found');
      }

      controller = CameraController(_cameras![0], ResolutionPreset.max);
      await controller!.initialize();

      if (!mounted) return;

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _flipCamera() async {
    if (_cameras!.length < 2) return;

    final lensDirection = controller!.description.lensDirection;
    CameraDescription newCamera;

    if (lensDirection == CameraLensDirection.back) {
      newCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );
    } else {
      newCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );
    }

    await controller!.dispose();
    controller = CameraController(newCamera, ResolutionPreset.max);
    await controller!.initialize();
    setState(() {});
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null && mounted) {
        await _navigateToChatScreen(image.path);
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Expanded(
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: SizedBox(
                  width: controller!.value.previewSize?.width ?? 0,
                  // height: controller!.value.previewSize?.height ?? 0,
                  child: CameraPreview(controller!),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_library, size: 40),
                  color: Colors.white,
                  onPressed: _pickFromGallery,
                ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      try {
                        final image = await controller!.takePicture();
                        if (mounted) {
                          await _navigateToChatScreen(image.path);
                        }
                      } catch (e) {
                        print('Error taking picture: $e');
                      }
                    },
                    icon: const Icon(
                      Icons.camera,
                      size: 32,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.flip_camera_ios, size: 40),
                  color: Colors.white,
                  onPressed: _flipCamera,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
