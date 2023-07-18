import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_docbook/constants/routes.dart';
import 'package:flutter_docbook/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_docbook/services/auth/bloc/auth_event.dart';
import 'package:flutter_docbook/services/auth/bloc/auth_state.dart';
import 'package:flutter_docbook/services/auth/firebase_auth_provider.dart';
import 'package:flutter_docbook/views/login_view.dart';
import 'package:flutter_docbook/views/notes/create_update_note_view.dart';
import 'package:flutter_docbook/views/notes/notes_view.dart';
import 'package:flutter_docbook/views/register_view.dart';
import 'package:flutter_docbook/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView()
      },
    );
  }
}

// ========================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthStateLoggedIn) {
        return const NotesView();
      } else if (state is AuthStateNeedsVerification) {
        return const VerifyEmailView();
      } else if (state is AuthStateLoggedOut) {
        return const LoginView();
      } else if (state is AuthStateRegistering) {
        return const RegisterView();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    });
  }
}
