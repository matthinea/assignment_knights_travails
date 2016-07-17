require_relative 'knight'

class KnightSearcher

  def initialize(moves_tree)
    @start = moves_tree.starting_pos
    @max_depth = moves_tree.max_depth
  end

  def bfs_for(start, target_coords)
    # Upon locating the target square, the method should output 
    # the sequence of moves used to get there as well as the final depth required.

    # if start.x,y are target, return start
    # else, iterate through children of start
    # if a child.x,y are target, return that child
    # if no children.x,y are target, iterate through all the children of all the children of start
    # etc
    
    until start.depth > @max_depth

      if match?(start, target_coords)
        puts "Found after #{start.depth} moves."
        puts "Move sequence (backwards from target):"
        until start.parent.nil?
          puts start.parent
        end 
      end 
      # needs to be implemented using a queue

    end

    

  end

  def match?(current, target) # match? takes a Move node with a target (x,y) pair
    return true if current.x == target[0] && current.y == target[1]
    false
  end

end