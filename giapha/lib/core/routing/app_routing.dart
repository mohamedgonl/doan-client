import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:le_hoi_module/le_hoi_module.dart';
// // import 'package:le_hoi_module/le_hoi_module/le_hoi/model/model_lehoi.dart';
// // import 'package:le_hoi_module/le_hoi_module/le_hoi/screen/lehoi/detail_lehoi.dart';
// // import 'package:le_hoi_module/le_hoi_module/le_hoi/screen/lehoi/search_lehoi.dart';
// // import 'package:le_hoi_module/phong_tuc_module/screen/phong_tuc_screen.dart';
// import 'package:lichviet_modules/core/constants/screen_name_constants.dart';
// import 'package:lichviet_modules/domain/entities/ngay_tot_entity.dart';
// import 'package:lichviet_modules/domain/entities/notification_entity.dart';
// import 'package:lichviet_modules/domain/entities/post_entity.dart';
// import 'package:lichviet_modules/domain/entities/response/ngay_tot_response_entity.dart';
// import 'package:lichviet_modules/domain/entities/viec_entity.dart';
// import 'package:lichviet_modules/presentation/features/account/account_info/account_info_screen.dart';
// import 'package:lichviet_modules/presentation/features/account/account_update/account_update_screen.dart';
// import 'package:lichviet_modules/presentation/features/account/province/province_screen.dart';

// import 'package:lichviet_modules/presentation/features/active_pro/active_pro_screen.dart';
// import 'package:lichviet_modules/presentation/features/auth/permission/permission_screen.dart';
// import 'package:lichviet_modules/presentation/features/auth/sign_in/sign_in_screen.dart';
// import 'package:lichviet_modules/presentation/features/bat_trach/bat_trach_utils.dart';
// import 'package:lichviet_modules/presentation/features/bat_trach/chi_tiet_la_kinh/chi_tiet_la_kinh_screen.dart';
// import 'package:lichviet_modules/presentation/features/bat_trach/compass/compass_select_screen.dart';
// import 'package:lichviet_modules/presentation/features/bat_trach/huong_dan_su_dung/toturial_screen.dart';
// import 'package:lichviet_modules/presentation/features/bat_trach/ve_khuon_hinh/ve_khuon_hinh_screen.dart';
// import 'package:lichviet_modules/presentation/features/bat_trach/xac_dinh_toa/xac_dinh_toa_screen.dart';
// import 'package:lichviet_modules/presentation/features/bat_trach/xem_phong_thuy/xem_phong_thuy_screen.dart';
// import 'package:lichviet_modules/presentation/features/bat_trach/chon_ban_do/chon_ban_do_screen.dart';
// import 'package:lichviet_modules/presentation/features/bat_trach/ket_qua/ket_qua_screen.dart';
// import 'package:lichviet_modules/presentation/features/bat_trach/thong_tin_menh_chu/thong_tin_menh_chu_screen.dart';
// import 'package:lichviet_modules/presentation/features/bat_trach/xac_dinh_do/xac_dinh_do_screen.dart';
// import 'package:lichviet_modules/presentation/features/calendar_day/calendar_day_screen.dart';
// import 'package:lichviet_modules/presentation/features/calendar_page_load/calendar_page_load_screen.dart';
// import 'package:lichviet_modules/presentation/features/customer_support/customer_support_screen.dart';
// import 'package:lichviet_modules/presentation/features/detail_day/detail_day_hiepky.dart/detail_date_screen_hiepky.dart';
// import 'package:lichviet_modules/presentation/features/detail_day/detail_day_ngochap/detail_date_screen_ngochap.dart';
// import 'package:lichviet_modules/presentation/features/guide/guide_detail/guide_detail_screen.dart';
// import 'package:lichviet_modules/presentation/features/guide/guide_screen.dart';
// import 'package:lichviet_modules/presentation/features/horoscope/horoscope_detail/horoscope_detail_screen.dart';
// import 'package:lichviet_modules/presentation/features/horoscope/horoscope_screen.dart';
// import 'package:lichviet_modules/presentation/features/khung_la_kinh_zoom/khung_la_kinh_constant.dart';
// import 'package:lichviet_modules/presentation/features/khung_la_kinh_zoom/khung_la_kinh_screen.dart';
// import 'package:lichviet_modules/presentation/features/la_kinh/la_kinh_screen.dart';
// import 'package:lichviet_modules/presentation/features/main_screen/main_screen.dart';
// import 'package:lichviet_modules/presentation/features/notification/notification_detail/notification_detail.dart';
// import 'package:lichviet_modules/presentation/features/notification/notification_tab_list/notification_tab_list_screen.dart';
// import 'package:lichviet_modules/presentation/features/password/auth_otp/auth_otp_screen.dart';
// import 'package:lichviet_modules/presentation/features/password/change_password/change_password_screen.dart';
// import 'package:lichviet_modules/presentation/features/password/forgot_password/forgot_password_screen.dart';
// import 'package:lichviet_modules/presentation/features/password/set_password/set_password_screen.dart';
// import 'package:lichviet_modules/presentation/features/qr_code/qr_code_result.dart';
// import 'package:lichviet_modules/presentation/features/qr_code/qr_code_screen.dart';
// import 'package:lichviet_modules/presentation/features/search_event/search_event_screen.dart';
// import 'package:lichviet_modules/presentation/features/service_pro/service_pro_screen.dart';
// import 'package:lichviet_modules/presentation/features/service_pro/widget/rules_policy_screen.dart';
// import 'package:lichviet_modules/presentation/features/test_toolbar_screen.dart/test_toolbar_screen.dart';
// import 'package:lichviet_modules/presentation/features/xem_ngay_tot/detail_result/detail_result_screen.dart';
// import 'package:lichviet_modules/presentation/features/xem_ngay_tot/details/xem_ngay_tot_detail.dart';
// import 'package:lichviet_modules/presentation/features/xem_ngay_tot/history/history_screen.dart';
// import 'package:lichviet_modules/presentation/features/xem_ngay_tot/result/result_screen.dart';
// import 'package:lichviet_modules/presentation/features/xem_ngay_tot/xem_ngay_tot_screen.dart';
// // import 'package:van_khan_bloc/van_khan.dart';
// // import 'package:van_khan_bloc/van_khan_module/van_khan/category_paper.dart';
// // import 'package:van_khan_bloc/van_khan_module/van_khan/detail/vankhan_detail_screen.dart';
// // import 'package:van_khan_bloc/van_khan_module/van_khan/search/vankhan_list_cubit.dart';
// // import 'package:van_khan_bloc/van_khan_module/van_khan/search/vankhan_list_screen.dart';
// // import 'package:van_khan_bloc/van_khan_module/van_khan/vankhan_model.dart';

