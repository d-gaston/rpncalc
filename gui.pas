unit GUI;
(*
This form contains code for the button interactions. The form has access to
an operandStack object which it uses to maintain the calculator state.
There are two main types of buttons: number input buttons and operator buttons
Clicking a button always clears the Error label (and may or may not change it
to something else depending on whether or not an error occurrs).
Each operation that changes the stack also calls the writeStackToListBox
to update the display.

Number input:
Numbers are input by appending digits to a string variable (numberString).
A decimal point may be appended as well, but multiple decimal points cannot
be appended (will result in a message being displayed in the Error label)

Operator input:
operators are divided into two kinds: arithmetic and stack.

Arithmetic operators are responsible for popping two numbers off the stack,
applying a binary arithmetic operator (+ - * /) and pushing the result of the
operation onto the stack. Since RPN transforms a binary expression from the
form A + B to A B + the first operand (op1) will be the second item on the stack
and the second operand (op2) will be on the top of the stack. A check is done
before each operation to ensure that there are at least 2 items on the stack. If
the check fails, the stack is unaffected and the Error label displays a message.
If a division by 0 is attempted then an error message is displayed.

Stack operators (push, pop, swap, dup) manipulate the items on the stack without
changing their values.
Push - Converts the the value after the Input> label (contained in numberString)
       to a Double and pushes it onto the stack.
       Displays error message:
             -If numberString is blank an error message
             -If the max capacity is reached (currently 1000)
Pop  - Deletes the top item on the stack. A stack of 1 2 3 become 1 2
       Displays error message:
             -If stack is empty
Dup  - Duplicates the top item on the stack. A stack of 1 2 3 become 1 2 3 3
       Displays error message:
             -If stack is empty
             -If max capacity has been reached
Swap - Swaps the top two items on the stack. A stack of 1 2 3 becomes 1 3 2
       Displays error message:
             -If there are fewer than 2 items on the stack
*)
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, stack;

type

  { TCalcForm }

  TCalcForm = class(TForm)




    Button0: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    DecimalButton: TButton;

    PlusButton: TButton;
    MinusButton: TButton;
    MultButton: TButton;
    DivButton: TButton;
    PushButton: TButton;
    PopButton: TButton;
    DupButton: TButton;
    SwapButton: TButton;

    InputLabel: TLabel;
    ErrorLabel: TLabel;
    StackLabel: TLabel;
    PromptLabel: TLabel;
    StackListBox: TListBox;

    procedure Button0Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure DecimalButtonClick(Sender: TObject);
    procedure DivButtonClick(Sender: TObject);
    procedure DupButtonClick(Sender: TObject);
    procedure PopButtonClick(Sender: TObject);
    procedure PushButtonClick(Sender: TObject);
    procedure MinusButtonClick(Sender: TObject);
    procedure MultButtonClick(Sender: TObject);
    procedure PlusButtonClick(Sender: TObject);
    procedure SwapButtonClick(Sender: TObject);


  private

  public

  end;
(*
Helper procedure to display the stack on the form. A listBox was used
since it will automatically provide scrolling functionality if more inputs
are pushed than will fit on the screen.
*)
procedure writeStackToListBox;

var
  //The actual instance of the form.
  CalcForm: TCalcForm;
  numberString: string;

implementation

{$R *.lfm}

{ TCalcForm }


