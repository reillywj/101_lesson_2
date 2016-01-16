# 1. Greet user to calculator
# 2. Ask user for name
# 3. Ask user for financial information
# 4. Provide monthly interest and monthly payments

require 'yaml'
require 'pry'
MESSAGES = YAML.load_file('annuity_calculator.yml')

def prompt(message)
  puts message
  print "=> "
end

def calculate_monthly_interest(apr) apr/12 end

def convert_years_to_months(years) years*12 end

def calculate_monthly_payment(loan, apr, duration_in_years)
  #presumes no negative inputs
  monthly_interest = calculate_monthly_interest apr/100
  months = convert_years_to_months duration_in_years
  if monthly_interest > 0
    loan*(monthly_interest*(1+monthly_interest)**months)/((1+monthly_interest)**months - 1)
  else monthly_interest == 0
    loan/months
  end
end

def get_valid_name_input
  prompt MESSAGES['prompt_name']
  answer = gets.chomp
  if answer == ''
    prompt MESSAGES['invalid_name']
    get_valid_name_input
  end
  answer
end

def get_valid_integer_input
  answer = gets.chomp
  unless valid_integer? answer
    prompt MESSAGES['invalid_integer']
    get_valid_integer_input
  end
  answer
end

def get_valid_floating_point_input
  answer = gets.chomp
  unless valid_floating_point? answer
    prompt MESSAGES['invalid_floating_point']
    get_valid_floating_point_input
  end
  answer
end

def get_valid_duration_input
  answer = gets.chomp
  unless valid_duration? answer
    prompt MESSAGES['invalid_duration']
    get_valid_duration_input
  end
  answer
end

def valid_floating_point?(string_input)
  Float(string_input) >= 0 rescue false
end

def valid_integer?(string_input)
  Integer(string_input) >= 0 rescue false
end

def valid_duration?(string_input)
  Integer(string_input) > 0 rescue false
end

puts MESSAGES['welcome']


user_name = get_valid_name_input
puts "Hello #{user_name}, let's get started."

prompt MESSAGES['prompt_loan_amount']
loan_amount = get_valid_integer_input.to_i

prompt MESSAGES['prompt_apr']
apr_as_percentage = gets.chomp.to_f

prompt MESSAGES['prompt_loan_duration']
loan_duration_years = get_valid_duration_input.to_i

puts "#{user_name}'s Loan Information:"
puts "Loan Amount: $#{loan_amount}"
puts "Duration: #{loan_duration_years} years"
puts "APR: #{apr_as_percentage}%"

print "Calculating monthly payment..."
10.times do
  sleep 0.2
  print "."
end

monthly_payment = calculate_monthly_payment(loan_amount, apr_as_percentage, loan_duration_years)

puts "Loan Payment Information"
puts "#{user_name}, you will have #{convert_years_to_months loan_duration_years} payments of $#{monthly_payment.round 2} per month, with monthly interest of #{(calculate_monthly_interest apr_as_percentage).round(3)}% (#{apr_as_percentage}% APR)."


