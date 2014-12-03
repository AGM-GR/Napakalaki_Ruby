#encoding: UTF-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'prize'
require_relative 'bad_consequence'

module Napakalaki

  class Monster

    attr_reader :name,:combatLevel,:badConsequence,:prize;

    def initialize (name = "", combatLevel = 0, badConsequence = BadConsequence.new(), prize = Prize.new())

      @name = name
      @combatLevel = combatLevel
      @prize = prize
      @badConsequence = badConsequence

    end

    def Monster.newCombatlevel(name, combatLevel)

      new(name, combatLevel, BadConsequence.new(), Prize.new())

    end

    def Monster.newBadConsequencePrize(name,combatLevel,badConsequence,prize)

      new(name, combatLevel, badConsequence, prize)

    end

    def to_s

      "Nombre Monstruo: #{@name} ,Nivel: #{@combatLevel} ,Mal rollo: #{@badConsequence.to_s}"

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

  end

end
