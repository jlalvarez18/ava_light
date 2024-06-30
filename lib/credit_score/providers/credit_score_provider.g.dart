// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_score_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getExperianReportsHash() =>
    r'f6078845167b93572094c4aaa62881603e290133';

/// See also [getExperianReports].
@ProviderFor(getExperianReports)
final getExperianReportsProvider =
    AutoDisposeProvider<List<CreditReport>>.internal(
  getExperianReports,
  name: r'getExperianReportsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getExperianReportsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetExperianReportsRef = AutoDisposeProviderRef<List<CreditReport>>;
String _$getSortedExperianReportsHash() =>
    r'c39e369df4fc159dc30c15a7fb2d984aa9532105';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getSortedExperianReports].
@ProviderFor(getSortedExperianReports)
const getSortedExperianReportsProvider = GetSortedExperianReportsFamily();

/// See also [getSortedExperianReports].
class GetSortedExperianReportsFamily extends Family<List<CreditReport>> {
  /// See also [getSortedExperianReports].
  const GetSortedExperianReportsFamily();

  /// See also [getSortedExperianReports].
  GetSortedExperianReportsProvider call({
    bool ascending = true,
  }) {
    return GetSortedExperianReportsProvider(
      ascending: ascending,
    );
  }

  @override
  GetSortedExperianReportsProvider getProviderOverride(
    covariant GetSortedExperianReportsProvider provider,
  ) {
    return call(
      ascending: provider.ascending,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getSortedExperianReportsProvider';
}

/// See also [getSortedExperianReports].
class GetSortedExperianReportsProvider
    extends AutoDisposeProvider<List<CreditReport>> {
  /// See also [getSortedExperianReports].
  GetSortedExperianReportsProvider({
    bool ascending = true,
  }) : this._internal(
          (ref) => getSortedExperianReports(
            ref as GetSortedExperianReportsRef,
            ascending: ascending,
          ),
          from: getSortedExperianReportsProvider,
          name: r'getSortedExperianReportsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSortedExperianReportsHash,
          dependencies: GetSortedExperianReportsFamily._dependencies,
          allTransitiveDependencies:
              GetSortedExperianReportsFamily._allTransitiveDependencies,
          ascending: ascending,
        );

  GetSortedExperianReportsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ascending,
  }) : super.internal();

  final bool ascending;

  @override
  Override overrideWith(
    List<CreditReport> Function(GetSortedExperianReportsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSortedExperianReportsProvider._internal(
        (ref) => create(ref as GetSortedExperianReportsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ascending: ascending,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<CreditReport>> createElement() {
    return _GetSortedExperianReportsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSortedExperianReportsProvider &&
        other.ascending == ascending;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ascending.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSortedExperianReportsRef
    on AutoDisposeProviderRef<List<CreditReport>> {
  /// The parameter `ascending` of this provider.
  bool get ascending;
}

class _GetSortedExperianReportsProviderElement
    extends AutoDisposeProviderElement<List<CreditReport>>
    with GetSortedExperianReportsRef {
  _GetSortedExperianReportsProviderElement(super.provider);

  @override
  bool get ascending => (origin as GetSortedExperianReportsProvider).ascending;
}

String _$latestExperianReportHash() =>
    r'0650dca6e17f14626305d251eb97dcbe5832a643';

/// See also [latestExperianReport].
@ProviderFor(latestExperianReport)
final latestExperianReportProvider = AutoDisposeProvider<CreditReport>.internal(
  latestExperianReport,
  name: r'latestExperianReportProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestExperianReportHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LatestExperianReportRef = AutoDisposeProviderRef<CreditReport>;
String _$minReportedExperianScoreHash() =>
    r'f6a372e72960e98d261ae04d255bde82456b01a2';

/// See also [minReportedExperianScore].
@ProviderFor(minReportedExperianScore)
final minReportedExperianScoreProvider = AutoDisposeProvider<int>.internal(
  minReportedExperianScore,
  name: r'minReportedExperianScoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$minReportedExperianScoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MinReportedExperianScoreRef = AutoDisposeProviderRef<int>;
String _$maxReportedExperianScoreHash() =>
    r'9ba44f9704428cf227f77297e8bedcae27367134';

/// See also [maxReportedExperianScore].
@ProviderFor(maxReportedExperianScore)
final maxReportedExperianScoreProvider = AutoDisposeProvider<int>.internal(
  maxReportedExperianScore,
  name: r'maxReportedExperianScoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$maxReportedExperianScoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MaxReportedExperianScoreRef = AutoDisposeProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
