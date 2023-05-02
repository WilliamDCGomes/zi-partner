import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MasksForTextFields {
  static final loginMask = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-Z0-9]'),
  );
  static final phoneNumberMask = MaskTextInputFormatter(
      mask: '(##) ####-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  static final phoneNumberAcceptExtraNumberMask = MaskTextInputFormatter(
      mask: '(##) ####-#####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  static final cellPhoneNumberMask = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  static final cepMask = MaskTextInputFormatter(
      mask: '#####-###',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  static final cpfMask = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  static final birthDateMask = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  static final shirtDateMask = MaskTextInputFormatter(
      mask: '##/##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  static final cardNumberMask = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  static final cvcCodeMask = MaskTextInputFormatter(
      mask: '###',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
}