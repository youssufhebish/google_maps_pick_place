import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../models/address_model.dart';

class AddressLabel extends StatelessWidget {
  const AddressLabel(
      {required this.address,
      required this.loading,
      required this.onTap,
      required this.loader,
      required this.notConnected,
      this.done,
      this.error,
      Key? key})
      : super(key: key);
  final FullAddress address;
  final bool loading;
  final bool notConnected;
  final Widget loader;
  final Function(FullAddress) onTap;
  final Widget? done;
  final Widget? error;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.width / 2.0,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.black.withOpacity(0.25) : Colors.white.withOpacity(0.25),
              ),
              child: loading
                  ? loader
                  : Column(
                      children: <Widget>[
                        notConnected? Text(
                          Directionality.of(context).name == 'rtl' ? 'لا يوجد اتصال بالانترنت \n حاول مرة أخرى' : 'No internet connection \n try again later',
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          textScaleFactor: 1.0,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: MediaQuery.of(context).platformBrightness != Brightness.dark ? Colors.black : Colors.white,
                          ),
                        ) : Text(
                          address.address!,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          textScaleFactor: 1.0,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: MediaQuery.of(context).platformBrightness != Brightness.dark ? Colors.black : Colors.white,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            onTap(address);
                            Navigator.of(context).pop();
                          },
                          child: notConnected
                              ? error ??
                                  CircleAvatar(
                                    backgroundColor: notConnected
                                        ? Colors.red.withOpacity(0.35)
                                        : Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.35),
                                    child: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.red,
                                      size: 30.0,
                                    ),
                                  )
                              : done ??
                                  CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.35),
                                    child: Icon(
                                      Icons.check,
                                      color: Theme.of(context).primaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                        ),
                        const Spacer()
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}