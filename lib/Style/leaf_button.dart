import 'package:flutter/material.dart';

class LeafButton extends StatelessWidget {
  final bool isLiked;
  final void Function()? onTap;

  const LeafButton({
    super.key,
    required this.isLiked,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLiked ? Icons.energy_savings_leaf : Icons.energy_savings_leaf_outlined,
        color: isLiked ? Color(0xFF455932) : Colors.grey,
      ),
    );
  }
}
