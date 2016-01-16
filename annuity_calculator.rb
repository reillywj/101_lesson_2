# 1. Greet user to calculator
# 2. Ask user for name
# 3. Ask user for financial information
# 4. Provide monthly interest and monthly payments
# 5. Ask if want to calculate more. If yes, loop through 2-5.
# 6. Say good bye.

require 'yaml'
require 'pry'
MESSAGES = YAML.load_file('annuity_calculator.yml')

def title(message)
  puts "#{'*' * 10} #{message} #{'*' * 10}"
end

def standard_line(message = "")
  puts "=>#{message}"
end

def prompt(message)
  standard_line message
  print "> "
end

def monthly_interest(apr)
  apr / 12
end

def years_to_months(years)
  years * 12
end

def calculate_monthly_payment(loan, apr, years)
  mthly_int = monthly_interest apr / 100
  months = years_to_months years
  if mthly_int > 0
    loan * (mthly_int * (1 + mthly_int)**months) / ((1 + mthly_int)**months - 1)
  else
    loan / months
  end
end

def floating_point_input
  answer = gets.chomp
  unless valid_floating_point? answer
    prompt MESSAGES['invalid_floating_point']
    answer = floating_point_input
  end
  answer
end

def duration_input
  answer = gets.chomp
  unless valid_duration? answer
    prompt MESSAGES['invalid_duration']
    answer = duration_input
  end
  answer
end

def valid_floating_point?(string_input)
  Float(string_input) >= 0 rescue false
end

def valid_duration?(string_input)
  Integer(string_input) > 0 rescue false
end

title MESSAGES['welcome']

loop do
  title MESSAGES['get_started']

  prompt MESSAGES['prompt_loan_amount']
  loan_amount = floating_point_input.to_f

  prompt MESSAGES['prompt_apr']
  apr = floating_point_input.to_f
  mthly_int = monthly_interest apr

  prompt MESSAGES['prompt_loan_duration']
  loan_years = duration_input.to_i
  number_of_payments = years_to_months loan_years
  payment = calculate_monthly_payment(loan_amount, apr, loan_years)

  title "Loan Summary"
  standard_line "Loan Amount: $#{loan_amount}"
  standard_line "Duration: #{loan_years} years"
  standard_line "APR: #{apr}%"

  print ">Calculating monthly payment..."
  10.times do
    sleep 0.1
    print "."
  end

  puts ''

  title "Loan Payment Information"
  standard_line "#{number_of_payments} payments"
  standard_line "$#{payment.round 2} per month"
  standard_line "#{(mthly_int).round(3)}% monthly interest (#{apr}% APR)"
  prompt MESSAGES['prompt_continue']
  break unless %w(y yes).include? gets.chomp.downcase
end

standard_line MESSAGES['goodbye']