// import '../../data/model/bat_trach/bat_trach_model.dart';
// import '../../presentation/features/change_day/change_day_screen.dart';
// import '../../presentation/features/draw_on_image/draw_on_image.dart';
// import '../../presentation/features/xem_ngay_tot/family_member/family_member_screen.dart';
import 'base/routes.dart';

class AppPageRoute extends NavRoute {
  AppPageRoute(
    String id, {
    required NavPageBuilder builder,
    dynamic data,
  }) : super(id, builder: builder, data: data);

  // static AppPageRoute mainHiepKyScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.trangchuHiepKyScreen,
  //         builder: mainScreenBuilder);
  // static AppPageRoute mainNgocHapScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.trangchuNgocHapScreen,
  //         builder: mainScreenBuilder);

  // static AppPageRoute detailHiepKyScreen(
  //         String? initDate, bool navigateFromHome,
  //         {bool openByDeepLink = false}) =>
  //     AppWidgetRoute(ScreenNameConstants.chiTietNgayHiepKyScreen,
  //         builder: ((context) => detailHiepKyScreenBuilder(context,
  //             initDate: initDate, navigateFromHome: navigateFromHome)),
  //         data: openByDeepLink);

  // static AppPageRoute calendarPageLoadScreen(String? initDate) =>
  //     AppWidgetRoute(ScreenNameConstants.lichThangScreen,
  //         builder: ((context) =>
  //             calendarPageLoadScreenBuilder(context, initDate: initDate)));

  // static AppPageRoute calendarEventList(String? initDate) =>
  //     AppWidgetRoute(ScreenNameConstants.suKienScreen,
  //         builder: ((context) =>
  //             calendarPageLoadScreenBuilder(context, initDate: initDate)));

  // static AppPageRoute detailNgocHapScreen(
  //         String? initDate, bool navigateFromHome) =>
  //     AppWidgetRoute(ScreenNameConstants.chiTietNgayNgocHapScreen,
  //         builder: ((context) => detailNgocHapScreenBuilder(context,
  //             initDate: initDate, navigateFromHome: navigateFromHome)));

