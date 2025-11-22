import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../widgets/colors.dart';
import 'confirm_info_screen.dart';

class SelectServiceAreaScreen extends StatefulWidget {
  const SelectServiceAreaScreen({super.key});

  @override
  State<SelectServiceAreaScreen> createState() =>
      _SelectServiceAreaScreenState();
}

class _SelectServiceAreaScreenState extends State<SelectServiceAreaScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<String> allZips = ['156256', '156256', '156256'];
  final List<String> selectedZips = ['156256', '156256'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KoreColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Select Service Area",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {

              setState(() {});
            },
            icon: const Icon(Icons.arrow_forward, color: Colors.black),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Zip Codes",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),


            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: KoreColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "select your zip code",
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.search, color: KoreColors.textLight),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Selected chips (horizontal scroll if overflow)
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: selectedZips.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final zip = selectedZips[index];
                  return _ZipChip(
                    zip: zip,
                    onRemove: () {
                      setState(() => selectedZips.removeAt(index));
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Map area (big)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/image0.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                // optional overlay to mimic pinned area
                child: Stack(
                  children: [
                    // left slider mock
                    Positioned(
                      left: 12,
                      bottom: 18,
                      child: Container(
                        width: 36,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(child: Text("H")),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Confirm button (full width)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E7A60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConfirmInfoScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small green pill-like zip chip with remove button (matches screenshot)
class _ZipChip extends StatelessWidget {
  final String zip;
  final VoidCallback onRemove;

  const _ZipChip({required this.zip, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F6EF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.circle_outlined, size: 8, color: Color(0xFF0E7A60)),
          const SizedBox(width: 6),
          Text(
            zip,
            style: const TextStyle(color: Color(0xFF0E7A60)),
          ),

        ],
      ),
    );
  }
}
