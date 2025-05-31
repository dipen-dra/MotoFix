// lib/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motofix_app/view/all_service_screen.dart';

// --- Global Theme & Data (could be in separate files) ---

// Define a color scheme for consistency
class AppColors {
  // Retained the original background color as requested
  static const Color primaryDark = Color(0xFF395668); // Original background
  static const Color cardBackground = Color(0xFF2C3E50); // Slightly lighter for cards
  static const Color accentBlue = Colors.white; // For highlights/buttons
  static const Color accentGreen = Color(0xFF4CAF50); // For prices/success
  static const Color textWhite = Colors.white;
  static const Color textWhite70 = Colors.white70;
}

// Data for services (can be moved to a separate data file if it grows)
final List<Map<String, dynamic>> _nearYouServices = [
  {'title': 'Oil Servicing', 'price': 'Rs. 1000', 'icon': FontAwesomeIcons.oilCan},
  {'title': 'Tire Replacement', 'price': 'Rs. 2500', 'icon': FontAwesomeIcons.solidCircleDot},
  {'title': 'General Checkup', 'price': 'Rs. 1500', 'icon': FontAwesomeIcons.stethoscope},
  {'title': 'Battery Service', 'price': 'Rs. 3000', 'icon': FontAwesomeIcons.carBattery},
  {'title': 'Brake Inspection', 'price': 'Rs. 800', 'icon': FontAwesomeIcons.carBurst},
];

final List<Map<String, dynamic>> _recentActivities = [
  {'title': 'Oil Servicing', 'date': '2024-07-28', 'icon': FontAwesomeIcons.oilCan, 'status': 'Completed'},
  {'title': 'Tire Replacement', 'date': '2024-07-25', 'icon': FontAwesomeIcons.solidCircleDot, 'status': 'Completed'},
  {'title': 'General Checkup', 'date': '2024-07-20', 'icon': FontAwesomeIcons.stethoscope, 'status': 'Pending Payment'},
  {'title': 'Brake Inspection', 'date': '2024-07-18', 'icon': FontAwesomeIcons.carBurst, 'status': 'Canceled'},
];

