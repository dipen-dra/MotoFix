// lib/view/all_services_screen.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motofix_app/view/home_screen.dart'; // Ensure HomeScreen is imported for AppColors

// Comprehensive list of services for AllServicesScreen
final List<Map<String, dynamic>> _allAvailableServices = [
  {'title': 'Oil Servicing', 'price': 'Rs. 1000', 'icon': FontAwesomeIcons.oilCan, 'description': 'Complete engine oil and filter change for optimal performance.'},
  {'title': 'Tire Replacement', 'price': 'Rs. 2500', 'icon': FontAwesomeIcons.solidCircleDot, 'description': 'Professional tire replacement and balancing for safety.'},
  {'title': 'General Checkup', 'price': 'Rs. 1500', 'icon': FontAwesomeIcons.stethoscope, 'description': 'Thorough inspection of all vehicle systems for preventative maintenance.'},
  {'title': 'Battery Service', 'price': 'Rs. 3000', 'icon': FontAwesomeIcons.carBattery, 'description': 'Battery health check, terminal cleaning, and replacement if needed.'},
  {'title': 'Brake Inspection', 'price': 'Rs. 800', 'icon': FontAwesomeIcons.carBurst, 'description': 'Inspection and testing of brake pads, rotors, and fluid levels.'},
  {'title': 'Engine Repair', 'price': 'Rs. 5000', 'icon': FontAwesomeIcons.gear, 'description': 'Diagnosis and repair of complex engine issues by certified mechanics.'},
  {'title': 'Car Wash', 'price': 'Rs. 500', 'icon': FontAwesomeIcons.car, 'description': 'Full exterior wash, interior vacuum, and tire dressing.'},
  {'title': 'AC Service', 'price': 'Rs. 2000', 'icon': FontAwesomeIcons.fan, 'description': 'AC system check, refrigerant refill, and vent cleaning for fresh air.'},
  {'title': 'Suspension Repair', 'price': 'Rs. 4000', 'icon': FontAwesomeIcons.tools, 'description': 'Repair or replacement of worn suspension components for a smoother ride.'},
  {'title': 'Wheel Alignment', 'price': 'Rs. 1200', 'icon': FontAwesomeIcons.road, 'description': 'Precision wheel alignment for better handling and tire longevity.'},
  {'title': 'Dent & Paint Repair', 'price': 'Rs. 7000', 'icon': FontAwesomeIcons.paintRoller, 'description': 'Minor dent removal and paint touch-ups to restore aesthetics.'},
  {'title': 'Full Car Detailing', 'price': 'Rs. 3500', 'icon': FontAwesomeIcons.sprayCan, 'description': 'Deep cleaning and restoration of vehicle interior and exterior for a showroom finish.'},
  {'title': 'Clutch Replacement', 'price': 'Rs. 6000', 'icon': FontAwesomeIcons.cog, 'description': 'Replacement of worn clutch components for manual transmission vehicles.'},
  {'title': 'Transmission Fluid Change', 'price': 'Rs. 2200', 'icon': FontAwesomeIcons.gasPump, 'description': 'Replacement of old transmission fluid to ensure smooth gear shifts.'},
  {'title': 'Spark Plug Replacement', 'price': 'Rs. 900', 'icon': FontAwesomeIcons.bolt, 'description': 'Replacement of spark plugs for improved engine ignition and fuel efficiency.'},
];

class AllServicesScreen extends StatefulWidget {
  final Map<String, dynamic> service; // Keep the service parameter for compatibility
  const AllServicesScreen({super.key, required this.service});

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  bool _isGridView = true; // State to toggle between grid and list view

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double itemFontSize = screenWidth > 600 ? 16 : 14;
    final double iconSize = screenWidth > 600 ? 40 : 32;

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        title: const Text(
          'All Services',
          style: TextStyle(
            color: AppColors.textWhite,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textWhite),
        actions: [
          IconButton(
            icon: Icon(
              _isGridView ? Icons.list_rounded : Icons.grid_view_rounded,
              color: AppColors.textWhite,
            ),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView; // Toggle the view
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isGridView
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns in grid
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.85, // Adjust aspect ratio for card height
                ),
                itemCount: _allAvailableServices.length,
                itemBuilder: (context, index) {
                  return _buildServiceGridItem(
                    service: _allAvailableServices[index],
                    itemFontSize: itemFontSize,
                    iconSize: iconSize,
                  );
                },
              )
            : ListView.builder(
                itemCount: _allAvailableServices.length,
                itemBuilder: (context, index) {
                  return _buildServiceListItem(
                    service: _allAvailableServices[index],
                    itemFontSize: itemFontSize,
                    iconSize: iconSize,
                  );
                },
              ),
      ),
    );
  }

  // --- Widget for Grid View Item ---
  Widget _buildServiceGridItem({
    required Map<String, dynamic> service,
    required double itemFontSize,
    required double iconSize,
  }) {
    return GestureDetector(
      onTap: () {
        print('${service['title']} tapped from All Services (Grid View)');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailScreen(service: service),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Icon(service['icon'] as IconData?, size: iconSize, color: AppColors.accentBlue)),
              const SizedBox(height: 12),
              Text(
                service['title'] ?? '',
                style: TextStyle(
                  fontSize: itemFontSize + 2,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhite,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                service['price'] ?? '',
                style: const TextStyle(fontSize: 14, color: AppColors.accentGreen, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  service['description'] ?? '',
                  style: TextStyle(fontSize: itemFontSize - 2, color: AppColors.textWhite70),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget for List View Item ---
  Widget _buildServiceListItem({
    required Map<String, dynamic> service,
    required double itemFontSize,
    required double iconSize,
  }) {
    return GestureDetector(
      onTap: () {
        print('${service['title']} tapped from All Services (List View)');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailScreen(service: service),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0.5,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Icon(service['icon'] as IconData?, size: iconSize * 0.8, color: AppColors.accentBlue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['title'] ?? '',
                    style: TextStyle(
                      fontSize: itemFontSize + 2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service['description'] ?? '',
                    style: TextStyle(fontSize: itemFontSize - 2, color: AppColors.textWhite70),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service['price'] ?? '',
                    style: const TextStyle(fontSize: 14, color: AppColors.accentGreen, fontWeight: FontWeight.bold),
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

// Placeholder ServiceDetailScreen (to be customized as needed)
class ServiceDetailScreen extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        title: Text(
          service['title'] ?? 'Service Details',
          style: const TextStyle(
            color: AppColors.textWhite,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textWhite),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                service['icon'] as IconData?,
                size: 60,
                color: AppColors.accentBlue,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              service['title'] ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              service['description'] ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textWhite70,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Price: ${service['price'] ?? ''}',
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.accentGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                print('Book ${service['title']} tapped');
                // TODO: Implement booking flow
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentBlue,
                foregroundColor: AppColors.textWhite,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}