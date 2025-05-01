import 'package:ataaby/core/exports.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import 'message_screen.dart';

class RoomScreen extends StatefulWidget {
  RoomScreen({this.isLawyer = false, super.key});
  bool isLawyer;
  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  void initState() {
    context.read<ChatCubit>().getChatRooms();
    print('RoomScreen');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        var cubit = context.read<ChatCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text('rooms'.tr()),
          ),
          body: (state is LoadingCreateChatRoomState)
              ? const Center(child: RefreshProgressIndicator())
              : (state is ErrorCreateChatRoomState)
                  ? const Center(child: CircularProgressIndicator())
                  : cubit.chatRoomModel?.data?.length == 0
                      ? Center(
                          child: Text(
                            'no_rooms'.tr(),
                            style: getRegularStyle(),
                          ),
                        )
                      : ListView.builder(
                          itemCount: cubit.chatRoomModel?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Material(
                              color: Colors.white,
                              shadowColor: Colors.grey,
                              elevation: 1,
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(cubit
                                                .chatRoomModel
                                                ?.data?[index]
                                                .user
                                                ?.image ??
                                            ''),
                                      ),
                                      Flexible(
                                          child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 8.0),
                                        child: Text(
                                          cubit.chatRoomModel?.data?[index].user
                                                  ?.name ??
                                              '',
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  //

                                  Navigator.pushNamed(
                                    context,
                                    Routes.messageRoute,
                                    arguments: MainUserAndRoomChatModel(
                                      isLawyer: widget.isLawyer,
                                      chatId: cubit
                                          .chatRoomModel?.data?[index].uuid
                                          .toString(),
                                    ),
                                  );

                                  //
                                },
                              ),
                            );
                          }),
        );
      },
    );
  }
}
