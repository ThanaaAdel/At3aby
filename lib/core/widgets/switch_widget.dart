import 'package:flutter/material.dart';

class StyledSwitch extends StatefulWidget {
  final void Function(bool isToggled) onToggled;
  final bool status; // Add a status parameter

  const StyledSwitch({
    super.key,
    required this.onToggled,
    required this.status, // Require the status parameter
  });

  @override
  State<StyledSwitch> createState() => _StyledSwitchState();
}

class _StyledSwitchState extends State<StyledSwitch> {
  late bool isToggled; // Change to late since it will be initialized in initState
  double size = 30;
  double innerPadding = 0;

  @override
  void initState() {
    isToggled = widget.status; // Initialize isToggled based on the status
    innerPadding = size / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled); // Pass the new status to the callback
      },
      onPanEnd: (b) {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled); // Pass the new status to the callback
      },
      child: AnimatedContainer(
        height: size * 0.9,
        width: size * 1.4,
        padding: EdgeInsets.all(innerPadding),
        alignment: isToggled ? Alignment.centerLeft : Alignment.centerRight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isToggled ? Colors.blue.shade100 : Colors.grey.shade300,
        ),
        child: Container(
          width: size - innerPadding * 2,
          height: size - innerPadding * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: isToggled ? Colors.blue.shade600 : Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}