// --- HomeScreen Widget ---

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _location = 'Kathmandu, Nepal'; // Default location
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = []; // State to hold search results

  // Dummy vehicle data
  String _currentVehicle = 'Honda Civic (AB 123 CD)';
  String _nextServiceDate = '2025-08-15';
  double _serviceProgress = 0.75; // 75% complete towards next service

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String query = _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }
    // Simulate search results from a larger dummy list
    List<String> dummySuggestions = [
      'Oil Servicing', 'Tire Replacement', 'Battery Service', 'Brake Inspection',
      'General Checkup', 'Engine Repair', 'Car Wash', 'AC Service', 'Wheel Alignment'
    ];
    setState(() {
      _searchResults = dummySuggestions
          .where((service) => service.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizes for fonts and icons
    final double titleFontSize = screenWidth > 600 ? 20 : 16;
    final double subtitleFontSize = screenWidth > 600 ? 16 : 13;
    final double iconSize = screenWidth > 600 ? 38 : 32;

    return GestureDetector(
      onTap: () => _searchFocusNode.unfocus(), // Dismiss keyboard on tap outside
      child: Scaffold(
        backgroundColor: AppColors.primaryDark, // Using the original background color
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildEnhancedAppBar(), // Enhanced App Bar
                  SizedBox(height: screenHeight * 0.03),
                  _buildInteractiveLocationWidget(), // Interactive Location Widget
                  SizedBox(height: screenHeight * 0.03),
                  _buildSearchBar(screenWidth), // Smart Search Bar
                  SizedBox(height: screenHeight * 0.04),
                  _buildServiceCards(), // Main Service Cards
                  SizedBox(height: screenHeight * 0.04),
                  _buildMyVehicleSection(), // My Vehicle Section
                  SizedBox(height: screenHeight * 0.04),
                  _buildNearYouSection(screenHeight, titleFontSize, subtitleFontSize, iconSize), // Near You Section
                  SizedBox(height: screenHeight * 0.04),
                  _buildRecentActivities(titleFontSize, subtitleFontSize), // Recent Activities
                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // User Profile/Greeting
        GestureDetector(
          onTap: () {
            print('User profile tapped');
            // TODO: Navigate to UserProfileScreen
          },
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://cdn.britannica.com/35/238335-050-2CB2EB8A/Lionel-Messi-Argentina-Netherlands-World-Cup-Qatar-2022.jpg'), // Placeholder image
                backgroundColor: AppColors.accentBlue,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hello, Dipendra', // Placeholder name
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                  ),
                  Text(
                    'Welcome back',
                    style: TextStyle(fontSize: 14, color: AppColors.textWhite70),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Notifications
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textWhite, size: 28),
          onPressed: () {
            print('Notifications button pressed');
            // TODO: Navigate to NotificationsScreen
          },
        ),
      ],
    );
  }

  Widget _buildInteractiveLocationWidget() {
    return Center(
      child: InkWell( // Use InkWell for splash feedback
        onTap: () async {
          print('Location widget tapped: Current $_location');
          // Simulate fetching new locations or showing a picker
          final newLocation = await _showLocationPicker(context);
          if (newLocation != null) {
            setState(() {
              _location = newLocation;
            });
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.cardBackground.withOpacity(0.4), // Slightly more transparent
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.textWhite70.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // To wrap content tightly
            children: [
              const Icon(Icons.location_on_rounded, color: AppColors.accentBlue, size: 22),
              const SizedBox(width: 10),
              Text(
                _location,
                style: const TextStyle(fontSize: 16, color: AppColors.textWhite, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_drop_down_rounded, color: AppColors.textWhite70, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _showLocationPicker(BuildContext context) async {
    return await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.primaryDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select a location', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textWhite)),
              const SizedBox(height: 20),
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: const Text('Kathmandu, Nepal', style: TextStyle(color: AppColors.textWhite)),
                    trailing: const Icon(Icons.check, color: AppColors.accentGreen),
                    onTap: () => Navigator.pop(context, 'Kathmandu, Nepal'),
                  ),
                  ListTile(
                    title: const Text('Lalitpur, Nepal', style: TextStyle(color: AppColors.textWhite)),
                    onTap: () => Navigator.pop(context, 'Lalitpur, Nepal'),
                  ),
                  ListTile(
                    title: const Text('Bhaktapur, Nepal', style: TextStyle(color: AppColors.textWhite)),
                    onTap: () => Navigator.pop(context, 'Bhaktapur, Nepal'),
                  ),
                  // Add more locations
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(double screenWidth) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20), // Circular radius
            border: Border.all(color: AppColors.textWhite70, width: 1), // White border
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            style: const TextStyle(color: AppColors.textWhite, fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Search for services or garages...',
              hintStyle: const TextStyle(color: AppColors.textWhite70),
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textWhite70, size: 24),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: AppColors.textWhite70),
                      onPressed: () {
                        _searchController.clear();
                        _onSearchChanged(); // Clear results
                      },
                    )
                  : null,
              border: InputBorder.none,
              enabledBorder: InputBorder.none, // Explicitly remove enabled border
              focusedBorder: InputBorder.none, // Explicitly remove focused border
              errorBorder: InputBorder.none, // Explicitly remove error border
              contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 12),
            ),
            onTap: () => print('Search bar tapped'),
            onSubmitted: (value) => print('Search submitted: $value'),
          ),
        ),
        if (_searchResults.isNotEmpty) // Display suggestions conditionally
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20), // Slightly smaller radius for hierarchy
              border: Border.all(color: AppColors.textWhite70, width: 1), // Matching white border
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.5,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _searchResults.map((result) => ListTile(
                title: Text(result, style: const TextStyle(color: AppColors.textWhite)),
                onTap: () {
                  _searchController.text = result;
                  _searchFocusNode.unfocus();
                  setState(() {
                    _searchResults = []; // Clear suggestions after selection
                  });
                  print('Selected search suggestion: $result');
                },
              )).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildServiceCards() {
    return Row(
      children: <Widget>[
        _buildServiceCard(
          title: 'Home Service',
          description: 'Get repairs at your doorstep',
          icon: Icons.home_repair_service_rounded,
          onTap: () => print('Home Service card tapped'),
        ),
        const SizedBox(width: 15), // Increased spacing
        _buildServiceCard(
          title: 'Book Garage',
          description: 'Find a garage near you',
          icon: Icons.garage_rounded,
          onTap: () => print('Book a Garage card tapped'),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, size: 45, color: AppColors.accentBlue),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textWhite70,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyVehicleSection() {
    return GestureDetector(
      onTap: () {
        print('My Vehicle section tapped');
        // TODO: Navigate to VehicleManagementScreen
      },
      child: Container(
        padding: const EdgeInsets.all(20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Vehicle',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textWhite),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_rounded, color: AppColors.textWhite70),
                  onPressed: () {
                    print('Edit vehicle tapped');
                    // TODO: Option to switch/add vehicle
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _currentVehicle,
              style: const TextStyle(fontSize: 16, color: AppColors.textWhite70),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Next Service Due:',
                      style: TextStyle(fontSize: 14, color: AppColors.textWhite70),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _nextServiceDate,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.accentGreen),
                    ),
                  ],
                ),
                SizedBox(
                  width: 80, // Adjust width as needed
                  child: LinearProgressIndicator(
                    value: _serviceProgress, // Simulate progress
                    backgroundColor: AppColors.textWhite70.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentBlue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearYouSection(
    double screenHeight,
    double titleFontSize,
    double subtitleFontSize,
    double iconSize,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Services Near You',
              style: TextStyle(
                fontSize: titleFontSize + 4,
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite,
              ),
            ),
            TextButton(
              onPressed: () {
                print('See all services tapped');
                // Navigate to AllServicesScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AllServicesScreen(service: {})),
                );
              },
              child: const Text(
                'See all',
                style: TextStyle(color: AppColors.accentBlue, fontSize: 15),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
        SizedBox(
          height: screenHeight * 0.23, // Adjusted height for better fit
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _nearYouServices.length,
            itemBuilder: (context, index) => _buildServiceListItem(
              service: _nearYouServices[index],
              titleFontSize: subtitleFontSize,
              iconSize: iconSize,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceListItem({
    required Map<String, dynamic> service,
    required double titleFontSize,
    required double iconSize,
  }) {
    return GestureDetector(
      onTap: () {
        print('${service['title']} service tapped');
        // TODO: Navigate to service details screen
      },
      child: Container(
        width: 160, // Adjusted width for more content space
        margin: const EdgeInsets.only(right: 15), // Increased margin
        padding: const EdgeInsets.all(18),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(service['icon'] as IconData?, size: iconSize, color: AppColors.accentBlue),
            const SizedBox(height: 12),
            Text(
              service['title'] ?? '',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w500,
                color: AppColors.textWhite,
              ),
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
    );
  }

  Widget _buildRecentActivities(double titleFontSize, double subtitleFontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Your Recent Activities',
          style: TextStyle(
            fontSize: titleFontSize + 4,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
          ),
        ),
        const SizedBox(height: 15),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(), // Important for nested scroll views
          shrinkWrap: true,
          itemCount: _recentActivities.length,
          itemBuilder: (context, index) => _buildActivityListItem(
            activity: _recentActivities[index],
            subtitleFontSize: subtitleFontSize,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityListItem({required Map<String, dynamic> activity, required double subtitleFontSize}) {
    Color statusColor;
    switch (activity['status']) {
      case 'Completed':
        statusColor = AppColors.accentGreen;
        break;
      case 'Pending Payment':
        statusColor = Colors.orange;
        break;
      case 'Canceled':
        statusColor = Colors.redAccent;
        break;
      default:
        statusColor = AppColors.textWhite70;
    }

    return GestureDetector(
      onTap: () {
        print('${activity['title']} activity tapped (Status: ${activity['status']})');
        // TODO: Navigate to activity details screen
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(10),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  Icon(activity['icon'] as IconData?, color: AppColors.accentBlue, size: 22),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      activity['title'] ?? '',
                      style: TextStyle(fontSize: subtitleFontSize + 1, color: AppColors.textWhite, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  activity['date'] ?? '',
                  style: TextStyle(fontSize: subtitleFontSize - 1, color: AppColors.textWhite70),
                ),
                const SizedBox(height: 4),
                Text(
                  activity['status'] ?? '',
                  style: TextStyle(fontSize: subtitleFontSize - 1, color: statusColor, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}