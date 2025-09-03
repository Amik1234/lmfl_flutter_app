import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../constants/app_colors.dart';
import '../models/mega_menu_item.dart';

/// Виджет мега меню с подменю и анимациями
/// Конвертировано из Android MegaMenuAdapter
class MegaMenuWidget extends StatefulWidget {
  final List<MegaMenuItem> menuItems;
  final Function(MegaMenuItem) onItemTap;
  final VoidCallback onBackgroundTap;

  const MegaMenuWidget({
    Key? key,
    required this.menuItems,
    required this.onItemTap,
    required this.onBackgroundTap,
  }) : super(key: key);

  @override
  State<MegaMenuWidget> createState() => _MegaMenuWidgetState();
}

class _MegaMenuWidgetState extends State<MegaMenuWidget>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  
  final Map<int, bool> _expandedItems = {};

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startEntryAnimations();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
  }

  void _startEntryAnimations() {
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onBackgroundTap,
      child: Container(
        color: Colors.black54,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  _buildMenuGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryLightColor, AppColors.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: const Text(
        'Меню сайта',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textOnPrimary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMenuGrid() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: AnimationLimiter(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: widget.menuItems.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: _buildMenuItem(widget.menuItems[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(MegaMenuItem item) {
    final isExpanded = _expandedItems[item.id] ?? false;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _handleMenuItemTap(item),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Основной элемент меню
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Иконка
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Icon(
                        item.iconData,
                        size: 28,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Заголовок
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Индикатор подменю
              if (item.hasSubMenu)
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.expand_more,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                ),
              
              // Подменю
              if (item.hasSubMenu && isExpanded)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: _buildSubMenu(item.subMenuItems ?? []),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubMenu(List<MegaMenuItem> subItems) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: subItems.map((subItem) => _buildSubMenuItem(subItem)).toList(),
      ),
    );
  }

  Widget _buildSubMenuItem(MegaMenuItem subItem) {
    return InkWell(
      onTap: () => widget.onItemTap(subItem),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.chevron_right,
              size: 16,
              color: AppColors.accentColor,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                subItem.title,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuItemTap(MegaMenuItem item) {
    if (item.hasSubMenu && item.subMenuItems != null) {
      setState(() {
        _expandedItems[item.id] = !(_expandedItems[item.id] ?? false);
      });
      
      // Если есть основная ссылка, открываем её тоже
      if (item.url != null) {
        widget.onItemTap(item);
      }
    } else {
      widget.onItemTap(item);
    }
  }
}