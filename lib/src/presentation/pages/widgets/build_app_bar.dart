import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nortus/src/presentation/routes/app_routes.dart';
import 'package:nortus/src/presentation/themes/app_assets.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BuildAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 20,
      backgroundColor: AppColors.primary,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              AppAssets.images.nortusLogo,
              height: 32,
            ),
          ),

          const SizedBox(width: 24),

          _buildAppBarItem(
            'Notícias',
            () => context.go(AppRoutes.news),
          ),
          _buildAppBarItem(
            'Meu perfil',
            () => context.go(AppRoutes.user),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarItem(String label, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
