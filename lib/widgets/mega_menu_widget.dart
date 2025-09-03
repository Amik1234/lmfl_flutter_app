import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../models/mega_menu_item.dart';

/// Улучшенный виджет мега меню с адаптивным дизайном
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
  late AnimationController _scaleController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  final Map<int, bool> _expandedItems = {};
  final Map<int, AnimationController> _itemControllers = {};

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeItemControllers();
    _startEntryAnimations();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutBack,
    ));
  }

  void _initializeItemControllers() {
    for (var item in widget.menuItems) {
      if (item.hasSubMenu) {
        _itemControllers[item.id] = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: this,
        );
      }
    }
  }

  void _startEntryAnimations() {
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 50), () {
      _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    for (var controller in _itemControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final crossAxisCount = isTablet ? 3 : 2;
    
    return GestureDetector(
      onTap: widget.onBackgroundTap,
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(isTablet ? 32 : 16),
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 600 : double.infinity,
                    maxHeight: screenSize.height * 0.8,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColors.cardGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppColors.elevatedShadow,
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(),
                      _buildMenuGrid(crossAxisCount),
                    ],
                  ),
                ),
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.textOnPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.sports_soccer,
              size: 32,
              color: AppColors.textOnPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Меню ЛМФЛ',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textOnPrimary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Выберите раздел',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textOnPrimary.withOpacity(0.8),
              letterSpacing: 0.25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(int crossAxisCount) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: AnimationLimiter(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1.1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: widget.menuItems.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 500),
                columnCount: crossAxisCount,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: ScaleAnimation(
                      scale: 0.8,
                      child: _buildMenuItem(widget.menuItems[index]),
                    ),
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
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      child: Card(
        elevation: isExpanded ? 8 : 4,
        shadowColor: AppColors.primaryColor.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isExpanded 
                ? AppColors.primaryColor.withOpacity(0.3)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: InkWell(
          onTap: () => _handleMenuItemTap(item),
          borderRadius: BorderRadius.circular(20),
          splashColor: AppColors.primaryColor.withOpacity(0.1),
          highlightColor: AppColors.primaryColor.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Основной элемент меню
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Иконка с анимацией
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isExpanded ? 56 : 52,
                        height: isExpanded ? 56 : 52,
                        decoration: BoxDecoration(
                          gradient: isExpanded 
                              ? AppColors.primaryGradient
                              : LinearGradient(
                                  colors: [
                                    AppColors.primaryColor.withOpacity(0.1),
                                    AppColors.primaryColor.withOpacity(0.05),
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isExpanded 
                              ? AppColors.cardShadow
                              : null,
                        ),
                        child: Icon(
                          item.iconData,
                          size: isExpanded ? 28 : 26,
                          color: isExpanded 
                              ? AppColors.textOnPrimary
                              : AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Заголовок
                      Text(
                        item.title,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isExpanded 
                              ? AppColors.primaryColor
                              : AppColors.textPrimary,
                          letterSpacing: 0.1,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                // Индикатор подменю с анимацией
                if (item.hasSubMenu) ...[
                  const SizedBox(height: 8),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isExpanded 
                            ? AppColors.primaryColor.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: isExpanded 
                            ? AppColors.primaryColor
                            : AppColors.textTertiary,
                      ),
                    ),
                  ),
                ],
                
                // Подменю с улучшенной анимацией
                if (item.hasSubMenu && isExpanded)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.only(top: 12),
                    child: _buildSubMenu(item.subMenuItems ?? []),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubMenu(List<MegaMenuItem> subItems) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primarySurfaceColor,
            AppColors.primarySurfaceColor.withOpacity(0.5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: subItems.asMap().entries.map((entry) {
          final index = entry.key;
          final subItem = entry.value;
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 300),
            child: SlideAnimation(
              verticalOffset: 20.0,
              child: FadeInAnimation(
                child: _buildSubMenuItem(subItem, index == subItems.length - 1),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSubMenuItem(MegaMenuItem subItem, bool isLast) {
    return InkWell(
      onTap: () => widget.onItemTap(subItem),
      borderRadius: BorderRadius.circular(8),
      splashColor: AppColors.accentColor.withOpacity(0.1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: !isLast ? Border(
            bottom: BorderSide(
              color: AppColors.dividerColor.withOpacity(0.5),
              width: 0.5,
            ),
          ) : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                subItem.iconData,
                size: 16,
                color: AppColors.accentColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                subItem.title,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.1,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuItemTap(MegaMenuItem item) {
    if (item.hasSubMenu && item.subMenuItems != null) {
      setState(() {
        final wasExpanded = _expandedItems[item.id] ?? false;
        _expandedItems[item.id] = !wasExpanded;
        
        // Анимация для элемента
        final controller = _itemControllers[item.id];
        if (controller != null) {
          if (!wasExpanded) {
            controller.forward();
          } else {
            controller.reverse();
          }
        }
      });
      
      // Вибрация при раскрытии подменю
      HapticFeedback.selectionClick();
      
      // Если есть основная ссылка, открываем её тоже
      if (item.url != null) {
        Future.delayed(const Duration(milliseconds: 200), () {
          widget.onItemTap(item);
        });
      }
    } else {
      // Вибрация при выборе элемента
      HapticFeedback.lightImpact();
      widget.onItemTap(item);
    }
  }
}