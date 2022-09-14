import 'dart:math';

class Food {
  factory Food.fromInt(int index) {
    assert(index >= 0 && index <= 6, 'Index is outside of availble foods');
    return _foods[index];
  }

  static List<Food> randomList() {
    final random = Random();

    return List.generate(
        random.nextInt(3) + 2, (index) => Food.fromInt(random.nextInt(7)));
  }

  Food._(this.id, this.label);

  final int id;
  final String label;

  static final List<Food> _foods = [
    Food._(0, 'Bread'),
    Food._(1, 'Coffee'),
    Food._(2, 'Donut'),
    Food._(3, 'Sprinkle'),
    Food._(4, 'Egg'),
    Food._(5, 'Slice'),
    Food._(6, 'Soda'),
  ];
}
