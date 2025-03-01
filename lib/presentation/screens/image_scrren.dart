import 'dart:developer';
import 'dart:io';
import 'package:agranom_ai/bloc/image_upload_bloc/image_upload_bloc.dart';
import 'package:agranom_ai/common/utils/enums/statuses.dart';
import 'package:agranom_ai/data/services/image_picker_service.dart';
import 'package:agranom_ai/presentation/widgets/customChatCard.dart';
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
  List<Map<String, dynamic>> messages = [];

  Future<void> _pickImage(bool fromCamera) async {
    final image = await _imagePickerService.pickImage(fromCamera: fromCamera);
    if (image != null) {
      setState(() {
        messages.add({'type': 'image', 'content': image, 'isUser': true});
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
                if (state.status == Statuses.Success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Rasm muvaffaqiyatli yuklandi!")),
                  );
                } else if (state.status == Statuses.Error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Xatolik: ${state.errorMessage}")),
                  );
                  log(state.errorMessage.toString());
                }
                if (state.imagePath != null) {
                  context.read<ImageUploadBloc>().add(
                        ImageUploadEvent.getPredict(
                            imagePath: "${state.imagePath}"),
                      );
                  log("Description  ${state.imageData?.data?.type?.description}");
                }

                if (state.imageData?.data != null) {
                  setState(() {
                    messages.add({
                      'type': 'response',
                      'content': state.imageData!.data,
                      'isUser': false
                    });
                  });
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[messages.length - 1 - index];
                    final isUserMessage = message['isUser'] as bool;

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
                        child: message['type'] == 'image'
                            ? Image.file(
                                message['content'] as File,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              )
                            : message['type'] == 'response'
                                ? CabbageLoopersCard(data: message['content'])
                                : const Text(""),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pickImage(false),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
