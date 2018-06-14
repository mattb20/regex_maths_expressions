# Objectify Tech Test

### Description
In order to make your team more efficient in writing well-tested code, you have been tasked to develop an **extremely important** utility that converts a string which is the LaTeX syntax for a mathematical expression into the relevant Ruby objects.  It is estimated this utility method improves overall code writing productivity by 5-10%!

### Task
Extend `String class` with a function called `objectify` which converts a Latex string such as `'\frac{2x+3}{x-4}'` into our corresponding Ruby objects.  For example, calling `objectify` on the string `"2+3"` should return an instance of `Addition`, with arguments of 2 and 3.  That is `"2+3".objectify` should return `Addition.new(2,3)`.

### Examples
```ruby
# Addition :add
'-2+3'.objectify
=> Addition.new(-2, 3)

# Multiplication :mtp
'2xy'.objectify
=> Multiplication.new(2, 'x', 'y')

# Division :div
'\frac{-2}{3}'.objectify
=> Division.new(-2, 3)

'\frac{-14x}{25}'.objectify
=> div(mtp(-14, 'x'), 25)  #factory methods see notes
```
> For more examples please refer to the spec file `spec/lib/string_spec.rb`

### Notes
* Review the models for basic `Addition`, `Multiplication` objects in the lib folder.
* Arguments in general can be input in two ways:  as an `Array` of arguments e.g. `Addition.new([2,3,4])`, or as individual arguments e.g. `Addition.new(2,3,4)`.
* `Division` takes two arguments, you can make use the alias setter and getter methods for numerator / top and denominator / bot.
*  **You should make use of our basic factories**.  For example `add(2,3)` is the same as `Addition.new(2,3)`.


### Requirements
* Make all the tests pass up to line 108 of the spec file.

### Getting Started
* Install ruby 2.3.1+
* From the project directory run `bundle install`
* Check the test spec in `./spec/string_spec.rb`
* Write your code in `./lib/string.rb`
* Run `rspec` from the project directory to check your progress.
* Run `rspec ./spec/lib/string_spec.rb:4` to run only the test starting on line 4.

### Hints
* You are not limited to having only a single function, should you see it appropriate you can add more supporting functions.</br>
* The task can be completed without the use of regular expressions, however, it is recommended that you make use of regular expressions.


### Extension - include powers
* Factory: Power - `pow` takes two arguments first argument `base` and second argument `index`
* Example: `objectify('(-12)^{-31x}') => pow(-12, mtp(-31, 'x')) #base=-12, index=mtp(-31, 'x')`
* Should you wish to do the extension, simply remove the 'x' at the beginning of line 109 of the test file.

### To use
* Install ruby 2.5+
* run rvm use 2.5.0
* From the project directory run `bundle install`
* Check the test spec in `./spec/string_spec.rb`
* Run `rspec` from the project directory to check your progress.


### My approach
I began by trying to write regexs to match addition expressions however after a short amount of time, I realised it would probably be easier to match division first as all division expressions contained the keyword 'frac'. I firstly decided to try to match and extract the arguments of a division expression using two real numbers, no algebra at this point. I commented out all the tests that did not relate to the first tier of division expressions in the spec file. Playing around with irb helped me to extract the arguments from the regex if there was a match. I began by solely using the match method in RegEx Ruby class but switched to using scan as this would provide me with both real number arguments if there was a match to fractional expression. Using scan with a regex extracted the real number arguments in string form inside an array and then I used Ruby built in array method map to map the strings to integers and pass them to div.

I then moved onto the second division involving letters. I was originally going to use two separate conditionals to match the last two fractions. But realised I could combine them both into one conditional so I did that. When I had passed each of the fraction tests I refactored the code by extracting converting the string arguments to integer if they are digits to a separate method.
