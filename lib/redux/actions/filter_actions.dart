class ChangeSearchAction {
  final String search;
  const ChangeSearchAction(this.search);
}

class ChangeTypeAction {
  final String type;
  const ChangeTypeAction(this.type);
}

class ChangeJLTPAction {
  final List<int> jlpt;
  const ChangeJLTPAction(this.jlpt);
}

class ChangeLevelAction {
  final List<String> level;
  const ChangeLevelAction(this.level);
}

class ChangePartOfSpeechAction {
  final List<String> partOfSpeech;
  const ChangePartOfSpeechAction(this.partOfSpeech);
}
