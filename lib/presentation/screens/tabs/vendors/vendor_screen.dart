import 'package:flutter/material.dart';
import 'package:perfect_wedding_planner/core/theme/app_colors.dart';
import 'package:perfect_wedding_planner/core/theme/text_styles.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendors'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'My Vendors'),
            Tab(text: 'Find Vendors'),
          ],
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primary,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add vendor action
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search vendors
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _MyVendorsTab(),
          _FindVendorsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          // Add vendor action
        },
      ),
    );
  }
}

class _MyVendorsTab extends StatelessWidget {
  const _MyVendorsTab();

  @override
  Widget build(BuildContext context) {
    // Mock data for vendors
    final vendors = [
      const _VendorModel(
        id: '1',
        name: 'Elegant Events Venue',
        category: 'Venue',
        phone: '(555) 123-4567',
        email: 'contact@elegantevents.com',
        website: 'www.elegantevents.com',
        isBooked: true,
        price: 15000,
        notes: 'Booked for October 15, 2024. Deposit of \$5,000 paid.',
        imageUrl:
            'https://images.pexels.com/photos/265129/pexels-photo-265129.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      ),
      const _VendorModel(
        id: '2',
        name: 'Divine Photography',
        category: 'Photographer',
        phone: '(555) 234-5678',
        email: 'hello@divinephotos.com',
        website: 'www.divinephotos.com',
        isBooked: false,
        price: 3000,
        notes: 'Meeting scheduled for June 15 at 2:00 PM.',
        imageUrl:
            'https://images.pexels.com/photos/3737744/pexels-photo-3737744.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      ),
      const _VendorModel(
        id: '3',
        name: 'Gourmet Catering Co.',
        category: 'Caterer',
        phone: '(555) 345-6789',
        email: 'info@gourmetcatering.com',
        website: 'www.gourmetcatering.com',
        isBooked: true,
        price: 9500,
        notes: 'Deposit of \$2,000 paid. Tasting scheduled for July 10.',
        imageUrl:
            'https://images.pexels.com/photos/5865196/pexels-photo-5865196.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      ),
      const _VendorModel(
        id: '4',
        name: 'Bloom & Petal Florists',
        category: 'Florist',
        phone: '(555) 456-7890',
        email: 'orders@bloomandpetal.com',
        website: 'www.bloomandpetal.com',
        isBooked: false,
        price: 2500,
        notes: 'Meeting scheduled for June 20.',
        imageUrl:
            'https://images.pexels.com/photos/1723637/pexels-photo-1723637.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      ),
    ];

    // Group vendors by category
    final groupedVendors = <String, List<_VendorModel>>{};
    for (final vendor in vendors) {
      if (groupedVendors.containsKey(vendor.category)) {
        groupedVendors[vendor.category]!.add(vendor);
      } else {
        groupedVendors[vendor.category] = [vendor];
      }
    }

    // Sort categories alphabetically
    final sortedCategories = groupedVendors.keys.toList()..sort();

    return vendors.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
            itemCount: sortedCategories.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final category = sortedCategories[index];
              final vendorsInCategory = groupedVendors[category]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Text(
                      category,
                      style: TextStyles.headline5,
                    ),
                  ),
                  ...vendorsInCategory.map((vendor) => _VendorCard(
                        vendor: vendor,
                      )),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.storefront_outlined,
            size: 72,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No vendors added yet',
            style: TextStyles.headline5.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your wedding vendors to keep track of them',
            style: TextStyles.body2.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FindVendorsTab extends StatelessWidget {
  const _FindVendorsTab();

  @override
  Widget build(BuildContext context) {
    // Mock data for vendor categories
    final vendorCategories = [
      const _VendorCategoryModel(
        name: 'Venues',
        icon: Icons.location_on,
        color: Colors.blue,
      ),
      const _VendorCategoryModel(
        name: 'Photographers',
        icon: Icons.camera_alt,
        color: Colors.purple,
      ),
      const _VendorCategoryModel(
        name: 'Caterers',
        icon: Icons.restaurant,
        color: Colors.orange,
      ),
      const _VendorCategoryModel(
        name: 'Florists',
        icon: Icons.local_florist,
        color: Colors.pink,
      ),
      const _VendorCategoryModel(
        name: 'DJs & Bands',
        icon: Icons.music_note,
        color: Colors.green,
      ),
      const _VendorCategoryModel(
        name: 'Wedding Planners',
        icon: Icons.event,
        color: Colors.red,
      ),
      const _VendorCategoryModel(
        name: 'Bakeries',
        icon: Icons.cake,
        color: Colors.brown,
      ),
      const _VendorCategoryModel(
        name: 'Attire',
        icon: Icons.checkroom,
        color: Colors.teal,
      ),
    ];

    // Mock data for featured vendors
    final featuredVendors = [
      const _FeaturedVendorModel(
        name: 'Grand Plaza Hotel',
        category: 'Venue',
        rating: 4.8,
        reviewCount: 142,
        imageUrl:
            'https://images.pexels.com/photos/6287584/pexels-photo-6287584.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      ),
      const _FeaturedVendorModel(
        name: 'Elite Photography',
        category: 'Photographer',
        rating: 4.9,
        reviewCount: 89,
        imageUrl:
            'https://images.pexels.com/photos/6287584/pexels-photo-6287584.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      ),
      const _FeaturedVendorModel(
        name: 'Luxe Catering',
        category: 'Caterer',
        rating: 4.7,
        reviewCount: 56,
        imageUrl:
            'https://images.pexels.com/photos/6287584/pexels-photo-6287584.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search vendors...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Vendor categories
          const Text(
            'Categories',
            style: TextStyles.headline5,
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: vendorCategories.length,
            itemBuilder: (context, index) {
              final category = vendorCategories[index];
              return _CategoryCard(category: category);
            },
          ),
          const SizedBox(height: 24),

          // Featured vendors
          const Text(
            'Featured Vendors',
            style: TextStyles.headline5,
          ),
          const SizedBox(height: 16),
          ...featuredVendors.map((vendor) => _FeaturedVendorCard(
                vendor: vendor,
              )),

          const SizedBox(height: 80), // Extra space for FAB
        ],
      ),
    );
  }
}

class _VendorCard extends StatelessWidget {
  final _VendorModel vendor;

  const _VendorCard({required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vendor image
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage(vendor.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Vendor details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        vendor.name,
                        style: TextStyles.headline6,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: vendor.isBooked
                            ? AppColors.success.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        vendor.isBooked ? 'Booked' : 'Not Booked',
                        style: TextStyles.caption.copyWith(
                          color:
                              vendor.isBooked ? AppColors.success : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price: \$${vendor.price.toStringAsFixed(0)}',
                      style: TextStyles.body2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.phone,
                        color: AppColors.secondary,
                      ),
                      onPressed: () {
                        // Call vendor
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (vendor.notes != null && vendor.notes!.isNotEmpty)
                  Text(
                    vendor.notes!,
                    style: TextStyles.caption.copyWith(
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final _VendorCategoryModel category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to category vendors
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              category.icon,
              color: category.color,
              size: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.name,
            style: TextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _FeaturedVendorCard extends StatelessWidget {
  final _FeaturedVendorModel vendor;

  const _FeaturedVendorCard({required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: Image.network(
              vendor.imageUrl,
              width: 120,
              fit: BoxFit.fitHeight,
            ),
          ),

          // Vendor details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vendor.name,
                    style: TextStyles.headline6,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    vendor.category,
                    style: TextStyles.caption.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${vendor.rating} (${vendor.reviewCount} reviews)',
                        style: TextStyles.caption.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      // View vendor details
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                    child: const Text('View Details'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorModel {
  final String id;
  final String name;
  final String category;
  final String phone;
  final String email;
  final String website;
  final bool isBooked;
  final double price;
  final String? notes;
  final String imageUrl;

  const _VendorModel({
    required this.id,
    required this.name,
    required this.category,
    required this.phone,
    required this.email,
    required this.website,
    required this.isBooked,
    required this.price,
    this.notes,
    required this.imageUrl,
  });
}

class _VendorCategoryModel {
  final String name;
  final IconData icon;
  final Color color;

  const _VendorCategoryModel({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class _FeaturedVendorModel {
  final String name;
  final String category;
  final double rating;
  final int reviewCount;
  final String imageUrl;

  const _FeaturedVendorModel({
    required this.name,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
  });
}
