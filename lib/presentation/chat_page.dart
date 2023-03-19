import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:yf_gpt/view_model/list_message_viewmodel.dart';

class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({super.key});

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<ListMessagesViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('YF GPT'),
        backgroundColor: Color.fromRGBO(140, 31, 164, 1),
      ),
      body: Column(
        children: [
          Expanded(
              child: _viewModel.state.items.isEmpty
                  ? Lottie.asset("asset/lottie/37270-robot-says-hi.json", repeat: true, reverse: true)
                  : MessagesListWidget(viewModel: _viewModel)),
          if (_viewModel.state.stateLoading)
            const LinearProgressIndicator(
              minHeight: 2,
            ),
          Container(
            height: 60,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: "Hi friend, how can i help you?",
                    border: InputBorder.none,
                  ),
                )),
                const SizedBox(
                  width: 16,
                ),
                FloatingActionButton(
                  backgroundColor: Color.fromRGBO(140, 31, 164, 1),
                  onPressed: () {
                    String question = messageController.text.toString();
                    if (question.isEmpty) return;
                    messageController.clear();
                    _viewModel.sendMessageMe(question);
                    _viewModel.sendMessage(question);
                  },
                  elevation: 0,
                  child: const Icon(
                    Icons.radio_button_on,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesListWidget extends StatelessWidget {
  const MessagesListWidget({
    super.key,
    required ListMessagesViewModel viewModel,
  }) : _viewModel = viewModel;

  final ListMessagesViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: _viewModel.state.items[index].sentByMe ? Alignment.topRight : Alignment.topLeft,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _viewModel.state.items[index].sentByMe ? Colors.blue[200] : Colors.grey.shade300,
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  _viewModel.state.items[index].message,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )),
          ),
        );
      },
      itemCount: _viewModel.state.items.length,
    );
  }
}