  // static AppPageRoute xemNgayTotScreen(String? id) =>
  //     AppWidgetRoute(ScreenNameConstants.chonNgayScreen,
  //         builder: ((context) => xemNgayTotScreenBuilder(context, id)));

  // static AppPageRoute notificationDetailScreen(
  //         NotificationEntity notificationModel, bool fromTabList) =>
  //     AppWidgetRoute(ScreenNameConstants.thongBaoChiTietScreen,
  //         builder: ((context) => notificationDetailScreenBuilder(context,
  //             notificationModel: notificationModel, fromTabList: fromTabList)));

  // static AppPageRoute zoomWebViewScreen(String initDate, PhuongVi type) =>
  //     AppWidgetRoute(
  //         (type == PhuongVi.catHungNam)
  //             ? ScreenNameConstants.chiTietNgayPhuongViNamScreen
  //             : ScreenNameConstants.chiTietNgayPhuongViThangScreen,
  //         builder: ((context) => khungLaKinhScreenBuilder(context,
  //             initDate: initDate, type: type)));
  // static AppPageRoute horoscopeScreen(int tabIndex) =>
  //     AppWidgetRoute('/horoscope',
  //         builder: (context) => horoscopeScreenBuilder(context, tabIndex));

  // static AppPageRoute qrCodeScreen() =>
  //     AppWidgetRoute('/qr_code', builder: qrCodeScreenBuilder);

  // static AppPageRoute qrCodeResultScreen(String dataQrCode) =>
  //     AppWidgetRoute('/qr_code_result',
  //         builder: (context) => qrCodeResultScreenBuilder(dataQr: dataQrCode));

  // static AppPageRoute horoscopeDetailScreen(
  //         int index, List<PostEntity> tuViList, bool navigateFromHome) =>
  //     AppWidgetRoute('/horoscope_detail', builder: ((context) {
  //       return horoscopeDetailScreenBuilder(
  //           context, index, tuViList, navigateFromHome);
  //     }));

  // static AppPageRoute activeProScreen(String code) =>
  //     AppWidgetRoute('/active_pro',
  //         builder: (context) => activeProScreenBuilder(context, code));

  // static AppPageRoute xemNgayTotDetailScreen(ViecEntity item) =>
  //     AppWidgetRoute(ScreenNameConstants.chonNgayNhapThongTinScreen,
  //         builder: (context) => xemNgayTotDetailScreenBuilder(context, item));

  // static AppPageRoute testToolbarScreen() => AppWidgetRoute('/test_toolbar',
  //     builder: (context) => testToolBarScreenBuilder(context));
  // static AppPageRoute laKinhScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.lakinhScreen,
  //         builder: (context) => laKinhScreenBuilder(context));
  // static AppPageRoute searchEventScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.lichThangTimSuKienScreen,
  //         builder: (context) => searchEventScreenBuilder(context));
  // static AppPageRoute accountInfoScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.taiKhoanScreen,
  //         builder: (context) => accountInfoScreenBuilder());
  // static AppPageRoute accountUpdateScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.capNhatThongTinCaNhanScreen,
  //         builder: (context) => accountUpdateScreenBuilder());
  // static AppPageRoute provinceScreen(String address) =>
  //     AppWidgetRoute('/province_screen',
  //         builder: (context) => provinceScreenBuilder(address));
  // static AppPageRoute notificationTabListScreen(String title, String type) {
  //   // categoryId 1: thông báo, 2: ưu đãi, 3: sự kiện
  //   var screenName = '';
  //   switch (type) {
  //     case '1':
  //       screenName = ScreenNameConstants.thongBaoThongBaoScreen;
  //       break;
  //     case '2':
  //       screenName = ScreenNameConstants.thongBaoUuDaiScreen;
  //       break;
  //     case '3':
  //       screenName = ScreenNameConstants.thongBaoSuKienScreen;
  //       break;
  //     default:
  //       screenName = ScreenNameConstants.thongBaoThongBaoScreen;
  //       break;
  //   }
  //   return AppWidgetRoute(screenName,
  //       builder: (context) =>
  //           notificationTabListScreenBuilder(context, title, type));
  // }

  // static AppPageRoute serviceProScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.dangKyDichVuScreen,
  //         builder: (context) => serviceProScreenBuilder(context));
  // static AppPageRoute calendarDayScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.lichNgayScreen,
  //         builder: (context) => calendarDayScreenBuilder(context));
  // static AppPageRoute changeDayScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.doiNgayScreen,
  //         builder: (context) => changeDayScreenBuilder(context));

