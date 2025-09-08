/// Utility extensions for [Iterable] providing null-safe operations and enhanced functionality.
/// 
/// This extension adds common utility methods that provide safe alternatives to
/// standard [Iterable] methods that would otherwise throw exceptions when elements
/// are not found. It also includes indexing support and functional programming utilities.
/// 
/// Key features:
/// * Null-safe alternatives to [firstWhere] and [lastWhere]
/// * Index-aware iteration and mapping
/// * Null filtering and compacting operations
/// * Duplicate removal utilities
/// 
/// Example usage:
/// ```dart
/// final numbers = [1, 2, 3, 4, 5];
/// 
/// // Safe finding (returns null instead of throwing)
/// final even = numbers.tryFirstWhere((n) => n.isEven); // 2
/// final large = numbers.tryFirstWhere((n) => n > 10);  // null
/// 
/// // Index-aware operations
/// numbers.forEachWithIndex((index, value) {
///   print('$index: $value');
/// });
/// 
/// // Functional operations
/// final doubled = numbers.mapWithIndex((index, value) => value * 2);
/// final distinct = [1, 2, 2, 3].distinct(); // [1, 2, 3]
/// ```
extension IterableExt<E> on Iterable<E> {
  /// Safely finds the first element that satisfies the given predicate.
  /// 
  /// Returns the first element that matches [test], or `null` if no element
  /// is found. This is a null-safe alternative to [firstWhere] which throws
  /// a [StateError] when no matching element exists.
  /// 
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final even = numbers.tryFirstWhere((n) => n.isEven); // 2
  /// final negative = numbers.tryFirstWhere((n) => n < 0); // null
  /// ```
  E? tryFirstWhere(bool Function(E element) test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }

  /// Safely finds the last element that satisfies the given predicate.
  /// 
  /// Returns the last element that matches [test], or `null` if no element
  /// is found. This is a null-safe alternative to [lastWhere] which throws
  /// a [StateError] when no matching element exists.
  /// 
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final evenLast = numbers.tryFindLast((n) => n.isEven); // 4
  /// final negative = numbers.tryFindLast((n) => n < 0);    // null
  /// ```
  E? tryFindLast(bool Function(E element) test) {
    try {
      return lastWhere(test);
    } catch (e) {
      return null;
    }
  }

  /// Safely gets the first element of the iterable.
  /// 
  /// Returns the first element, or `null` if the iterable is empty.
  /// This is equivalent to calling [firstOrNull].
  /// 
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3];
  /// final empty = <int>[];
  /// 
  /// print(numbers.tryFirst()); // 1
  /// print(empty.tryFirst());   // null
  /// ```
  E? tryFirst() => firstOrNull;

  /// Safely gets the last element of the iterable.
  /// 
  /// Returns the last element, or `null` if the iterable is empty.
  /// This is equivalent to calling [lastOrNull].
  /// 
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3];
  /// final empty = <int>[];
  /// 
  /// print(numbers.tryLast()); // 3
  /// print(empty.tryLast());   // null
  /// ```
  E? tryLast() => lastOrNull;

  /// Iterates over elements with their corresponding indices.
  /// 
  /// Calls the provided [each] function for every element in the iterable,
  /// passing both the zero-based index and the element value.
  /// 
  /// This is useful when you need both the position and value during iteration.
  /// 
  /// Example:
  /// ```dart
  /// final fruits = ['apple', 'banana', 'orange'];
  /// fruits.forEachWithIndex((index, fruit) {
  ///   print('$index: $fruit');
  /// });
  /// // Output:
  /// // 0: apple
  /// // 1: banana
  /// // 2: orange
  /// ```
  void forEachWithIndex(void Function(int index, E element) each) {
    toList().asMap().forEach(each);
  }

  /// Maps elements to a new type while providing access to their indices.
  /// 
  /// Similar to [map], but the transformation function receives both the
  /// zero-based index and the element value, allowing index-aware transformations.
  /// 
  /// Returns a new [List] containing the transformed elements.
  /// 
  /// Example:
  /// ```dart
  /// final letters = ['a', 'b', 'c'];
  /// final indexed = letters.mapWithIndex((index, letter) => '$index-$letter');
  /// print(indexed); // ['0-a', '1-b', '2-c']
  /// ```
  List<T> mapWithIndex<T>(T Function(int index, E element) each) {
    final newList = <T>[];

    forEachWithIndex((index, value) {
      final newValue = each(index, value);
      newList.add(newValue);
    });

    return newList;
  }

  /// Maps elements to a new type and filters out null results.
  /// 
  /// This combines the functionality of [map] and [where] in a single operation.
  /// The transformation function can return null to indicate that an element
  /// should be excluded from the result.
  /// 
  /// Returns a new [List] containing only the non-null transformed elements.
  /// 
  /// Example:
  /// ```dart
  /// final mixed = ['1', 'hello', '2', 'world', '3'];
  /// final numbers = mixed.compactMap((str) => int.tryParse(str));
  /// print(numbers); // [1, 2, 3]
  /// ```
  /// 
  /// This is particularly useful for parsing operations where some elements
  /// may not be valid or convertible.
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

  /// Returns a new list with duplicate elements removed.
  /// 
  /// Uses the elements' equality ([Object.==]) and hash codes ([Object.hashCode])
  /// to determine uniqueness. The order of first occurrence is preserved.
  /// 
  /// This is implemented by converting to a [Set] and back to a [List],
  /// which automatically handles deduplication.
  /// 
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 2, 3, 1, 4];
  /// final unique = numbers.distinct();
  /// print(unique); // [1, 2, 3, 4]
  /// ```
  /// 
  /// Note: For custom objects, ensure [Object.==] and [Object.hashCode]
  /// are properly implemented for correct deduplication behavior.
  List<E> distinct() {
    final set = toSet();
    return set.toList();
  }
}
