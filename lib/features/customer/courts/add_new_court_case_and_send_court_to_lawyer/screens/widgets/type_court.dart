import 'package:ataaby/core/exports.dart';
import 'package:auto_size_text/auto_size_text.dart';

enum TypeCourt { legal_advice ,advocacy}

class TypeCourtCaseRatioExample extends StatefulWidget {
  const TypeCourtCaseRatioExample(
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
  final TypeCourt selectedValue; // External control for selected value
  final ValueChanged<TypeCourt?> onChanged; // Callback for changes

  @override
  State<TypeCourtCaseRatioExample> createState() => _TypeCourtCaseRatioExampleState();
}

class _TypeCourtCaseRatioExampleState extends State<TypeCourtCaseRatioExample> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 20.0),
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
                value: TypeCourt.legal_advice,
              ),
              _buildRadioOption(
                title: widget.titleFromRadioButtonSecond,
                description: widget.descriptionSecond,
                value: TypeCourt.advocacy,
              ),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildRadioOption(
                  title: widget.titleFromRadioButtonFirst,
                  description: widget.descriptionFirst,
                  value: TypeCourt.legal_advice,
                ),
              ),
              Expanded(
                child: _buildRadioOption(
                  title: widget.titleFromRadioButtonSecond,
                  description: widget.descriptionSecond,
                  value: TypeCourt.advocacy,
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
    required TypeCourt value,
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
      leading: Radio<TypeCourt>(
        fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
        value: value,
        groupValue: widget.selectedValue,
        onChanged: (TypeCourt? newValue) {
          setState(() {
            widget.onChanged(newValue);
          });
        },
      ),
    );
  }
}
