class FormModel {
  final String? _text;
  final String? _error;

  FormModel(this._text, this._error);

  String? get error => _error;
  String? get text => _text;
}
