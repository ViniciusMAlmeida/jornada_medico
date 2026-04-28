import 'package:flutter/material.dart';

class MenuItem {
  MenuItem(this.label, this.icon, [this.selected = false, this.iconColor]);

  final String label;
  final IconData icon;
  bool selected;
  final Color? iconColor;
}

class Sidebar extends StatefulWidget {
  const Sidebar({
    super.key,
    required this.menuItems,
    required this.footerItems,
    required this.onToggleSidebar,
    required this.isExpanded,
  });

  final List<MenuItem> menuItems;
  final List<MenuItem> footerItems;
  final VoidCallback onToggleSidebar;
  final bool isExpanded;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.isExpanded ? 260 : 60,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
      color: Colors.white,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              child: child,
            ),
          );
        },
        child: widget.isExpanded
            ? Column(
                key: const ValueKey('expanded'),
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'saúde',
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(
                                    fontSize: 22,
                                    color: const Color(0xFF04967F),
                                  ),
                            ),
                            Text(
                              'brasil',
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(
                                    fontSize: 22,
                                    color: const Color(0xFFFFC000),
                                  ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: widget.onToggleSidebar,
                          icon: const Icon(
                            Icons.menu_open,
                            color: Color(0xFF686868),
                          ),
                          tooltip: 'Alternar Menu',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 32,
                          backgroundColor: Color(0xFFD1FAE5),
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF047857),
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Olá, Maiany!',
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Veja seus atendimentos',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: const Color(0xFF64748B)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(
                    height: 1.5,
                    color: Color(0xFFC7CDD4),
                    indent: 16,
                    endIndent: 16,
                  ),
                  const SizedBox(height: 32),
                  ...widget.menuItems.map(
                    (item) => _SidebarMenuItem(
                      item: item,
                      onTap: () {
                        setState(() {
                          for (final current in widget.menuItems) {
                            current.selected = current == item;
                          }
                        });
                      },
                    ),
                  ),
                  const Spacer(),
                  const Divider(
                    height: 1.5,
                    color: Color(0xFFC7CDD4),
                    indent: 16,
                    endIndent: 16,
                  ),
                  ...widget.footerItems.map(
                    (item) => _SidebarMenuItem(
                      item: item,
                      compact: false,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              )
            : Center(
                key: const ValueKey('collapsed'),
                child: IconButton(
                  onPressed: widget.onToggleSidebar,
                  icon: const Icon(Icons.menu_open, color: Color(0xFF686868)),
                  tooltip: 'Alternar Menu',
                ),
              ),
      ),
    );
  }
}

class _SidebarMenuItem extends StatefulWidget {
  const _SidebarMenuItem({
    required this.item,
    required this.onTap,
    this.compact = false,
  });

  final MenuItem item;
  final void Function() onTap;
  final bool compact;

  @override
  State<_SidebarMenuItem> createState() => _SidebarMenuItemState();
}

class _SidebarMenuItemState extends State<_SidebarMenuItem> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          padding: EdgeInsets.symmetric(
            vertical: widget.compact ? 12 : 14,
            horizontal: 14,
          ),
          decoration: BoxDecoration(
            color: widget.item.selected
                ? const Color(0xFFEDFDF8)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                widget.item.icon,
                color: widget.item.iconColor ?? const Color(0xFF30B595),
                size: 22,
              ),
              if (!widget.compact) ...[
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.item.label,
                    style: TextStyle(color: const Color(0xFF475569)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
