class UserFormModel {
  int? id;
  int? userId;
  String? fullAcademicName;
  String? academicTitle;
  String? givenNames;
  String? orcid;
  String? professionalEmail;
  String? department;
  String? institution;
  String? city;
  String? country;
  String? correspondingAuthor;
  String? correspondenceAddress;
  String? researchInterests;
  String? conceptualisation;
  String? surgicalProcedureAndVideo;
  String? abstractPreparation;
  String? editingAndNarration;
  String? finalApproval;
  String? acknowledgements;
  String? declarations;
  String? ethicalApprovalInstitution;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserFormModel({
    this.id,
    this.userId,
    this.fullAcademicName,
    this.academicTitle,
    this.givenNames,
    this.orcid,
    this.professionalEmail,
    this.department,
    this.institution,
    this.city,
    this.country,
    this.correspondingAuthor,
    this.correspondenceAddress,
    this.researchInterests,
    this.conceptualisation,
    this.surgicalProcedureAndVideo,
    this.abstractPreparation,
    this.editingAndNarration,
    this.finalApproval,
    this.acknowledgements,
    this.declarations,
    this.ethicalApprovalInstitution,
    this.createdAt,
    this.updatedAt,
  });

  factory UserFormModel.fromJson(Map<String, dynamic> json) => UserFormModel(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        fullAcademicName: json['full_academic_name'] as String?,
        academicTitle: json['academic_title'] as String?,
        givenNames: json['given_names'] as String?,
        orcid: json['orcid'] as String?,
        professionalEmail: json['professional_email'] as String?,
        department: json['department'] as String?,
        institution: json['institution'] as String?,
        city: json['city'] as String?,
        country: json['country'] as String?,
        correspondingAuthor: json['corresponding_author'] as String?,
        correspondenceAddress: json['correspondence_address'] as String?,
        researchInterests: json['research_interests'] as String?,
        conceptualisation: json['conceptualisation'] as String?,
        surgicalProcedureAndVideo:
            json['surgical_procedure_and_video'] as String?,
        abstractPreparation: json['abstract_preparation'] as String?,
        editingAndNarration: json['editing_and_narration'] as String?,
        finalApproval: json['final_approval'] as String?,
        acknowledgements: json['acknowledgements'] as String?,
        declarations: json['declarations'] as String?,
        ethicalApprovalInstitution:
            json['ethical_approval_institution'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'full_academic_name': fullAcademicName,
        'academic_title': academicTitle,
        'given_names': givenNames,
        'orcid': orcid,
        'professional_email': professionalEmail,
        'department': department,
        'institution': institution,
        'city': city,
        'country': country,
        'corresponding_author': correspondingAuthor,
        'correspondence_address': correspondenceAddress,
        'research_interests': researchInterests,
        'conceptualisation': conceptualisation,
        'surgical_procedure_and_video': surgicalProcedureAndVideo,
        'abstract_preparation': abstractPreparation,
        'editing_and_narration': editingAndNarration,
        'final_approval': finalApproval,
        'acknowledgements': acknowledgements,
        'declarations': declarations,
        'ethical_approval_institution': ethicalApprovalInstitution,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
