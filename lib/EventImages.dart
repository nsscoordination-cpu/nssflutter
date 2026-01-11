import 'package:flutter/material.dart';
import 'package:nss/Api/regiapi.dart';

class Eventimages extends StatefulWidget {
  final String eid;

  const Eventimages({super.key, required this.eid});

  @override
  State<Eventimages> createState() => _EventimagesState();
}

class _EventimagesState extends State<Eventimages> {
  String eventName = '';
  List<dynamic> images = [];
  bool isLoading = true;

  Future<void> getImages() async {
    try {
      final response =
          await dio.get('$url/api/event/fetchdetails/${widget.eid}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          eventName = response.data['details']['name'];
          images = response.data['details']['photos'] ?? [];
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Event image error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Event Gallery'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : images.isEmpty
              ? const Center(child: Text('No images available'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 Event Title
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        eventName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// 🔹 Images Grid
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: images.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          final imageUrl =
                              '$url${images[index]['url']}';

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FullImageView(
                                    imageUrl: imageUrl,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, progress) {
                                    if (progress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (_, __, ___) =>
                                      const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

/// 🔹 FULL SCREEN IMAGE VIEW
class FullImageView extends StatelessWidget {
  final String imageUrl;

  const FullImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 5,
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
