# Rock Paper Scissors!

VALID_CHOICES = %w(rock paper scissors)
WINNING_COMBOS = [%w(rock scissors), %w(paper rock), %w(scissors paper)]

def display_results(player, computer)
  if player == computer
    prompt "Tie!"
  elsif WINNING_COMBOS.include? [player, computer]
    prompt "You won!"
  else
    prompt "You lose!"
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets.chomp.downcase

    if VALID_CHOICES.include? choice
      break
    else
      prompt "That's not a valid choice."
    end
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results choice, computer_choice

  prompt 'Do you want to play again?'
  answer = Kernel.gets.chomp.downcase
  break unless %w(y yes).include? answer
end

prompt 'Thank you for playing Rock, Paper, Scissors!'
