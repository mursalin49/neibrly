import 'package:flutter/material.dart';

Future<void> showNaibrlyRequestBottomSheet(
  BuildContext context, {
  bool initialLocationEnabled = false,
  int initialSelectedMiles = 3,
  ValueChanged<bool>? onLocationChanged,
  ValueChanged<int>? onMilesChanged,
  VoidCallback? onSend,
}) async {
  await showModalBottomSheet(
    context: context,
    useSafeArea: true,
    barrierColor: const Color(0xFF030306).withOpacity(0.90),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return _NaibrlyRequestBottomSheetContent(
        initialLocationEnabled: initialLocationEnabled,
        initialSelectedMiles: initialSelectedMiles,
        onLocationChanged: onLocationChanged,
        onMilesChanged: onMilesChanged,
        onSend: onSend,
      );
    },
  );
}

class _NaibrlyRequestBottomSheetContent extends StatefulWidget {
  final bool initialLocationEnabled;
  final int initialSelectedMiles;
  final ValueChanged<bool>? onLocationChanged;
  final ValueChanged<int>? onMilesChanged;
  final VoidCallback? onSend;

  const _NaibrlyRequestBottomSheetContent({
    required this.initialLocationEnabled,
    required this.initialSelectedMiles,
    this.onLocationChanged,
    this.onMilesChanged,
    this.onSend,
  });

  @override
  State<_NaibrlyRequestBottomSheetContent> createState() => _NaibrlyRequestBottomSheetContentState();
}

class _NaibrlyRequestBottomSheetContentState extends State<_NaibrlyRequestBottomSheetContent> {
  late bool isLocationEnabled;
  late int selectedMiles;

  @override
  void initState() {
    super.initState();
    isLocationEnabled = widget.initialLocationEnabled;
    selectedMiles = widget.initialSelectedMiles;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset("assets/images/roundCross.png"),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/tickMark.png",
                  height: 120,
                  width: 159,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Naibrly Request",
                  style: TextStyle(
                    color: Color(0xFF1C1C1C),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "On your current location",
                  style: TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 24),

                // Location toggle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1C1C1C),
                            ),
                          ),
                          Switch(
                            value: isLocationEnabled,
                            onChanged: (value) {
                              setState(() => isLocationEnabled = value);
                              widget.onLocationChanged?.call(value);
                            },
                            activeColor: const Color(0xFF0E7A60),
                          ),
                        ],
                      ),
                      if (!isLocationEnabled) ...[
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFFF34F4F), width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Please on your location",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFF34F4F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Miles selection
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Send to nearby user within*",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1C1C1C),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildRadioOption("3", selectedMiles == 3, () {
                            setState(() => selectedMiles = 3);
                            widget.onMilesChanged?.call(3);
                          }),
                          const SizedBox(width: 12),
                          _buildRadioOption("10", selectedMiles == 10, () {
                            setState(() => selectedMiles = 10);
                            widget.onMilesChanged?.call(10);
                          }),
                          const SizedBox(width: 12),
                          _buildRadioOption("15", selectedMiles == 15, () {
                            setState(() => selectedMiles = 15);
                            widget.onMilesChanged?.call(15);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Send Ping
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onSend?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E7A60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Send Ping',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(String miles, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0E7A60) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFF0E7A60) : const Color(0xFFE5E5E5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected)
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      size: 12,
                      color: Color(0xFF0E7A60),
                    ),
                  ),
                )
              else
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
                    shape: BoxShape.circle,
                  ),
                ),
              const SizedBox(width: 6),
              Text(
                "$miles miles",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF1C1C1C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


