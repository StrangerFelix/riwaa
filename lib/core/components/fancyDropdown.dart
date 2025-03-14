import 'package:flutter/material.dart';

class FancyDropdown<T> extends StatefulWidget {
  final List<DropdownItem<T>> items;
  final DropdownItem<T>? value;
  final String hint;
  final ValueChanged<DropdownItem<T>?> onChanged;
  final Color? backgroundColor;
  final Color? accentColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BoxShadow? boxShadow;
  final double iconSize;
  final Duration animationDuration;
  final Curve animationCurve;
  final double elevation;
  final bool showSearchBox;
  final String searchHint;

  const FancyDropdown({
    super.key,
    required this.items,
    this.value,
    required this.onChanged,
    this.hint = 'Select an item',
    this.backgroundColor,
    this.accentColor,
    this.textColor,
    this.borderRadius = 12.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.boxShadow,
    this.iconSize = 24.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.elevation = 8.0,
    this.showSearchBox = false,
    this.searchHint = 'Search...',
  });

  @override
  State<FancyDropdown<T>> createState() => _FancyDropdownState<T>();
}

class _FancyDropdownState<T> extends State<FancyDropdown<T>> with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  DropdownItem<T>? _selectedItem;
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<List<DropdownItem<T>>> _filteredItems = ValueNotifier<List<DropdownItem<T>>>([]);

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.value;
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(_expandAnimation);
    _filteredItems.value = widget.items;
  }

  @override
  void didUpdateWidget(FancyDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _selectedItem = widget.value;
    }
    if (oldWidget.items != widget.items) {
      _filteredItems.value = widget.items;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _removeOverlay();
    _searchFocusNode.dispose();
    _searchController.dispose();
    _filteredItems.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    FocusScope.of(context).unfocus(); // قابل للحذف
    if (_isOpen) {
      _removeOverlay();
    } else {
      _createOverlay();
    }
    setState(() {
      _isOpen = !_isOpen;
    });
    _animationController.status == AnimationStatus.completed
        ? _animationController.reverse()
        : _animationController.forward();
  }

  void _createOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _searchController.clear();
    _filteredItems.value = widget.items;
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(),
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height),
                child: Material(
                  elevation: widget.elevation,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  color: widget.backgroundColor ?? Theme.of(context).cardColor,
                  shadowColor: widget.accentColor?.withValues(alpha: 0.2) ?? Colors.black.withValues(alpha: 0.2),
                  child: SizeTransition(
                    sizeFactor: _expandAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.showSearchBox) _buildSearchBox(),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height * 0.4, // Limit height to 40% of screen
                            ),
                            child: ValueListenableBuilder<List<DropdownItem<T>>>(
                              valueListenable: _filteredItems,
                              builder: (context, items, _) {
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    final item = items[index];
                                    return _buildDropdownItem(item);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          hintText: widget.searchHint,
          prefixIcon: Icon(
            Icons.search,
            color: widget.accentColor ?? Theme.of(context).primaryColor,
            size: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.accentColor?.withValues(alpha: 0.2) ?? Colors.grey.withValues(alpha: 0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.accentColor ?? Theme.of(context).primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.accentColor?.withValues(alpha: 0.3) ?? Colors.grey.withValues(alpha: 0.3),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (value) {
          _filteredItems.value = widget.items
              .where((item) => item.label.toLowerCase().contains(value.toLowerCase()))
              .toList();
        },
      ),
    );
  }

  Widget _buildDropdownItem(DropdownItem<T> item) {
    final bool isSelected = _selectedItem == item;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedItem = item;
        });
        widget.onChanged(item);
        _toggleDropdown();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            if (item.leading != null) ...[
              item.leading!,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                  color: isSelected
                      ? widget.accentColor ?? Theme.of(context).primaryColor
                      : widget.textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                color: widget.accentColor ?? Theme.of(context).primaryColor,
                size: 20,
              ),
            if (item.trailing != null) ...[
              const SizedBox(width: 12),
              item.trailing!,
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = widget.backgroundColor ?? Theme.of(context).cardColor;
    final Color accentColor = widget.accentColor ?? Theme.of(context).primaryColor;
    final Color textColor = widget.textColor ?? Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87;
    
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          margin: widget.margin,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              widget.boxShadow ??
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
            ],
            border: Border.all(
              color: _isOpen ? accentColor : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _selectedItem?.label ?? widget.hint,
                  style: TextStyle(
                    color: _selectedItem != null ? textColor : textColor.withValues(alpha: .7),
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              RotationTransition(
                turns: _rotateAnimation,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: accentColor,
                  size: widget.iconSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownItem<T> {
  final String label;
  final T value;
  final Widget? leading;
  final Widget? trailing;

  DropdownItem({
    required this.label,
    required this.value,
    this.leading,
    this.trailing,
  });
}
