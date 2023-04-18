# require_relative 'knightpathfinder'
class PolyTreeNode
    
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end
    
    def parent=(other_node)
        if other_node == nil
            self.parent.children.delete(self)
            @parent = other_node
        elsif @parent.nil?
            @parent = other_node
            other_node.children << self
        else 
            self.parent.children.delete(self)
            @parent = other_node
            other_node.children << self
        end

    end
    
    def add_child(child_node)
        child_node.parent = self 
        
    end
    
    def remove_child(child_node)
        child_node.parent = nil
    end


    # def inspect
    #     { 'value' => @value, 'parent_value' => @parent.value }.inspect
    # end
    #################################################
    #Searchable
    
    #depth --- REcursive
    def dfs(target_value)
        return nil if self.nil?
        return self if self.value == target_value
       
        self.children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end
      return nil
    end
    
    #breadth
    def bfs(target_value) # %[f a g x]
        queue = [self]
        loop do
            first = queue.shift
            return first if first.value == target_value
            queue.concat(first.children)
            return nil if queue.empty?
        end
        
    end

end
