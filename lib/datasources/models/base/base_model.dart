abstract class BaseModel<ID> {
  late ID id;

  BaseModel();

  Map<String, dynamic> toMap();
}
