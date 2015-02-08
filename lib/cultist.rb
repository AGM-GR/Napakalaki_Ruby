# encoding: UTF-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'card'
require_relative 'cultist_player'

module Napakalaki
  
  class Cultist

    include Card

    def initialize (nam,lvl)

      @name = nam
      @gainedLevels = lvl

    end

    def getBasicValue

      return @gainedLevels

    end

    def getSpecialValue
      
      bonus = CultistPlayer.getTotalCultistPlayers
      
      return (@gainedLevels * bonus)

    end

  end
 
end
