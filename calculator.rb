# ask the user for two numbers
# ask the user for an operation
# perform the operation on the two numbers
# output the results

# answer = Kernel.gets()
# Kernel.puts(answer)

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(number)
  number.to_f != 0 || number == '0'
end


prompt "Welcome to Calculator!"

name = ''
loop do
  prompt "What's your name?"
  name = Kernel.gets.chomp
  if name.empty?
    prompt "Make sure to use a valid name"
  else
    break
  end
end

prompt "Hi #{name}. Let's get calculating!"

loop do
  number1 = ''
  loop do
    prompt "What's the first number?"
    number1 = Kernel.gets().chomp()
    if valid_number?(number1)
      break
    else
      prompt "Hmm.. that doesn't look like a valid number"
    end
  end

  number2 = ''
  loop do
    prompt "What's the second number?"
    number2 = Kernel.gets().chomp()
    if valid_number?(number2)
      break
    else
      prompt "Hmm.. that doesn't look like a valid number"
    end
  end
  number1 = number1.to_f
  number2 = number2.to_f
  operator_number = ''
  loop do
    operator_prompt = <<-MSG
What operation would you like to perform?
1: add
2: subtract
3: multiply
4: divide
    MSG
    prompt operator_prompt
    operator_number = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator_number)
      break
    else
      prompt "Invalid operator"
    end
  end
  result = case operator_number
          when '1'
            operator = "+"
            number1 + number2
          when '2'
            operator = "-"
            number1 - number2
          when '3'
            operator = "*"
            number1 * number2
          when '4'
            operator = "/"
            number1 / number2
          else
            "Invalid input"
          end

  prompt "#{number1}#{operator}#{number2} = #{result}"

  prompt "Do you want to perform another calculation? (Y to calculate again)"
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank you, #{name}, for using this Calculator. Have a nice day!"