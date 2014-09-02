#! /usr/bin/env ruby

class Player
  def get_move
    raise "Abstract method called"
  end
end

class HumanPlayer < Player
end

class ComputerPlayer < Player
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  print `clear`
  
  class TestPlayer < MiniTest::Unit::TestCase
    def setup
      @player = HumanPlayer.new
      @computer = ComputerPlayer.new
    end
    
    def test_player_creation
      assert @player
    end
    
    def test_computer_creation
      assert @computer
    end
  end
end