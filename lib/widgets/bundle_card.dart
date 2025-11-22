import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/Ios_effect/iosTapEffect.dart';
import 'package:naibrly/views/screen/Users/Home/bundle_published_bottomsheet.dart';

class BundleCard extends StatefulWidget {
  final String serviceTitle;
  final String originalPrice;
  final String discountedPrice;
  final String savings;
  final List<Map<String, dynamic>> providers;
  final List<String> benefits;
  final VoidCallback? onJoinBundle;
  final bool isExpandable;
  final bool isExpanded;
  final VoidCallback? onToggleExpansion;
  final int? participants;
  final int? maxParticipants;
  final String? serviceDate; // ISO string like 2025-06-10
  final int? discountPercentage;
  final String? publishedText;

  const BundleCard({
    Key? key,
    required this.serviceTitle,
    required this.originalPrice,
    required this.discountedPrice,
    required this.savings,
    required this.providers,
    required this.benefits,
    this.onJoinBundle,
    this.isExpandable = true,
    this.isExpanded = false,
    this.onToggleExpansion,
    this.participants,
    this.maxParticipants,
    this.serviceDate,
    this.discountPercentage,
    this.publishedText,
  }) : super(key: key);

  @override
  State<BundleCard> createState() => _BundleCardState();
}

class _BundleCardState extends State<BundleCard> {
  @override
  Widget build(BuildContext context) {
    final int participants = widget.participants ?? 0;
    final int maxParticipants = widget.maxParticipants ?? 0;
    final int openSpots = (maxParticipants - participants).clamp(0, 999);
    final String? capacityText = maxParticipants > 0
        ? "$maxParticipants-Person Bundle ($participants Joined, $openSpots Spot${openSpots == 1 ? '' : 's'} Open)"
        : null;

    final String? formattedDate = _formatDate(widget.serviceDate);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 1),
            blurRadius: 15,
          ),
        ],
        border: Border.all(
          width: 0.8,
          color: Colors.black.withOpacity(0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Title and actions
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      widget.serviceTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    if (widget.isExpanded && (widget.publishedText ?? '').isNotEmpty) ...[
                      const SizedBox(height: 4),
                      AppText(
                        widget.publishedText ?? '',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ],
                    if (!widget.isExpanded) ...[
                      if (capacityText != null) ...[
                        const SizedBox(height: 6),
                        AppText(
                          capacityText,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 6),
                      ],
                      if (formattedDate != null)
                        AppText(
                          "Service Date: $formattedDate",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                    ]
                  ],
                ),
              ),
              // Actions: avatars (collapsed) or share (expanded) + expand/collapse icon
              Row(
                children: [
                  if (!widget.isExpanded) ...[
                    _buildCollapsedAvatars(),
                    const SizedBox(width: 8),
                  ]
                  else ...[
                    IosTapEffect(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          useSafeArea: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const BundlePublishedBottomSheet(),
                        );
                      },
                      child: const Icon(Icons.share_outlined, size: 20, color: Colors.black87),
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (widget.isExpandable)
                    IosTapEffect(
                      onTap: widget.onToggleExpansion ?? () {},
                      child: Icon(
                        widget.isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Expanded Content
          if (widget.isExpanded && widget.isExpandable) ...[
            const SizedBox(height: 16),
            // Capacity + Service date (expanded view)
            if (capacityText != null)
              AppText(
                capacityText,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            if (formattedDate != null) ...[
              const SizedBox(height: 8),
              AppText(
                "Service Date: $formattedDate",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ],
            const SizedBox(height: 12),

            // Provider Information
            for (int i = 0; i < widget.providers.length; i++) ...[
              _buildProviderInfo(widget.providers[i]),
              if (i < widget.providers.length - 1) const SizedBox(height: 8),
            ],
            const SizedBox(height: 16),
            // Rates two-column
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        "Standard rates est.",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 4),
                      AppText(
                        "${widget.discountedPrice}/hr",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        "Standard rates est.",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 4),
                      AppText(
                        widget.discountPercentage != null
                            ? "${widget.discountPercentage}% off"
                            : "5-10% off",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: widget.onJoinBundle ?? () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  elevation: 0,
                ),
                child: const Text(
                  "Join Bundle",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],

          // Collapsed Actions (More Info + Join)
          if (!widget.isExpanded) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onToggleExpansion ?? () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary, width: 1),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: AppText(
                      "More Info",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onJoinBundle ?? () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Join Bundle",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.grey.shade300,
      ),
      child: Image.asset('assets/images/jane.png'),
    );
  }

  Widget _buildCollapsedAvatars() {
    final List<String> avatarPaths = widget.providers
        .map((p) => (p['avatar'] as String?) ?? 'assets/images/jane.png')
        .toList();
    final int count = avatarPaths.length.clamp(0, 3);

    final double radius = 12;
    final double diameter = radius * 2;
    final double overlap = 8; // amount of horizontal overlap between avatars
    final double width = count > 0 ? diameter + (count - 1) * (diameter - overlap) : diameter;

    return SizedBox(
      width: width,
      height: diameter,
      child: Stack(
        children: [
          for (int i = 0; i < count; i++)
            Positioned(
              left: i * (diameter - overlap),
              child: Container(
                width: diameter,
                height: diameter,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                  color: Colors.grey.shade300,
                  image: DecorationImage(
                    image: AssetImage(avatarPaths[i]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProviderInfo(Map<String, dynamic> provider) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
          ),
          child: Image.asset(provider['avatar'] ?? 'assets/images/jane.png'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                provider['name'] ?? 'Unknown Provider',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Image.asset('assets/images/location.png'),
                  const SizedBox(width: 4),
                  Expanded(
                    child: AppText(
                      provider['location'] ?? 'Unknown Location',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            "•",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: AppText(
              text,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

String? _formatDate(String? iso) {
  if (iso == null || iso.isEmpty) return null;
  try {
    final dt = DateTime.tryParse(iso);
    if (dt == null) return null;
    const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
    final m = months[dt.month - 1];
    return "$m ${dt.day}, ${dt.year}";
  } catch (_) {
    return null;
  }
}
