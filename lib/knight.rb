Move = Struct.new(:x, :y, :depth, :children, :parent)

VECTORS = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]

class MoveTree

  attr_reader :starting_pos, :max_depth, :current_pos, :turns

  def initialize(starting = [3,3], max_depth = 6)
    @starting_pos = Move.new(starting[0], starting[1], 0)
    @max_depth = max_depth
    @current_pos = @starting_pos
    @turns = 0
    build_trees(@starting_pos)
    inspect
    move_inspect
  end

  def build_move(x, y)
    Move.new(x, y)
  end

  def build_trees(starting_pos)
    return if starting_pos.depth == @max_depth
    moves = moves_array(starting_pos)
    moves.each do |move|
      connect_move_to_parent(move, starting_pos)
    end
    starting_pos.children.each do |child|
      build_trees(child)
    end
  end


  def connect_move_to_parent(move, parent)
    grandparent = parent.parent
    if grandparent.nil? || grandparent.x != move.x && grandparent.y != move.y
      parent.children ||= []
      parent.children << move
      move.parent = parent
      move.depth = parent.depth + 1
    end
  end

  def moves_array(starting_pos)

    x = starting_pos.x
    y = starting_pos.y
    possible_moves = []

    VECTORS.each do |move|
      possible_moves << [x + move[0], y + move[1]]
    end

    possible_moves.select! { |move| move[0] < 7 && move[1] < 7 && move[0] >= 0 && move[1] >= 0 }
    possible_moves.map! do |move|
      Move.new(move[0], move[1])
    end
    
    possible_moves
  end

  def inspect
    puts "This tree starts at [#{@starting_pos.x}, #{@starting_pos.y}]."
    puts "This tree is #{@max_depth} moves deep."
  end

  def move_inspect
    puts "At #{@turns} turns, the potential valid moves are:"
    moves_array(@current_pos).each{|move| puts "[#{move.x}, #{move.y}]".center(10)}
    puts
  end

  def move(x,y) 
    potential_moves = []
    moves_array(@current_pos).each do |move| 
      potential_moves << [move.x, move.y]
    end
    if potential_moves.include?([x, y])
      @current_pos = scan(x, y, @current_pos)
      @turns += 1
    else 
      puts "That is not a valid move."
    end
    move_inspect
  end

  def scan(x, y, current_pos)
    current_pos.children.each do |child|
       return child if child.x == x && child.y == y
    end
  end
end
