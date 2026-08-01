import 'package:flutter/material.dart';
import '../../models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  IconData _iconForSlug(String slug) {
    if (slug.contains('smartphone') || slug.contains('mobile')) {
      return Icons.smartphone;
    }
    if (slug.contains('laptop')) return Icons.laptop_mac;
    if (slug.contains('fragrance') || slug.contains('perfume')) {
      return Icons.spa;
    }
    if (slug.contains('beauty') || slug.contains('skin')) {
      return Icons.brush;
    }
    if (slug.contains('furniture')) return Icons.chair;
    if (slug.contains('grocery') || slug.contains('food')) {
      return Icons.local_grocery_store;
    }
    if (slug.contains('shoe') || slug.contains('footwear')) {
      return Icons.hiking;
    }
    if (slug.contains('watch')) return Icons.watch;
    if (slug.contains('bag')) return Icons.shopping_bag;
    if (slug.contains('jewel')) return Icons.diamond;
    if (slug.contains('car') || slug.contains('vehicle')) {
      return Icons.directions_car;
    }
    if (slug.contains('motorcycle')) return Icons.motorcycle;
    if (slug.contains('tablet')) return Icons.tablet_mac;
    if (slug.contains('kitchen') || slug.contains('accessor')) {
      return Icons.kitchen;
    }
    if (slug.contains('sunglass')) return Icons.visibility;
    if (slug.contains('women') || slug.contains('men')) {
      return Icons.checkroom;
    }
    return Icons.category;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _iconForSlug(category.slug),
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 10),
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}