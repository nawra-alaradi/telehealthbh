extension ExtString on String {
  bool get isValidUsername {
    final nameRegExp = RegExp(r"^[A-Za-z]{1,}[0-9]{1,}$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp =
        RegExp(r'.{6,20}$'); // match any character including special character
    return passwordRegExp.hasMatch(this);
  }

  // modified
  // bool get isValidEmail {
  //   final emailRegExp = RegExp(r"^[a-zA-Z]+[0-9]+@[a-zA-Z]+\.[a-zA-Z]+");
  //   return emailRegExp.hasMatch(this);
  // }

  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegExp.hasMatch(this);
  }

//TODO: REVIEW THESE
  bool get isValidPersonalNumber {
    final personalNumberRegExp = RegExp(r"[0-9]{9}");
    return personalNumberRegExp.hasMatch(this);
  }

  bool get isValidBlockNumber {
    final blockNumberRegExp = RegExp(r"[0-9]{3,4}");
    return blockNumberRegExp.hasMatch(this);
  }

  bool get isValidDate {
    // final dateRegExp = RegExp(r"[0-9]{1,2}[/]{0-9]{1,2}[/][0-9]{4}");
    final dateRegExp = RegExp(
        r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$");
    return dateRegExp.hasMatch(this);
  }

//TODO: MODIFY CREDIT CARD NUMBER REGEXP
  bool get isValidCreditCardNumber {
    final creditCardRegExp = RegExp(r"^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}$");
    return creditCardRegExp.hasMatch(this);
  }

  bool get isValidMonth {
    final monthRegExp = RegExp(r"^(0?[1-9]|1[012])$");
    return monthRegExp.hasMatch(this);
  }

  bool get isValidYear {
    final yearRegExp = RegExp(r"^[0-9]{2}$");
    return yearRegExp.hasMatch(this);
  }

  bool get isValidCVC {
    final cvcRegExp = RegExp(r"^[0-9]{3}$");
    return cvcRegExp.hasMatch(this);
  }

  //TODO: MODIFY CHANNEL CODE REGEXP
  bool get isValidChannelCode {
    final channelCodeRegExp = RegExp(r"^[0-9]{9}$");
    return channelCodeRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegex = RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
    return nameRegex.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(
        r"^\+?[0-9]{3}\s?[0-9]{8}\s*$"); //form +97338389604  //trim the phone number
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidNationality {
    final nationalityRegExp = RegExp(r"[a-zA-Z]{4,}");
    return nationalityRegExp.hasMatch(this);
  }
}
