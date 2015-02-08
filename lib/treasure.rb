# encoding: UTF-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'card'

module Napakalaki

  class Treasure
    
    include Card
    
    attr_reader :name,:goldCoins,:minBonus,:maxBonus,:Type;

    def initialize (name, goldCoins, min, max, treasurekind)

      @name = name
      @goldCoins = goldCoins
      @minBonus = min
      @maxBonus = max
      @Type = treasurekind

    end

    def to_s

      "#{@name} ,Type #{@Type} ,Max.Bonus #{@maxBonus} ,Min.Bonus #{@minBonus} ,Gold coins #{@goldCoins}"

    end

    def getType
    
      return @Type
      
    end
    
    def getBasicValue
    
      return @minBonus

    end

    def getSpecialValue

      return @maxBonus

    end
    
  end

end