import 'package:flutter/material.dart';
import 'with_shadow_container.dart';

class CurrentLocationButton extends StatelessWidget {
  /// Getting current location button
  const CurrentLocationButton({
    required this.getCurrentLocation,
    Key? key,
  }) : super(key: key);

  final dynamic getCurrentLocation;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: SafeArea(
        child: InkWell(
          onTap: () => getCurrentLocation(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: withShadowDecoration(
              CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.my_location_outlined,
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
