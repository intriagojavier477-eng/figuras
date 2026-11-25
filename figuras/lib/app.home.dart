import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key, required this.title});

  final String title;

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final TextEditingController _baseController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  String _tituloResultado = "";
  String _valorResultado = "";
  bool _esError = false;

  void _calcularArea() {
    final double? base = double.tryParse(_baseController.text);
    final double? altura = double.tryParse(_alturaController.text);

    setState(() {
      if (base != null && altura != null && base > 0 && altura > 0) {
        final double area = (base * altura) / 2;
        _tituloResultado = "Área del Triángulo";
        _valorResultado = "${area.toStringAsFixed(2)} u²";
        _esError = false;
      } else {
        _tituloResultado = "Datos inválidos";
        _valorResultado = "Ingresa valores mayores a 0 en Base y Altura";
        _esError = true;
      }
    });
  }

  void _calcularPerimetro() {
    final double? base = double.tryParse(_baseController.text);
    final double? altura = double.tryParse(_alturaController.text);

    setState(() {
      if (base != null && altura != null && base > 0 && altura > 0) {
        final double hipotenusa = sqrt(pow(base, 2) + pow(altura, 2));
        final double perimetro = base + altura + hipotenusa;
        _tituloResultado = "Perímetro del Triángulo";
        _valorResultado = "${perimetro.toStringAsFixed(2)} u";
        _esError = false;
      } else {
        _tituloResultado = "Datos inválidos";
        _valorResultado = "Ingresa valores mayores a 0 en Base y Altura";
        _esError = true;
      }
    });
  }

  void _limpiar() {
    setState(() {
      _baseController.clear();
      _alturaController.clear();
      _tituloResultado = "";
      _valorResultado = "";
      _esError = false;
    });
  }

  @override
  void dispose() {
    _baseController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtro que bloquea letras y símbolos, permitiendo solo números y un punto decimal
    final List<TextInputFormatter> filtroSoloNumeros = [
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF12141D),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF1E2230),
        foregroundColor: Colors.amberAccent,
        leading: const Icon(Icons.calculate_rounded),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        actions: [
          IconButton(
            onPressed: _limpiar,
            tooltip: "Limpiar campos",
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                color: const Color(0xFF1E2230),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.amberAccent.withOpacity(0.25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Encabezado de la figura con icono
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.amberAccent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.change_history_rounded,
                              color: Colors.amberAccent,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Triángulo",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Cálculo de área y perímetro",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Campo Base
                      TextField(
                        controller: _baseController,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: filtroSoloNumeros,
                        decoration: InputDecoration(
                          labelText: "Base",
                          hintText: "Ej. 10.5",
                          labelStyle: const TextStyle(color: Colors.white70),
                          hintStyle: const TextStyle(color: Colors.white30),
                          prefixIcon: const Icon(
                            Icons.straighten_rounded,
                            color: Colors.amberAccent,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF151823),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: Colors.amberAccent, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Campo Altura
                      TextField(
                        controller: _alturaController,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: filtroSoloNumeros,
                        decoration: InputDecoration(
                          labelText: "Altura",
                          hintText: "Ej. 8.0",
                          labelStyle: const TextStyle(color: Colors.white70),
                          hintStyle: const TextStyle(color: Colors.white30),
                          prefixIcon: const Icon(
                            Icons.height_rounded,
                            color: Colors.amberAccent,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF151823),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: Colors.amberAccent, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Botones de Área y Perímetro con icono
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _calcularArea,
                              icon: const Icon(Icons.square_foot_rounded),
                              label: const Text(
                                "Área",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amberAccent,
                                foregroundColor: const Color(0xFF12141D),
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _calcularPerimetro,
                              icon: const Icon(Icons.architecture_rounded),
                              label: const Text(
                                "Perímetro",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.amberAccent,
                                side: const BorderSide(color: Colors.amberAccent, width: 1.5),
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Tarjeta animada de resultado
                      if (_valorResultado.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _esError
                                ? Colors.redAccent.withOpacity(0.15)
                                : Colors.amberAccent.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _esError ? Colors.redAccent : Colors.amberAccent,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _esError
                                    ? Icons.error_outline_rounded
                                    : Icons.check_circle_outline_rounded,
                                color: _esError ? Colors.redAccent : Colors.amberAccent,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _tituloResultado,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: _esError ? Colors.redAccent : Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _valorResultado,
                                      style: TextStyle(
                                        fontSize: _esError ? 14 : 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}