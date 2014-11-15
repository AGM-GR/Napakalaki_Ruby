#encoding: UTF-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'Prize.rb'
require_relative 'BadConsequence.rb'

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
  
    "Nombre Monstruo: #{@name} \n Nivel: #{@combatLevel}"
  
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
