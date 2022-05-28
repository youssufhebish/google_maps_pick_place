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
                radius: 17.0,
                backgroundColor: Colors.transparent,
                // backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light
                //     ? Colors.white
                //     : Colors.black,
                child: Icon(
                  Icons.cancel_outlined,
                  size: 25.0,
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
