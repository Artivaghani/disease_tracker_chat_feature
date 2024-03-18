import 'package:disease_tracker/config/app_config.dart';
import 'package:disease_tracker/extension/time_exten.dart';
import 'package:disease_tracker/screens/message_screen/models/message_model.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => AppWidgets.exitDialog(),
      child: Scaffold(
        appBar: AppWidgets.titleBar(StorageHelper().isDoctor
            ? AppStrings.patients
            : AppStrings.doctors),
        body: GetBuilder<MessageController>(
            init: MessageController(),
            builder: (controller) {
              return ListView(
                children: [
                  if (!controller.isDismiss && StorageHelper().isDoctor)
                    AppWidgets.cardContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppStrings.pMsg,
                            textAlign: TextAlign.start,
                            style: Get.theme.textTheme.displaySmall,
                          ),
                          AppWidgets.getGradintText(AppStrings.dismiss)
                              .paddingOnly(top: Appdimens.dimen30)
                              .asButton(onTap: () {
                            controller.isDismiss = true;
                            controller.update();
                          })
                        ],
                      ),
                    ),
                  getSearchView(controller),
                  getTabView(controller),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.getUserList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return AppWidgets.getLoadingView()
                              .paddingSymmetric(vertical: Appdimens.dimen50);
                        } else if ((snapshot.connectionState ==
                                    ConnectionState.done ||
                                snapshot.connectionState ==
                                    ConnectionState.active) &&
                            snapshot.data != null) {
                          QuerySnapshot<Map<String, dynamic>>? data =
                              snapshot.data;
                          if (data!.docs.isEmpty) {
                            return AppWidgets.getDataNotFoundView()
                                .paddingSymmetric(vertical: Appdimens.dimen50);
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getRecentView(controller, data),
                                getAllMessages(controller, data),
                              ],
                            );
                          }
                        } else {
                          return AppWidgets.getDataNotFoundView()
                              .paddingSymmetric(vertical: Appdimens.dimen50);
                        }
                      }),
                ],
              ).paddingAll(Appdimens.dimen20);
            }),
      ),
    );
  }

  getSearchView(MessageController controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
                  height: Appdimens.dimen50,
                  child: AppTextField(
                    hintText: AppStrings.searchHint,
                    suffixIcon: SvgPicture.asset(
                      AppImages.search,
                      height: Appdimens.dimen20,
                      width: Appdimens.dimen20,
                    ).paddingAll(Appdimens.dimen16),
                  ))
              .paddingOnly(
                  top: (controller.isDismiss || !StorageHelper().isDoctor)
                      ? 0
                      : Appdimens.dimen50),
          Row(
            children: [
              SvgPicture.asset(AppImages.help),
              Text(
                AppStrings.searchHint1,
                style: Get.theme.textTheme.headlineMedium,
              ).paddingOnly(left: Appdimens.dimen6)
            ],
          ).paddingOnly(top: Appdimens.dimen8)
        ],
      );

  getTabView(MessageController controller) => Container(
        margin: EdgeInsets.only(top: Appdimens.dimen30),
        height: Appdimens.dimen40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.tabList.length,
          itemBuilder: (context, index) => AppWidgets.cardContainer(
                  borderRadius: BorderRadius.circular(Appdimens.dimen20),
                  margin: EdgeInsets.only(right: Appdimens.dimen18),
                  padding: EdgeInsets.symmetric(
                      vertical: Appdimens.dimen4,
                      horizontal: Appdimens.dimen20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        controller.tabList[index]['icon'],
                        // ignore: deprecated_member_use
                        color: AppColors.secondaryColor,
                        width: Appdimens.dimen18,
                        height: Appdimens.dimen18,
                      ),
                      Text(
                        controller.tabList[index]['title'],
                        style: Get.theme.textTheme.headlineMedium,
                      ).paddingOnly(left: Appdimens.dimen8),
                      if (index == 0)
                        Container(
                          margin: EdgeInsets.only(left: Appdimens.dimen10),
                          padding: EdgeInsets.symmetric(
                              horizontal: Appdimens.dimen8,
                              vertical: Appdimens.dimen2),
                          decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius:
                                  BorderRadius.circular(Appdimens.dimen20)),
                          child: Text(
                            '99+',
                            style: Get.theme.textTheme.headlineMedium,
                          ),
                        )
                    ],
                  ))
              .asButton(
                  onTap: () => AppDialogs.showCommonDialog(
                      AppWidgets.getDialogView('Alert', AppStrings.alterMsg),
                      isOk: true)),
        ),
      );

  getRecentView(
      MessageController controller, QuerySnapshot<Map<String, dynamic>> data) {
    List<MessageModel> recentList = [];
    for (var element in data.docs) {
      MessageModel model = MessageModel.fromJson(element.data());
      DateTime now = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, DateTime.now().hour - 5);
      DateTime newTime = DateTime.parse(model.timestamp ?? '');
      bool isRecent = newTime.isAfter(now);
      if (isRecent) {
        recentList.add(model);
      }
    }
    return recentList.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.recent,
                style: Get.theme.textTheme.displayLarge,
              ),
              ListView.builder(
                itemCount: recentList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return getMessageCard(recentList[index], controller,
                      isRecent: true);
                },
              ).paddingOnly(top: Appdimens.dimen20)
            ],
          ).paddingOnly(top: Appdimens.dimen30)
        : const SizedBox();
  }

  getMessageCard(MessageModel messageModel, MessageController controller,
          {bool isRecent = false}) =>
      Row(
        children: [
          Image.asset(
            StorageHelper().isDoctor ? AppImages.patient : AppImages.doctor,
            height: Appdimens.dimen60,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  (StorageHelper().isDoctor
                          ? messageModel.pName
                          : messageModel.dName) ??
                      '',
                  style: Get.theme.textTheme.displayMedium),
              Text(
                messageModel.lastMsg ?? '',
                style: Get.theme.textTheme.headlineMedium,
              ).paddingOnly(top: Appdimens.dimen2),
            ],
          ).paddingSymmetric(
            horizontal: Appdimens.dimen10,
          )),
          Column(
            children: [
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.getReadMsg((StorageHelper().isDoctor
                          ? messageModel.pId
                          : messageModel.dId) ??
                      ''),
                  builder: (context, snapshot) {
                    List<QueryDocumentSnapshot> nonSeenList = [];
                    if (snapshot.hasData && snapshot.data != null) {
                      nonSeenList = snapshot.data!.docs;
                    }

                    if (nonSeenList.isEmpty) {
                      return SvgPicture.asset(
                        AppImages.chat,
                        height: Appdimens.dimen20,
                      );
                    } else {
                      return SizedBox(
                        height: Appdimens.dimen30,
                        width: Appdimens.dimen30,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.unreadChat,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Center(
                                child: Text(
                                  nonSeenList.length.toString(),
                                  textAlign: TextAlign.center,
                                  style: Get.theme.textTheme.titleMedium,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }),
              if (messageModel.timestamp != null && isRecent)
                Text(
                  DateTime.parse(
                    messageModel.timestamp!,
                  ).timeAgo(),
                  style: Get.theme.textTheme.headlineMedium,
                ).paddingOnly(top: Appdimens.dimen10),
            ],
          ),
        ],
      ).paddingOnly(bottom: Appdimens.dimen16).asButton(
            onTap: () => Get.to(ChatScreen(
              id: (StorageHelper().isDoctor
                      ? messageModel.pId
                      : messageModel.dId) ??
                  '',
              profile: '',
            )),
          );

  getAllMessages(MessageController controller,
          QuerySnapshot<Map<String, dynamic>> data) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.allPatients,
            style: Get.theme.textTheme.displayLarge,
          ),
          AppWidgets.getRichText(AppStrings.recentFirst,
                  str2: AppStrings.tapFilter)
              .paddingOnly(top: Appdimens.dimen2),
          ListView.builder(
            itemCount: data.docs.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return getMessageCard(
                  MessageModel.fromJson(data.docs[index].data()), controller);
            },
          ).paddingOnly(top: Appdimens.dimen20),
        ],
      ).paddingOnly(top: Appdimens.dimen30);
}
