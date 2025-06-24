class CategoryEntity {
  final String slug;
  final String name;
  final String url;

  CategoryEntity({required this.slug, required this.name, required this.url});

  CategoryEntity copyWith({String? slug, String? name, String? url}) =>
      CategoryEntity(
        slug: slug ?? this.slug,
        name: name ?? this.name,
        url: url ?? this.url,
      );
}
