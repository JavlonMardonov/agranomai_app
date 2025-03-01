import 'package:agranom_ai/data/models/get_predict_dto.dart';
import 'package:flutter/material.dart';

class CabbageLoopersCard extends StatelessWidget {
  final Data data;

  const CabbageLoopersCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> images = ["${data.type?.images}"];

    final String name = "${data.type?.name}";
    final String imageUrl =  "https://api.agronomai.birnima.uz${data.image}";
    final String nameUz = "${data.type?.nameUz}";
    final String description = "${data.type?.description}";
    final double confidence = double.parse("${data.confidence}");
    final String createdAt = "${data.createdAt}";

    return Card(
      elevation: 2,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                width: double.infinity,
                height: 150,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image, color: Colors.grey[600]),
                );
              },
              ),
            ),
            
            // Rasm

            SizedBox(height: 16),
            // Nomi (Inglizcha va O'zbekcha)
            Text(
              name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              nameUz,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            // Tavsif
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            SizedBox(height: 16),

            Text(
              "Confidence: ${confidence.toStringAsFixed(2)}%",
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
            Text(
              "Created: ${createdAt.substring(0, 10)}",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
