import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yf_gpt/presentation/chat_page.dart';
import 'package:yf_gpt/view_model/list_message_viewmodel.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListMessagesViewModel(),
      child: const MaterialApp(
        title: 'YG GPT',
        debugShowCheckedModeBanner: false,
        home: ChatGptScreen(),
      ),
    );
  }
}
