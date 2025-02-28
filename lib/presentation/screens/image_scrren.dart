import 'dart:developer';
import 'dart:io';
import 'package:agranom_ai/bloc/image_upload_bloc/image_upload_bloc.dart';
import 'package:agranom_ai/common/utils/enums/statuses.dart';
import 'package:agranom_ai/data/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePickerService _imagePickerService = ImagePickerService();
  final TextEditingController _textController = TextEditingController();
  File? _selectedImage;
  List<Map<String, dynamic>> messages = [];

  Future<void> _pickImage(bool fromCamera) async {
    final image = await _imagePickerService.pickImage(fromCamera: fromCamera);
    if (image != null) {
      setState(() {
        _selectedImage = image;
        messages.add({'type': 'image', 'content': image});
      });
      context.read<ImageUploadBloc>().add(
            ImageUploadEvent.getImagePath(imagefile: image),
          );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera Chat")),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ImageUploadBloc, ImageUploadState>(
              listener: (context, state) {
                if (state.status == Statuses.Success &&
                    state.imagePath != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Rasm muvaffaqiyatli yuklandi!")),
                  );
                  context.read<ImageUploadBloc>().add(
                        ImageUploadEvent.getPredict(
                            imagePath: "${state.imagePath}"),
                      );
                  log("Desctr[okdv.............] ${state.imageData?.data?.type?.description}");
                } else if (state.status == Statuses.Error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Xatolik: ${state.errorMessage}")),
                  );
                  log(state.errorMessage.toString());
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isImage = message['type'] == 'image';
                    final isUserMessage = message['isUser'] ?? true;

                    return Align(
                      alignment: isUserMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              isUserMessage ? Colors.green : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: isImage
                            ? Image.file(
                                message['content'],
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              )
                            : Text(
                                "${state.imageData?.data?.type?.description}",
                                style: TextStyle(
                                  color: isUserMessage
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: "Matn kiriting...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final text = _textController.text;
                    if (text.isNotEmpty) {
                      setState(() {
                        messages.add(
                            {'type': 'text', 'content': text, 'isUser': true});
                      });
                      _textController.clear();
                    }
                  },
                  icon: const Icon(Icons.send, color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pickImage(false),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
