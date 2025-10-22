import 'package:flutter/material.dart';

class HeartButton extends StatefulWidget {
  final bool isFavorite;
  final int size;
  final VoidCallback onPressed;

  const HeartButton({Key? key, required this.isFavorite, required this.onPressed, this.size = 30}) : super(key: key);

  @override
  _HeartButtonState createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: widget.isFavorite ? Colors.red : IconTheme.of(context).color,
        size: widget.size.toDouble(),
      ),
      onPressed: widget.onPressed,
    );
  }
}