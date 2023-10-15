abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreateDatabaseState extends AppStates{}

class AppInsertDatabaseState extends AppStates{}

class AppGetDatabaseState extends AppStates{}

class AppGetDatabaseLoadingState extends AppStates{}

class AppUpdateDatabaseState extends AppStates{}

class AppDeleteDatabaseState extends AppStates{}

class AppChangeBottomSheetState extends AppStates {}

class AppChangeModeState extends AppStates {}
class UpdateProductImageSuccessStates extends AppStates {}

class ImageintStates extends AppStates {}

class ImageSuccessStates extends AppStates {}

class CreateworkshopSuccessState extends AppStates {}
class AddServiceReviewSuccessState extends AppStates {}

class AddServiceReviewLoadingState extends AppStates {}
class AddShopReviewSuccessState extends AppStates {}

class AddShopReviewLoadingState extends AppStates {}
class GetAllServiceReviewSuccessState extends AppStates {}

class GetAllServiceReviewLoadingState extends AppStates {}
class GetAllShopReviewSuccessState extends AppStates {

}
class AddTowingLoadingState extends AppStates {}
class AddTowingSuccessState extends AppStates {}
class GetTowingItSelfLoadingState extends AppStates {}
class GetTowingItSelfSuccessState extends AppStates {}
class GetAllTowingLoadingState extends AppStates {}
class GetAllTowingSuccessState extends AppStates {}
class OrderingSuccessState extends AppStates {}
class DeclineOrdersLoadingState extends AppStates {}
class DeclineOrdersSuccessState extends AppStates {}

class GetMyOrdersSuccessState extends AppStates {}
class GetLocationSuccessState extends AppStates {}
class GetAllShopReviewLoadingState extends AppStates {}
class CreateworkshopErrorStates extends AppStates {
  final String error;

  CreateworkshopErrorStates( this.error);
}

class GetworkshopsLoadingStates extends AppStates {}
class GetworkshopsSuccessStates extends AppStates {}
class GetworkshopsStates extends AppStates {
  final String error;

  GetworkshopsStates( this.error);
}

class CreateServicesSuccessState extends AppStates {}
class CreateServicesErrorStates extends AppStates {
  final String error;

  CreateServicesErrorStates( this.error);
}
class GetServiceLoadingStates extends AppStates {}
class GetServiceReviewsSuccessStates extends AppStates {}
class GetServiceReviewsLoadingStates extends AppStates {}
class GetShopReviewsSuccessStates extends AppStates {}
class GetShopReviewsLoadingStates extends AppStates {}
class GetServiceSuccessStates extends AppStates {}
class GetUsersLoadingStates extends AppStates {}
class GetUsersSuccessStates extends AppStates {}
class classServiceSuccessStates extends AppStates {}

class GetServiceStates extends AppStates {
  final String error;

  GetServiceStates( this.error);
}
class UpdateProductSuccessStates extends AppStates {}
class UpdateProductErrorStates extends AppStates {
  final String error;

  UpdateProductErrorStates( this.error);
}
class CreateUserSuccessState extends AppStates {}
class CreateUserErrorState extends AppStates {
  final String error;

  CreateUserErrorState( this.error);
}


class LogoutLoadingState extends AppStates {}

class DeleteServiceLoadingState extends AppStates {}
class DeleteServiceSuccessState extends AppStates {}
class DeleteWorkLoadingState extends AppStates {}
class DeleteWorkSuccessState extends AppStates {}
class LogoutSuccessState extends AppStates {}
class ImageErrorStates extends AppStates {
  final String error;

  ImageErrorStates( this.error);
}
class UpdateProductImageErrorStates extends AppStates {
  final String error;

  UpdateProductImageErrorStates( this.error);
}