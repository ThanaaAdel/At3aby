import 'package:ataaby/core/exports.dart';
import 'package:auto_size_text/auto_size_text.dart';

enum SingingCharacter { individual, office }

enum TypeCourt { legal_advice, advocacy }

class RadioExample extends StatefulWidget {
  const RadioExample(
      {super.key,
      required this.titleFromRadioButtonFirst,
      required this.titleFromRadioButtonSecond,
      this.descriptionFirst,
      this.descriptionSecond,
      required this.headerTitle,
      this.isVertical = true,
      this.padding,
      required this.selectedValue,
      required this.onChanged});

  final String titleFromRadioButtonFirst;
  final String titleFromRadioButtonSecond;
  final String? descriptionFirst;
  final String? descriptionSecond;
  final String headerTitle;
  final bool isVertical;
  final EdgeInsetsGeometry? padding;
  final SingingCharacter selectedValue; // External control for selected value
  final ValueChanged<SingingCharacter?> onChanged; // Callback for changes

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Title
          Text(
            widget.headerTitle,
            style: TextStyle(fontSize: 15.0.sp),
          ),
          widget.isVertical
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRadioOption(
                      title: widget.titleFromRadioButtonFirst,
                      description: widget.descriptionFirst,
                      value: SingingCharacter.individual,
                    ),
                    _buildRadioOption(
                      title: widget.titleFromRadioButtonSecond,
                      description: widget.descriptionSecond,
                      value: SingingCharacter.office,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: _buildRadioOption(
                        title: widget.titleFromRadioButtonFirst,
                        description: widget.descriptionFirst,
                        value: SingingCharacter.individual,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: _buildRadioOption(
                        title: widget.titleFromRadioButtonSecond,
                        description: widget.descriptionSecond,
                        value: SingingCharacter.office,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildRadioOption({
    required String title,
    String? description,
    required SingingCharacter value,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            title,
            style: TextStyle(fontSize: 13.0.sp),
          ),
          if (description != null)
            AutoSizeText(
              description,
              style: TextStyle(
                fontSize: 12.0.sp,
                color: Colors.grey,
              ),
            ),
        ],
      ),
      leading: Radio<SingingCharacter>(
        fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
        value: value,
        groupValue: widget.selectedValue,
        onChanged: (SingingCharacter? newValue) {
          widget.onChanged(newValue);
        },
      ),
    );
  }
}
