class EndPoints {
  static const String baseUrl = 'https://ataaby.topbusiness.ebharbook.com/api/';
  static const String loginClientUrl = '${baseUrl}v1/client/auth/login';
  static const String loginLawyerUrl = '${baseUrl}v1/lawyer/auth/login';
  static const String homeUrl = '${baseUrl}home';
  static const String getCountriesUrl = '${baseUrl}v1/general/getCountries';
  static const String getCitiesUrl = '${baseUrl}v1/general/getCities/';
  static const String lawyerRegisterUrl = '${baseUrl}v1/lawyer/auth/register';
  static const String clientRegistersUrl = '${baseUrl}v1/client/auth/register';
  static const String getLevelsUrl = '${baseUrl}v1/general/getLevels';
  static const String specialitiesByIdUrl =
      '${baseUrl}v1/general/specialitiesById/';
  static const String lawyerSendOtpUrl = '${baseUrl}v1/lawyer/auth/sendOtp';
  static const String lawyercheckOtpUrl = '${baseUrl}v1/lawyer/auth/checkOtp';
  static const String clientSendOtpUrl = '${baseUrl}v1/client/auth/sendOtp';
  static const String clientcheckOtpUrl = '${baseUrl}v1/client/auth/checkOtp';
  static const String clientResetPasswordUrl =
      '${baseUrl}v1/client/auth/resetPassword';
  static const String lawyerResetPasswordUrl =
      '${baseUrl}v1/lawyer/auth/resetPassword';
  static const String lawyerUpdateEmailUrl =
      '${baseUrl}v1/lawyer/profile/updateEmail';
  static const String clientUpdateEmailUrl =
      '${baseUrl}v1/client/profile/updateEmail';
  static const String lawyertGetSpecialitieslUrl =
      '${baseUrl}v1/general/getSpecialities';
  static const String getMyCourtCasesUrl =
      '${baseUrl}v1/lawyer/getMyCourtCases';
  static const String homeLawyerUrl = '${baseUrl}v1/lawyer/getHome';
  static const String updateProfileLawyerUrl =
      '${baseUrl}v1/lawyer/profile/update';
  static const String getCourtByIdUrl = '${baseUrl}v1/lawyer/getCourtCase/';
  static const String getRefuseReasonsUrl =
      '${baseUrl}v1/general/getFinishReasons';
  //! accept and refuse by lawyer
  static const String lawyerActionCourtCaseUrl =
      '${baseUrl}v1/lawyer/actionCourtCase';
  static const String addEventCourtCaseUrl =
      '${baseUrl}v1/lawyer/addEventCourtCase';
  static const String addCourtCaseDuesUrl =
      '${baseUrl}v1/lawyer/addCourtCaseDues';
  static const String personalDataCustomer =
      '${baseUrl}v1/client/profile/update';
  static const String homeDataCustomer = '${baseUrl}v1/client/getHome';
  static const String homeDetailsDataCustomer =
      '${baseUrl}v1/client/lawyerDetails/';
  static const String clientGetLawyers = '${baseUrl}v1/client/getLawyers';
  static const String addNewCourtCase = '${baseUrl}v1/client/addNewCourtCase';
  static const String addPrivateCourtCase =
      '${baseUrl}v1/client/addPrivateCase';
  static const String getCourtCaseDues =
      '${baseUrl}v1/client/getCourtCaseDeus/';
  static const String courtCase = '${baseUrl}v1/client/getCourtCases/';
  static const String actionEvent = '${baseUrl}v1/client/actionEvent';
  static const String detailsCourtCase = '${baseUrl}v1/client/getCourtCase/';
  static const String addNewUpdateLawyerUrl =
      '${baseUrl}v1/lawyer/addNewUpdate';
  static const String getCancelReasonsUrl =
      '${baseUrl}v1/general/getCancelReasons';
  static const String cancelCourtCaseUrl =
      '${baseUrl}v1/client/cancelCourtCase';
  //! make cancel court case
  static const String deleteEventCourtCaseUrl =
      '${baseUrl}v1/lawyer/deleteEventCourtCase/';
  static const String deleteCourtCaseUpdateUrl =
      '${baseUrl}v1/lawyer/deleteCourtCaseUpdate/';
  static const String updateCourtCaseUpdateUrl =
      '${baseUrl}v1/lawyer/updateCourtCaseUpdate/';

