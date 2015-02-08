# encoding: UTF-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'prize'
require_relative 'bad_consequence'
require_relative 'card'

module Napakalaki

  class Monster
    
    include Card
    
    attr_reader :name,:combatLevel,:badConsequence,:prize,:levelChangeAgainstCultistPlayer;

    def initialize (name = "", combatLevel = 0, badConsequence = BadConsequence.new(), prize = Prize.new(), levelcultist = 0)

      @name = name
      @combatLevel = combatLevel
      @prize = prize
      @badConsequence = badConsequence
      @levelChangeAgainstCultistPlayer = levelcultist

    end

    def Monster.newCombatlevel(name, combatLevel)

      new(name, combatLevel, BadConsequence.new(), Prize.new(),0)

    end

    def Monster.newBadConsequencePrize(name,combatLevel,badConsequence,prize)

      new(name, combatLevel, badConsequence, prize,0)

    end
    
    def Monster.newBadConsequenceCultist(name,combatLevel,badConsequence,prize,levelcultist)

      new(name, combatLevel, badConsequence, prize,levelcultist)

    end
    
    def to_s
      
      if @levelChangeAgainstCultistPlayer == 0 then
        
        "Nombre Monstruo: #{@name} ,Nivel: #{@combatLevel} ,Mal rollo: #{@badConsequence.to_s}"
      
      else
        
        "Nombre Monstruo: #{@name} ,Nivel: #{@combatLevel} ,Mal rollo: #{@badConsequence.to_s}, Bonus contra Sectarios: #{@levelChangeAgainstCultistPlayer}"
        
      end
      
    end 

    def kills

      return @badConsequence.death

    end

    def getLevelsGained

      return @prize.levels

    end

    def getTreasuresGained

      return @prize.treasures

    end
    
    def getBasicValue
    
      return @combatLevel

    end

    def getSpecialValue

      return (@combatLevel + @levelChangeAgainstCultistPlayer)

    end

  end

end
