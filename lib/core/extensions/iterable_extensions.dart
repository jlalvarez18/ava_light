extension IterableExt<E> on Iterable<E> {
  E? tryFirstWhere(bool Function(E element) test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }

  E? tryFindLast(bool Function(E element) test) {
    try {
      return lastWhere(test);
    } catch (e) {
      return null;
    }
  }

  E? tryFirst() => firstOrNull;

  E? tryLast() => lastOrNull;

  void forEachWithIndex(void Function(int index, E element) each) {
    toList().asMap().forEach(each);
  }

  List<T> mapWithIndex<T>(T Function(int index, E element) each) {
    final newList = <T>[];

    forEachWithIndex((index, value) {
      final newValue = each(index, value);

      newList.add(newValue);
    });

    return newList;
  }

  List<T> compactMap<T>(T? Function(E element) each) {
    final newList = <T>[];

    forEach((e) {
      final newValue = each(e);

      if (newValue != null) {
        newList.add(newValue);
      }
    });

    return newList;
  }

  List<E> distinct() {
    final set = toSet();

    return set.toList();
  }
}
