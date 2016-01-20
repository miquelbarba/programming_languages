# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyTetris < Tetris
  # your enhancements here
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_180_clockwise})
    @root.bind('c', proc {@board.cheat})
  end
end

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  # class array holding all the pieces and their rotations
  All_My_Pieces = All_Pieces +
                  [
                    rotations([[0, 0], [1, 0], [0, 1], [1, 1], [1, 2]]),
                    [ [[0, 0], [-1, 0], [1, 0], [-2, 0], [2, 0]],
                      [[0, 0], [0, -1], [0, 1], [0, 2], [0, -2]]],
                    rotations([[0, 0], [1, 0], [0, 1]])
                  ]
  Cheating_Piece = [[[0, 0]]]

  # your enhancements here
  # class method to choose the next piece
  def self.next_piece (board, cheating = false)
    MyPiece.new(cheating ? Cheating_Piece : All_My_Pieces.sample, board)
  end
  
end

class MyBoard < Board
  # your enhancements here
  def initialize (game)
    super
    @cheating = false
    next_piece
  end

  def rotate_180_clockwise
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end

  def next_piece
    @current_block = MyPiece.next_piece(self, @cheating)
    @cheating = false
    @current_pos = nil
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    @current_pos.each_with_index do |position, index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = position
    end
    remove_filled
    @delay = [@delay - 2, 80].max
  end  

  def cheat
    if @score >= 100 && !@cheating
      @score -= 100
      @cheating = true
    end    
  end
end
