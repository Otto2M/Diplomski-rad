import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/providers/user_provider.dart';
import 'package:povedi_me_app/screens/profile/pofile_view.dart';

class MyProfile extends ConsumerWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: userAsyncValue.when(
            data: (user) {
              if (user == null) {
                return Center(
                    child: Text(
                  'Korisnik nije prijavljen.',
                  style: AppTextStyles.description(context),
                  textAlign: TextAlign.center,
                ));
              }
              return ProfileView(user: user);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(
              child: Text('Došlo je do pogreške.',
                  style: AppTextStyles.errorText(context)),
            ),
          ),
        ),
      ),
    );
  }
}
