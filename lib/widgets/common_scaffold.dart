// lib/widgets/common_scaffold.dart
import 'package:flutter/material.dart';
import '../main.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;

  const CommonScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy theme hiện tại của app → tự động biết đang sáng hay tối
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF87CEEB), // xanh trời nhạt đẹp
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(title),
        centerTitle: true,
        actions: [
          // Nút đổi sáng/tối – DÙNG CHÍNH THỨ Flutter CUNG CẤP
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.black87 : Colors.white,
              size: 28,
            ),
            onPressed: () {
              // Đổi theme toàn app chỉ bằng 1 dòng này!
              final current = Theme.of(context).brightness;
              final newMode = current == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
              // Gọi hàm đổi theme từ MyApp
              (context.findAncestorStateOfType<State<MyApp>>() as dynamic)
                  ?.setState(() {
                    (context.findAncestorWidgetOfExactType<MaterialApp>()
                                as dynamic)
                            ?.themeMode =
                        newMode;
                  });
            },
          ),
          if (actions != null) ...actions!,
          const SizedBox(width: 8),
        ],
      ),
      body: body,
    );
  }
}
