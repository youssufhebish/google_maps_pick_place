import 'package:flutter/material.dart';
import 'with_shadow_container.dart';

class CloseMapButton extends StatelessWidget {
  /// Closing Map widget
  const CloseMapButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: SafeArea(
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: withShadowDecoration(
              CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.cancel_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              context,
            ),
          ),
        ),
      ),
    );
  }
}
