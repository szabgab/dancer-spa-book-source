# Calculator

The Calculator examples is really just a simple extension of the echo example. Here the HTML page has two input boxes and a button. The two boxes are expected to receive two numbers. When the user presses the button the application sends the values from the two input boxes to the server that returns the sum of the two numbers.

![code/calc.psgi](code/calc.psgi)

## Testing

The testing is also quite similar, but this time we send two values in the hash of the POST request.

![code/calc.t](code/calc.t)

## Exercise calculator {#exercise-calculator}

* Change the calculator so it will have 3 fields. 2 for numbers and one in the middle for an operator.
* Change the jQuery code to send all 3 values to the back-end.
* Change the back-end to accept all 3 values and calculate the result based on the provided operator.

Check the [solutions](#solutions)

