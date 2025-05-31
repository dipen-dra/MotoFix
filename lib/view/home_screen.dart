// // lib/view/home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// // Data for services (can be moved to a separate data file if it grows)
// final List<Map<String, String>> _nearYouServices = [
//   {'title': 'Oil Servicing', 'price': 'Rs. 1000', 'icon': 'oil'},
//   {'title': 'Tire Replacement', 'price': 'Rs. 2500', 'icon': 'tire'},
//   {'title': 'General Checkup', 'price': 'Rs. 1500', 'icon': 'checkup'},
//   {'title': 'Battery Service', 'price': 'Rs. 3000', 'icon': 'battery'},
// ];

// final List<Map<String, String>> _recentActivities = [
//   {'title': 'Oil Servicing', 'date': '2024-07-28'},
//   {'title': 'Tire Replacement', 'date': '2024-07-25'},
// ];

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String _location = 'Set your location';
//   final FocusNode _searchFocusNode = FocusNode();

//   @override
//   void dispose() {
//     _searchFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     // Responsive sizes for fonts and icons
//     final double titleFontSize = screenWidth > 600 ? 18 : 14;
//     final double iconSize = screenWidth > 600 ? 36 : 30;

//     return GestureDetector(
//       onTap: () => _searchFocusNode.unfocus(),
//       child: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(screenWidth * 0.04),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 _buildAppBar(),
//                 SizedBox(height: screenHeight * 0.02),
//                 _buildLocationWidget(),
//                 SizedBox(height: screenHeight * 0.02),
//                 _buildSearchBar(screenWidth),
//                 SizedBox(height: screenHeight * 0.02),
//                 _buildServiceCards(),
//                 SizedBox(height: screenHeight * 0.02),
//                 _buildNearYouSection(screenHeight, titleFontSize, iconSize),
//                 SizedBox(height: screenHeight * 0.02),
//                 _buildRecentActivities(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAppBar() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.menu, color: Colors.white),
//           onPressed: () {
//             // TODO: Implement drawer or side menu
//           },
//         ),
//         const Text(
//           'Home',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         IconButton(
//           icon: const Icon(Icons.notifications_none, color: Colors.white),
//           onPressed: () {
//             // TODO: Implement notifications
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildSearchBar(double screenWidth) {
//     return SizedBox(
//       height: 40,
//       child: TextField(
//         focusNode: _searchFocusNode,
//         style: const TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           hintText: 'Search service, location',
//           hintStyle: const TextStyle(color: Colors.white70),
//           prefixIcon: const Icon(Icons.search, color: Colors.white70),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: Colors.white12,
//           contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
//         ),
//       ),
//     );
//   }

//   Widget _buildLocationWidget() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Icon(Icons.location_on, color: Colors.white70),
//         const SizedBox(width: 8),
//         Text(_location, style: const TextStyle(fontSize: 16, color: Colors.white70)),
//       ],
//     );
//   }

//   Widget _buildServiceCards() {
//     return Row(
//       children: <Widget>[
//         _buildServiceCard(title: 'Get Services from\nhome', icon: Icons.home_repair_service),
//         const SizedBox(width: 10),
//         _buildServiceCard(title: 'Get Services from\nhome', icon: Icons.home_repair_service),
//       ],
//     );
//   }

//   Widget _buildServiceCard({required String title, required IconData icon}) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF395668),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Icon(icon, size: 40, color: Colors.white),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNearYouSection(double screenHeight, double titleFontSize, double iconSize) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             const Text('Near You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
//             TextButton(
//               onPressed: () {
//               },
//               child: const Text('See all', style: TextStyle(color: Colors.blue)),
//             ),
//           ],
//         ),
//         SizedBox(height: screenHeight * 0.01),
//         SizedBox(
//           height: screenHeight * 0.22,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: _nearYouServices.length,
//             itemBuilder: (context, index) => _buildServiceListItem(
//               service: _nearYouServices[index],
//               titleFontSize: titleFontSize,
//               iconSize: iconSize,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildServiceListItem({
//     required Map<String, String> service,
//     required double titleFontSize,
//     required double iconSize,
//   }) {
//     IconData? serviceIcon;
//     switch (service['icon']) {
//       case 'oil':
//         serviceIcon = FontAwesomeIcons.oilCan;
//         break;
//       case 'tire':
//         serviceIcon = FontAwesomeIcons.solidCircleDot;
//         break;
//       case 'checkup':
//         serviceIcon = FontAwesomeIcons.stethoscope;
//         break;
//       case 'battery':
//         serviceIcon = FontAwesomeIcons.carBattery;
//         break;
//       default:
//         serviceIcon = Icons.settings;
//     }

//     return Container(
//       width: 130, // reduced width to avoid overflow
//       margin: const EdgeInsets.only(right: 8), // reduced margin to avoid overflow
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: const Color(0xFF395668),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Icon(serviceIcon, size: iconSize, color: Colors.white70),
//           const SizedBox(height: 10),
//           Flexible(
//             child: Text(
//               service['title'] ?? '',
//               style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w500, color: Colors.white),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             service['price'] ?? '',
//             style: const TextStyle(fontSize: 13, color: Colors.greenAccent),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRecentActivities() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         const Text('Recent Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
//         const SizedBox(height: 10),
//         ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: _recentActivities.length,
//           itemBuilder: (context, index) => _buildActivityListItem(activity: _recentActivities[index]),
//         ),
//       ],
//     );
//   }

//   Widget _buildActivityListItem({required Map<String, String> activity}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: const Color(0xFF395668),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Text(activity['title'] ?? '', style: const TextStyle(fontSize: 14, color: Colors.white)),
//           Text(activity['date'] ?? '', style: const TextStyle(fontSize: 12, color: Colors.white70)),
//         ],
//       ),
//     );
//   }
// }



// /// lib/view/home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// // --- Global Theme & Data (could be in separate files) ---

// // Define a color scheme for consistency
// class AppColors {
//   // Retained the original background color as requested
//   static const Color primaryDark = Color(0xFF395668); // Original background
//   static const Color cardBackground = Color(0xFF2C3E50); // Slightly lighter for cards
//   static const Color accentBlue = Color(0xFF5B8BFB); // For highlights/buttons
//   static const Color accentGreen = Color(0xFF4CAF50); // For prices/success
//   static const Color textWhite = Colors.white;
//   static const Color textWhite70 = Colors.white70;
// }

// // Data for services (can be moved to a separate data file if it grows)
// final List<Map<String, dynamic>> _nearYouServices = [
//   {'title': 'Oil Servicing', 'price': 'Rs. 1000', 'icon': FontAwesomeIcons.oilCan},
//   {'title': 'Tire Replacement', 'price': 'Rs. 2500', 'icon': FontAwesomeIcons.solidCircleDot},
//   {'title': 'General Checkup', 'price': 'Rs. 1500', 'icon': FontAwesomeIcons.stethoscope},
//   {'title': 'Battery Service', 'price': 'Rs. 3000', 'icon': FontAwesomeIcons.carBattery},
//   {'title': 'Brake Inspection', 'price': 'Rs. 800', 'icon': FontAwesomeIcons.carBurst},
// ];

// final List<Map<String, dynamic>> _recentActivities = [
//   {'title': 'Oil Servicing', 'date': '2024-07-28', 'icon': FontAwesomeIcons.oilCan},
//   {'title': 'Tire Replacement', 'date': '2024-07-25', 'icon': FontAwesomeIcons.solidCircleDot},
//   {'title': 'General Checkup', 'date': '2024-07-20', 'icon': FontAwesomeIcons.stethoscope},
// ];

// // --- HomeScreen Widget ---

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String _location = 'Kathmandu, Nepal'; // Default location
//   final FocusNode _searchFocusNode = FocusNode();

//   @override
//   void dispose() {
//     _searchFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     // Responsive sizes for fonts and icons
//     final double titleFontSize = screenWidth > 600 ? 20 : 16;
//     final double subtitleFontSize = screenWidth > 600 ? 16 : 13;
//     final double iconSize = screenWidth > 600 ? 38 : 32;

//     return GestureDetector(
//       onTap: () => _searchFocusNode.unfocus(), // Dismiss keyboard on tap outside
//       child: Scaffold(
//         backgroundColor: AppColors.primaryDark, // Using the original background color
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   _buildAppBar(),
//                   SizedBox(height: screenHeight * 0.03),
//                   _buildLocationWidget(),
//                   SizedBox(height: screenHeight * 0.03),
//                   _buildSearchBar(screenWidth),
//                   SizedBox(height: screenHeight * 0.04), // Increased space
//                   _buildServiceCards(),
//                   SizedBox(height: screenHeight * 0.04), // Increased space
//                   _buildNearYouSection(screenHeight, titleFontSize, subtitleFontSize, iconSize),
//                   SizedBox(height: screenHeight * 0.04), // Increased space
//                   _buildRecentActivities(titleFontSize, subtitleFontSize),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAppBar() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.menu_rounded, color: AppColors.textWhite, size: 28),
//           onPressed: () {
//             // TODO: Implement drawer or side menu
//             print('Menu button pressed');
//           },
//         ),
//         const Text(
//           'Home',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textWhite,
//           ),
//         ),
//         IconButton(
//           icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textWhite, size: 28),
//           onPressed: () {
//             // TODO: Implement notifications
//             print('Notifications button pressed');
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildLocationWidget() {
//     return Center(
//       child: GestureDetector(
//         onTap: () {
//           // TODO: Implement location selection
//           setState(() {
//             _location = 'New Location, Updated!'; // Simulate location update
//           });
//           print('Location widget tapped: $_location');
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           decoration: BoxDecoration(
//             color: AppColors.cardBackground.withOpacity(0.5),
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: AppColors.textWhite70.withOpacity(0.3)),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min, // To wrap content tightly
//             children: [
//               const Icon(Icons.location_on_rounded, color: AppColors.accentBlue, size: 20),
//               const SizedBox(width: 8),
//               Text(
//                 _location,
//                 style: const TextStyle(fontSize: 15, color: AppColors.textWhite),
//               ),
//               const SizedBox(width: 4),
//               const Icon(Icons.arrow_drop_down_rounded, color: AppColors.textWhite70, size: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar(double screenWidth) {
//     return Container(
//       height: 50, // Slightly increased height for better tap target
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: TextField(
//         focusNode: _searchFocusNode,
//         style: const TextStyle(color: AppColors.textWhite, fontSize: 16),
//         decoration: InputDecoration(
//           hintText: 'Search for services or garages...',
//           hintStyle: const TextStyle(color: AppColors.textWhite70),
//           prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textWhite70, size: 24),
//           border: InputBorder.none, // Remove default TextField border
//           contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 12),
//         ),
//         onTap: () => print('Search bar tapped'),
//         onSubmitted: (value) => print('Search submitted: $value'),
//       ),
//     );
//   }

//   Widget _buildServiceCards() {
//     return Row(
//       children: <Widget>[
//         _buildServiceCard(
//           title: 'Home Service',
//           description: 'Get repairs at your doorstep',
//           icon: Icons.home_repair_service_rounded,
//           onTap: () => print('Home Service card tapped'),
//         ),
//         const SizedBox(width: 15), // Increased spacing
//         _buildServiceCard(
//           title: 'Book a Garage',
//           description: 'Find a garage near you',
//           icon: Icons.garage_rounded,
//           onTap: () => print('Book a Garage card tapped'),
//         ),
//       ],
//     );
//   }

//   Widget _buildServiceCard({
//     required String title,
//     required String description,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: AppColors.cardBackground,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Icon(icon, size: 45, color: AppColors.accentBlue),
//               const SizedBox(height: 12),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textWhite,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 description,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: AppColors.textWhite70,
//                 ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNearYouSection(
//     double screenHeight,
//     double titleFontSize,
//     double subtitleFontSize,
//     double iconSize,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Text(
//               'Popular Services Near You',
//               style: TextStyle(
//                 fontSize: titleFontSize + 4,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textWhite,
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 print('See all services tapped');
//                 // TODO: Navigate to services list screen
//               },
//               child: const Text(
//                 'See all',
//                 style: TextStyle(color: AppColors.accentBlue, fontSize: 15),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: screenHeight * 0.02),
//         SizedBox(
//           height: screenHeight * 0.23, // Adjusted height for better fit
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: _nearYouServices.length,
//             itemBuilder: (context, index) => _buildServiceListItem(
//               service: _nearYouServices[index],
//               titleFontSize: subtitleFontSize,
//               iconSize: iconSize,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildServiceListItem({
//     required Map<String, dynamic> service,
//     required double titleFontSize,
//     required double iconSize,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         print('${service['title']} service tapped');
//         // TODO: Navigate to service details screen
//       },
//       child: Container(
//         width: 160, // Adjusted width for more content space
//         margin: const EdgeInsets.only(right: 15), // Increased margin
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Icon(service['icon'] as IconData?, size: iconSize, color: AppColors.accentBlue),
//             const SizedBox(height: 12),
//             Text(
//               service['title'] ?? '',
//               style: TextStyle(
//                 fontSize: titleFontSize,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.textWhite,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               service['price'] ?? '',
//               style: const TextStyle(fontSize: 14, color: AppColors.accentGreen, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRecentActivities(double titleFontSize, double subtitleFontSize) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Your Recent Activities',
//           style: TextStyle(
//             fontSize: titleFontSize + 4,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textWhite,
//           ),
//         ),
//         SizedBox(height: 15),
//         ListView.builder(
//           physics: const NeverScrollableScrollPhysics(), // Important for nested scroll views
//           shrinkWrap: true,
//           itemCount: _recentActivities.length,
//           itemBuilder: (context, index) => _buildActivityListItem(
//             activity: _recentActivities[index],
//             subtitleFontSize: subtitleFontSize,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildActivityListItem({required Map<String, dynamic> activity, required double subtitleFontSize}) {
//     return GestureDetector(
//       onTap: () {
//         print('${activity['title']} activity tapped');
//         // TODO: Navigate to activity details
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               spreadRadius: 0.5,
//               blurRadius: 3,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Row(
//               children: [
//                 Icon(activity['icon'] as IconData?, color: AppColors.accentBlue, size: 22),
//                 const SizedBox(width: 12),
//                 Text(
//                   activity['title'] ?? '',
//                   style: TextStyle(fontSize: subtitleFontSize + 1, color: AppColors.textWhite, fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//             Text(
//               activity['date'] ?? '',
//               style: TextStyle(fontSize: subtitleFontSize - 1, color: AppColors.textWhite70),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


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
  static const Color accentBlue = Color(0xFF5B8BFB); // For highlights/buttons
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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String _location = 'Kathmandu, Nepal'; // Default location
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = []; // State to hold search results

  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;

  // Dummy vehicle data
  String _currentVehicle = 'Honda Civic (AB 123 CD)';
  String _nextServiceDate = '2025-08-15';
  double _serviceProgress = 0.75; // 75% complete towards next service


  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fabAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_fabAnimationController);
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    _fabAnimationController.dispose();
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

  void _toggleFab() {
    if (_fabAnimationController.isDismissed) {
      _fabAnimationController.forward();
    } else {
      _fabAnimationController.reverse();
    }
  }

  // Placeholder for emergency call using url_launcher
  // You'd need to add url_launcher to your pubspec.yaml
  /*
  void _launchEmergencyCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print('Could not launch $launchUri');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not initiate call.'), backgroundColor: Colors.red),
      );
    }
  }
  */

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
                  SizedBox(height: screenHeight * 0.04), // Increased space
                  _buildPromotionalCarousel(screenHeight), // Promotional Carousel
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
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ScaleTransition(
              scale: _fabAnimation,
              child: FloatingActionButton(
                heroTag: 'fab_emergency',
                onPressed: () {
                  print('Emergency tapped');
                  // TODO: Trigger emergency flow (e.g., _launchEmergencyCall('9876543210'); )
                },
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.sos_rounded, color: AppColors.textWhite),
              ),
            ),
            const SizedBox(height: 10),
            ScaleTransition(
              scale: _fabAnimation,
              child: FloatingActionButton(
                heroTag: 'fab_book_service',
                onPressed: () {
                  print('Book service tapped');
                  // TODO: Navigate to generic booking flow or AllServicesScreen
                },
                backgroundColor: AppColors.accentBlue,
                child: const Icon(Icons.add_task_rounded, color: AppColors.textWhite),
              ),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              heroTag: 'fab_main',
              onPressed: _toggleFab,
              backgroundColor: AppColors.accentBlue,
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _fabAnimationController,
                color: AppColors.textWhite,
              ),
            ),
          ],
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
                backgroundImage: NetworkImage('https://via.placeholder.com/150/0000FF/FFFFFF?text=User'), // Placeholder image
                backgroundColor: AppColors.accentBlue,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hello, John!', // Placeholder name
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

  // Function to simulate location picker (used by _buildInteractiveLocationWidget)
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
              borderRadius: BorderRadius.circular(10),
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

  // Dummy data for promotions
  final List<Map<String, String>> _promotions = [
    {'image': 'https://via.placeholder.com/600x200/5B8BFB/FFFFFF?text=20%25+OFF+on+Oil+Change', 'title': 'Flash Sale!'},
    {'image': 'https://via.placeholder.com/600x200/4CAF50/FFFFFF?text=Free+Tire+Rotation+with+Service', 'title': 'Special Offer!'},
    {'image': 'https://via.placeholder.com/600x200/FFA500/FFFFFF?text=New+Feature:+Roadside+Assistance', 'title': 'New Feature!'},
  ];

  Widget _buildPromotionalCarousel(double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.18, // Adjust height as needed
      child: PageView.builder(
        itemCount: _promotions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => print('Promotion tapped: ${_promotions[index]['title']}'),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(_promotions[index]['image']!),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _promotions[index]['title']!,
                    style: const TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(offset: Offset(1, 1), blurRadius: 3, color: Colors.black54)
                      ]
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
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
          title: 'Book a Garage',
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
              'Popular Services Near You',
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
                  MaterialPageRoute(builder: (context) => const AllServicesScreen(service: {},)),
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
        // You might pass the selected service data to the ServiceDetailScreen
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailScreen(service: service)));
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
      case 'Completed': statusColor = AppColors.accentGreen; break;
      case 'Pending Payment': statusColor = Colors.orange; break;
      case 'Canceled': statusColor = Colors.redAccent; break;
      default: statusColor = AppColors.textWhite70;
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
            Expanded( // Use Expanded for flex
              child: Row(
                children: [
                  Icon(activity['icon'] as IconData?, color: AppColors.accentBlue, size: 22),
                  const SizedBox(width: 12),
                  Flexible( // Make text flexible to prevent overflow
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