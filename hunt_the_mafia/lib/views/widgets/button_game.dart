part of 'widgets.dart';

class PrimaryGameButton extends StatelessWidget {
  const PrimaryGameButton({
    super.key,
    required this.onPressed,
    this.iconData,
    this.assetPath,
    required this.label,
    this.maxSize = false,
    this.foregroundColor,
    this.backgroundColor,
  });

  final void Function()? onPressed;
  final IconData? iconData;
  final String? assetPath;
  final String? label;
  final bool maxSize;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Shape.roundedRectangle),
              ),
              foregroundColor: foregroundColor ?? const Color(0xFFFFB800),
              backgroundColor: backgroundColor ?? const Color(0xFF311A46),
              padding: (iconData != null || assetPath != null)
                  ? const EdgeInsets.only(left: 16, right: 24)
                  : null)
          .copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: maxSize ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData != null) ...[
            Icon(
              iconData,
              size: 18.0,
            ),
          ] else if (assetPath != null) ...[
            Image.asset(
              assetPath!,
              width: 18.0,
            ),
          ],
          if (iconData != null || assetPath != null)
            SizedSpacer.horizontal(space: Space.small),
          if (label != null) Text(label!),
        ],
      ),
    );
  }
}
