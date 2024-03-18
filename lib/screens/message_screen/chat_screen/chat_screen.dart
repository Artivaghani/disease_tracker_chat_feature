import 'package:disease_tracker/config/app_config.dart';
import 'package:disease_tracker/screens/message_screen/chat_screen/chat_controller.dart';
import 'package:disease_tracker/screens/message_screen/models/chat_model.dart';

class ChatScreen extends StatelessWidget {
  final String id;
  final String profile;
  ChatScreen({super.key, required this.id, required this.profile});

  final ChatController chatController = Get.put(ChatController());

  @override
  StatelessElement createElement() {
    chatController.isOnChat = true;
    chatController.addPaginationListerner(id);
    chatController.getChat(id);
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          chatController.isOnChat = false;
        }
      },
      child: Scaffold(
        appBar: AppWidgets.titleBar(AppStrings.chat),
        body: GetBuilder<ChatController>(builder: (controller) {
          return Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    StorageHelper().isDoctor
                        ? AppImages.patient
                        : AppImages.doctor,
                    height: Appdimens.dimen60,
                  ),
                  Expanded(
                      child: Text(StorageHelper().isDoctor ? pName : dName,
                              style: Get.theme.textTheme.headlineSmall)
                          .paddingSymmetric(
                    horizontal: Appdimens.dimen10,
                  )),
                  SvgPicture.asset(
                    AppImages.call,
                    height: Appdimens.dimen35,
                  )
                ],
              ),
              Expanded(
                  child: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.chatList.length,
                reverse: true,
                itemBuilder: (context, index) {
                  ChatModel chatModel = ChatModel.fromJson(
                      controller.chatList[index].data()
                          as Map<String, dynamic>);

                  bool isMe = chatModel.senderId ==
                      (StorageHelper().isDoctor
                          ? '${AppConst.doctor}101'
                          : '${AppConst.patient}102');
                  return getChatCard(chatModel, isMe);
                },
              ).paddingOnly(top: Appdimens.dimen20)),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: chatController.sendMsgController,
                      hintText: AppStrings.sendMessage,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: Appdimens.dimen16,
                          horizontal: Appdimens.dimen22),
                      borderRadius: BorderRadius.circular(Appdimens.dimen30),
                    ),
                  ),
                  SvgPicture.asset(AppImages.send)
                      .paddingOnly(left: Appdimens.dimen20)
                      .asButton(
                        onTap: () => chatController.sendMessage(id),
                      )
                ],
              ).paddingSymmetric(vertical: Appdimens.dimen10)
            ],
          ).paddingAll(Appdimens.dimen20);
        }),
      ),
    );
  }

  getChatCard(ChatModel chatModel, bool isMe) => Container(
        padding: EdgeInsets.all(Appdimens.dimen14),
        margin: EdgeInsets.only(
            bottom: Appdimens.dimen10,
            right: isMe ? 0 : Appdimens.dimenW250,
            left: isMe ? Appdimens.dimenW250 : 0),
        decoration: BoxDecoration(
            color: isMe
                ? AppColors.greenColor.withOpacity(0.2)
                : AppColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topLeft: isMe
                    ? Radius.circular(Appdimens.dimen10)
                    : const Radius.circular(0),
                bottomLeft: Radius.circular(Appdimens.dimen10),
                bottomRight: Radius.circular(Appdimens.dimen10),
                topRight: isMe
                    ? const Radius.circular(0)
                    : Radius.circular(Appdimens.dimen10))),
        child: Text(
          chatModel.msg ?? '',
          style: Get.theme.textTheme.headlineMedium,
        ).align(alignment: isMe ? Alignment.topRight : Alignment.topLeft),
      );
}
