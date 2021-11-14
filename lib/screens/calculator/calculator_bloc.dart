
import 'dart:async';
import 'package:eigital_sample_app/screens/calculator/calculator_event.dart';
import 'package:eigital_sample_app/screens/calculator/calculator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState>{


  CalculatorBloc() : super(CalculatorState(input: '')) {
    on<CalculatorInputEvent>(_onInput);
  }

  Future<void> _onInput(CalculatorInputEvent event, Emitter<CalculatorState> emitter) async {
    if(event.input == 'DEL') {
      if(state.input.isNotEmpty){
        emitter(CalculatorState(input: state.input.substring(0,state.input.length - 1),output: state.output));
      }
    }
    else if(event.input == 'C') {
      emitter(CalculatorState(input: '',output: 0.0));
    }
    else if(event.input == '='){
      try{
        var formattedInput = state.input.replaceAll('x', '*');
        Parser parser = new Parser();
        Expression exp = parser.parse(formattedInput);
        ContextModel cm = ContextModel();
        double result = exp.evaluate(EvaluationType.REAL, cm);
        emitter(CalculatorState(input: state.input,output: result));
      }
      catch (e){
        emitter(CalculatorState(input: state.input,output: double.nan));
      }
    }
    else if(event.input == '('){
      emitter(CalculatorState(input: state.input + '(',output: state.output));
    }
    else if(event.input == ')'){
      emitter(CalculatorState(input: state.input + ')',output: state.output));
    }
    else {
      emitter(CalculatorState(input: state.input + event.input,output: state.output));
    }
  }
}