# RPN Calculator
This is a simple reverse polish notation calculator app I made to learn a bit about the Lazarus development environment and Pascal programming language. The GUI isn't going to win any awards, but it's functional. In addition to the following usage guide, the source code has quite a few comments.

## Usage
The application has the following displays:
+ **Input>** shows the current input prompt. This is reset when the value is pushed to the stack.
+ **Error:** shows any error messages generated by the operators
+ **Stack:** a list showing the current stack, one item on each line. The stack grows downward.

The application has the following buttons:
+ **0-9**: Input a digit that is appended to the prompt following the **Input>** label
+ **.** : Input a decimal point that is appended to the prompt following the **Input>** label. Only one decimal point can be input.
+ **+** : Addition, adds the top two numbers on the stack and pushes the result onto the top of the stack. `1 2 3` --> `1 5`
+ **-** : Subtraction, adds the top two numbers on the stack and pushes the result onto the top of the stack. `1 2 3` --> `1 -1`
+ **\*** : Multiplication, adds the top two numbers on the stack and pushes the result onto the top of the stack. `1 2 3`--> `1 6`
+ **/**: Division, adds the top two numbers on the stack and pushes the result onto the top of the stack. `1 2 3` -->
`1 0.66...` 
+ **push**: Converts the number string in the input prompt to a double and pushes the result onto the stack. Displays an error message if the input prompt is empty or if the stack's max capacity has been reached.
+ **pop**: Deletes the top item off of the stack. Displays an error message if the stack is empty. `1 2 3` --> `1 2`
+ **dup**: Duplicates the top item on the stack. Displays an error message if the stack is empty or if the stack's max capacity has been reached. `1 2 3` --> `1 2 3 3`
+ **swap**: Swaps the top two numbers on the stack. Displays an error message if there are fewer than 2 numbers on the stack. `1 2 3` --> `1 3 2`