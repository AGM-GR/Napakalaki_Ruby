# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'TreasureKind.rb'

class Treasure
  
  attr_reader :name,:goldCoins,:minBonus,:maxBonus,:Type;
  
  def initialize (name, goldCoins, min, max, treasurekind)
    
    @name = name
    @goldCoins = goldCoins
    @minBonus = min
    @maxBonus = max
    @Type = treasurekind
    
  end
  
  
end
