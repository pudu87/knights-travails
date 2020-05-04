require_relative 'node.rb'

class Knight
  attr_accessor :board

  MOVESETS = [-2, -1, 1, 2].permutation(2).to_a.
                            filter { |set| (set[0] * set[1]).abs == 2 }
  def initialize
    @board = Array.new(8) { Array.new (8) }
  end

  def build_tree(queue)
    return if queue.empty?
    (queue.size).times do
      create_children(queue)
      queue.shift
    end
    build_tree(queue)
  end

  def find_target(x, y, queue)
    (queue.size).times do
      queue[0].children.each do |node|
        return node if (node.x == x && node.y == y)
        queue << node
      end
      queue.shift
    end
    find_target(x, y, queue)
  end

  def find_path(node, path=[])
    return unless node
    find_path(node.parent, path)
    path << [node.x, node.y]
  end

  private

  def create_children(queue, node=queue[0])
    MOVESETS.each do |set|
      x = node.x + set[0]
      y = node.y + set[1]
      if valid?(x, y)
        node.children << Node.new(x, y, node)
        queue << node.children[-1]
        board[x][y] = true
      end
    end
  end

  def valid?(x, y)
    (0..7).include?(x) && (0..7).include?(y) && !board[x][y]
  end
end


def knight_moves(start, destination)
  knight = Knight.new
  root = Node.new(start[0], start[1])
  knight.build_tree([root])
  target = knight.find_target(destination[0], destination[1], [root])
  path = knight.find_path(target)
  p path
end

knight_moves([0,0], [7,7])
knight_moves([7,7], [0,0])
knight_moves([3,4], [4,4])