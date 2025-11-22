// import 'package:flutter/material.dart';
//
// import '../../widgets/colors.dart';
//
// class ProfileDashboardScreen extends StatefulWidget {
//   const ProfileDashboardScreen({super.key});
//
//   @override
//   State<ProfileDashboardScreen> createState() => _ProfileDashboardScreenState();
// }
//
// class _ProfileDashboardScreenState extends State<ProfileDashboardScreen> {
//   int _selectedIndex = 0;
//
//   void _onTabTapped(int index) {
//     setState(() => _selectedIndex = index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//
//       // ===== CUSTOM FLOATING NAVBAR =====
//       bottomNavigationBar: Container(
//         height: 70,
//         margin: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 10,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _navItem(Icons.home_outlined, "Home", 0),
//             _navItem(Icons.list_alt_outlined, "Orders", 1),
//             _navItem(Icons.notifications_none, "Notifications", 2),
//             _navItem(Icons.person_outline, "Profile", 3),
//           ],
//         ),
//       ),
//
//       // ===== BODY =====
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ===== PROFILE HEADER =====
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Row(
//                           children: [
//                             Text("Jacob Maicle",
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.w600)),
//                             SizedBox(width: 4),
//                             Icon(Icons.circle,
//                                 color: Colors.green, size: 8),
//                           ],
//                         ),
//                         SizedBox(height: 4),
//                         Row(
//                           children: [
//                             Icon(Icons.star,
//                                 size: 14, color: Colors.orange),
//                             SizedBox(width: 4),
//                             Text("5.0 (1,513 reviews)",
//                                 style: TextStyle(color: Colors.black54)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: Color(0xFFE8F5E9),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Text(
//                           "\$5892",
//                           style: TextStyle(
//                               color: Colors.green,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       ClipOval(
//                         child: Image.asset(
//                           "assets/images/home.png",
//                           width: 45,
//                           height: 45,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 25),
//
//               // ===== ACTIVE REQUESTS =====
//               const Text("Active Requests",
//                   style: TextStyle(fontWeight: FontWeight.w600)),
//               const SizedBox(height: 10),
//
//         Container(
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: const Color(0xFFF1FBF2), // ✅ হালকা সবুজ ব্যাকগ্রাউন্ড
//             border: Border.all(
//               color: const Color(0xFFB2E3B3), // ✅ একই রঙের হালকা বর্ডার
//               width: 1.2,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: "Appliance Repairs: ",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                     TextSpan(
//                       text: "\$63/hr",
//                       style: TextStyle(
//                         color: KoreColors.primary,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: const [
//                   CircleAvatar(
//                     radius: 16,
//                     backgroundImage: AssetImage("assets/images/jane.png"),
//                   ),
//                   SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Jane Doe", style: TextStyle(fontWeight: FontWeight.w600)),
//                       Row(
//                         children: [
//                           Icon(Icons.star, size: 14, color: Colors.orange),
//                           Text(" 5.0 (55 reviews)", style: TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               const SizedBox(height: 12),
//               const Text(
//                 "Address: 123 Oak Street Springfield, IL 62704\nDate: 18 Sep 2025  Time: 14:00",
//                 style: TextStyle(color: Colors.black87, fontSize: 13),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Problem Note for Fridge Repair\nThe fridge is not cooling properly, making strange noises, freezing food, leaking water, etc.",
//                 style: TextStyle(color: Colors.grey, fontSize: 13),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () {},
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: Colors.redAccent),
//                         foregroundColor: Colors.redAccent,
//                       ),
//                       child: const Text("Cancel"),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                       ),
//                       child: const Text("Accept"),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         );
//
//
//         const SizedBox(height: 25),
//
//               // ===== ANALYTICS SECTION =====
//               const Text("Analytics",
//                   style: TextStyle(fontWeight: FontWeight.w600)),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   _buildAnalyticsCard("My Order", "05", "82"),
//                   const SizedBox(width: 10),
//                   _buildAnalyticsCard("My Earnings", "\$223", "\$2586"),
//                 ],
//               ),
//
//               const SizedBox(height: 25),
//
//               // ===== CLIENT FEEDBACK =====
//               const Text("Client Feedback",
//                   style: TextStyle(fontWeight: FontWeight.w600)),
//               const SizedBox(height: 10),
//
//               _buildReview(
//                   "Jessica R",
//                   "Thank you for your work! The service met my expectations and I'm very happy.",
//                   4.0,
//                   "2 Days ago",
//                   "assets/images/jessica.png"),
//               _buildReview("Maria Gosh", "Good but can be improved.", 2.0,
//                   "1 Month ago", "assets/images/maria.png"),
//               _buildReview("Ethan Lert", "Average experience overall.", 3.0,
//                   "4 Weeks ago", "assets/images/ethan.png"),
//
//               const SizedBox(height: 10),
//               Center(
//                 child: OutlinedButton(
//                   onPressed: () {},
//                   style: OutlinedButton.styleFrom(
//                     side: const BorderSide(color: Colors.grey),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//                   ),
//                   child: const Text("See more",
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.w500)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ===== NAV ITEM =====
//   Widget _navItem(IconData icon, String label, int index) {
//     final isSelected = _selectedIndex == index;
//     return GestureDetector(
//       onTap: () => _onTabTapped(index),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: isSelected ? Colors.green : Colors.grey),
//           Text(label,
//               style: TextStyle(
//                   color: isSelected ? Colors.green : Colors.grey,
//                   fontSize: 12)),
//         ],
//       ),
//     );
//   }
//
//   // ===== ANALYTICS CARD =====
//   Widget _buildAnalyticsCard(String title, String today, String month) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.green.withOpacity(0.2)),
//         ),
//         child: Column(
//           children: [
//             Text(title,
//                 style: const TextStyle(
//                     color: Colors.grey, fontWeight: FontWeight.w500)),
//             const SizedBox(height: 6),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     Text(today,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16)),
//                     const Text("Today", style: TextStyle(fontSize: 12)),
//                   ],
//                 ),
//                 Container(
//                     width: 1, height: 30, color: Colors.green.withOpacity(0.2)),
//                 Column(
//                   children: [
//                     Text(month,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16)),
//                     const Text("This Month", style: TextStyle(fontSize: 12)),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ===== REVIEW CARD =====
//   Widget _buildReview(String name, String comment, double rating, String time,
//       String imagePath) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CircleAvatar(radius: 22, backgroundImage: AssetImage(imagePath)),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(name,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w600, fontSize: 14)),
//                     Text(time,
//                         style:
//                         const TextStyle(color: Colors.grey, fontSize: 12)),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Row(
//                       children: List.generate(
//                         5,
//                             (index) => Icon(Icons.star,
//                             size: 16,
//                             color: index < rating
//                                 ? Colors.orange
//                                 : Colors.grey.shade300),
//                       ),
//                     ),
//                     const SizedBox(width: 6),
//                     Text("(${rating.toStringAsFixed(1)})",
//                         style: const TextStyle(
//                             color: Colors.grey, fontSize: 12)),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   comment,
//                   style: const TextStyle(
//                       color: Colors.black87, fontSize: 13, height: 1.4),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
