import 'package:ava_light/core/extensions/iterable_extensions.dart';

extension ListExt<E> on List<E> {
  List<List<E>> chunk(int chunkSize) {
    final List<List<E>> chunks = [];

    int len = length;

    for (var i = 0; i < len; i += chunkSize) {
      int size = i + chunkSize;

      final chunk = sublist(i, size > len ? len : size);

      chunks.add(chunk);
    }

    return chunks;
  }

  E removeFirst() {
    return removeAt(0);
  }

  E? tryRemoveFirst() {
    try {
      return removeFirst();
    } catch (e) {
      return null;
    }
  }

  int? tryIndexOf(E element) {
    final index = indexOf(element);

    if (index == -1) {
      return null;
    }

    return index;
  }

  int? tryIndexWhere(bool Function(E element) test, [int start = 0]) {
    final index = indexWhere(test, start);

    if (index == -1) {
      return null;
    }

    return index;
  }

  List<E> sortedBy({int Function(E a, E b)? compare}) {
    List<E> list = [];
    list.addAll(this);
    list.sort(compare);

    return list;
  }
}

extension StackExt<E> on List<E> {
  void push(E element) {
    insert(0, element);
  }

  E? pop() {
    final element = tryFirst();

    if (element == null) return null;

    removeAt(0);

    return element;
  }
}

extension QueueExt<E> on List<E> {
  void enqueue(E element) {
    add(element);
  }

  E? dequeue() {
    final element = tryFirst();

    if (element != null) {
      removeAt(0);

      return element;
    }

    return null;
  }
}
