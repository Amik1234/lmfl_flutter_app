import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex == 2 ? -1 : _selectedIndex, // Не выделяем мега меню
        onTap: _onBottomNavTap,
        backgroundColor: AppColors.bottomNavBackground,
        selectedItemColor: AppColors.bottomNavSelected,
        unselectedItemColor: AppColors.bottomNavUnselected,
        elevation: 0,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Контакты',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _isMegaMenuVisible 
                    ? AppColors.primaryColor.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.apps,
                size: 28,
                color: _isMegaMenuVisible 
                    ? AppColors.primaryColor 
                    : AppColors.bottomNavUnselected,
              ),
            ),
            label: 'Меню',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'О нас',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Войти',
          ),
        ],
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