import 'package:authentication_firebase/core/theme/app_colors.dart';
import 'package:authentication_firebase/core/util/input_decoration.dart';
import 'package:flutter/material.dart';

class StandardTextFormField extends StatefulWidget {
  final String label;
  final String? initialValue;
  final bool hasObscureText;
  final int? maxLength;

  final FormFieldValidator<String?>? validator;
  final void Function(String? value)? onChanged;
  final void Function(String? value)? onFieldSubmitted;

  final FocusNode? focusNode;

  const StandardTextFormField({
    Key? key,
    required this.label,
    this.initialValue,
    this.hasObscureText = false,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  @override
  State<StandardTextFormField> createState() => _StandardTextFormFieldState();
}

class _StandardTextFormFieldState extends State<StandardTextFormField> {
  GlobalKey<FormFieldState> defaultFieldKey = GlobalKey<FormFieldState>();

  bool isTextObscured = false;
  bool isInvalid = false;

  @override
  void initState() {
    isTextObscured = widget.hasObscureText;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) setState(() => isInvalid = false);
        defaultFieldKey.currentState?.validate();
      },
      child: Builder(builder: (context) {
        return TextFormField(
          key: defaultFieldKey,
          initialValue: widget.initialValue ?? '',
          obscureText: isTextObscured,
          maxLength: widget.maxLength,
          decoration: getFormFieldDecoration(widget.label).copyWith(
            suffixIcon: widget.hasObscureText
                ? IconButton(
                    icon: Icon(
                      isTextObscured ? Icons.visibility : Icons.visibility_off,
                      color: isInvalid ? AppColors.red900 : null,
                    ),
                    onPressed: () => setState(() => isTextObscured = !isTextObscured),
                  )
                : null,
          ),
          validator: (value) {
            if (FocusScope.of(context).hasFocus) return null;

            final validation = widget.validator != null ? widget.validator!(value) : null;
            setState(() => isInvalid = validation != null);

            return validation;
          },
          textInputAction: TextInputAction.next,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          buildCounter: widget.maxLength == null
              ? null
              : (_, {required currentLength, maxLength, required isFocused}) {
                  return Container(
                      transform: Matrix4.translationValues(13, 0, 0),
                      child: Text(
                        '$currentLength/$maxLength',
                        style: TextStyle(color: isInvalid ? AppColors.red900 : AppColors.grey600),
                      ));
                },
        );
      }),
    );
  }
}
