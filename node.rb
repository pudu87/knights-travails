class Node
  attr_accessor :x, :y, :children, :parent

  def initialize(x, y, parent=nil)
    @x = x
    @y = y
    @children = []
    @parent = parent
  end
end