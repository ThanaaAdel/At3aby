import 'package:ataaby/core/exports.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final double? borderRadius;
  final bool? enabled;
  final bool isMessage;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String titleFromTextFormField;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleStyle;
  //FocusNode myFocusNode = FocusNode();
  const CustomTextField({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.validator,
    this.titleStyle,
    this.suffixIcon,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.isMessage = false,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onTap,
    this.isPassword = false,
    this.onSubmitted,
    this.borderRadius,
    this.enabled = true,
    required this.titleFromTextFormField,
    this.hintText,
    this.padding,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
    return Padding(
      padding: widget.padding ??
          EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(widget.titleFromTextFormField,
              style: widget.titleStyle ?? getRegularStyle(fontSize: 15.sp)),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
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
              maxLines: widget.isMessage ? 4 : 1,
              minLines: widget.isMessage ? 4 : 1,
              onFieldSubmitted: widget.onSubmitted,
              initialValue: widget.initialValue,
              obscureText: widget.isPassword ? !showPassword : false,
              decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      widget.enabled! ? AppColors.white : AppColors.grayLite,
                  labelText: widget.labelText,
                  labelStyle: getRegularStyle(
                      fontHeight: 1.2,
                      color: myFocusNode.hasFocus
                          ? AppColors.gray
                          : AppColors.grayLite),
                  suffix: widget.suffix,
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
                  hintStyle: !widget.enabled!
                      ? getRegularStyle(
                          color: AppColors.blackLight, fontSize: 15.sp)
                      : getRegularStyle(color: AppColors.gray, fontSize: 15.sp),
                  errorStyle: getRegularStyle(color: AppColors.red),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.grayLite, width: 1.5),
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius ?? 15.r))),
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.grayLite, width: 1.5),
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
                          Radius.circular(widget.borderRadius ?? 10.r))))),
        ],
      ),
    );
  }
}
