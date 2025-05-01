import 'package:ataaby/core/exports.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';

import '../current_issues/data/model/main_sos_court.dart';

class SosCourCaseDetails extends StatefulWidget {
  const SosCourCaseDetails({super.key, this.sosCourCaseDetails});
  final MainSosCourtCasesModelDatum? sosCourCaseDetails;

  @override
  State<SosCourCaseDetails> createState() => _SosCourCaseDetailsState();
}

class _SosCourCaseDetailsState extends State<SosCourCaseDetails> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  Future<void> _playAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer
          .play(UrlSource(widget.sosCourCaseDetails?.voice ?? ""));
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _position = Duration.zero;
      _isPlaying = false;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                ImageAssets.smallAppbarImage,
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 10.0.h, top: 30.0.h, right: 5.w, left: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.white,
                        size: 30.sp,
                      ),
                    ),
                    Text(
                      "Distress_issues".tr(),
                      style: getRegularStyle(color: AppColors.white),
                    ),
                    Image.asset(
                      ImageAssets.coloredLogoImage,
                      height: 60.h,
                      width: 60.w,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18.sp * textScaleFactor(context),
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "${'the_problem'.tr()}: ",
                          style: TextStyle(
                              color: AppColors.primary), // Title color
                        ),
                        TextSpan(
                          text: widget.sosCourCaseDetails?.problem ?? "",
                          style: TextStyle(
                              color: AppColors.secondPrimary), // Data color
                        ),
                      ],
                    ),
                  ),
                ),
                20.h.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18.sp * textScaleFactor(context),
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "${'phone'.tr()}: ",
                          style: TextStyle(
                              color: AppColors.primary), // Title color
                        ),
                        TextSpan(
                          text: widget.sosCourCaseDetails?.phone ?? "",
                          style: TextStyle(
                              color: AppColors.secondPrimary), // Data color
                        ),
                      ],
                    ),
                  ),
                ),
                5.h.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18.sp * textScaleFactor(context),
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "${'address'.tr()}: ",
                          style: TextStyle(
                              color: AppColors.primary), // Title color
                        ),
                        TextSpan(
                          text: widget.sosCourCaseDetails?.address ?? "",
                          style: TextStyle(
                              color: AppColors.secondPrimary), // Data color
                        ),
                      ],
                    ),
                  ),
                ),
                10.h.verticalSpace,
                !(widget.sosCourCaseDetails?.voice == null ||
                        widget.sosCourCaseDetails!.voice!.contains('.png'))
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Slider(
                            min: 0,
                            activeColor: AppColors.primary,
                            max: _duration.inSeconds.toDouble(),
                            value: _duration.inSeconds.toDouble() > 0
                                ? _position.inSeconds
                                    .toDouble()
                                    .clamp(0, _duration.inSeconds.toDouble())
                                : 0,
                            onChanged: (value) async {
                              final newPosition =
                                  Duration(seconds: value.toInt());
                              await _audioPlayer.seek(newPosition);
                              setState(() {
                                _position = newPosition;
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(_isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow),
                                iconSize: 50,
                                onPressed: _playAudio,
                              ),
                              IconButton(
                                icon: Icon(Icons.stop),
                                iconSize: 50,
                                onPressed: _stopAudio,
                              ),
                            ],
                          ),
                          Text(
                            '${_position.toString().split('.')[0]} / ${_duration.toString().split('.')[0]}',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