  // static AppPageRoute rulesPolicyScreen(
  //         {required String title, required String urlWebView}) =>
  //     AppWidgetRoute('/rules_policy',
  //         builder: (context) =>
  //             RulesPolicyScreen(title: title, urlWebView: urlWebView));

  // static AppPageRoute familyMemberScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.chonNgayProfileListScreen,
  //         builder: (context) => familyMemberScreenBuilder(context));
  // static AppPageRoute detailResultScreen(
  //         NgayTotEntity ngayTot,
  //         ViecEntity viec,
  //         String name,
  //         String birthDay,
  //         bool showLakinh,
  //         String huong,
  //         Map<String, String>? warnings) =>
  //     AppWidgetRoute(ScreenNameConstants.chonNgayKQChiTetScreen,
  //         builder: (context) => detailResultScreenBuilder(context, ngayTot,
  //             viec, name, birthDay, showLakinh, huong, warnings));
  // static AppPageRoute resultScreen(
  //   ViecEntity viec,
  //   String doText,
  //   String birthYear,
  //   String timeText,
  //   String name,
  //   List<NgayTotResponseEntity>? ngayTotResponse,
  //   int historyId,
  //   int maxMonth,
  //   int indexTime,
  // ) =>
  //     AppWidgetRoute(ScreenNameConstants.chonNgayKetQuaScreen,
  //         builder: (context) => resultScreenBuilder(
  //               context,
  //               viec,
  //               doText,
  //               birthYear,
  //               timeText,
  //               name,
  //               ngayTotResponse,
  //               historyId,
  //               maxMonth,
  //               indexTime,
  //             ));
  // static AppPageRoute historyScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.chonNgayLichSuScreen,
  //         builder: (context) => historyScreenBuilder(context));
  // static AppPageRoute customerSupportScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.hoTroKHScreen,
  //         builder: (context) => customerSupportScreenBuilder());
  // static AppPageRoute guideScreen(String id) =>
  //     AppWidgetRoute(ScreenNameConstants.huongDanSDScreen,
  //         builder: (context) => guideScreenBuilder(id));
  // static AppPageRoute guideDetailScreen(String title, String id) =>
  //     AppWidgetRoute(ScreenNameConstants.huongDanSDCTScreen,
  //         builder: (context) => guideDetailScreenBuilder(title, id));
  // static AppPageRoute setPasswordScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.datMatKhauScreen,
  //         builder: (context) => setPasswordScreenBuilder(context));
  // static AppPageRoute changePasswordScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.doiMatKhauScreen,
  //         builder: (context) => changePasswordScreenBuilder(context));
  // static AppPageRoute forgotPasswordScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.quenMatKhauScreen,
  //         builder: (context) => forgotPasswordScreenBuilder(context));
  // static AppPageRoute permissionScreen() => AppWidgetRoute(
  //       '/permission',
  //       builder: (context) => permissionBuilder(context),
  //     );
  // static AppPageRoute authOtpScreen(
  //         String userName, String pass, bool updateUser) =>
  //     AppWidgetRoute(ScreenNameConstants.xacthucOTPScreen,
  //         builder: (context) => authOtpScreenBuilder(context,
  //             userName: userName, passWord: pass, updateUser: updateUser));

  // static AppPageRoute signInScreen(bool popAfterLogin, {String? codeActive}) =>
  //     AppWidgetRoute(ScreenNameConstants.dangNhapScreen,
  //         builder: (context) =>
  //             signInScreenBuilder(context, popAfterLogin, codeActive));

