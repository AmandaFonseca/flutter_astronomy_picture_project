import 'package:astronomy_picture/custom_colors.dart';
import 'package:flutter/material.dart';

class ErrorApodWidget extends StatelessWidget {
  final String msg;
  final Function()? onRetry;
  const ErrorApodWidget({
    super.key,
    required this.msg,
    this.onRetry,
    required Color color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: CustomColors.vermilion, size: 100),

            const SizedBox(height: 16),
            Text(
              msg,
              style: TextStyle(color: CustomColors.white),
              textAlign: TextAlign.center,
            ),

            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Tentar novamente'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
