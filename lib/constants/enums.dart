enum MaritalStatus { married, unmarried, divorced, widow }

enum ReligionEnum { muslim, chritian }

enum GenderEnum { male, female, others, preferNotToSay }

enum HowDidYouHereAboutUs { friends, onlineAdds, socialMedia, others }

String maritalStatus(MaritalStatus maritalStatus) {
  switch (maritalStatus) {
    case MaritalStatus.married:
      return "Married";
    case MaritalStatus.divorced:
      return "Divorced";
    case MaritalStatus.unmarried:
      return "Un-Married";
    case MaritalStatus.widow:
      return "Widow";
  }
}
