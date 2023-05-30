abstract class SocialStaes {}

class SocialInitialState extends SocialStaes {}

class SocialGetUserLoadingState extends SocialStaes {}

class SocialGetUserSucsessState extends SocialStaes {}

class SocialGetAllUserLoadingState extends SocialStaes {}

class SocialGetAllUserSucsessState extends SocialStaes {}

class SocialGetAllUserErrorState extends SocialStaes {}

class SocialGetPostsLoadingState extends SocialStaes {}

class SocialGetPostSucsessState extends SocialStaes {}

class SocialGetLikePostssSucsessState extends SocialStaes {}

class SocialGetLikePostsErrorState extends SocialStaes {
  final String error;

  SocialGetLikePostsErrorState(this.error);
}

class SocialGetPostErrorState extends SocialStaes {
  final String error;

  SocialGetPostErrorState(this.error);
}

class SocialChangeNavBarState extends SocialStaes {}

class SocialNewPostState extends SocialStaes {}

class SocialSucsessProfileimageState extends SocialStaes {}

class SocialerrorProfileimageState extends SocialStaes {}

class SocialSucsessuploadProfileimageState extends SocialStaes {}

class SocialerroruploadProfileimageState extends SocialStaes {}

class SocialerrorupdateState extends SocialStaes {}

class SocialloadingupdateState extends SocialStaes {}

class SocialSucsessuploadCoverimageState extends SocialStaes {}

class SocialerroruploadCoverimageState extends SocialStaes {}

class SocialSucsessCoverimageState extends SocialStaes {}

class SocialerrorCoverimageState extends SocialStaes {}

class SocialGetUserErrorState extends SocialStaes {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialloadingCreatePostState extends SocialStaes {}

class SociallSuccessCreatposteState extends SocialStaes {}

class SociallErrorCreatposteState extends SocialStaes {}

class SocialSucsesspostimageState extends SocialStaes {}

class SocialerrorspostimageState extends SocialStaes {}

class SocialremovepostimageState extends SocialStaes {}

class SocialLoadingCommentState extends SocialStaes {}

class SocialeSuccessCommentState extends SocialStaes {}

class SocialErrorCommentState extends SocialStaes {}

class SocialLoadingGetCommentState extends SocialStaes {}

class SocialeSuccessGetCommentState extends SocialStaes {}

class SocialErrorGetCommentState extends SocialStaes {}

class SocialeSuccessSendMeeagesState extends SocialStaes {}

class SocialErrorSendMeeagesState extends SocialStaes {}

class SocialeSuccessGetSendMeeagesState extends SocialStaes {}

class SocialErrorGetSendMeeagesState extends SocialStaes {}
