class PremiumPlansState {
  List<dynamic>? premiumList = [];
  String? error;
  bool? isFetching;

  PremiumPlansState({
    this.isFetching,
    this.premiumList,
    this.error,
  });

  PremiumPlansState.initialState()
      : premiumList = [],
        isFetching = true,
        error = '';

  @override
  String toString() {
    return 'PremiumPlansState{premiumList: $premiumList, error: $error, isFetching: $isFetching}';
  }
}
