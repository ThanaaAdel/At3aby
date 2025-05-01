import 'package:audioplayers/audioplayers.dart';

import '../../../../../../core/exports.dart';
import '../../cubit/Sos_lawyers_cubit.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioFilePath;

  const AudioPlayerWidget({
    super.key,
    required this.audioFilePath,
  });

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  double _currentPosition = 0.0;
  double _totalDuration = 1.0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onPositionChanged.listen((duration) {
      setState(() {
        _currentPosition = duration.inMilliseconds.toDouble();
      });
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration.inMilliseconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPauseAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(widget.audioFilePath));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Waveform (as a slider representing audio progress)
        Expanded(
          child: Slider(
            value: _currentPosition,
            activeColor: AppColors.primary,
            max: _totalDuration,
            onChanged: (value) async {
              setState(() {
                _currentPosition = value;
              });
              await _audioPlayer.seek(Duration(milliseconds: value.toInt()));
            },
          ),
        ),
        // Audio play/pause button
        IconButton(
          icon: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            color: AppColors.primary,
          ),
          onPressed: _playPauseAudio,
        ),
        InkWell(
          onTap: () {
            context.read<SosLawyersCubit>().clearRecordedFilePath();
          },
          child: Icon(
            Icons.close,
            color: AppColors.red,
          ),
        ),
      ],
    );
  }
}
