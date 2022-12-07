import 'package:app_social/components/custom_button_circle_color.dart';
import 'package:flutter/material.dart';

class MeetingControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;
  final bool isCheckMicro;
  final bool isCheckCamera;

  const MeetingControls({
    Key? key,
    required this.onToggleMicButtonPressed,
    required this.onToggleCameraButtonPressed,
    required this.onLeaveButtonPressed,
    required this.isCheckCamera,
    required this.isCheckMicro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomButtonCircleColor(
          color: Colors.red,
          func: onLeaveButtonPressed,
          child: const Icon(
            Icons.phone,
            color: Colors.white,
          ),
        ),
        CustomButtonCircleColor(
          color: Colors.black.withOpacity(.3),
          func: onToggleMicButtonPressed,
          child: Icon(
            isCheckMicro ? Icons.mic : Icons.mic_off_outlined,
            color: isCheckMicro ? Colors.white : Colors.grey,
          ),
        ),
        CustomButtonCircleColor(
          color: Colors.black.withOpacity(.3),
          func: onToggleCameraButtonPressed,
          child: Icon(
            Icons.camera_alt,
            color: isCheckCamera ? Colors.white : Colors.grey,
          ),
        ),
      ],
    );
  }
}
