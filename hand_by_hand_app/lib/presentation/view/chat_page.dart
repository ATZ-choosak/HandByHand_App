import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/data/models/chat/chat_model.dart';
import 'package:hand_by_hand_app/module/page_route.dart';
import 'package:hand_by_hand_app/presentation/bloc/chat_bloc/bloc/chat_bloc.dart';
import 'package:hand_by_hand_app/presentation/view/chat_view.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:hand_by_hand_app/presentation/widgets/profile_image_circle.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(GetChatSessionsEvent());

    List<ChatSession> sessions = [];

    return CustomScaffoldWithoutScroll(child: BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is GetChatSessionsSuccess) {
          sessions = state.sessions;
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<ChatBloc>().add(GetChatSessionsEvent());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "ข้อความ",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    return ChatItem(session: sessions[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.session,
  });

  final ChatSession session;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pageRoute(
            context,
            ChatView(
              user: session.user,
              chatId: session.id,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ProfileImageCircle(
                radius: 25,
                profileImage: session.user.profileImage,
                name: session.user.name),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.user.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(session.user.email)
              ],
            )
          ],
        ),
      ),
    );
  }
}
