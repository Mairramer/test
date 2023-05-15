import 'package:flutter/material.dart';
import 'package:test/common/layout/app_sizes.dart';
import 'package:test/common/layout/app_strings.dart';
import 'package:test/common/layout/app_typography.dart';
import 'package:test/core/random_color_generator.dart';

/// This is the home screen of the app
class HomeScreen extends StatefulWidget {
  /// Constructor
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _colorTextEditingController = TextEditingController();

  final AppStrings _appStrings = AppStringsImpl();
  RandomColorGenerator _colorGenerator = RandomColorGenerator();
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  bool _isGradient = false;
  List<Color> _gradientColors = [
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    _colorGenerator = RandomColorGenerator();
    _backgroundColor = _colorGenerator.nextColor();
    _textColor = _colorGenerator.getTextColor(_backgroundColor);
    _isGradient = false;
  }

  @override
  void dispose() {
    _colorTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _changeBackgroundColor(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              _appStrings.titleHomeScreen,
              style: AppTypography.typographyHeader3,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _toggleIsGradient,
              icon: Icon(_isGradient ? Icons.color_lens : Icons.gradient),
            ),
          ],
        ),
        body: Stack(
          children: [
            DecoratedBox(
              key: UniqueKey(),
              decoration: BoxDecoration(
                color: _isGradient ? null : _backgroundColor,
                gradient: _isGradient
                    ? LinearGradient(
                        colors: _gradientColors,
                        begin: _colorGenerator.generateRandomAlignment(),
                        end: _colorGenerator.generateRandomAlignment(),
                        tileMode: TileMode.mirror,
                      )
                    : null,
              ),
              child: Center(
                child: Text(
                  _appStrings.hello,
                  style: AppTypography.typographyHeader3.copyWith(
                    color: _textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (_isGradient)
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(AppSizes.px08),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _colorTextEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Enter a number of colors',
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                  ),
                  onFieldSubmitted: (value) {
                    _changeBackgroundColor(numColors: int.tryParse(value));
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _toggleIsGradient() {
    setState(() {
      _isGradient = !_isGradient;
    });
  }

  void _changeBackgroundColor({int? numColors}) {
    if (_isGradient && _colorTextEditingController.text.isNotEmpty) {
      numColors = int.tryParse(_colorTextEditingController.text);
    }

    final newClampedNumColors = numColors?.clamp(3, 10000) ?? 3;

    setState(() {
      if (_isGradient) {
        _gradientColors = _colorGenerator.generateGradientColors(
          numColors: newClampedNumColors,
        );
      } else {
        _backgroundColor = _colorGenerator.nextColor();
      }
      _textColor = _colorGenerator.getTextColor(
        _isGradient ? _gradientColors.first : _backgroundColor,
        _gradientColors,
      );
    });
  }
}
