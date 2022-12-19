part of '../widgets.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({
    super.key,
    required this.onPressed,
    this.iconData,
    this.assetPath,
    required this.label,
    this.maxSize = false,
  });

  final void Function()? onPressed;
  final IconData? iconData;
  final String? assetPath;
  final String? label;
  final bool maxSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.primary,
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

class FilledTonalButton extends StatelessWidget {
  const FilledTonalButton({
    super.key,
    required this.onPressed,
    this.iconData,
    this.assetPath,
    required this.label,
    this.maxSize = false,
  });

  final void Function()? onPressed;
  final IconData? iconData;
  final String? assetPath;
  final String? label;
  final bool maxSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
              foregroundColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
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
