import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_catalog_app/cubits/auth/auth_cubit.dart';
import 'package:ecommerce_catalog_app/cubits/auth/auth_state.dart';
import 'package:ecommerce_catalog_app/cubits/profile/profile_cubit.dart';
import 'package:ecommerce_catalog_app/cubits/profile/profile_state.dart';
import 'package:ecommerce_catalog_app/widgets/state_widgets.dart';
import 'package:ecommerce_catalog_app/screens/auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthCubit>().currentUserId;

    return BlocProvider(
      create: (_) => ProfileCubit()..fetchUserData(uid ?? ''),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLogoutSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading || state is ProfileInitial) {
                return const LoadingWidget();
              }

              if (state is ProfileError) {
                return ErrorDisplayWidget(
                  message: state.message,
                  onRetry: () =>
                      context.read<ProfileCubit>().fetchUserData(uid ?? ''),
                );
              }

              if (state is ProfileLoaded) {
                final user = state.user;

                return RefreshIndicator(
                  onRefresh: () async {
                    await context.read<ProfileCubit>().fetchUserData(uid ?? '');
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Text(
                            user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                            style: const TextStyle(fontSize: 36, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _ProfileInfoTile(icon: Icons.person, label: 'Name', value: user.name),
                        _ProfileInfoTile(icon: Icons.phone, label: 'Phone', value: user.phone),
                        _ProfileInfoTile(icon: Icons.email, label: 'Email', value: user.email),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, authState) {
                              final isLoading = authState is AuthLoading;
                              return ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                                icon: isLoading
                                    ? const SizedBox.shrink()
                                    : const Icon(Icons.logout),
                                label: isLoading
                                    ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                    : const Text('Logout'),
                                onPressed: isLoading
                                    ? null
                                    : () => context.read<AuthCubit>().logout(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label; // تم تعديلها لتكون منفصلة وصحيحة
  final String value;

  const _ProfileInfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}