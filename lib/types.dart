enum StorageKeys {
  increments,
  history,
  goal,
  wereDefaultsSet,
  totalCount,
}

enum PopupMenuOption {
  history('History'),
  edit('Edit'),
  reset('Reset');

  final String displayText;
  const PopupMenuOption(this.displayText);
}
