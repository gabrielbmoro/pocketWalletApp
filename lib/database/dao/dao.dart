abstract class Dao<Model> {
  Map<String, dynamic> toMap(Model item);

  List<Model> toList(List<Map<String, dynamic>> result);

  Future<List<Model>> findAll();

  Future<int> save(Model model);
}
