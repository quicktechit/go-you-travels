import '../../../../core/constant/const.dart';
import '../model/visa_file_model.dart';

class VisaFileState {
  final String selectedTab; // All, Approved, Processing, Rejected, Completed, Cancelled
  final String searchQuery;
  final List<VisaFileItem> files;

  const VisaFileState({
    this.selectedTab = 'All',
    this.searchQuery = '',
    this.files = const [],
  });

  int countForTab(String tab) {
    if (tab.startsWith('All')) return files.length;
    final clean = tab.split(' (').first.trim().toLowerCase();
    return files.where((f) => f.status.label.toLowerCase() == clean).length;
  }

  List<VisaFileItem> get filteredFiles {
    return files.where((item) {
      if (selectedTab != 'All' && !selectedTab.startsWith('All')) {
        final cleanTab = selectedTab.split(' (').first.trim().toLowerCase();
        if (item.status.label.toLowerCase() != cleanTab) {
          return false;
        }
      }
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        return item.fileId.toLowerCase().contains(query) ||
            item.clientName.toLowerCase().contains(query) ||
            item.country.toLowerCase().contains(query) ||
            item.visaCategory.toLowerCase().contains(query);
      }
      return true;
    }).toList();
  }

  VisaFileState copyWith({
    String? selectedTab,
    String? searchQuery,
    List<VisaFileItem>? files,
  }) {
    return VisaFileState(
      selectedTab: selectedTab ?? this.selectedTab,
      searchQuery: searchQuery ?? this.searchQuery,
      files: files ?? this.files,
    );
  }
}

final quickTechVisaFilesProvider =
    StateNotifierProvider<QuickTechVisaFilesNotifier, VisaFileState>((ref) {
  return QuickTechVisaFilesNotifier();
});

class QuickTechVisaFilesNotifier extends StateNotifier<VisaFileState> {
  QuickTechVisaFilesNotifier()
      : super(const VisaFileState(
          selectedTab: 'All',
          files: [
            VisaFileItem(
              fileId: 'VF-2024-002',
              clientName: 'Dr. Sabrina Chowdhury',
              visaCategory: 'Visitor & Work Permit',
              country: 'Canada',
              applicationType: 'Individual',
              status: VisaFileStatus.approved,
              currentStepIndex: 4,
              collectedDocsCount: 8,
              totalDocsCount: 8,
              targetTravelDate: '2026-10-25',
              packagePrice: 6200.0,
              paidAmount: 6200.0,
              dueAmount: 0.0,
            ),
            VisaFileItem(
              fileId: 'VF-2024-001',
              clientName: 'Mahmudul Hasan',
              visaCategory: 'Umrah Visa',
              country: 'Saudi Arabia',
              applicationType: 'Family (4 Persons)',
              status: VisaFileStatus.processing,
              currentStepIndex: 3,
              collectedDocsCount: 8,
              totalDocsCount: 7,
              targetTravelDate: '2026-11-10',
              packagePrice: 3500.0,
              paidAmount: 2000.0,
              dueAmount: 1500.0,
            ),
            VisaFileItem(
              fileId: 'VF-2024-003',
              clientName: 'Tariqul Anowar',
              visaCategory: 'Student Visa',
              country: 'United Kingdom',
              applicationType: 'Individual',
              status: VisaFileStatus.rejected,
              currentStepIndex: 2,
              collectedDocsCount: 6,
              totalDocsCount: 8,
              targetTravelDate: '2026-09-15',
              packagePrice: 5000.0,
              paidAmount: 3000.0,
              dueAmount: 2000.0,
            ),
            VisaFileItem(
              fileId: 'VF-2024-004',
              clientName: 'Nusrat Jahan',
              visaCategory: 'B1/B2 Tourist Visa',
              country: 'USA',
              applicationType: 'Individual',
              status: VisaFileStatus.cancelled,
              currentStepIndex: 1,
              collectedDocsCount: 4,
              totalDocsCount: 8,
              targetTravelDate: '2026-12-01',
              packagePrice: 4200.0,
              paidAmount: 1000.0,
              dueAmount: 3200.0,
            ),
          ],
        ));

  void setSelectedTab(String tab) {
    state = state.copyWith(selectedTab: tab);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateFileStatus(String fileId, VisaFileStatus newStatus) {
    final updatedList = state.files.map((file) {
      if (file.fileId == fileId) {
        int newStep = file.currentStepIndex;
        if (newStatus == VisaFileStatus.approved) newStep = 4;
        if (newStatus == VisaFileStatus.processing) newStep = 2;
        if (newStatus == VisaFileStatus.submitted) newStep = 3;
        if (newStatus == VisaFileStatus.newFile) newStep = 0;

        Fluttertoast.showToast(msg: "Status updated to ${newStatus.label}");
        return file.copyWith(
          status: newStatus,
          currentStepIndex: newStep,
        );
      }
      return file;
    }).toList();

    state = state.copyWith(files: updatedList);
  }

  void addDocument(String fileId, String docTitle, String docType) {
    final updatedList = state.files.map((file) {
      if (file.fileId == fileId) {
        final newDoc = VisaDocumentItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: docTitle,
          type: docType,
          uploadedDate: DateTime.now().toString().split(' ').first,
        );
        final newDocs = [...file.documents, newDoc];
        Fluttertoast.showToast(msg: "Document uploaded successfully");
        return file.copyWith(
          documents: newDocs,
          collectedDocsCount: file.collectedDocsCount + 1,
        );
      }
      return file;
    }).toList();

    state = state.copyWith(files: updatedList);
  }
}