  static const String finishCourtCaseUrl =
      '${baseUrl}v1/client/finishCourtCase';
  static const String lawyerWorkTimesUrl =
      '${baseUrl}v1/lawyer/lawyerWorkTimes';
  static const String updateLawyerWorkTimesUrl =
      '${baseUrl}v1/lawyer/lawyerWorkTimes/updateStatus';
  static const String getOfficeTeamUrl = '${baseUrl}v1/lawyer/getOfficeTeam';
  static const String getHomeMarketUrl =
      '${baseUrl}v1/lawyer/getMarketProductHome';
  static const String getMarketProductUrl =
      '${baseUrl}v1/lawyer/getMarketProduct/';
  static const String addOrderUrl = '${baseUrl}v1/lawyer/addOrder';
  static const String sendOfficeRequest =
      '${baseUrl}v1/lawyer/sendOfficeRequest';
  static const String searchLawyerUrl =
      '${baseUrl}v1/lawyer/searchLawyer?lawyer_id=';
  static const String getOfficeRequestUrl =
      '${baseUrl}v1/lawyer/getOfficeRequest';
  static const String sendOfficeResponseUrl =
      '${baseUrl}v1/lawyer/sendOfficeResponse';
  static const String addSosRequestUrl = '${baseUrl}v1/client/addSosRequest';
  static const String sosLawyersUrl = '${baseUrl}v1/client/sosLawyers';
  static const String deleteLawyerFromOffice =
      '${baseUrl}v1/lawyer/deleteLawyerFromOffice';
  static const String getAdOfferPackagesUrl =
      '${baseUrl}v1/lawyer/getAdOfferPackages';
  static const String getLawyerAdPackagesUrl =
      '${baseUrl}v1/lawyer/getLawyerAdPackages';
  static const String addAdsToLawyerPackageUrl =
      '${baseUrl}v1/lawyer/addAdToLawyerPackage';
  static const String getLawyerPackageAdsUrl =
      '${baseUrl}v1/lawyer/getLawyerPackageAds/';
  static const String getCommunityServiceCategoriesUrl =
      '${baseUrl}v1/client/getCommunityServiceCategories';
  static const String getCommunityServiceSubCategoriesUrl =
      '${baseUrl}v1/client/getCommunityServiceSubCategories/';
  static const String getCommunityServiceDetailsCategoriesUrl =
      '${baseUrl}v1/client/getCommunityService/';
  static const String getOrdersUrl = '${baseUrl}v1/lawyer/getOrders';
  static const String getOffersUrl = '${baseUrl}v1/client/getLawyerOffers';
  static const String getPostsUrl = '${baseUrl}v1/community/getPosts';
  static const String addPostUrl = '${baseUrl}v1/community/addPost';
  static const String getPostCommentUrl =
      '${baseUrl}v1/community/getPostComments/';
  static const String addCommentFromPostUrl =
      '${baseUrl}v1/community/addPostComment';
  static const String deletePostUrl = '${baseUrl}v1/community/deletePost/';
  static const String deleteCommentFromPostUrl =
      '${baseUrl}v1/community/deletePostComment/';
  static const String deleteReplyFromCommentUrl =
      '${baseUrl}v1/community/deletePostCommentReply/';
  static const String addPostActionUrl = '${baseUrl}v1/community/addPostAction';
  static const String addReplyFromCommentUrlOrReply =
      '${baseUrl}v1/community/addPostCommentReply';
  static const String addLawyerToCourtCaseRequestUrl =
      '${baseUrl}v1/lawyer/addLawyerToCourtCaseRequest';
  static const String getContractsUrlFromLawyer =
      '${baseUrl}v1/client/getContracts';
  static const String getChatRoomsUrl = '${baseUrl}v1/chat/getChatRooms';
  static const String getCommentsRepliesUrl =
      '${baseUrl}v1/community/getCommentReply/';
  static const String sendMessageUrl = '${baseUrl}v1/chat/sendMessage';
  static const String createChatRoomUrl = '${baseUrl}v1/chat/createChatRoom';
  static const String getWalletTransaction =
      '${baseUrl}v1/lawyer/getWalletTransactions';
  static const String getClientWalletTransaction =
      '${baseUrl}v1/client/getWalletTransactions';
  static const String getSettingDataFromApp =
      '${baseUrl}v1/general/getSettings';
  static const String transfareCourtCaseToAnatherLawyer =
      '${baseUrl}v1/lawyer/transferCourtCaseToAnotherLawyerRequest';
  static const String getCommercialCodeUrl =
      '${baseUrl}v1/client/profile/getCommercialCode';
  static const String getLawyersFromGeneral = '${baseUrl}v1/general/getLawyers';
  static const String notificationLawyerUrl =
      '${baseUrl}v1/lawyer/getNotifications';
  static const String notificationClientUrl =
      '${baseUrl}v1/client/getNotifications';
  static const String pointsClientUrl =
      '${baseUrl}v1/client/profile/getClientPoints';
  static const String withdrawRequestLawyerUrl =
      '${baseUrl}v1/lawyer/withdrawRequest';
  static const String withdrawRequestClientUrl =
      '${baseUrl}v1/client/withdrawRequest';
  static const String paymobPayUrl = '${baseUrl}v1/paymob/pay?price=';
  static const String paymentCallBackUrl =
      '${baseUrl}v1/paymob/paymentCallBack?orderId=';
  static const String addAdOfferPackagesToLawyer =
      '${baseUrl}v1/lawyer/addAdOfferPackageToLawyer';
  static const String changePasswordFromLawyer =
      '${baseUrl}v1/lawyer/changePassword';
  //! Courtcase send and share
  static const String getAllTransferCourtCasesUrl =
      '${baseUrl}v1/client/getAllTransferCourtCases';
  static const String getAllTransferCourtCaseslawyerUrl =
      '${baseUrl}v1/lawyer/getAllTransferCourtCases';
  static const String transferCourtCaseToAnotherLawyerResponseUrl =
      '${baseUrl}v1/client/transferCourtCaseToAnotherLawyerResponse';
  static const String transferCourtCaseToAnotherLawyerResponseLawyerUrl =
      '${baseUrl}v1/lawyer/transferCourtCaseToAnotherLawyerResponse';
  static const String addLawyerToCourtCaseResponseUrl =
      '${baseUrl}v1/lawyer/addLawyerToCourtCaseResponse?court_case_event_id=';
  static const String courtCaseTransferRequestUrl =
      '${baseUrl}v1/lawyer/courtCaseTransferRequest?court_case_event_id=';

  static const String getAllContributionCourtCasesUrl =
      '${baseUrl}v1/lawyer/getAllContributionCourtCases';
  static const String courtCaseContributionRequestByIdUrl =
      '${baseUrl}v1/lawyer/courtCaseContributionRequest?court_case_event_id=';
}
