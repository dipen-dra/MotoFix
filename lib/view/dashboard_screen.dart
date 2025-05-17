// import 'package:flutter/material.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//       ),
//       body: const Center(
//         child: Text('Welcome to the Dashboard!'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import the Font Awesome package

// Dummy data for services
final List<Map<String, String>> _nearYouServices = [
  {'title': 'Oil Servicing', 'price': 'Rs. 1000', 'icon': 'oil'},
  {'title': 'Tire Replacement', 'price': 'Rs. 2500', 'icon': 'tire'},
  {'title': 'General Checkup', 'price': 'Rs. 1500', 'icon': 'checkup'},
  {'title': 'Battery Service', 'price': 'Rs. 3000', 'icon': 'battery'},
];

// Dummy data for recent activities
final List<Map<String, String>> _recentActivities = [
  {'title': 'Oil Servicing', 'date': '2024-07-28'},
  {'title': 'Tire Replacement', 'date': '2024-07-25'},
];

class MotoFixDashboard extends StatefulWidget {
  const MotoFixDashboard({super.key});

  @override
  State<MotoFixDashboard> createState() => _MotoFixDashboardState();
}

class _MotoFixDashboardState extends State<MotoFixDashboard> {
  String _location = 'Set your location'; // Default location text
  final FocusNode _searchFocusNode = FocusNode(); // FocusNode for search field

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose(); // Dispose the FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Unfocus the search field when tapping outside of it
        _searchFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF2A4759), // Background color
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildAppBar(), // Custom App Bar
                const SizedBox(height: 20),
                _buildLocationWidget(), //location widget
                const SizedBox(height: 20),
                _buildSearchBar(context), // Search Bar
                const SizedBox(height: 20),
                _buildServiceCards(context), // "Get Services from Home" Cards
                const SizedBox(height: 20),
                _buildNearYouSection(context), // "Near You" Section
                const SizedBox(height: 20),
                _buildRecentActivities(context), // Recent Activities
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context), // Bottom Navigation
      ),
    );
  }

  // Custom App Bar
  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // Handle menu button press
          },
        ),
        const Text(
          'Home',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
            // Handle notifications button press
          },
        ),
      ],
    );
  }// Search Bar
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 40, // Reduced height
      child: TextField(
        focusNode: _searchFocusNode, // Attach the FocusNode
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search service, location',
          hintStyle: TextStyle(color: Colors.white70),
          prefixIcon: const Icon(Icons.search, color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Rounded edges
            borderSide: BorderSide.none, // Remove the border
          ),
          filled: true,
          fillColor: Colors.white12, // Use a semi-transparent white
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10), // Adjust padding
        ),
      ),
    );
  }

  // Location Display Widget
  Widget _buildLocationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_on, color: Colors.white70),
        const SizedBox(width: 8),
        Text(
          _location, // Use the _location variable here
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }

  // "Get Services from Home" Cards
  Widget _buildServiceCards(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildServiceCard(context, title: 'Get Services from\nhome', icon: Icons.home_repair_service),
        const SizedBox(width: 10),
        _buildServiceCard(context, title: 'Get Services from\nhome', icon: Icons.home_repair_service),
      ],
    );
  }

  // Individual Service Card
  Widget _buildServiceCard(BuildContext context, {required String title, required IconData icon}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF395668), // Darker container color
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

  // "Near You" Section
  Widget _buildNearYouSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Near You',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextButton(
              onPressed: () {
                // Handle "See all" button press
              },
              child: const Text(
                'See all',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150, // Fixed height for the horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _nearYouServices.length,
            itemBuilder: (context, index) {
              final service = _nearYouServices[index];
              return _buildServiceListItem(context, service: service);
            },
          ),
        ),
      ],
    );
  }

  //build service list item
  Widget _buildServiceListItem(BuildContext context, {required Map<String, String> service}) {
    IconData? serviceIcon;
    switch (service['icon']) {
      case 'oil':
        serviceIcon = FontAwesomeIcons.oilCan;
        break;
      case 'tire':
        serviceIcon = FontAwesomeIcons.solidTired;
        break;
      case 'checkup':
        serviceIcon = FontAwesomeIcons.stethoscope;
        break;
      case 'battery':
        serviceIcon = FontAwesomeIcons.batteryFull;
        break;
      default:
        serviceIcon = Icons.settings;
    }

    return Container(
      width: 130, // Fixed width for each item
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF395668),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(serviceIcon, size: 30, color: Colors.white70),
          const SizedBox(height: 8),
          Text(
            service['title'] ?? '',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            service['price'] ?? '',
            style: const TextStyle(fontSize: 12, color: Colors.greenAccent),
          ),
        ],
      ),
    );
  }

  // Recent Activities
  Widget _buildRecentActivities(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Recent Activities',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        // Use a ListView.builder to create the activity items
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling, as it's within a Column
          shrinkWrap: true, // Important for lists within columns
          itemCount: _recentActivities.length,
          itemBuilder: (context, index) {
            final activity = _recentActivities[index];
            return _buildActivityListItem(context, activity: activity); // Build each activity item
          },
        ),
      ],
    );
  }

  // Activity Item
  Widget _buildActivityListItem(BuildContext context, {required Map<String, String> activity}) {
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
        Text(
          activity['title'] ?? '',
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
        Text(
          activity['date'] ?? '',
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    ),
  );
}

  // Bottom Navigation Bar
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF2A4759), // Match the overall background
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed, // Ensure labels are always visible
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          label: 'Activities',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // Handle bottom navigation item taps
        if (index == 0) {
          // Navigate to home
        } else if (index == 1) {
          // Navigate to activities
        } else if (index == 2) {
          // Navigate to profile
        }
      },
    );
  }
}




