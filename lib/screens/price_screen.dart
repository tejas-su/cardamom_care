import 'package:cardamom_care/blocs/chat_bloc/chat_bloc.dart';
import 'package:cardamom_care/blocs/chat_bloc/query_field_cubit.dart';
import 'package:cardamom_care/models/chat_model.dart';
import 'package:cardamom_care/utils/stylesheet.dart';
import 'package:cardamom_care/widgets/loading_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class PricePredictionScreen extends StatefulWidget {
  const PricePredictionScreen({super.key});

  @override
  State<PricePredictionScreen> createState() => _PricePredictionScreenState();
}

class _PricePredictionScreenState extends State<PricePredictionScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    controller = TextEditingController();

    super.initState();
  }

  late TextEditingController controller;

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Send message on pressed
    onPressed() {
      String text = controller.text;
      controller.clear();
      context.read<ChatBloc>().add(OnSendQueryEvent(query: text));
      context
          .read<QueryFieldCubit>()
          .canSendMessage(canSend: false); //Disable the textfield
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade100,
          title: const Text(
            'CardamomCare',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
                onPressed: () =>
                    context.read<ChatBloc>().add(OnDeleteAllChatsEvent()),
                icon: Icon(Icons.delete_rounded))
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(children: [
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return switch (state) {
                  //Loading indicator to show when the chats are loading
                  ChatLoadingState() =>
                    Expanded(child: Center(child: CircularProgressIndicator())),
                  //Display the messages in a list view
                  ChatLoadedState() => Expanded(
                      child: ListView.builder(
                        itemCount: state.isRecieving
                            ? state.chats.length + 1
                            : state.chats.length,
                        itemBuilder: (context, index) {
                          context.read<QueryFieldCubit>().canSendMessage(
                              canSend: !state
                                  .isRecieving); //enable the text field once the response has come
                          if (index < state.chats.length) {
                            ChatModel chat = state.chats[index];
                            bool isSender = chat.sender == 'user';

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: Align(
                                alignment: isSender
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.sizeOf(context).width /
                                                1.2),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: isSender
                                              ? Radius.circular(8)
                                              : Radius.circular(0),
                                          bottomRight: isSender
                                              ? Radius.circular(0)
                                              : Radius.circular(8)),
                                      color: Theme.of(context).highlightColor,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        isSender
                                            ? Text(
                                                chat.query ?? '',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontSize: 16),
                                              )
                                            : Markdown(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                selectable: true,
                                                padding: EdgeInsets.all(0),
                                                softLineBreak: true,
                                                shrinkWrap: true,
                                                data: isSender
                                                    ? chat.query ?? ''
                                                    : chat.response ?? '',
                                                styleSheet: markDownStyleSheet,
                                              )
                                      ],
                                    )),
                              ),
                            );
                          } else {
                            return LoadingResponse();
                          }
                        },
                      ),
                    ),
                  ChatErrorState() => Expanded(
                      child: Center(
                        child: Text(state.errorMessage),
                      ),
                    ),
                };
              },
            ),
            BlocBuilder<QueryFieldCubit, bool>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: TextField(
                    enabled: state,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    controller: controller,
                    minLines: 1,
                    maxLines: 10,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: onPressed,
                            icon: Icon(Icons.send_rounded)),
                        contentPadding: EdgeInsets.all(20),
                        filled: true,
                        fillColor: Theme.of(context)
                            .navigationBarTheme
                            .backgroundColor,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        hintText: 'Chat with CardamomCare',
                        border: InputBorder.none),
                  ),
                );
              },
            )
          ]),
        ));
  }
}
