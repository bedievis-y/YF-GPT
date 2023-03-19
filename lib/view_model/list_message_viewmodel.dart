import 'package:flutter/material.dart';
import 'package:yf_gpt/model/message_model.dart';
import 'package:yf_gpt/services/message_model_service.dart';

class _ModelState {
  final List<MessageModel> items;
  bool stateLoading;

  _ModelState({
    this.items = const <MessageModel>[],
    this.stateLoading = false,
  });

  _ModelState copyWith({
    List<MessageModel>? items,
    bool? stateLoading,
  }) {
    return _ModelState(
      items: items ?? this.items,
      stateLoading: stateLoading ?? this.stateLoading,
    );
  }
}

class ListMessagesViewModel extends ChangeNotifier {
  var _state = _ModelState();

  _ModelState get state => _state;

  set state(_ModelState val) {
    _state = _state.copyWith(items: val.items);
    notifyListeners();
  }

  set stateLoading(bool val) {
    _state = _state.copyWith(stateLoading: val);
    notifyListeners();
  }

  sendMessage(String question) async {
    state.stateLoading = true;
    var list = state.items.toList();
    final apiResult = await MessageModelService().sendMessageToAPI(question);
    list.add(MessageModel(
      message: apiResult,
      sentByMe: false,
    ));
    state.stateLoading = false;
    state = state.copyWith(items: list);
  }

  sendMessageMe(String question) async {
    state.stateLoading = true;
    var list = state.items.toList();
    list.add(MessageModel(
      message: question,
      sentByMe: true,
    ));
    state.stateLoading = false;
    state = state.copyWith(items: list);
  }
}