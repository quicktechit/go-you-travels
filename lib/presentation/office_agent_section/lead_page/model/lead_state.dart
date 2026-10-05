import 'lead_model.dart';

class QuickTechLeadState {
  final String searchQuery;
  final String selectedStatusTab;
  final String filterPriority;
  final String filterCountry;
  final String filterSource;
  final List<LeadItem> leads;

  const QuickTechLeadState({
    this.searchQuery = '',
    this.selectedStatusTab = 'All Leads',
    this.filterPriority = 'Any Priority',
    this.filterCountry = 'All',
    this.filterSource = 'All',
    this.leads = const [],
  });

  QuickTechLeadState copyWith({
    String? searchQuery,
    String? selectedStatusTab,
    String? filterPriority,
    String? filterCountry,
    String? filterSource,
    List<LeadItem>? leads,
  }) {
    return QuickTechLeadState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedStatusTab: selectedStatusTab ?? this.selectedStatusTab,
      filterPriority: filterPriority ?? this.filterPriority,
      filterCountry: filterCountry ?? this.filterCountry,
      filterSource: filterSource ?? this.filterSource,
      leads: leads ?? this.leads,
    );
  }

  // Helper Getters for statistics
  int get totalLeadsCount => leads.length;

  int get convertedCount =>
      leads.where((l) => l.status == LeadStatus.converted).length;

  int get convertedPercentage {
    if (leads.isEmpty) return 0;
    return ((convertedCount / leads.length) * 100).round();
  }

  int get newInquiriesCount =>
      leads.where((l) => l.status == LeadStatus.newLead).length;

  int get followUpsDueCount =>
      leads.where((l) => l.status == LeadStatus.followUp).length;

  int get hotLeadsCount => leads
      .where((l) =>
          l.priority == LeadPriority.high || l.priority == LeadPriority.urgent)
      .length;

  int get contactedCount =>
      leads.where((l) => l.status == LeadStatus.contacted).length;

  int get interestedCount =>
      leads.where((l) => l.status == LeadStatus.interested).length;

  int get notInterestCount =>
      leads.where((l) => l.status == LeadStatus.notInterest).length;

  int get notReachableCount =>
      leads.where((l) => l.status == LeadStatus.notReachable).length;

  int get lostCount =>
      leads.where((l) => l.status == LeadStatus.lost).length;

  // Filtered Leads according to active filters
  List<LeadItem> get filteredLeads {
    return leads.where((lead) {
      // 1. Search Query Filter
      if (searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        final matchesName = lead.name.toLowerCase().contains(q);
        final matchesPhone = lead.phone.toLowerCase().contains(q);
        final matchesCountry =
            lead.destinationCountry.toLowerCase().contains(q);
        final matchesVisa = lead.visaInterest.toLowerCase().contains(q);
        if (!matchesName && !matchesPhone && !matchesCountry && !matchesVisa) {
          return false;
        }
      }

      // 2. Status Tab Filter
      if (selectedStatusTab != 'All Leads') {
        final cleanTab = selectedStatusTab.contains(' (')
            ? selectedStatusTab.split(' (').first
            : selectedStatusTab;

        if (cleanTab == 'New' && lead.status != LeadStatus.newLead) return false;
        if (cleanTab == 'Contacted' && lead.status != LeadStatus.contacted) return false;
        if (cleanTab == 'Interested' && lead.status != LeadStatus.interested) return false;
        if (cleanTab == 'Follow-up' && lead.status != LeadStatus.followUp) return false;
        if (cleanTab == 'Converted' && lead.status != LeadStatus.converted) return false;
        if (cleanTab == 'Not Interested' && lead.status != LeadStatus.notInterest) return false;
        if (cleanTab == 'Not Reachable' && lead.status != LeadStatus.notReachable) return false;
        if (cleanTab == 'Lost' && lead.status != LeadStatus.lost) return false;
      }

      // 3. Filter Priority
      if (filterPriority != 'Any Priority') {
        if (lead.priority.label.toLowerCase() !=
            filterPriority.toLowerCase()) {
          return false;
        }
      }

      // 4. Filter Country
      if (filterCountry != 'All') {
        if (!lead.destinationCountry
            .toLowerCase()
            .contains(filterCountry.toLowerCase())) {
          return false;
        }
      }

      // 5. Filter Source
      if (filterSource != 'All') {
        if (!lead.leadSource
            .toLowerCase()
            .contains(filterSource.toLowerCase())) {
          return false;
        }
      }

      return true;
    }).toList();
  }
}
