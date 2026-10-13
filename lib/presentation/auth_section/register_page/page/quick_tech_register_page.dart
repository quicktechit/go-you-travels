import '../../../../core/constant/const.dart';
import '../widget/register_card.dart';
import '../widget/register_header.dart';
import '../widget/register_top_bar.dart';

class QuickTechRegisterPage extends ConsumerWidget {
  const QuickTechRegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Bar (Back to Login, Language, Dark/Light Mode Toggle)
              const RegisterTopBar(),
              SizedBox(height: 24.h),

              // Logo & App Header Branding
              const RegisterHeader(),
              SizedBox(height: 24.h),

              // Register Form Card Container
              const RegisterCard(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