  // static AppPageRoute xemPhongThuyScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.xemPhongThuyScreen,
  //         builder: (context) => xemPhongThuyScreenBuilder());
  // static AppPageRoute chonBanDoScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.chonBanDoScreen,
  //         builder: (context) => chonBanDoScreenBuilder(context));
  // static AppPageRoute chonAnhScreen(XFile imageFile) =>
  //     AppWidgetRoute(ScreenNameConstants.chonAnhScreen,
  //         builder: (context) => drawOnImageScreenBuilder(context, imageFile));
  // static AppPageRoute veKhuonHinhScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.veKhuonHinhScreen,
  //         builder: (context) => veKhuonHinhScreenBuilder());
  // static AppPageRoute xacDinhToaScreen({required TuGiac tuGiac}) =>
  //     AppWidgetRoute(ScreenNameConstants.xacDinhToaScreen,
  //         builder: (context) => xacDinhToaScreenBuilder(tuGiac: tuGiac));
  // static AppPageRoute xacDinhDoScreen(
  //         {required TuGiac tuGiac,
  //         required int canhToa,
  //         required Offset trongTam,
  //         required double doCuaToa,
  //         required double doCuaHuong,
  //         required double maxCanh}) =>
  //     AppWidgetRoute(ScreenNameConstants.xacDinhDoScreen,
  //         builder: (context) => xacDinhDoScreenBuilder(
  //             tuGiac: tuGiac,
  //             canhToa: canhToa,
  //             trongTam: trongTam,
  //             doCuaToa: doCuaToa,
  //             doCuaHuong: doCuaHuong,
  //             maxCanh: maxCanh));
  // static AppPageRoute thongTinMenhChuScreen(
  //         {TuGiac? tuGiac,
  //         double? doCuaToa,
  //         int? canhToa,
  //         Offset? trongTam,
  //         double? doCuaHuong}) =>
  //     AppWidgetRoute(ScreenNameConstants.thongTinMenhChuScreen,
  //         builder: (context) => thongTinMenhChuScreenBuilder(
  //             tuGiac, doCuaToa, canhToa, trongTam, doCuaHuong));
  // static AppPageRoute ketQuaScreen(
  //         TuGiac? tuGiac,
  //         double? doCuaToa,
  //         int? canhToa,
  //         Offset? trongTam,
  //         double? doCuaHuong,
  //         String ngaySinh,
  //         String gioiTinh) =>
  //     AppWidgetRoute(ScreenNameConstants.ketQuaScreen,
  //         builder: (context) => ketQuaScreenBuilder(tuGiac, doCuaToa, canhToa,
  //             trongTam, doCuaHuong, ngaySinh, gioiTinh));
  // static AppPageRoute chiTietLaKinhScreen(
  //         Quai quai, double doHuong, int canhToa, bool check3m6) =>
  //     AppWidgetRoute(ScreenNameConstants.chiTietLaKinh,
  //         builder: (context) =>
  //             chiTietLaKinhScreenBuilder(quai, doHuong, canhToa, check3m6));

  // static AppPageRoute huongDanBatTrachScreen() =>
  //     AppWidgetRoute(ScreenNameConstants.huongDanBatTrach,
  //         builder: (context) => toturialBatTrachScreenBuilder());

  // static AppPageRoute labanScreen({required bool showAcceptButton}) =>
  //     AppWidgetRoute(ScreenNameConstants.laBan,
  //         builder: (context) =>
  //             compassSelectScreenBuilder(showAcceptButton: showAcceptButton));

  // static AppPageRoute vanKhanCategoryScreen() => AppWidgetRoute(
  //     '/vankhan_category',
  //     builder: (context) => VanKhanScreen(
  //           onClickBack: () async {
  //             context.pop();
  //             return false;
  //           },
  //           onClickToListOrSearch: (LoaiTimKiem timKiem, BuildContext context) {
  //             AppNavigator.of(context)
  //                 .pushTo(AppPageRoute.vanKhanSearchAndSearch(data: timKiem));
  //           },
  //         ));

  // static AppPageRoute vanKhanScreenDetail({required VanKhanModel data}) =>
  //     AppWidgetRoute('/vankhan_detail',
  //         builder: (context) => VankhanDetailScreen(
  //               data,
  //               onClose: () async {
  //                 context.pop();
  //                 return false;
  //               },
  //             ));

  // static AppPageRoute vanKhanSearchAndSearch({required LoaiTimKiem data}) =>
  //     AppWidgetRoute('/vankhan_search_and_list',
  //         builder: (context) => VanKhanListScreen(
  //               data,
  //               onClickToDetail:
  //                   (VanKhanModel vanKhanModel, BuildContext context) {
  //                 AppNavigator.of(context).pushTo(
  //                     AppPageRoute.vanKhanScreenDetail(data: vanKhanModel));
  //               },
  //               onClose: () async {
  //                 context.pop();
  //                 return false;
  //               },
  //               onClickToSearch:
  //                   (LoaiTimKiem loaiTimKiem, BuildContext context) {
  //                 AppNavigator.of(context).pushTo(
  //                     AppPageRoute.vanKhanSearchAndSearch(data: loaiTimKiem));
  //               },
  //             ));

