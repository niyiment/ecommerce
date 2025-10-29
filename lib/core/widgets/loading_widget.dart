
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.size = 40.0, this.color, this.message});

  final double size;
  final Color? color;
  final String? message;

  @override
  Widget build(BuildContext context)  =>Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).primaryColor),
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16,),
            Text(message!,
              style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
            ),
          ]
        ],
      ),
    );
}

class LinearLoadingWidget extends StatelessWidget {
  const LinearLoadingWidget({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) => LinearProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).primaryColor),
  );
}
