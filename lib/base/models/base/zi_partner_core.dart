import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'zi_partner_core.g.dart';

@JsonSerializable()
class ZiPartnerCore {
  late String? id;
  late DateTime? inclusion;
  late DateTime? alteration;
  @JsonKey(fromJson: fromJsonActive)
  late bool? active;
  static bool fromJsonActive(dynamic value) => value is int ? value == 1 : value ?? true;

  ZiPartnerCore({
    this.id,
    this.inclusion,
    this.alteration,
    this.active,
  }) {
    id ??= const Uuid().v4();
    inclusion ??= DateTime.now();
    active ??= true;
  }
}
