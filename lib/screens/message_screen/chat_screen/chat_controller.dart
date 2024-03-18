import 'package:disease_tracker/config/app_config.dart';
import 'package:disease_tracker/screens/message_screen/models/chat_model.dart';
import 'package:disease_tracker/screens/message_screen/models/message_model.dart';

String pName = 'Aarti Vaghani';
String dName = 'Dr. Oleg Teterin';

class ChatController extends GetxController {
  bool isLoading = true;
  bool isOnChat = true;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController sendMsgController = TextEditingController();
  List<QueryDocumentSnapshot> chatList = [];
  ScrollController scrollController = ScrollController();
  bool isBlock = false;

  addPaginationListerner(String id) {
    scrollController.addListener(() => scrollListener(id));
  }

  getChat(String id, {bool isScroll = false}) {
    isLoading = true;
    update();
    CollectionReference<Map<String, dynamic>> colRef = firebaseFirestore
        .collection(AppConst.message)
        .doc(AppFunctions.getGroupId(id))
        .collection(AppFunctions.getGroupId(id));
    if (isScroll) {
      colRef
          .orderBy(AppConst.timestamp, descending: true)
          .startAfterDocument(chatList[chatList.length - 1])
          .limit(AppConst.limit)
          .get()
          .then((value) {
        chatList.addAll(value.docs);
        isLoading = false;
        update();
      }).onError((error, stackTrace) {
        isLoading = false;
        update();
      });
    } else {
      colRef
          .orderBy(AppConst.timestamp, descending: true)
          .limit(AppConst.limit)
          .snapshots()
          .listen((event) {
        chatList = event.docs;
        update();
        if (isOnChat) {
          setReadMsg(id, colRef);
        }
      });
      isLoading = false;
      update();
    }
  }

  setReadMsg(String id, CollectionReference<Map<String, dynamic>> colRef) {
    return colRef
        .where(AppConst.isRead, isEqualTo: false)
        .where(AppConst.senderId,
            isEqualTo: StorageHelper().isDoctor
                ? '${AppConst.patient}$id'
                : '${AppConst.doctor}$id')
        .get()
        .then((value) {
      for (var element in value.docs) {
        colRef.doc(element.id).update({AppConst.isRead: true});
      }
    });
  }

  sendMessage(String id) {
    if (sendMsgController.text.isNotEmpty) {
      DocumentReference reference = firebaseFirestore
          .collection(AppConst.message)
          .doc(AppFunctions.getGroupId(id));
      reference.set(MessageModel(
              pId: '102',
              dId: '101',
              timestamp: DateTime.now().toString(),
              lastMsg: sendMsgController.text,
              pName: pName,
              pProfile: '',
              dName: dName,
              dProfile: '',
              isBlock: isBlock)
          .toJson());

      firebaseFirestore.runTransaction((transaction) {
        return reference
            .collection(AppFunctions.getGroupId(id))
            .doc()
            .set(ChatModel(
                    senderId: StorageHelper().isDoctor
                        ? '${AppConst.doctor}101'
                        : '${AppConst.patient}102',
                    msg: sendMsgController.text,
                    isRead: false,
                    timestamp: DateTime.now().toString())
                .toJson())
            .then((value) {
          sendMsgController.text = '';
        });
      });
    }
  }

  scrollListener(String id) {
    if (isLoading) {
      return;
    }

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getChat(id, isScroll: true);
    }
  }

  @override
  void onClose() {
    isOnChat = false;
    super.onClose();
  }
}
