import 'package:cardamom_care/models/chat_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();
  static Future<HiveService> init() async {
    final hiveService = HiveService._();
    hiveService.box = Hive.isBoxOpen('chats')
        ? hiveService.getBoxinstance()
        : await hiveService.openBox();
    return hiveService;
  }

  HiveService.dispose() {
    closeBox();
  }

  late Box<ChatModel> box;

  //Open the box
  Future<Box<ChatModel>> openBox() async {
    return Hive.openBox<ChatModel>('chats');
  }

  //get box istance
  getBoxinstance() {
    return Hive.box<ChatModel>('chats');
  }

  //insert values to the box
  isertIntoBox({required ChatModel chat}) async {
    await box.add(chat);
  }

  //get all the messages stored in the box
  List<ChatModel> getChats() {
    return box.values.toList().cast<ChatModel>();
  }

  //delete all the messages from the box
  deleteAllMessages() async {
    await box.clear();
    return box.values.toList().cast<ChatModel>();
  }

  //closes the box instance
  closeBox() async {
    await box.close();
  }
}
