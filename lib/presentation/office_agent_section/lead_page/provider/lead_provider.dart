import '../../../../core/constant/const.dart';
import '../model/lead_model.dart';
import '../model/lead_state.dart';

final quickTechLeadProvider =
    StateNotifierProvider<QuickTechLeadNotifier, QuickTechLeadState>((ref) {
  return QuickTechLeadNotifier();
});

class QuickTechLeadNotifier extends StateNotifier<QuickTechLeadState> {
  QuickTechLeadNotifier()
      : super(QuickTechLeadState(
          leads: [
            LeadItem(
              id: '1',
              name: 'Zubair Hossain',
              phone: '+61 400 123 456',
              destinationCountry: 'Australia',
              visaInterest: 'Higher Education Student Visa',
              leadSource: 'Walk-in',
              status: LeadStatus.converted,
              priority: LeadPriority.low,
              notes: 'Initial inquiry for Australia Masters program.',
              createdAt: DateTime.now().subtract(const Duration(days: 5)),
            ),
            LeadItem(
              id: '2',
              name: 'Mahfuzur Rahman',
              phone: '+1 437 889 2100',
              destinationCountry: 'Canada',
              visaInterest: 'Express Entry & Work Visa',
              leadSource: 'Facebook Ads',
              status: LeadStatus.newLead,
              priority: LeadPriority.urgent,
              notes: 'Needs urgent guidance on CRS score calculation.',
              createdAt: DateTime.now().subtract(const Duration(hours: 3)),
            ),
            LeadItem(
              id: '3',
              name: 'Anika Tabassum',
              phone: '+44 7700 900077',
              destinationCountry: 'United Kingdom',
              visaInterest: 'Student Visa (Tier 4)',
              leadSource: 'Google Search',
              status: LeadStatus.contacted,
              priority: LeadPriority.high,
              notes: 'Sent list of UK target universities.',
              createdAt: DateTime.now().subtract(const Duration(days: 1)),
            ),
            LeadItem(
              id: '4',
              name: 'Tanvir Ahmed',
              phone: '+49 151 23456789',
              destinationCountry: 'Schengen (Germany)',
              visaInterest: 'Job Seeker Visa',
              leadSource: 'Local Agent',
              status: LeadStatus.followUp,
              priority: LeadPriority.medium,
              notes: 'Follow-up scheduled regarding German block account.',
              createdAt: DateTime.now().subtract(const Duration(days: 2)),
            ),
            LeadItem(
              id: '5',
              name: 'Nusrat Jahan',
              phone: '+1 212 555 0198',
              destinationCountry: 'USA',
              visaInterest: 'B1/B2 Tourist Visa',
              leadSource: 'Referral',
              status: LeadStatus.interested,
              priority: LeadPriority.high,
              notes: 'Interested in family visit visa assistance.',
              createdAt: DateTime.now().subtract(const Duration(days: 3)),
            ),
            LeadItem(
              id: '6',
              name: 'Sajjad Hossain',
              phone: '+61 412 345 678',
              destinationCountry: 'Australia',
              visaInterest: 'General Skilled Migration',
              leadSource: 'Walk-in',
              status: LeadStatus.converted,
              priority: LeadPriority.low,
              notes: 'PR application submitted successfully.',
              createdAt: DateTime.now().subtract(const Duration(days: 7)),
            ),
          ],
        ));

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setSelectedStatusTab(String tab) {
    state = state.copyWith(selectedStatusTab: tab);
  }

  void applyFilters({
    required String priority,
    required String country,
    required String source,
  }) {
    state = state.copyWith(
      filterPriority: priority,
      filterCountry: country,
      filterSource: source,
    );
  }

  void resetFilters() {
    state = state.copyWith(
      filterPriority: 'Any Priority',
      filterCountry: 'All',
      filterSource: 'All',
    );
  }

  void addNewLead(LeadItem lead) {
    state = state.copyWith(
      leads: [lead, ...state.leads],
    );
    Fluttertoast.showToast(msg: "Lead '${lead.name}' created successfully!");
  }

  void saveCallLog({
    required String leadId,
    required String callResult,
    required String followUpTime,
    required String notes,
  }) {
    LeadStatus? newStatus;
    if (callResult == 'Interested') {
      newStatus = LeadStatus.interested;
    } else if (callResult == 'Not Reachable') {
      newStatus = LeadStatus.notReachable;
    } else if (callResult == 'Not Interested') {
      newStatus = LeadStatus.notInterest;
    } else if (callResult == 'Busy / Call Back' || callResult == 'Scheduled Visit') {
      newStatus = LeadStatus.followUp;
    }

    state = state.copyWith(
      leads: state.leads.map((lead) {
        if (lead.id == leadId) {
          final updatedNotes = notes.isNotEmpty
              ? "${lead.notes != null && lead.notes!.isNotEmpty ? '${lead.notes}\n' : ''}[Call Result: $callResult | Follow-up: $followUpTime] $notes"
              : lead.notes;
          return lead.copyWith(
            status: newStatus ?? lead.status,
            nextFollowUpDate: followUpTime,
            notes: updatedNotes,
          );
        }
        return lead;
      }).toList(),
    );

    Fluttertoast.showToast(msg: "Call log saved for lead");
  }

  void updateLeadStatus(String leadId, LeadStatus newStatus) {
    state = state.copyWith(
      leads: state.leads.map((lead) {
        if (lead.id == leadId) {
          return lead.copyWith(status: newStatus);
        }
        return lead;
      }).toList(),
    );
    Fluttertoast.showToast(msg: "Lead status updated to ${newStatus.label}");
  }

  void updateLeadPriority(String leadId, LeadPriority newPriority) {
    state = state.copyWith(
      leads: state.leads.map((lead) {
        if (lead.id == leadId) {
          return lead.copyWith(priority: newPriority);
        }
        return lead;
      }).toList(),
    );
    Fluttertoast.showToast(msg: "Lead priority updated to ${newPriority.label}");
  }

  void updateLeadSchedule({
    required String leadId,
    required String followUpTime,
    required String notes,
  }) {
    state = state.copyWith(
      leads: state.leads.map((lead) {
        if (lead.id == leadId) {
          final newHistoryItem = FollowUpHistoryItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: 'Schedule Updated',
            loggedBy: 'Current Agent',
            note: notes.isNotEmpty ? notes : 'Follow-up schedule updated.',
            nextFollowUp: followUpTime,
            timeAgo: 'Just now',
          );
          return lead.copyWith(
            nextFollowUpDate: followUpTime,
            notes: notes.isNotEmpty ? notes : lead.notes,
            history: [newHistoryItem, ...lead.history],
          );
        }
        return lead;
      }).toList(),
    );
    Fluttertoast.showToast(msg: "Schedule update saved successfully!");
  }
}
