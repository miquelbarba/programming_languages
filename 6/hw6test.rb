require 'minitest/spec'
require 'minitest/autorun'

require_relative './hw6provided'
require_relative './hw6assignment'

class TestMyPiece < MiniTest::Unit::TestCase
  def test_my_all_pieces
    assert_equal MyPiece::All_My_Pieces.size, 10
  end

  def test_next_piece
    refute_equal MyPiece.next_piece(nil).instance_variable_get("@all_rotations"), 
                 MyPiece::Cheating_Piece
  end  

  def test_next_piece_cheating
    assert_equal MyPiece.next_piece(nil, true).instance_variable_get("@all_rotations"), 
                 MyPiece::Cheating_Piece
  end    
end

class TestMyTetris < MiniTest::Unit::TestCase
  def test_key_bindings
    root = MyTetris.new.instance_variable_get("@root").instance_variable_get("@root")
    refute_nil root.bindinfo.index('u')
    refute_nil root.bindinfo.index('c')
    assert_nil root.bindinfo.index('5')
  end

  def test_set_board
    board = MyTetris.new.instance_variable_get("@board")
    assert_instance_of MyBoard, board
  end
end

class TestMyBoard < MiniTest::Unit::TestCase
  def setup
    @board = MyBoard.new(nil)
    @board.instance_variable_set("@score", 120)
  end

  def test_cheat
    assert_equal @board.instance_variable_get("@score"), 120
    assert !@board.instance_variable_get("@cheating")

    @board.cheat

    assert_equal @board.instance_variable_get("@score"), 20
    assert @board.instance_variable_get("@cheating")
  end

  def test_cheat_twice
    assert_equal @board.instance_variable_get("@score"), 120
    assert !@board.instance_variable_get("@cheating")

    @board.cheat
    @board.cheat

    assert_equal @board.instance_variable_get("@score"), 20
    assert @board.instance_variable_get("@cheating")
  end

  def test_cheat_without_score
    @board.instance_variable_set("@score", 99)

    assert_equal @board.instance_variable_get("@score"), 99
    assert !@board.instance_variable_get("@cheating")

    @board.cheat

    assert_equal @board.instance_variable_get("@score"), 99
    assert !@board.instance_variable_get("@cheating")
  end

  def test_cheat_with_score
    @board.instance_variable_set("@score", 100)

    assert_equal @board.instance_variable_get("@score"), 100
    assert !@board.instance_variable_get("@cheating")

    @board.cheat

    assert_equal @board.instance_variable_get("@score"), 0
    assert @board.instance_variable_get("@cheating")
  end

  def test_rotate_180_clockwise
    current_block = MiniTest::Mock.new
    current_block.expect(:move, true, [0, 0, 2])
    game = MiniTest::Mock.new
    game.expect(:is_running?, true)
    game.expect(:draw_piece, true, [current_block, [1, 1]])

    @board.instance_variable_set("@current_block", current_block)
    @board.instance_variable_set("@game", game)

    @board.rotate_180_clockwise

    current_block.verify
  end

  def test_next_piece_no_cheating
    @board.instance_variable_set("@cheating", false)

    @board.next_piece

    refute_equal @board.instance_variable_get("@current_block").instance_variable_get("@all_rotations"), 
                 MyPiece::Cheating_Piece
    assert !@board.instance_variable_get("@cheating")
    assert_nil @board.instance_variable_get("@current_pos")
  end

  def test_next_piece_cheating
    @board.instance_variable_set("@cheating", true)

    @board.next_piece

    assert_equal @board.instance_variable_get("@current_block").instance_variable_get("@all_rotations"), 
                 MyPiece::Cheating_Piece
    assert !@board.instance_variable_get("@cheating")
    assert_nil @board.instance_variable_get("@current_pos")
  end
end