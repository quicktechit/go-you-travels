import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../dashboard_page/provider/local_agent_dashboard_provider.dart';
import '../../dashboard_page/widget/submit_client_modal.dart';
import '../widget/client_card_item.dart';

class QuickTechLocalAgentMyClientPage extends HookConsumerWidget {
  const QuickTechLocalAgentMyClientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(localAgentDashboardProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final searchController = useTextEditingController();
    final searchQuery = useState('');

    final filteredClients = state.submittedClients.where((client) {
      if (searchQuery.value.isEmpty) return true;
      final query = searchQuery.value.toLowerCase();
      return client.name.toLowerCase().contains(query) ||
          client.country.toLowerCase().contains(query) ||
          client.visaType.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: const CustomAppbar(
        title: 'Clients',
        subtitle: 'Go You Travels',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 90.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              AppTextField(
                controller: searchController,
                onChanged: (val) => searchQuery.value = val,

                prefixIcon: Icons.search_rounded,
                hint:  'Search by name, passport, country, phone...',
              ),
              SizedBox(height: 16.h),

              // Clients List
              if (filteredClients.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Text(
                      'No clients found matching your search.',
                      style: GoogleFonts.figtree(
                        fontSize: 14.sp,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
              else
                ...filteredClients.map(
                  (client) => ClientCardItem(client: client),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: .only(bottom: 50),
        child: FloatingActionButton(
          onPressed: () => SubmitClientModal.show(context),
          backgroundColor: AppColors.primary,
          elevation: 4,
          child: Icon(
            Icons.person_add_rounded,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
