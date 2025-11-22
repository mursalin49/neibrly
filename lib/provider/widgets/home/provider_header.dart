import 'package:flutter/material.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import '../../models/provider_profile.dart';
import '../colors.dart';

class ProviderHeader extends StatefulWidget {
  final ProviderProfile profile;

  const ProviderHeader({
    super.key,
    required this.profile,
  });

  @override
  State<ProviderHeader> createState() => _ProviderHeaderState();
}

class _ProviderHeaderState extends State<ProviderHeader> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx + renderBox.size.width - 220,
        top: offset.dy + 60,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDropdownItem('Profile', Icons.person, () {}),
                _buildDropdownItem('Share', Icons.share, () {}),
                _buildDropdownItem('Payment History', Icons.payment, () {}),
                _buildDropdownItem('Help & Support', Icons.help, () {}),
                _buildDropdownItem('Privacy Policy', Icons.privacy_tip, () {}),
                _buildDropdownItem('Terms and Conditions', Icons.description, () {}),
                _buildDropdownItem('Log Out', Icons.logout, () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: Username and reviews
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.profile.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Active status with hollow shadow
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: widget.profile.isOnline ? KoreColors.container1 : KoreColors.textLight,
                      shape: BoxShape.circle,
                      boxShadow: widget.profile.isOnline ? [
                        BoxShadow(
                          color: KoreColors.container1.withOpacity(0.3),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ] : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.black,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.profile.rating} (${widget.profile.reviewCount} reviews)',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Right side: Balance with overlapping icon and dropdown
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Stack(
              children: [
                Image.asset("assets/images/Group 2085663248 (1).png"),
                Positioned(
                    top: 28,
                    left: 6,
                    child: AppText("\$5892",fontWeight: FontWeight.bold,fontSize: 14,color: Color(0xFF0E7A60),)
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildDropdownItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: () {
        _overlayEntry?.remove();
        _overlayEntry = null;
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

