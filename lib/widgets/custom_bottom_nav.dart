import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context,
              icon: Icons.home_rounded,
              label: 'Home',
              index: 0,
              isSelected: currentIndex == 0,
            ),
            _buildNavItem(
              context,
              icon: Icons.search_rounded,
              label: 'Suchen',
              index: 1,
              isSelected: currentIndex == 1,
            ),
            _buildAddButton(context),
            _buildNavItem(
              context,
              icon: Icons.favorite_rounded,
              label: 'Favoriten',
              index: 3,
              isSelected: currentIndex == 3,
            ),
            _buildNavItem(
              context,
              icon: Icons.person_rounded,
              label: 'Profil',
              index: 4,
              isSelected: currentIndex == 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? context.theme.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? context.theme.primaryColor
                  : context.theme.iconTheme.color?.withOpacity(0.6),
              size: 24,
            )
                .animate(target: isSelected ? 1 : 0)
                .scale(duration: 200.ms, curve: Curves.easeInOut),
            const SizedBox(height: 4),
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                color: isSelected
                    ? context.theme.primaryColor
                    : context.theme.textTheme.bodySmall?.color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(2),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.theme.primaryColor,
              context.theme.primaryColor.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: context.theme.primaryColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 28,
        ),
      )
          .animate()
          .scale(
            duration: 200.ms,
            curve: Curves.easeInOut,
          )
          .shimmer(
            duration: 2000.ms,
            color: Colors.white.withOpacity(0.3),
          ),
    );
  }
}

