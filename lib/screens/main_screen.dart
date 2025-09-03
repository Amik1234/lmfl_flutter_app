import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../models/mega_menu_item.dart';
import '../widgets/mega_menu_widget.dart';
import '../screens/home_page.dart';
import '../screens/webview_page.dart';
import '../screens/contacts_page.dart';
import '../screens/about_page.dart';
import '../screens/login_page.dart';

/// Главный экран приложения с навигацией
/// Конвертировано из Android MainActivity.kt
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isMegaMenuVisible = false;
  late List<Widget> _pages;
  late List<MegaMenuItem> _megaMenuItems;

  @override
  void initState() {
    super.initState();
    _initializePages();
    _megaMenuItems = MenuFactory.createMainMenuItems();
  }

  void _initializePages() {
    _pages = [
      const HomePage(),
      const ContactsPage(),
      Container(), // Заглушка для мега меню
      const AboutPage(),
      const LoginPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getPageTitle()),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 4,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
        children: [
          // Основной контент
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          
          // Мега меню
          if (_isMegaMenuVisible)
            MegaMenuWidget(
              menuItems: _megaMenuItems,
              onItemTap: _handleMegaMenuItemTap,
              onBackgroundTap: _hideMegaMenu,
            ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bottomNavBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: AppColors.elevatedShadow,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex == 2 ? -1 : _selectedIndex,
          onTap: _onBottomNavTap,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.bottomNavSelected,
          unselectedItemColor: AppColors.bottomNavUnselected,
          elevation: 0,
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 
                      ? AppColors.primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.home),
              ),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 1 
                      ? AppColors.primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.contact_mail_outlined),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.contact_mail),
              ),
              label: 'Контакты',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: _isMegaMenuVisible 
                      ? AppColors.primaryGradient
                      : null,
                  color: _isMegaMenuVisible 
                      ? null
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _isMegaMenuVisible 
                      ? AppColors.cardShadow
                      : null,
                ),
                child: Icon(
                  _isMegaMenuVisible ? Icons.close : Icons.apps_outlined,
                  size: 28,
                  color: _isMegaMenuVisible 
                      ? AppColors.textOnPrimary
                      : AppColors.bottomNavUnselected,
                ),
              ),
              label: 'Меню',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 3 
                      ? AppColors.primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.info_outlined),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.info),
              ),
              label: 'О нас',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 4 
                      ? AppColors.primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person_outlined),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person),
              ),
              label: 'Войти',
            ),
          ],
        ),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    if (index == 2) {
      // Мега меню
      _toggleMegaMenu();
    } else {
      setState(() {
        _selectedIndex = index;
        _isMegaMenuVisible = false;
      });
    }
  }

  void _toggleMegaMenu() {
    setState(() {
      _isMegaMenuVisible = !_isMegaMenuVisible;
    });
    
    // Добавляем вибрацию при открытии мега меню
    if (_isMegaMenuVisible) {
      HapticFeedback.lightImpact();
    }
  }

  void _hideMegaMenu() {
    setState(() {
      _isMegaMenuVisible = false;
    });
  }

  void _handleMegaMenuItemTap(MegaMenuItem item) {
    _hideMegaMenu();
    
    if (item.url != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewPage(
            url: item.url!,
            title: item.title,
          ),
        ),
      );
    }
  }

  String _getPageTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'ЛМФЛ - Махачкала';
      case 1:
        return 'Контакты';
      case 3:
        return 'О нас';
      case 4:
        return 'Вход';
      default:
        return 'ЛМФЛ';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}