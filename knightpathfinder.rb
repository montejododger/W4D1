require "byebug"
require_relative 'polytree'

class KnightPathFinder 


    #Finds valid moves from a certain position
    def self.valid_moves(pos)
        valid = []
        x, y = pos[0], pos[1]

        horse_index = [-2, 2, -1, 1]
        indexes = horse_index.combination(2).to_a 

        new_pos = indexes.select{ |sub| (-sub[0]) != sub[1]}

        final_pos = new_pos.dup 

        new_pos.each { |sub| final_pos << sub.reverse}


        valid = final_pos.map do |sub|
            [sub[0] + x, sub[1] + y ]
        end

        valid.select do |sub|
            sub[0].between?(0,7) && sub[1].between?(0,7)
        end
    end
    
    attr_accessor :parent, :children, :considered_positions

    def initialize(pos)
        #positions you have done
        @pos = pos
        @considered_positions = [pos]
        @children = []

        #create a one layer polytree for a certain position
        @root_node = PolyTreeNode.new(@pos)

        build_move_tree
    end
    # Write an instance method #new_move_positions(pos); this should call the ::valid_moves class method, 
    # but filter out any positions that are already in @considered_positions.
    # It should then add the remaining new positions to @considered_positions and return these new positions.

    #takes considered positions out from current move-set
    def new_move_positions(pos) 
        temp = KnightPathFinder.valid_moves(pos).select do |sub|
            !@considered_positions.include?(sub)
        end

        temp.each {|ele| @considered_positions << ele}
    end

    def build_move_tree

        # node = @root_node.value
        queue = [@root_node]
        

        until queue.empty?
            first = queue.shift
            current_pos = first.value
            future_pos = new_move_positions(current_pos)
            future_pos.each do |pos|
                next_node = PolyTreeNode.new(pos)
                first.add_child(next_node)
                queue << next_node
            end
        end
    end
end



 