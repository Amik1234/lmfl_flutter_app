import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Главная страница приложения
/// Конвертировано из Android HomeFragment.kt
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  static const String _homeUrl = 'https://lmfl05.ru/';

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.backgroundColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
              _hasError = true;
              _errorMessage = error.description;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(_homeUrl));
  }

  void _retry() {
    setState(() {
      _hasError = false;
      _isLoading = true;
    });
    _controller.loadRequest(Uri.parse(_homeUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Прогресс бар загрузки
          if (_isLoading)
            const LinearProgressIndicator(
              backgroundColor: AppColors.primaryLightColor,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          
          // Основной контент
          Expanded(
            child: _hasError ? _buildErrorWidget() : _buildWebView(),
          ),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: AppColors.cardShadow,
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: WebViewWidget(controller: _controller),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Иконка ошибки
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.errorColor.withOpacity(0.1),
                    AppColors.errorColor.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(48),
                border: Border.all(
                  color: AppColors.errorColor.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.wifi_off_outlined,
                size: 52,
                color: AppColors.errorColor,
              ),
            ),
            const SizedBox(height: 32),
            
            // Текст ошибки
            Text(
              'Ошибка подключения',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
                letterSpacing: 0.15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            Text(
              _errorMessage.isNotEmpty 
                  ? _errorMessage 
                  : 'Проверьте подключение к интернету',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                letterSpacing: 0.25,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
            // Кнопка повторить
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppColors.cardShadow,
              ),
              child: ElevatedButton.icon(
                onPressed: _retry,
                icon: const Icon(Icons.refresh_outlined, size: 20),
                label: Text(
                  'Повторить попытку',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.textOnPrimary,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Проверка, можно ли вернуться назад в WebView
  Future<bool> canGoBack() async {
    return await _controller.canGoBack();
  }

  /// Вернуться назад в WebView
  Future<void> goBack() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
    }
  }
}

              onPressed: _retry,
              icon: const Icon(Icons.refresh),
              label: const Text('Повторить'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.textOnPrimary,
                elevation: 4,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Проверка, можно ли вернуться назад в WebView
  Future<bool> canGoBack() async {
    return await _controller.canGoBack();
  }

  /// Вернуться назад в WebView
  Future<void> goBack() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
    }
  }
}