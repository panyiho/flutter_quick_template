// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'test_info.g.dart';

@JsonSerializable()
class TestInfo {
	int age;
	String name;
  TestInfo({
    this.age = 0,
    this.name = '',
  });

	factory TestInfo.fromJson(Map<String, dynamic> json) => 
			_$TestInfoFromJson(json);
	Map<String, dynamic> toJson() => _$TestInfoToJson(this);

  TestInfo copyWith({
    int? age,
    String? name,
  }) {
    return TestInfo(
      age: age ?? this.age,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'age': age,
      'name': name,
    };
  }

  @override
  String toString() => 'TestInfo(age: $age, name: $name)';

  @override
  bool operator ==(covariant TestInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.age == age &&
      other.name == name;
  }

  @override
  int get hashCode => age.hashCode ^ name.hashCode;
}
