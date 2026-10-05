import '../../../core/constant/const.dart';
import '../widget/login_card.dart';
import '../widget/login_header.dart';
import '../widget/login_top_bar.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Bar (Status, Language, Dark/Light Mode Toggle)
              const LoginTopBar(),
              SizedBox(height: 28.h),

              // Logo & App Header Branding
              const LoginHeader(),
              SizedBox(height: 28.h),

              // Login Form Card Container
              const LoginCard(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
