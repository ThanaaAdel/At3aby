import 'package:ataaby/core/exports.dart';

class SearchTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final bool? enabled;
  final bool isMessage;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  //FocusNode myFocusNode = FocusNode();
  const SearchTextField({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.validator,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.isMessage = false,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onTap,
    this.isPassword = false,
    this.onSubmitted,
    this.borderRadius,
    this.enabled = true,  this.hintText,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  FocusNode myFocusNode = FocusNode();
  bool showPassword = false;
  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      setState(() {
        // color = Colors.black;
      });
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        expands: false,
        onTap: widget.onTap,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        focusNode: myFocusNode,
        style: getRegularStyle(),
        onChanged: widget.onChanged,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        maxLines: widget.isMessage ? 5 : 1,
        minLines: widget.isMessage ? 5 : 1,
        onFieldSubmitted: widget.onSubmitted,
        initialValue: widget.initialValue,
        obscureText: widget.isPassword ? !showPassword : false,
        decoration: InputDecoration(
            filled: true,
            fillColor: widget.enabled!
                ? AppColors.white
                : AppColors.gray.withOpacity(0.5),
            labelText: widget.labelText,
            labelStyle: getRegularStyle(
                fontHeight: 1.5,
                color: myFocusNode.hasFocus
                    ? AppColors.gray
                    : AppColors.grayLite),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? showPassword
                    ? IconButton(
                        icon: SvgPicture.asset(
                          widget.isPassword
                              ? ImageAssets.passwordIcon
                              : ImageAssets.passwordIcon,

                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      )
                    : IconButton(
                icon: SvgPicture.asset(
                  widget.isPassword
                      ? ImageAssets.passwordIcon
                      : ImageAssets.passwordIcon,

                ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        })
                : widget.suffixIcon,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18, vertical: 5.h),
            hintText: widget.hintText,
            hintStyle: getRegularStyle(
                color: AppColors.gray, fontSize: 15.sp),
            errorStyle: getRegularStyle(color: AppColors.red),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.grayLite, width: 1.5),
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8.r))),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.grayLite, width: 1.5),
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 10.r))),
            // focused border style
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.primary, width: 1.5),
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 10.r))),

            // error border style
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.red, width: 1.5),
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 10.r))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.red, width: 1.5),
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 10.r)))));
  }
}
