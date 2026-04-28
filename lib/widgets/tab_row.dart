import 'package:flutter/material.dart';

class TabRow extends StatefulWidget {
  const TabRow({super.key, required this.tabs, required this.activeIndex, required this.onTabSelected});

  final List<String> tabs;
  final int activeIndex;
  final void Function(int) onTabSelected;

  @override
  State<TabRow> createState() => _TabRowState();
}

class _TabRowState extends State<TabRow> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this, initialIndex: widget.activeIndex);
  }

  @override
  void didUpdateWidget(TabRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeIndex != widget.activeIndex) {
      _tabController.animateTo(widget.activeIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      tabs: widget.tabs.map((tab) => Tab(text: tab)).toList(),
      onTap: widget.onTabSelected,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      labelColor: const Color(0xFF30B595),
      labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      indicator: BoxDecoration(
        color: const Color(0xFFDFF4F0),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(13)),
        border: Border(bottom: BorderSide(color: const Color(0xFF30B595), width: 1.5)),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}