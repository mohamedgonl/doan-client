part of 'singleton_anchored_banner_cubit.dart';

class SingletonAnchoredBannerState extends Equatable {
  const SingletonAnchoredBannerState({
    required this.isAdAvaiable,
    required this.height,
    required this.width,
    required this.showIfAvaiable,
  });
  factory SingletonAnchoredBannerState.initial() {
    return const SingletonAnchoredBannerState(
        isAdAvaiable: false,
        height: 0,
        width: double.infinity,
        showIfAvaiable: false);
  }
  final bool isAdAvaiable;
  final double height;
  final double width;
  final bool showIfAvaiable;
  bool adIsShowing() {
    return isAdAvaiable && showIfAvaiable;
  }

  SingletonAnchoredBannerState stateChanged({
    bool? isAdAvaiable,
    double? height,
    double? width,
    bool? showIfAvaiable,
  }) {
    return SingletonAnchoredBannerState(
      isAdAvaiable: isAdAvaiable ?? this.isAdAvaiable,
      height: height ?? this.height,
      width: width ?? this.width,
      showIfAvaiable: showIfAvaiable ?? this.showIfAvaiable,
    );
  }

  @override
  List<Object> get props => [isAdAvaiable, height, width, showIfAvaiable];
}
