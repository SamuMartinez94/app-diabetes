import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pantalla_bienvenida/resultado.dart';

void main() {
  testWidgets('ResultadoScreen tiene 3 botones de imágenes', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ResultadoScreen(
          bomba: 'bomba1',
          sensor: 'sensor1',
          cateter: 'cateter1',
        ),
      ),
    );

    // Busca todos los GestureDetector
    final botones = find.byType(GestureDetector);

    // Encontrar exactamente 3
    expect(botones, findsNWidgets(3));
  });
}
