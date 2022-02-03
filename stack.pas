unit stack;
(*
This unit contains a stack class implementation. Since this is a calculator
program, I didn't bother with making it generic or general purpose; it only
needs to hold doubles. I tried to follow the Pascal conventions that I noticed,
but I can't guaranteee that everything in here is idiomatic. Some notes:
-I used a dynamic array because I thought it would be nice to expand and shrink
it at runtime, but ultimately 1000 items is enough for this.
-The array is 0 indexed since that's what I'm used to, I believe 1 indexing
is common in Pascal programs.
   --This is why in the constructor I start the top of the stack at -1. When
   the first item is pushed, the topOfStack operator is incremented, making it
   0, where the first item is.
-The destructor sets the length of the dynamic array to 0. Not sure if this
actually prevents a memory leak, since the destructor is only called when
the form is closed this is a moot point.
-Bounds checks on the stack are done by the callers in the form. I did it this
way because while Push can return a boolean of whether or not it was successful,
Pop needs to return the item that it popped (I guess I don't HAVE to do it this
way, but most stacks work this way). So unless I raise exceptions, it's easier
for the callers to deal with it.
*)
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TStack = class
  strict private
    elements: array of double;
    topOfStack: integer;
  public
    constructor Create;
    destructor Destroy; override;
    function Push(Value: double): boolean;
    function Pop: double;
    function Peek(index: integer): double;
    function Size: integer;
    (*This makes the constant immutable*)
        {$WRITEABLECONST OFF}
  const
    capacity = 1000;
  end;

var
  operandStack: TStack;

implementation

function TStack.Push(Value: double): boolean;
(*
Bounds checks for Push are done by the caller.
*)
begin
    topOfStack := topOfStack + 1;
    elements[topOfStack] := Value;
end;

(*
Pop is only called by operators whose responsibility it is to verify that
the stack has operands to pop. Therefore a stack underflow will be impossible
and we don't need to do any bounds checking here.
*)
function TStack.Pop: double;
begin
  Result := elements[topOfStack];
  topOfStack := topOfStack - 1;
end;

function TStack.Peek(index: integer): double;
begin
  Result := elements[index];
end;

function TStack.Size: integer;
begin
  (*Add 1 because the index starts at 0*)
  Result := topOfStack + 1;
end;

constructor TStack.Create;
begin
  topOfStack := -1;
  setLength(elements, capacity);
end;

destructor TStack.Destroy;
begin
  setLength(elements, 0);
end;

(*
I'm not sure if this is idiomatic for a form application, but I don't know
when else to initialize the stack object for use by the rest of the app
*)
initialization
  begin
    operandStack := TStack.Create;
  end;

finalization
  begin
    operandStack.Destroy;
  end;

end.
