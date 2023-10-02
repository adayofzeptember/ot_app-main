part of 'account_bloc.dart';

// ignore: must_be_immutable
class AccountState extends Equatable {
  AccountState({
    required this.email,
    required this.urlProfile,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.birthDate,
    required this.joinDate,
    required this.department,
    required this.segment,
    required this.versionApp,
    required this.announcement,
    required this.birthDateEdit,
    required this.gender,
  });
  String urlProfile, firstname, lastname, phone, birthDate, joinDate, department, segment, email;
  String versionApp;
  String birthDateEdit, gender;
  AnnouncementModel announcement;
  AccountState copyWith({
    String? email,
    String? urlProfile,
    String? firstname,
    String? lastname,
    String? phone,
    String? birthDate,
    String? joinDate,
    String? department,
    String? segment,
    String? versionApp,
    AnnouncementModel? announcement,
    String? birthDateEdit,
    String? gender,
  }) {
    return AccountState(
      email: email ?? this.email,
      urlProfile: urlProfile ?? this.urlProfile,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      joinDate: joinDate ?? this.joinDate,
      department: department ?? this.department,
      segment: segment ?? this.segment,
      versionApp: versionApp ?? this.versionApp,
      announcement: announcement ?? this.announcement,
      birthDateEdit: birthDateEdit ?? this.birthDateEdit,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object> get props => [
        urlProfile,
        firstname,
        lastname,
        phone,
        birthDate,
        joinDate,
        department,
        segment,
        versionApp,
        announcement,
        birthDateEdit,
        gender,
      ];
}
