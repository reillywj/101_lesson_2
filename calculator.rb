# ask the user for two numbers
# ask the user for an operation
# perform the operation on the two numbers
# output the results

# answer = Kernel.gets()
# Kernel.puts(answer)

Kernel.puts("Welcome to Calculator!")

Kernel.puts("What's the first number?")
number1 = Kernel.gets().chomp().to_f()

Kernel.puts("What's the second number?")
number2 = Kernel.gets().chomp().to_f()

Kernel.puts("What operation would you like to perform? 1: add 2: subtract 3: multiply 4: divide")
operator_number = Kernel.gets().chomp().to_i

case operator_number
when 1
  operator = "+"
  result = number1 + number2
when 2
  operator = "-"
  result = number1 - number2
when 3
  operator = "*"
  result = number1 * number2
when 4
  operator = "/"
  result = number1 / number2
else
  result = "Invalid input"
end

Kernel.puts("#{number1}#{operator}#{number2} = #{result}")
