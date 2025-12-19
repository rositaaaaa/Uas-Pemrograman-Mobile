import 'package:flutter/material.dart';
import 'package:wisata_indonesia/screens/destination_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  final List<Map<String, dynamic>> _allDestinations = [
    {
      'id': '1',
      'name': 'Gunung Kerinci',
      'location': 'Jambi, Sumatera',
      'description': 'Gunung tertinggi di Sumatera dengan ketinggian 3.805 mdpl. Menawarkan pemandangan alam yang menakjubkan.',
      'image': 'https://images.unsplash.com/photo-1621451537084-482c73073a0f?q=80&w=1374',
      'rating': 4.8,
      'type': 'Pegunungan',
      'price': 'Rp 50.000',
    },
    {
      'id': '2',
      'name': 'Pantai Kuta',
      'location': 'Bali',
      'description': 'Surga peselancar dengan sunset terindah di Indonesia. Cocok untuk berselancar dan berjemur.',
      'image': 'https://images.unsplash.com/photo-1534008897995-27a23e859048?q=80&w=1374',
      'rating': 4.7,
      'type': 'Pantai',
      'price': 'Gratis',
    },
    {
      'id': '3',
      'name': 'Tanah Lot',
      'location': 'Bali',
      'description': 'Pura Hindu yang terletak di atas batu karang di tengah laut. Tempat terbaik melihat sunset.',
      'image': 'https://images.unsplash.com/photo-1552465011-b4e30bf7349d?q=80&w=1390',
      'rating': 4.9,
      'type': 'Budaya',
      'price': 'Rp 60.000',
    },
    {
      'id': '4',
      'name': 'Danau Kerinci',
      'location': 'Jambi',
      'description': 'Danau vulkanik terbesar di Jambi dengan air yang jernih dan pemandangan gunung sekitar.',
      'image': 'https://images.unsplash.com/photo-1593693399741-6c5c4e4f1c7c?q=80&w=1470',
      'rating': 4.5,
      'type': 'Danau',
      'price': 'Rp 30.000',
    },
    {
      'id': '5',
      'name': 'Borobudur',
      'location': 'Magelang, Jawa Tengah',
      'description': 'Candi Buddha terbesar di dunia yang dibangun pada abad ke-9. Situs warisan dunia UNESCO.',
      'image': 'https://images.unsplash.com/photo-1588666309990-d68f08e3d4c6?q=80&w=1450',
      'rating': 4.9,
      'type': 'Budaya',
      'price': 'Rp 75.000',
    },
    {
      'id': '6',
      'name': 'Gunung Bromo',
      'location': 'Jawa Timur',
      'description': 'Gunung berapi aktif dengan pemandangan sunrise yang legendaris.',
      'image': 'https://images.unsplash.com/photo-1588668214407-78eaaf642345?q=80&w=1470',
      'rating': 4.9,
      'type': 'Vulkanik',
      'price': 'Rp 35.000',
    },
    {
      'id': '7',
      'name': 'Raja Ampat',
      'location': 'Papua Barat',
      'description': 'Surga penyelam dengan keanekaragaman hayati laut tertinggi di dunia.',
      'image': 'https://images.unsplash.com/photo-1552733407-5d5c46c3bb3b?q=80&w=1380',
      'rating': 4.9,
      'type': 'Pantai',
      'price': 'Rp 150.000',
    },
    {
      'id': '8',
      'name': 'Prambanan',
      'location': 'Yogyakarta',
      'description': 'Candi Hindu terbesar di Indonesia dengan arsitektur yang megah.',
      'image': 'https://images.unsplash.com/photo-1548013146-72479768bada?q=80&w=1413',
      'rating': 4.7,
      'type': 'Budaya',
      'price': 'Rp 50.000',
    },
  ];

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // Gunakan Future.delayed untuk simulasi loading
    Future.delayed(const Duration(milliseconds: 300), () {
      final results = _allDestinations.where((dest) {
        final name = (dest['name'] as String? ?? '').toLowerCase();
        final location = (dest['location'] as String? ?? '').toLowerCase();
        final type = (dest['type'] as String? ?? '').toLowerCase();
        final description = (dest['description'] as String? ?? '').toLowerCase();
        final queryLower = query.toLowerCase();

        return name.contains(queryLower) ||
            location.contains(queryLower) ||
            type.contains(queryLower) ||
            description.contains(queryLower);
      }).toList();

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchResults = [];
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Cari destinasi wisata...',
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: _clearSearch,
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onChanged: _performSearch,
            onSubmitted: (value) => _performSearch(value),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isSearching) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Mencari...'),
          ],
        ),
      );
    }

    if (_searchController.text.isEmpty && _searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Cari destinasi wisata',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Cari berdasarkan nama, lokasi, atau jenis wisata',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildSearchChip('Pantai'),
                _buildSearchChip('Gunung'),
                _buildSearchChip('Budaya'),
                _buildSearchChip('Danau'),
                _buildSearchChip('Bali'),
                _buildSearchChip('Jawa'),
              ],
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Tidak ada hasil untuk "${_searchController.text}"',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Coba dengan kata kunci lain',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final destination = _searchResults[index];
        final destinationName = destination['name'] as String? ?? 'Destinasi';
        final destinationLocation = destination['location'] as String? ?? 'Lokasi';
        final destinationRating = destination['rating'] as double? ?? 0.0;
        final destinationType = destination['type'] as String? ?? 'Wisata';
        final destinationPrice = destination['price'] as String? ?? 'Rp 0';
        final destinationImage = destination['image'] as String? ?? '';
        final destinationDescription = destination['description'] as String? ?? '';

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
                image: destinationImage.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(destinationImage),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: destinationImage.isEmpty
                  ? const Icon(Icons.image, color: Colors.grey)
                  : null,
            ),
            title: Text(
              destinationName,
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
                        destinationLocation,
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
                      destinationRating.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        destinationType,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (destinationDescription.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      destinationDescription,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  destinationPrice,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DestinationDetailScreen(
                    destination: {
                      'id': destination['id'] as String? ?? '',
                      'name': destinationName,
                      'location': destinationLocation,
                      'description': destinationDescription,
                      'image': destinationImage,
                      'rating': destinationRating,
                      'type': destinationType,
                      'price': destinationPrice,
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchChip(String text) {
    return GestureDetector(
      onTap: () {
        _searchController.text = text;
        _performSearch(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue[100]!),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}