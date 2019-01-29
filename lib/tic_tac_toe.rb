class TicTacToe

  WIN_COMBINATIONS = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,4,8],
      [2,4,6],
      [0,3,6],
      [1,4,7],
      [2,5,8]
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  def move(index, player = "X")
    @board[index] = player
  end
  
  def position_taken?(position)
    !(@board[position].nil? || @board[position] == " ")
  end
  
  def valid_move?(position)
    position.between?(0,8) && !position_taken?(position)
  end
  
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    position = input_to_index(input)
    if valid_move?(position)
      move(position, current_player)
      display_board
    else
      turn()
    end
  end
  
  def turn_count
    turns = 0
    @board.each do |space|
      if space == "X" || space == "O"
        turns += 1
      end
    end
    return turns
  end
  
  def current_player
    player_turn = turn_count.even? ? "X" : "O"
    return player_turn
  end
  
  def won?
    ["X", "O"].each do |player|
      WIN_COMBINATIONS.each do |combo|
        if combo.all?{|combo| @board[combo] == player}
          return combo
        end
      end
    end
    return nil
  end
  
  def full?
    @board.all?{|board| board == "X" || board == "O"}
  end
  
  def draw?
    !won?(@board) && full?(@board)
  end
  
  def over?
    won? || full? || draw?
  end
  
  def winner
    won? ? @board[won?[0]] : nil
  end
  
  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end