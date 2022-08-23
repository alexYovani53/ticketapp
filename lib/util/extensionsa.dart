
extension StringExtensions on String {

  bool isWhiteSpace() => this.trim().isEmpty;

  
  bool isValidLeng() => this.toString().length>4;

  
  bool isNumber() => int.tryParse(this)!=null;

}