  // static AppPageRoute phongTucScreen() => AppWidgetRoute('/phong_tuc_list',
  //     builder: (context) => PhongTucScreen(
  //           onClickBack: () async {
  //             context.pop();
  //             return false;
  //             // return await EventUtils.willPopCallback(
  //             //     context,
  //             //     GetIt.I<UserCubit>().state.userInfo,
  //             //     GetIt.I<MethodChannel>(),
  //             //     'lehoi_list');
  //           },
  //           onClickSearch: (data, context) {
  //             AppNavigator.of(context)
  //                 .pushTo(AppPageRoute.searchLehoiScreen(data));
  //           },
  //           adsView: BannarAdWidget(),
  //           onClickToDetail: (Post article, String title, bool isShowTopDetail,
  //               BuildContext context) {
  //             context.pushTo(AppPageRoute.lehoiDetailScreen(
  //                 loaiTimKiem: article, title: title, showTopDetail: false));
  //           },
  //         ));

  // static AppPageRoute lehoiScreen() => AppWidgetRoute('/lehoi_list',
  //     builder: (context) => LeHoiScreen(
  //           onClickBack: () async {
  //             context.pop();
  //             return false;
  //             // return await EventUtils.willPopCallback(
  //             //     context,
  //             //     GetIt.I<UserCubit>().state.userInfo,
  //             //     GetIt.I<MethodChannel>(),
  //             //     'lehoi_list');
  //           },
  //           onClickSearch: (data, context) {
  //             AppNavigator.of(context)
  //                 .pushTo(AppPageRoute.searchLehoiScreen(data));
  //           },
  //           onClickToDetail: (Post loaiTimKiem, String title, context) {
  //             context.pushTo(AppPageRoute.lehoiDetailScreen(
  //                 loaiTimKiem: loaiTimKiem, title: title, showTopDetail: true));
  //           },
  //           currentLunarMonth: IntConstanst.monthLunarNow,
  //           adsView: BannarAdWidget(),
  //         ));

  // static AppPageRoute lehoiDetailScreen(
  //         {required Post loaiTimKiem,
  //         required String title,
  //         required showTopDetail}) =>
  //     AppWidgetRoute('/lehoi_detail',
  //         builder: (context) => DetailArticle(
  //               title: title,
  //               valueItem: loaiTimKiem,
  //               onClose: () async {
  //                 context.pop();
  //                 return false;
  //                 // return await EventUtils.willPopCallback(
  //                 //     context,
  //                 //     GetIt.I<UserCubit>().state.userInfo,
  //                 //     GetIt.I<MethodChannel>(),
  //                 //     'lehoi_detail');
  //               },
  //               adsView: BannarAdWidget(),
  //               onClickShare: (String title,
  //                   String imageUrl,
  //                   String description,
  //                   String screen,
  //                   String id,
  //                   String categoryId) async {
  //                 GetIt.I<MethodChannel>()
  //                     .invokeMethod(ChannelEndpoint.sharePost, {
  //                   'title': 'Chuyên mục tử vi',
  //                   'imageUrl': imageUrl,
  //                   'description': description,
  //                   'screen': screen,
  //                   'id': id,
  //                   'category_id': categoryId
  //                 });
  //               },
  //               isShowTopDetail: showTopDetail,
  //             ));

  // static AppPageRoute searchLehoiScreen(List<Post> listDatas) =>
  //     AppWidgetRoute('/lehoi_search',
  //         builder: (context) => SearchArticle(
  //               onClickToDetail:
  //                   (Post article, String title, bool showTopDetail) {
  //                 context.pushTo(AppPageRoute.lehoiDetailScreen(
  //                     loaiTimKiem: article,
  //                     title: title,
  //                     showTopDetail: showTopDetail));
  //               },
  //               onClose: () async {
  //                 context.pop();
  //                 return false;
  //                 // return await EventUtils.willPopCallback(
  //                 //     context,
  //                 //     GetIt.I<UserCubit>().state.userInfo,
  //                 //     GetIt.I<MethodChannel>(),
  //                 //     'lehoi_search');
  //               },
  //               isShowTopContent: true,
  //               data: listDatas,
  //             ));
}

///
class AppWidgetRoute extends AppPageRoute {
  AppWidgetRoute(
    String id, {
    required WidgetBuilder builder,
    dynamic data,
  }) : super(id,
            builder: (context, [dynamic data]) =>
                _widgetToPage(context, id, builder, data),
            data: data);

  static Page _widgetToPage(
      BuildContext context, String key, WidgetBuilder builder, dynamic data) {
    return MaterialPage(
      child: builder(context),
      key: ValueKey(key),
      name: key,
      arguments: data,
    );
  }
}
