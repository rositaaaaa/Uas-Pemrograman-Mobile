import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:wisata_indonesia/services/auth_service.dart';

class DestinationDetailScreen extends StatelessWidget {
  final Map<String, dynamic> destination;
  
  const DestinationDetailScreen({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final destinationId = destination['id'] as String;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: destination['image'] as String,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.grey[200]),
              ),
              title: Text(
                destination['name'] as String,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  authService.isBookmarked(destinationId) 
                      ? Icons.bookmark 
                      : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  authService.toggleBookmark(destinationId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        authService.isBookmarked(destinationId)
                            ? 'Ditambahkan ke favorit'
                            : 'Dihapus dari favorit',
                      ),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // Share functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Berbagi fitur akan segera tersedia'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          destination['location'] as String,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        (destination['rating'] as double).toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    destination['description'] as String,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Fasilitas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      Chip(
                        label: Text('Parkir'),
                        avatar: Icon(Icons.local_parking, size: 16),
                      ),
                      Chip(
                        label: Text('Toilet'),
                        avatar: Icon(Icons.wc, size: 16),
                      ),
                      Chip(
                        label: Text('Warung Makan'),
                        avatar: Icon(Icons.restaurant, size: 16),
                      ),
                      Chip(
                        label: Text('Penginapan'),
                        avatar: Icon(Icons.hotel, size: 16),
                      ),
                      Chip(
                        label: Text('Pemandu Wisata'),
                        avatar: Icon(Icons.tour, size: 16),
                      ),
                      Chip(
                        label: Text('Area Foto'),
                        avatar: Icon(Icons.photo_camera, size: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showAddTodoDialog(context),
                      icon: const Icon(Icons.add_task),
                      label: const Text('Tambah ke Todo List'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah ke Todo List'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tambahkan "${destination['name']}" ke daftar kegiatan?'),
            const SizedBox(height: 8),
            Text(
              destination['location'] as String,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              authService.addTodo(
                title: 'Kunjungi ${destination['name']}',
                description: destination['description'] as String,
                destinationName: destination['name'] as String,
                destinationLocation: destination['location'] as String,
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${destination['name']} ditambahkan ke Todo List'),
                  backgroundColor: Colors.green,
                  action: SnackBarAction(
                    label: 'Lihat',
                    textColor: Colors.white,
                    onPressed: () {
                      // Navigate to home and change tab to todo
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Future.delayed(const Duration(milliseconds: 100), () {
                        // In a real app, you would use a different navigation approach
                        // This is a simplified version
                        Navigator.pushNamed(context, '/todo');
                      });
                    },
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }
}