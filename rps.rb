# Rock Paper Scissors!

VALID_CHOICES = %w(r p sc l sp)
WINNING_COMBOS = { rock: %w(lizard scissors), paper: %w(rock spock),
                   scissors: %w(paper lizard), lizard: %w(paper spock),
                   spock: %w(rock scissors) }
NICKNAMES = { 'r' => :rock, 'p' => :paper, 'sc' => :scissors,
              'l' => :lizard, 'sp' => :spock }
GAME_NAME = "Rock, Paper, Scissors, Lizard, Spock"

def win?(player1, player2)
  WINNING_COMBOS[NICKNAMES[player1]].include? NICKNAMES[player2].to_s
end

def display_results(player, computer)
  if player == computer
    prompt "Tie!"
  elsif win? player, computer
    prompt "You won!"
  else
    prompt "You lose!"
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def display_score(score)
  prompt "Player: #{score[0]} v. Computer: #{score[1]}"
end

def end_of_game?(score)
  score.include? 5
end

def display_winner(score)
  if score[0] > score[1]
    prompt "You beat the computer! #{score[0]} to #{score[1]}."
  else
    prompt "Nice try. The computer beat you #{score[1]} to #{score[0]}."
  end
end

def display_choices(player, computer)
  prompt "Player: #{NICKNAMES[player]}"
  prompt "Computer: #{NICKNAMES[computer]}"
end

def page_break
  puts '-' * 40
end

prompt "Welcome to #{GAME_NAME}!"
prompt "This is a duel to 5!"
score = [0, 0]
until end_of_game? score
  choice = ''

  display_score score

  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")

    NICKNAMES.each do |key, value|
      prompt "#{key}::#{value}"
    end

    choice = Kernel.gets.chomp.downcase

    if VALID_CHOICES.include? choice
      break
    else
      prompt "That's not a valid choice."
    end
  end

  computer_choice = VALID_CHOICES.sample
  if win? choice, computer_choice
    score[0] += 1
  elsif choice == computer_choice
    # do nothing
  else
    score[1] += 1
  end

  display_choices choice, computer_choice

  display_results choice, computer_choice

  page_break

  # prompt 'Do you want to play again?'
  # answer = Kernel.gets.chomp.downcase
  # break unless %w(y yes).include? answer
end

display_winner score

prompt "Thank you for playing #{GAME_NAME}!"
