import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:yf_gpt/utils/constants.dart';

class MessageModelService {
  static final openAI = OpenAI.instance.build(
      token: apiToken,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 30),
      ),
      isLogger: true);

  Future<String> sendMessageToAPI(String question) async {
    final request = CompleteText(
      prompt: question,
      model: kTextDavinci3,
      maxTokens: 2000,
    );

    try {
      final response = await openAI.onCompletion(request: request);
      String answer = response?.choices.last.text.trim() ?? "";
      return answer;
    } catch (e) {
      return 'Check the internet connection';
    }
  }
}