{ Number Input }
procedure TCalcForm.Button0Click(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  AppendStr(numberString, '0');
  InputLabel.Caption := numberString;
end;

procedure TCalcForm.Button1Click(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  AppendStr(numberString, '1');
  InputLabel.Caption := numberString;
end;

procedure TCalcForm.Button2Click(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  AppendStr(numberString, '2');
  InputLabel.Caption := numberString;
end;

procedure TCalcForm.Button3Click(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  AppendStr(numberString, '3');
  InputLabel.Caption := numberString;
end;

procedure TCalcForm.Button4Click(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  AppendStr(numberString, '4');
  InputLabel.Caption := numberString;
end;

procedure TCalcForm.Button5Click(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  AppendStr(numberString, '5');
  InputLabel.Caption := numberString;
end;

procedure TCalcForm.Button6Click(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  AppendStr(numberString, '6');
  InputLabel.Caption := numberString;
end;

procedure TCalcForm.Button7Click(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  AppendStr(numberString, '7');
  InputLabel.Caption := numberString;
end;

procedure TCalcForm.Button8Click(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  AppendStr(numberString, '8');
  InputLabel.Caption := numberString;
end;

procedure TCalcForm.Button9Click(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  AppendStr(numberString, '9');
  InputLabel.Caption := numberString;
end;

procedure TCalcForm.DecimalButtonClick(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  if (numberString.CountChar('.') = 0) then
  begin
    AppendStr(numberString, '.');
    InputLabel.Caption := numberString;
  end
  else
      ErrorLabel.Caption := 'Error: Number already has decimal point';

end;

{ Stack Operators }

procedure TCalcForm.DupButtonClick(Sender: TObject);
var
  tmp: double;
begin
  ErrorLabel.Caption := 'Error: ';
  if operandStack.Size > 0 then
  begin
    if operandStack.Size < operandStack.capacity then
    begin
      tmp := operandStack.Pop;
      operandStack.Push(tmp);
      operandStack.Push(tmp);
      writeStackToListBox();
    end
    else
      ErrorLabel.Caption := 'Error: Max stack capacity reached';
  end
  else
    ErrorLabel.Caption := 'Error: Stack is empty';
end;

procedure TCalcForm.SwapButtonClick(Sender: TObject);
var
  First: double;
  second: double;
begin
  ErrorLabel.Caption := 'Error: ';
  if operandStack.Size >= 2 then
  begin
    First := operandStack.Pop;
    second := operandStack.Pop;
    operandStack.Push(First);
    operandStack.Push(second);
    writeStackToListBox();
  end
  else
    ErrorLabel.Caption := 'Error: Insufficient items on stack';
end;

procedure TCalcForm.PopButtonClick(Sender: TObject);
begin
  ErrorLabel.Caption := 'Error: ';
  if operandStack.Size > 0 then
  begin
    operandStack.Pop;
    writeStackToListBox();
  end
  else
    ErrorLabel.Caption := 'Error: Stack is empty';
end;

procedure TCalcForm.PushButtonClick(Sender: TObject);
var
  operand: double;
begin
  ErrorLabel.Caption := 'Error: ';
  if (Length(numberString) > 0) then
  begin
    if operandStack.Size < operandStack.capacity then
    begin
      operand := StrToFloat(numberString);
      writeln(FloatToStr(operand));
      operandStack.push(StrToFloat(numberString));
      writeStackToListBox();
    end
    else
      ErrorLabel.Caption := 'Error: Max stack capacity reached';
  end
  else
    ErrorLabel.Caption := 'Error: Nothing to push';
  numberString := '';
  InputLabel.Caption := numberString;
end;

{ Arithmetic Operators }


procedure TCalcForm.DivButtonClick(Sender: TObject);
var
  quotient: double;
  op1: double;
  op2: double;
begin
  ErrorLabel.Caption := 'Error: ';
  if operandStack.Size >= 2 then
  begin
    if operandStack.Peek(operandStack.Size - 1) <> 0 then
    begin
      op2 := operandStack.Pop;
      op1 := operandStack.Pop;
      quotient := op1 / op2;
      operandStack.Push(quotient);
      writeStackToListBox();
    end
    else
      ErrorLabel.Caption := 'Error: Cannot divide by zero';
  end
  else
    ErrorLabel.Caption := 'Error: Insufficient operands on stack';
end;

(*
Note: This only implements the binary operator
*)
procedure TCalcForm.MinusButtonClick(Sender: TObject);
var
  difference: double;
  op1: double;
  op2: double;
begin
  ErrorLabel.Caption := 'Error: ';
  if operandStack.Size >= 2 then
  begin
    op2 := operandStack.Pop;
    op1 := operandStack.Pop;
    difference := op1 - op2;
    operandStack.Push(difference);
    writeStackToListBox();
  end
  else
    ErrorLabel.Caption := 'Error: Insufficient operands on stack';
end;

procedure TCalcForm.MultButtonClick(Sender: TObject);
var
  product: double;
  op1: double;
  op2: double;
begin
  ErrorLabel.Caption := 'Error: ';
  if operandStack.Size >= 2 then
  begin
    op2 := operandStack.Pop;
    op1 := operandStack.Pop;
    product := op1 * op2;
    operandStack.Push(product);
    writeStackToListBox();
  end
  else
    ErrorLabel.Caption := 'Error: Insufficient operands on stack';
end;

procedure TCalcForm.PlusButtonClick(Sender: TObject);
var
  sum: double;
  op1: double;
  op2: double;
begin
  ErrorLabel.Caption := 'Error: ';
  if operandStack.Size >= 2 then
  begin
    op2 := operandStack.Pop;
    op1 := operandStack.Pop;
    sum := op1 + op2;
    operandStack.Push(sum);
    writeStackToListBox();
  end
  else
    ErrorLabel.Caption := 'Error: Insufficient operands on stack';
end;


(*Clears and repopulates the listbox on each call. Not the most efficient,
but at this scale it's not worth the trouble of juggling the list and the stack*)
procedure writeStackToListBox;
var
  i: integer;
begin
  CalcForm.StackListBox.Items.Clear;
  for i := 0 to operandStack.Size - 1 do
  begin
    CalcForm.StackListBox.Items.Add(FloatToStr(operandStack.Peek(i)));
  end;
end;

end.
