enum CouponType { none, fixed, percent }

class CouponModel {
  final CouponType type;
  final double value;

  const CouponModel(this.type, this.value);
}
