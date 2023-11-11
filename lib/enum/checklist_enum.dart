class ChecklistEnum {

  static getCigarette(String cigarette) {
    if (cigarette == "SMOKER") {
      return "흡연자";
    } else {
      return "비흡연자";
    }

  }

  static getType(String type) {
    if (type == "ACTIVE") {
      return "활동적";
    } else {
      return "소극적";
    }
  }

  static getHabit(String habit) {
    if (habit == "NONE") {
      return "코골이 없음";
    } else if (habit == "MILD") {
      return "코골이 약간";
    } else {
      return "코골이 심함";
    }
  }
}