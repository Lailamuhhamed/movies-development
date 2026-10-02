import 'package:movies_app/core/utils/Model/on_boarding_model.dart';
import 'package:movies_app/core/utils/app_assets.dart';

class OnBoardingList {

  static  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(image1: AppAssets.onBoarding2,
        image2: AppAssets.onBoarding2on, title: 'discover_movies',
        body: 'on_boarding2body', isStart: true),
    OnBoardingModel(image1: AppAssets.onBoarding3,
        image2: AppAssets.onBoarding3on, title: 'explore_all_genres', body: "on_boarding3body"),
    OnBoardingModel(image1: AppAssets.onBoarding4, image2: AppAssets.onBoarding4on
        , title: "create_watchlists", body: "on_boarding4body"),
    OnBoardingModel(image1: AppAssets.onBoarding5, image2: AppAssets.onBoarding5on
        , title: "rate_review_and_learn", body: "on_boarding5body"),
    OnBoardingModel(image1: AppAssets.onBoarding6, image2: AppAssets.onBoarding6on
        , title: "start_watching_now", body: '', isFinish: true)
  ];
}