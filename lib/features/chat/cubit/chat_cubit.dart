import 'dart:developer';

import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/chat/cubit/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../data/model/create_chat_room.dart';
import '../data/model/message_model.dart';
import '../data/model/room_model.dart';
import '../data/repos/chat_repo.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(ChatInitial());
  ChatRepo chatRepo;

  //! Firebase

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
  List<MessageModel> messages = [];
  void listenForMessages(String chatId) {
    emit(LoadingGetNewMessagteState());
    _firestore
        .collection('rooms')
        .doc(chatId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((snapshot) {
      messages = snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList();
      log('messages length : ${messages.length}');
      emit(ChatLoaded(messages));
    });
  }
  //////////!

  bool isEmojiVisible = false;
  void toggleEmojiKeyboard() {
    isEmojiVisible = !isEmojiVisible;
    emit(OntoggleEmojiSocietyState());
  }

  ScrollController scrollController = ScrollController();

  void listenForMessagesWithScroll() {
    scrollController.animateTo(
      0,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  //////////!

  MainCreateChatRoomModel? createChatRoomModel;

  void createChatRoom({String? lawyerId, String? userId}) async {
    emit(LoadingCreateChatRoomState());
    final res =
        await chatRepo.createChatRoom(lawyerId: lawyerId, userId: userId);

    res.fold((l) {
      emit(ErrorCreateChatRoomState());
    }, (r) {
      messages = [];
      listenForMessages(r.data?.uuid ?? '');
      createChatRoomModel = r;
      emit(LoadedCreateChatRoomState());
    });
  }

  ChatRoomModel? chatRoomModel;
  void getChatRooms() async {
    emit(LoadingCreateChatRoomState());
    final res = await chatRepo.getChatRooms();
    res.fold((l) {
      emit(ErrorCreateChatRoomState());
    }, (r) {
      chatRoomModel = r;
      emit(LoadedCreateChatRoomState());
    });
  }

  File? pickedImage;

  /// Pick image from gallery or camera
  Future<void> pickImage(BuildContext context,
      {required bool isGallery, String? chatId}) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: isGallery ?
        ImageSource.gallery :
        ImageSource.camera,
      );
      if (pickedFile != null) {
        pickedImage = File(pickedFile.path);
        sendMessageWithImage(chatId: chatId);
      } else {
        emit(FilePickCancelled());
      }
    } catch (e) {
      emit(UpdateProfileError());
    } finally {
      Navigator.pop(context);
    }
  }

  void sendMessage({String? chatId}) async {
    emit(LoadingCreateChatRoomState());
    final res = await chatRepo.sendMessage(
      chatId: chatId,
      message: messageController.text,
      file: pickedImage,
    );

    res.fold((l) {
      emit(ErrorCreateChatRoomState());
    }, (r) {
      messageController.clear();

      listenForMessages(chatId ?? '');
      listenForMessagesWithScroll();
      pickedImage = null;

      emit(LoadedCreateChatRoomState());
    });
  }

  void sendMessageWithImage({String? chatId}) async {
    emit(LoadingCreate2ChatRoomState());
    final res = await chatRepo.sendMessage(
        chatId: chatId, file: pickedImage, message: '');

    res.fold((l) {
      emit(Error2CreateChatRoomState());
    }, (r) {
      listenForMessages(chatId ?? '');
      listenForMessagesWithScroll();
      pickedImage = null;
      messageController.clear();

      emit(LoadedCreate2ChatRoomState());
    });
  }
}

String extractTimeFromTimestamp(Timestamp timestamp) {
  // Convert Firestore Timestamp to DateTime
  DateTime dateTime = timestamp.toDate();

  // Create formatter for local timezone (or specify specific zone)
  DateFormat outputFormat = DateFormat('h:mm a');

  // Return formatted time string
  return outputFormat.format(dateTime);
}
