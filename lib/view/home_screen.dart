// lib/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Data for services (can be moved to a separate data file if it grows)
final List<Map<String, String>> _nearYouServices = [
  {'title': 'Oil Servicing', 'price': 'Rs. 1000', 'icon': 'oil'},
  {'title': 'Tire Replacement', 'price': 'Rs. 2500', 'icon': 'tire'},
  {'title': 'General Checkup', 'price': 'Rs. 1500', 'icon': 'checkup'},
  {'title': 'Battery Service', 'price': 'Rs. 3000', 'icon': 'battery'},
];

final List<Map<String, String>> _recentActivities = [
  {'title': 'Oil Servicing', 'date': '2024-07-28'},
  {'title': 'Tire Replacement', 'date': '2024-07-25'},
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _location = 'Set your location';
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizes for fonts and icons
    final double titleFontSize = screenWidth > 600 ? 18 : 14;
    final double iconSize = screenWidth > 600 ? 36 : 30;

    return GestureDetector(
      onTap: () => _searchFocusNode.unfocus(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildAppBar(),
                SizedBox(height: screenHeight * 0.02),
                _buildLocationWidget(),
                SizedBox(height: screenHeight * 0.02),
                _buildSearchBar(screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildServiceCards(),
                SizedBox(height: screenHeight * 0.02),
                _buildNearYouSection(screenHeight, titleFontSize, iconSize),
                SizedBox(height: screenHeight * 0.02),
                _buildRecentActivities(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // TODO: Implement drawer or side menu
          },
        ),
        const Text(
          'Home',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
            // TODO: Implement notifications
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar(double screenWidth) {
    return SizedBox(
      height: 40,
      child: TextField(
        focusNode: _searchFocusNode,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search service, location',
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: const Icon(Icons.search, color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white12,
          contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        ),
      ),
    );
  }

  Widget _buildLocationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_on, color: Colors.white70),
        const SizedBox(width: 8),
        Text(_location, style: const TextStyle(fontSize: 16, color: Colors.white70)),
      ],
    );
  }

  Widget _buildServiceCards() {
    return Row(
      children: <Widget>[
        _buildServiceCard(title: 'Get Services from\nhome', icon: Icons.home_repair_service),
        const SizedBox(width: 10),
        _buildServiceCard(title: 'Get Services from\nhome', icon: Icons.home_repair_service),
      ],
    );
  }

  Widget _buildServiceCard({required String title, required IconData icon}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF395668),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearYouSection(double screenHeight, double titleFontSize, double iconSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Near You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            TextButton(
              onPressed: () {
                // TODO: Navigate to a "See All" services screen
              },
              child: const Text('See all', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.01),
        SizedBox(
          height: screenHeight * 0.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _nearYouServices.length,
            itemBuilder: (context, index) => _buildServiceListItem(
              service: _nearYouServices[index],
              titleFontSize: titleFontSize,
              iconSize: iconSize,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceListItem({
    required Map<String, String> service,
    required double titleFontSize,
    required double iconSize,
  }) {
    IconData? serviceIcon;
    switch (service['icon']) {
      case 'oil':
        serviceIcon = FontAwesomeIcons.oilCan;
        break;
      case 'tire':
        serviceIcon = FontAwesomeIcons.solidCircleDot;
        break;
      case 'checkup':
        serviceIcon = FontAwesomeIcons.stethoscope;
        break;
      case 'battery':
        serviceIcon = FontAwesomeIcons.carBattery;
        break;
      default:
        serviceIcon = Icons.settings;
    }

    return Container(
      width: 130, // reduced width to avoid overflow
      margin: const EdgeInsets.only(right: 8), // reduced margin to avoid overflow
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF395668),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(serviceIcon, size: iconSize, color: Colors.white70),
          const SizedBox(height: 10),
          Flexible(
            child: Text(
              service['title'] ?? '',
              style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w500, color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            service['price'] ?? '',
            style: const TextStyle(fontSize: 13, color: Colors.greenAccent),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Recent Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 10),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _recentActivities.length,
          itemBuilder: (context, index) => _buildActivityListItem(activity: _recentActivities[index]),
        ),
      ],
    );
  }

  Widget _buildActivityListItem({required Map<String, String> activity}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF395668),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(activity['title'] ?? '', style: const TextStyle(fontSize: 14, color: Colors.white)),
          Text(activity['date'] ?? '', style: const TextStyle(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }
}