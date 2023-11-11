class KycEnum {

  static getJob(String job) {
    if (job == "STUDENT") {
      return "학생";
    } else if (job == "OFFICEWORKER") {
      return "직장인";
    } else {
      return "무직";
    }
  }

  static getResult(int result) {
    if (result == 0) {
      return "DENIAL";
    } else if (result == 1) {
      return "REJECT";
    } else {
      return "APPROVE";
    }
  }

}