import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/chat/chat_model.dart';
import 'package:hand_by_hand_app/data/source/socket_service.dart';
import 'package:hand_by_hand_app/presentation/bloc/chat_bloc/bloc/chat_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:hand_by_hand_app/presentation/widgets/profile_image_circle.dart';
import 'package:hand_by_hand_app/service_locator.dart.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.user, required this.chatId});

  final User user;
  final String chatId;

  @override
  ChatViewState createState() => ChatViewState();
}

class ChatViewState extends State<ChatView> {
  late List<ChatMessage> messages;
  late TextEditingController chatController;
  final FocusNode _focusNode =
      FocusNode(); // Focus node to track the keyboard state
  final ScrollController _scrollController =
      ScrollController(); // ScrollController for the chat list
  bool isManualRefresh = false; // Flag to track manual refresh
  final SocketService socketService = getIt<SocketService>();

  @override
  void initState() {
    super.initState();
    messages = [];
    chatController = TextEditingController();

    // Fetch messages when entering the chat screen
    BlocProvider.of<ChatBloc>(context)
        .add(GetMessageEvent(chatId: widget.chatId));

    socketService.joinRoom(widget.chatId);

    // Add a listener to detect when the TextField gains or loses focus
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // If the keyboard is hidden and refresh was triggered by something else, skip refresh
        setState(() {
          isManualRefresh = false;
        });
      }
    });
  }

  @override
  void dispose() {
    chatController.dispose();
    _focusNode.dispose();
    _scrollController.dispose(); // Dispose of the ScrollController
    super.dispose();
    socketService.socket.off('new_message');
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    socketService.socket.on('new_message', (data) {
      if (data['room'] == widget.chatId) {
        setState(() {
          isManualRefresh = true;
        });
        context.read<ChatBloc>().add(GetMessageEvent(chatId: widget.chatId));
      }
    });

    return CustomScaffoldWithoutScroll(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            ProfileImageCircle(
                profileImage: widget.user.profileImage, name: widget.user.name),
            const SizedBox(width: 10),
            Text(
              widget.user.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          // Chat messages or content
          Expanded(
            child: Container(
              color: Colors.white,
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is GetMessageSuccess) {
                    messages = state.messages;
                    // Scroll to the bottom when messages are loaded
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });
                  }

                  if (state is SendMessageSuccess) {
                    // Scroll to the bottom when a new message is sent
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        isManualRefresh = true;
                      });
                      context
                          .read<ChatBloc>()
                          .add(GetMessageEvent(chatId: widget.chatId));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        controller:
                            _scrollController, // Attach the ScrollController to the ListView
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          if (messages[index].senderIsMe) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          topRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(18),
                                          bottomRight: Radius.circular(18),
                                        ),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.4),
                                        child: Text(
                                          messages[index].message,
                                          softWrap: true,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileImageCircle(
                                    profileImage:
                                        messages[index].sender.profileImage,
                                    name: messages[index].sender.name),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(18),
                                          bottomLeft: Radius.circular(18),
                                          bottomRight: Radius.circular(18),
                                        ),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.4),
                                        child: Text(
                                          messages[index].message,
                                          softWrap: true,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // TextField and Send button at the bottom
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
            child: Row(
              children: [
                // Expanded TextField to avoid overflow
                Expanded(
                  child: SizedBox(
                    height: 35,
                    child: TextField(
                      controller: chatController,
                      focusNode: _focusNode,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        hintText: "Aa",
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      context.read<ChatBloc>().add(SendMessageInputEvent(
                          chatId: widget.chatId, message: chatController.text));
                      chatController.text = "";
                      socketService.sendMessage(widget.chatId);
                    },
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
