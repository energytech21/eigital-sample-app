
abstract class CalculatorEvent {}

class CalculatorInputEvent extends CalculatorEvent {
  final String input;

  CalculatorInputEvent(this.input);
}