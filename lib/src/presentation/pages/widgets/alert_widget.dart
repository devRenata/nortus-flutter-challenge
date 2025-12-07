import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

enum ContentType { error, success }

class AlertWidget extends StatefulWidget {
  final String message;
  final ContentType type;
  final Duration duration;
  final VoidCallback? onDismissed;

  const AlertWidget({
    super.key,
    required this.message,
    required this.type,
    this.duration = const Duration(seconds: 3),
    this.onDismissed,
  });

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    offsetAnimation = Tween<Offset>(
      begin: const Offset(1.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        controller.reverse().then((_) {
          widget.onDismissed?.call();
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
      top: size.height * 0.03,
      right: size.width * 0.05,
      child: SlideTransition(
        position: offsetAnimation,
        child: Container(
          width: size.width * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  widget.message,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color get color {
    switch (widget.type) {
      case ContentType.error:
        return AppColors.error;
      case ContentType.success:
        return AppColors.success;
    }
  }

  IconData get icon {
    switch (widget.type) {
      case ContentType.error:
        return Icons.cancel_rounded;
      case ContentType.success:
        return Icons.check_circle_rounded;
    }
  }
}