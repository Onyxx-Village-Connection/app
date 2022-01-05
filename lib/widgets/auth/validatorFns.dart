String? nameValidator(value) {
  if (value == null || value.isEmpty || value.length < 2) {
    return 'Please enter your name';
  }
  return null;
}

String? cityValidator(value) {
  if (value == null || value.isEmpty || value.length < 2) {
    return 'Please enter your city';
  }
  return null;
}

String? timeWithOVCValidator(value) {
  if (value == null || value.isEmpty || value.length < 2) {
    return 'Please enter how long you have been with OVC';
  }
  return null;
}
