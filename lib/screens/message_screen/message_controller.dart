import 'package:disease_tracker/config/app_config.dart';

class MessageController extends GetxController {
  bool isDismiss = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserList() {
    if (StorageHelper().isDoctor) {
      return firebaseFirestore
          .collection(AppConst.message)
          .where(AppConst.dId, isEqualTo: '101')
          .orderBy(AppConst.timestamp, descending: true)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection(AppConst.message)
          .where(AppConst.pId, isEqualTo: '102')
          .orderBy(AppConst.timestamp, descending: true)
          .snapshots();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getReadMsg(String id) {
    return firebaseFirestore
        .collection(AppConst.message)
        .doc(AppFunctions.getGroupId(id))
        .collection(AppFunctions.getGroupId(id))
        .where(AppConst.isRead, isEqualTo: false)
        .where(AppConst.senderId,
            isEqualTo: StorageHelper().isDoctor
                ? '${AppConst.patient}$id'
                : '${AppConst.doctor}$id')
        .snapshots();
  }

  List<Map> tabList = [
    {'icon': AppImages.chat, 'title': 'Chats'},
    {'icon': AppImages.unread, 'title': 'Unread'},
    {'icon': AppImages.archiv, 'title': 'Archive'},
  ];
}
