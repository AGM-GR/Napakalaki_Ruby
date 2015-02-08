# encoding: UTF-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'treasure'
require_relative 'monster'
require 'player'

module Napakalaki
  
  class CultistPlayer < Player
    
    attr_reader :totalCultistPlayers
    
    @@totalCultistPlayers = 0
    
    def initialize(player,cultist)
      
      newCopia(player)
      @cultistCard = cultist
      @@totalCultistPlayers += 1
      
    end
    
    def getCombatLevel
      
      return (super + @cultistCard.getSpecialValue)
      
    end
    
    def computeGoldCoinsValue(trs)
      
      return (super(trs) * 2)
      
    end
    
    def getOponentLevel(monster)
      
      return (monster.getSpecialValue)
      
    end
    
    def shouldConvert
      
      return false
      
    end
    
    def self.getTotalCultistPlayers
      
      return @@totalCultistPlayers
      
    end
    
    def to_s

      "#{@name} ,Nivel: #{@level}, Cultist."

    end
    
  end

end
