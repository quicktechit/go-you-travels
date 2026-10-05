import 'package:flutter/material.dart';

enum VisaFileStatus {
  newFile('New', Color(0xFF2563EB), Color(0xFFEFF6FF)),
  docPending('Document Pending', Color(0xFFEA580C), Color(0xFFFFF7ED)),
  docCollected('Document Collected', Color(0xFF0D9488), Color(0xFFF0FDFA)),
  processing('Processing', Color(0xFF7E22CE), Color(0xFFF3E8FF)),
  submitted('Submitted', Color(0xFF1D4ED8), Color(0xFFEFF6FF)),
  underReview('Under Review', Color(0xFFD97706), Color(0xFFFEF3C7)),
  approved('Approved', Color(0xFF047857), Color(0xFFECFDF5)),
  rejected('Rejected', Color(0xFFDC2626), Color(0xFFFEF2F2)),
  completed('Completed', Color(0xFF059669), Color(0xFFECFDF5)),
  cancelled('Cancelled', Color(0xFF64748B), Color(0xFFF1F5F9));

  final String label;
  final Color textColor;
  final Color bgColor;

  const VisaFileStatus(this.label, this.textColor, this.bgColor);
}

class VisaDocumentItem {
  final String id;
  final String title;
  final String type;
  final String uploadedDate;

  const VisaDocumentItem({
    required this.id,
    required this.title,
    required this.type,
    required this.uploadedDate,
  });
}

class VisaFileItem {
  final String fileId;
  final String clientName;
  final String visaCategory;
  final String country;
  final String applicationType; // e.g. Individual, Family (4 Persons)
  final VisaFileStatus status;
  final int currentStepIndex; // 0 to 4 (New, Documents, Processing, Submitted, Review)
  final int collectedDocsCount;
  final int totalDocsCount;
  final String targetTravelDate;
  final double packagePrice;
  final double paidAmount;
  final double dueAmount;
  final List<VisaDocumentItem> documents;

  const VisaFileItem({
    required this.fileId,
    required this.clientName,
    required this.visaCategory,
    required this.country,
    required this.applicationType,
    required this.status,
    required this.currentStepIndex,
    required this.collectedDocsCount,
    required this.totalDocsCount,
    required this.targetTravelDate,
    required this.packagePrice,
    required this.paidAmount,
    required this.dueAmount,
    this.documents = const [],
  });

  VisaFileItem copyWith({
    String? fileId,
    String? clientName,
    String? visaCategory,
    String? country,
    String? applicationType,
    VisaFileStatus? status,
    int? currentStepIndex,
    int? collectedDocsCount,
    int? totalDocsCount,
    String? targetTravelDate,
    double? packagePrice,
    double? paidAmount,
    double? dueAmount,
    List<VisaDocumentItem>? documents,
  }) {
    return VisaFileItem(
      fileId: fileId ?? this.fileId,
      clientName: clientName ?? this.clientName,
      visaCategory: visaCategory ?? this.visaCategory,
      country: country ?? this.country,
      applicationType: applicationType ?? this.applicationType,
      status: status ?? this.status,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      collectedDocsCount: collectedDocsCount ?? this.collectedDocsCount,
      totalDocsCount: totalDocsCount ?? this.totalDocsCount,
      targetTravelDate: targetTravelDate ?? this.targetTravelDate,
      packagePrice: packagePrice ?? this.packagePrice,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      documents: documents ?? this.documents,
    );
  }
}
