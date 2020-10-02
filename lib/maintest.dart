class Test {
  String name;
  set newName(String name) {
    this.name = name;
  }

  bool canSubmit() {
    if (name == null) {
      return false;
    } else {
      return true;
    }
  }
}
