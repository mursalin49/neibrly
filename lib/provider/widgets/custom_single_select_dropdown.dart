import 'package:flutter/material.dart';
import 'colors.dart';

class CustomSingleSelectDropdown extends StatefulWidget {
  final String hint;
  final List<String> items;
  final String? selectedItem;
  final Function(String?) onChanged;

  const CustomSingleSelectDropdown({
    super.key,
    required this.hint,
    required this.items,
    this.selectedItem,
    required this.onChanged,
  });

  @override
  State<CustomSingleSelectDropdown> createState() => _CustomSingleSelectDropdownState();
}

class _CustomSingleSelectDropdownState extends State<CustomSingleSelectDropdown> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  double _fieldWidth = 0;

  bool get _isOpen => _overlayEntry != null;

  @override
  void dispose() {
    _close();
    super.dispose();
  }

  void _open() {
    if (_isOpen) return;
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final box = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    _fieldWidth = box?.size.width ?? 0;

    _overlayEntry = OverlayEntry(
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _close,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 48 + 4),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: _fieldWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      final isSelected = widget.selectedItem == item;
                      return InkWell(
                        onTap: () {
                          widget.onChanged(item);
                          _close();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                                width: index < widget.items.length - 1 ? 1 : 0,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected ? KoreColors.primary : const Color(0xFF1C1C1C),
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check_circle, size: 20, color: KoreColors.primary)
                              else
                                Icon(Icons.circle_outlined, size: 20, color: Colors.grey.shade400),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
    setState(() {});
  }

  void _close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() {});
  }

  void _toggle() => _isOpen ? _close() : _open();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggle,
            child: Container(
              key: _fieldKey,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: widget.selectedItem == null
                        ? Text(
                            widget.hint,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          )
                        : _MarqueeText(
                            text: widget.selectedItem!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1C1C1C),
                            ),
                          ),
                  ),
                  Icon(
                    _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle style;
  const _MarqueeText({required this.text, required this.style});

  @override
  State<_MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<_MarqueeText> with SingleTickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  bool _shouldScroll = false;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _evaluate());
  }

  @override
  void didUpdateWidget(covariant _MarqueeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _evaluate());
  }

  void _evaluate() {
    if (!mounted || !_controller.hasClients) {
      setState(() => _shouldScroll = false);
      return;
    }
    final max = _controller.position.maxScrollExtent;
    final should = max > 0;
    if (should != _shouldScroll) {
      setState(() => _shouldScroll = should);
    }
    if (_shouldScroll && !_running) {
      _start();
    }
  }

  Future<void> _start() async {
    _running = true;
    while (mounted && _shouldScroll) {
      if (!_controller.hasClients) break;
      await Future.delayed(const Duration(milliseconds: 600));
      if (!_controller.hasClients) break;
      await _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(seconds: 6),
        curve: Curves.linear,
      );
      await Future.delayed(const Duration(milliseconds: 600));
      if (!_controller.hasClients) break;
      await _controller.animateTo(
        0,
        duration: const Duration(seconds: 6),
        curve: Curves.linear,
      );
    }
    _running = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SingleChildScrollView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Text(
          widget.text,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.visible,
          style: widget.style,
        ),
      ),
    );
  }
}

