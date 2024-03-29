import 'package:flutter/material.dart';
// import 'package:snippet_coder_utils/FormHelper.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel(
      {super.key,
      this.videoEnabled,
      this.audioEnabled,
      this.isConnectionFailed,
      this.onVideoToggle,
      this.onAudioToggle,
      this.onReconnected,
      this.onMeetingEnd});

  final bool? videoEnabled;
  final bool? audioEnabled;
  final bool? isConnectionFailed;
  final VoidCallback? onVideoToggle;
  final VoidCallback? onAudioToggle;
  final VoidCallback? onReconnected;
  final VoidCallback? onMeetingEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.blueGrey[900],
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildControls(),
        ));
  }

  List<Widget> buildControls() {
    if (!isConnectionFailed!) {
      return <Widget>[
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.grey),
          child: IconButton(
            onPressed: onVideoToggle,
            icon: Icon(videoEnabled! ? Icons.videocam : Icons.videocam_off),
            color: Colors.white,
            iconSize: 32,
          ),
        ),
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.grey),
          child: IconButton(
            onPressed: onAudioToggle,
            icon: Icon(audioEnabled! ? Icons.mic : Icons.mic_off),
            color: Colors.white,
            iconSize: 32,
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.red),
          child: IconButton(
            icon: const Icon(
              Icons.call_end,
              color: Colors.white,
            ),
            onPressed: onMeetingEnd,
          ),
        )
      ];
    } else {
      return <Widget>[
        // FormHelper.submitButton('Reconnect', onReconnected!,
        //     btnColor: Colors.red, borderRadius: 10, width: 200, height: 40),
      ];
    }
  }
}
