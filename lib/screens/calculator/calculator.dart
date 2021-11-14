import 'package:eigital_sample_app/screens/calculator/calculator_bloc.dart';
import 'package:eigital_sample_app/screens/calculator/calculator_event.dart';
import 'package:eigital_sample_app/screens/calculator/calculator_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class CalculatorWidget extends StatelessWidget {
  CalculatorWidget({Key? key}) : super(key: key);

  final List<String> buttons = [
    'C',
    '(',
    ')',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              height: 200,
              child: BlocBuilder<CalculatorBloc, CalculatorState>(
                  bloc: context.read<CalculatorBloc>(),
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(state.input, style: TextStyle(fontSize: 25)),
                        Text(
                            state.output == double.nan
                                ? 'ERR'
                                : state.output.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    );
                  })),
          Expanded(
            child: GridView.builder(
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 20,
                    child: TextButton(
                        child: Text(buttons[index],
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        onPressed: () => context
                            .read<CalculatorBloc>()
                            .add(CalculatorInputEvent(buttons[index]))),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.5, crossAxisCount: 4)),
          )
        ],
      ),
    );
  }
}
