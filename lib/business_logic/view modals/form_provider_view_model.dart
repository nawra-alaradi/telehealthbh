import 'package:flutter/foundation.dart';
import 'package:telehealth_bh_app/business_logic/modals/form_model.dart';
import 'package:telehealth_bh_app/extension_class.dart';

class FormProvider extends ChangeNotifier {
  //FormModel username = FormModel(null, null);
  FormModel doctorPassword = FormModel(null, null);
  FormModel email = FormModel(null, null);
  FormModel emailForgotPassword = FormModel(null, null);
  FormModel personalNumber = FormModel(null, null);
  FormModel ekeyPersonalNumber = FormModel(null, null);
  FormModel patientPassword = FormModel(null, null);
  late FormModel IdExpirationDate = FormModel(null, null);
  FormModel blockNumber = FormModel(null, null);
  FormModel creditCardNumber = FormModel(null, null);
  FormModel cardMonth = FormModel(null, null);
  FormModel cardYear = FormModel(null, null);
  FormModel cardCVC = FormModel(null, null);
  FormModel channelCode = FormModel(null, null);

  validateDoctorPassword(String value) {
    if (value.isValidPassword) {
      doctorPassword = FormModel(value, null);
    } else {
      doctorPassword =
          FormModel(null, 'Password must \nbe 6-20 characters long');
    }
    notifyListeners();
  }

  validateEmail(String value) {
    if (value.isValidEmail) {
      email = FormModel(value, null);
    } else {
      email = FormModel(null, 'Please Enter a valid email');
    }
    notifyListeners();
  }

  validateEmailForgotPassword(String value) {
    if (value.isValidEmail) {
      emailForgotPassword = FormModel(value, null);
    } else {
      emailForgotPassword = FormModel(null, 'Please Enter a valid email');
    }
    notifyListeners();
  }

  validatePersonalNumber(String value) {
    personalNumber = (value.isValidPersonalNumber)
        ? FormModel(value, null)
        : FormModel(null, 'Please Enter a valid personal number');
    notifyListeners();
  }

  validateEkeyPersonalNumber(String value) {
    ekeyPersonalNumber = (value.isValidPersonalNumber)
        ? FormModel(value, null)
        : FormModel(null, 'Please Enter a valid personal number');
    notifyListeners();
  }

  validatePatientPassword(String value) {
    if (value.isValidPassword) {
      patientPassword = FormModel(value, null);
    } else {
      patientPassword =
          FormModel(null, 'Password must \nbe 6-20 characters long');
    }
    notifyListeners();
  }

  validateIdExpirationDate(String value) {
    if (value.isValidDate) {
      IdExpirationDate = FormModel(value, null);
    } else {
      IdExpirationDate =
          FormModel(null, 'Date must be in the format dd/mm/yyyy');
    }
    notifyListeners();
  }

  validateBlockNumber(String value) {
    blockNumber = (value.isValidBlockNumber)
        ? FormModel(value, null)
        : FormModel(null, 'Please enter a valid block number');
    notifyListeners();
  }

  validateCreditCardNumber(String value) {
    if (value.isValidCreditCardNumber) {
      creditCardNumber = FormModel(value, null);
    } else {
      creditCardNumber =
          FormModel(null, 'Please Enter a valid credit card number');
    }
    notifyListeners();
  }

  validateCreditCardMonth(String value) {
    if (value.isValidMonth) {
      cardMonth = FormModel(value, null);
    } else {
      cardMonth = FormModel(null, 'Invalid month');
    }
    notifyListeners();
  }

  validateCreditCardYear(String value) {
    if (value.isValidYear) {
      cardYear = FormModel(value, null);
    } else {
      cardYear = FormModel(null, 'Invalid year');
    }
    notifyListeners();
  }

  validateCreditCardCVC(String value) {
    if (value.isValidCVC) {
      cardMonth = FormModel(value, null);
    } else {
      cardCVC = FormModel(null, 'Invalid CVC');
    }
    notifyListeners();
  }

  validateChannelCode(String value) {
    if (value.isValidChannelCode) {
      channelCode = FormModel(value, null);
    } else {
      channelCode = FormModel(null, 'Invalid channel code');
    }
    notifyListeners();
  }

  bool get validateDoctorLoginScreen =>
      (email.text != null && doctorPassword.text != null);

  bool get validateEmailScreen => (emailForgotPassword.text != null);

  bool get validateCPRLoginScreen => (personalNumber.text != null &&
      IdExpirationDate.text != null &&
      blockNumber.text != null);

  bool get validateEkeyLoginScreen =>
      (ekeyPersonalNumber.text != null && patientPassword.text != null);

  //TODO: Add the dropdownbutton for credit  card type to this validation
  bool get validatePaymentScreen => (creditCardNumber.text != null &&
      cardMonth.text != null &&
      cardYear.text != null &&
      cardYear.text != null &&
      cardCVC.text != null);

  bool get validateConsultationScreen => (channelCode.text != null);
  void clearCache() {
    doctorPassword = FormModel(null, null);
    email = FormModel(null, null);
    personalNumber = FormModel(null, null);
    patientPassword = FormModel(null, null);
    IdExpirationDate = FormModel(null, null);
    blockNumber = FormModel(null, null);
    creditCardNumber = FormModel(null, null);
    cardMonth = FormModel(null, null);
    cardYear = FormModel(null, null);
    cardCVC = FormModel(null, null);
    channelCode = FormModel(null, null);
  }

  //used when user navigates back to cpr login screen
  void clearEkeyCredentials() {
    ekeyPersonalNumber = FormModel(null, null);
    patientPassword = FormModel(null, null);
  }

  void clearCPRCredentials() {
    personalNumber = FormModel(null, null);
    IdExpirationDate = FormModel(null, null);
    blockNumber = FormModel(null, null);
  }

  void clearDoctorCredentials() {
    email = FormModel(null, null);
    doctorPassword = FormModel(null, null);
  }

  void clearEmailForgotPassword() {
    emailForgotPassword = FormModel(null, null);
  }
}

//FormModel phone = FormModel(null, null);

// validateUsername(String value) {
//   if (value.isValidUsername) {
//     username = FormModel(value, null);
//   } else {
//     username = FormModel(null, 'Please Enter a Valid Name');
//   }
//   notifyListeners();
// }

/* Not needed for the time being
  validatePhone(String value) {
    if (value.isValidPhone) {
      phone = FormModel(value, null);
    } else {
      phone = FormModel(null, 'Phone number must be 11 digits');
    }
    notifyListeners();
  }*/
