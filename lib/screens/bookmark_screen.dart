import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wisata_indonesia/services/auth_service.dart';
import 'package:wisata_indonesia/screens/destination_detail_screen.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final bookmarkedIds = authService.bookmarkedIds;
    
    // Mock data (gunakan data yang sama dengan home_screen)
    final List<Map<String, dynamic>> allDestinations = [
      {
        'id': '1',
        'name': 'Gunung Kerinci',
        'location': 'Jambi, Sumatera',
        'description': 'Gunung tertinggi di Sumatera dengan ketinggian 3.805 mdpl.',
        'image': 'https://cdn.pixabay.com/photo/2021/01/24/01/47/field-5944098_1280.jpg',
        'rating': 4.8,
        'type': 'Pegunungan',
        'price': 'Rp 50.000',
      },
      {
        'id': '2',
        'name': 'Pantai Kuta',
        'location': 'Bali',
        'description': 'Surfa paradise with beautiful sunset.',
        'image': 'https://cdn.pixabay.com/photo/2022/01/17/12/11/sunset-6944554_1280.jpg',
        'rating': 4.7,
        'type': 'Pantai',
        'price': 'Gratis',
      },
      {
        'id': '3',
        'name': 'Tanah Lot',
        'location': 'Bali',
        'description': 'Hindu temple on a rock in the sea.',
        'image': 'https://cdn.pixabay.com/photo/2017/08/11/21/13/bali-2632751_1280.jpg',
        'rating': 4.9,
        'type': 'Budaya',
        'price': 'Rp 60.000',
      },
      {
        'id': '4',
        'name': 'Danau Toba',
        'location': 'Sumatera Utara',
        'description': 'Largest volcanic lake in Sumatera Utara.',
        'image': 'https://cdn.pixabay.com/photo/2019/03/14/10/12/sumatra-4054560_1280.jpg',
        'rating': 4.5,
        'type': 'Danau',
        'price': 'Rp 30.000',
      },
      {
        'id': '5',
        'name': 'Borobudur',
        'location': 'Magelang, Jawa Tengah',
        'description': 'Largest Buddhist temple in the world.',
        'image': 'https://cdn.pixabay.com/photo/2017/03/22/23/02/borobudur-2166750_1280.jpg',
        'rating': 4.9,
        'type': 'Budaya',
        'price': 'Rp 75.000',
      },
    ];

    final bookmarkedDestinations = allDestinations
        .where((dest) => bookmarkedIds.contains(dest['id'] as String))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Tersimpan'),
        actions: [
          if (bookmarkedDestinations.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                _showClearAllBookmarksDialog(context);
              },
              tooltip: 'Hapus semua',
            ),
        ],
      ),
      body: bookmarkedDestinations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada wisata tersimpan',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tekan ikon bookmark untuk menyimpan',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.explore),
                    label: const Text('Jelajahi Wisata'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarkedDestinations.length,
              itemBuilder: (context, index) {
                final destination = bookmarkedDestinations[index];
                final destinationId = destination['id'] as String;
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: destination['image'] as String,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[200],
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
                    title: Text(
                      destination['name'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                destination['location'] as String,
                                style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 12, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text(
                              (destination['rating'] as double).toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Spacer(),
                            Chip(
                              label: Text(
                                destination['type'] as String,
                                style: const TextStyle(fontSize: 10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.bookmark, color: Colors.blue),
                      onPressed: () {
                        authService.toggleBookmark(destinationId);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DestinationDetailScreen(destination: destination),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  void _showClearAllBookmarksDialog(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Semua Favorit'),
        content: const Text('Yakin ingin menghapus semua wisata dari favorit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              // Remove all bookmarks
              for (final id in authService.bookmarkedIds.toList()) {
                authService.toggleBookmark(id);
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Semua favorit telah dihapus'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Hapus Semua', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}