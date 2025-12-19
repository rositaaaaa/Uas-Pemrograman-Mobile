import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:wisata_indonesia/screens/search_screen.dart';
import 'package:wisata_indonesia/screens/bookmark_screen.dart';
import 'package:wisata_indonesia/screens/destination_detail_screen.dart';
import 'package:wisata_indonesia/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.landscape, 'label': 'Pegunungan', 'color': Colors.green},
    {'icon': Icons.beach_access, 'label': 'Pantai', 'color': Colors.blue},
    {'icon': Icons.temple_hindu, 'label': 'Budaya', 'color': Colors.orange},
    {'icon': Icons.whatshot, 'label': 'Vulkanik', 'color': Colors.red},
    {'icon': Icons.water, 'label': 'Danau', 'color': Colors.cyan},
  ];

  final List<Map<String, dynamic>> destinations = const [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            pinned: true,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?q=80&w=1470',
                fit: BoxFit.cover,
              ),
              title: const Text('Wisata Indonesia'),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Section
                  const Text(
                    'Selamat Datang!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Temukan keindahan Indonesia',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),

                  // Quick Actions
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickAction(
                          Icons.search,
                          'Cari Destinasi',
                          Colors.blue,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildQuickAction(
                          Icons.bookmark,
                          'Tersimpan',
                          Colors.purple,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookmarkScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Categories
                  const Text(
                    'Kategori',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return _buildCategoryCard(category);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Popular Destinations
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Destinasi Populer',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Lihat Semua'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Destinations Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final destination = destinations[index];
                  return _buildDestinationCard(context, destination);
                },
                childCount: destinations.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: category['color'].withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: category['color'].withOpacity(0.3)),
            ),
            child: Icon(category['icon'], color: category['color'], size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            category['label'],
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(BuildContext context, Map<String, dynamic> destination) {
    final authService = Provider.of<AuthService>(context);
    final destinationId = destination['id'] as String;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailScreen(destination: destination),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: destination['image'] as String,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      height: 120,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      height: 120,
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: IconButton(
                        icon: Icon(
                          authService.isBookmarked(destinationId) ? Icons.bookmark : Icons.bookmark_border,
                          color: authService.isBookmarked(destinationId) ? Colors.blue : Colors.grey,
                          size: 16,
                        ),
                        onPressed: () {
                          authService.toggleBookmark(destinationId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                authService.isBookmarked(destinationId)
                                    ? '${destination['name']} ditambahkan ke favorit'
                                    : '${destination['name']} dihapus dari favorit',
                              ),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination['name'] as String,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 12, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          destination['location'] as String,
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        (destination['rating'] as double).toString(),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        destination['price'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}