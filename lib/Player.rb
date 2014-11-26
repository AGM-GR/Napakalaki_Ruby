# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'Treasure.rb'
require_relative 'Monster.rb'
require_relative 'TreasureKind.rb'
require_relative 'CombatResult.rb'
require_relative 'CardDealer'
require_relative 'Dice.rb'

class Player
  
  attr_reader :dead, :level;
  
  def initialize(name, dead, level, pendingbadConsequence, visibleTreasures, hiddenTreasures)
    @name = name
    @dead = dead
    @level = level
    @pendingbadConsequence = pendingbadConsequence
    @visibleTreasures = visibleTreasures
    @hiddenTreasures = hiddenTreasures
  end
  
  def Player.newName(name)
    
    new(name,true,1,BadConsequence.new, Array.new, Array.new)
    
  end
  
  def bringToLife
    
    @dead = false
    
  end
  
  def getCombatLevel
    
    lvl = @level
    collarVisible = false
    
    for i in 0..(@visibleTreasures.size - 1)
      
      if @visibleTreasures[i].Type == TreasureKind::NECKLACE
        
        collarVisible = true
        
      end
    end
    
    if collarVisible
      
      for i in 0..(@visibleTreasures.size - 1)
        
        lvl = lvl + collarVisible[i].maxBonus
        
      end
      
    else
      
      for i in 0..(@visibleTreasures.size - 1)
        
        lvl = lvl + collarVisible[i].minBonus
        
      end
    end
    
    return lvl
    
  end
  
  
  def incrementLevels(levels)

    if (@level+levels < 10)
      
      @level = @level + levels

    else
      
      @level = 10
      
    end
      
  end
  
  
  def decrementLevels(levels)
    
    if (@level-levels > 1)

      @level -= levels

    else
      
      @level = 1
      
    end
    
  end
  
  def setPendingBadConsequence(bc)
    
    @pendingbadConsequence = bc
    
  end
  
  
  def dieIfNoTreasures
    
    if (@visibleTreasures.empty? && @hiddenTreasures.empty?)
      
      @dead = true
      
    end
    
  end
  
  
  def discardNecklaceIfVisible
    
    necklace_found = false
    cardDealer = cardDealer.new

    for i in 0..(@visibleTreasures.size - 1) && !necklace_found

      if @visibleTreasures[i].Type == TreasureKind::NECKLACE

        necklace_found = true

        cardDealer.giveTreasureBack(@visibleTreasures[i])

        @visibleTreasures.remove(i)
         
      end
      
    end
    
  end
  
  
  def die
    
    setLevel(1)
        
    dealer = CardDealer.new

    for i in 0..(@visibleTreasures.size-1)

      dealer.giveTreasureBack(@visibleTreasures[i])
      
    end

    @visibleTreasures.clear

    for i in 0..(@hiddenTreasures.size-1)

      dealer.giveTreasureBack(@hiddenTreasures[i])
      
    end

    @hiddenTreasures.clear

    dieIfNoTreasures
    
  end
  
  
  def computeGoldCoinsValue(trs)
    
    gold = 0
    #lvls = 0

    for i in 0..(trs.size-1)

      gold += trs[i].getGoldCoins
        
    end

    #lvls = gold / 1000.0

    return gold
    
  end
  
  
  def canIBuyLevels (levels)

    return (@level+levels < 10)
    
  end
  
  
  def applyPrize (currentMonster)
    
    nLevels = currentMonster.getLevelsGained
        
    incrementLevels(nLevels)

    nTreasures = currentMonster.getTreasuresGained

    if nTreasures > 0

      dealer = CardDealer.new

      for i in 0..(nTreasures-1)

        trs = dealer.nextTreasure

        @hiddenTreasures.push(trs)

      end
      
    end
    
  end
  
  
  def applyBadConsequence (bad)
    
    nLevels = bad.getLevels
        
    decrementLevels(nLevels)
        
    pendingBad = bad.adjustToFitTreasureList(@visibleTreasures,@hiddenTreasures)

    setPendingBadConsequence(pendingBad)

  end
  
  
  def canMakeTreasureVisible (treasure)
    
    if (treasure.Type == TreasureKind::SHOE && howManyVisibleTreasures(TreasureKind::SHOE) == 0)
            
      return true
        
    elsif (treasure.Type == TreasureKind::ARMOR && howManyVisibleTreasures(TreasureKind::ARMOR) == 0)
            
      return true
        
    elsif (treasure.Type == TreasureKind::NECKLACE && howManyVisibleTreasures(TreasureKind::NECKLACE) == 0)
        
      return true
        
    elsif (treasure.Type == TreasureKind::HELMET && howManyVisibleTreasures(TreasureKind::HELMET) == 0)
                     
      return true
        
    elsif (treasure.Type == TreasureKind::ONEHAND && 
            howManyVisibleTreasures(TreasureKind::ONEHAND) < 2 && 
            howManyVisibleTreasures(TreasureKind::BOTHHAND) == 0)
            
      return true
        
    elsif (treasure.Type == TreasureKind::BOTHHAND && 
            howManyVisibleTreasures(TreasureKind::BOTHHAND) == 0 && 
            howManyVisibleTreasures(TreasureKind::ONEHAND) == 0)
            
      return true
        
    else
            
      return false
      
    end
    
  end
  
  
  def howManyVisibleTreasures (treasurekind)
   
    cont=0

    for i in 0..(visibleTreasures.size()-1)

      if visibleTreasures[i].getType == treasureKind

        cont = cont + 1
        
      end
    end

    return cont
    
  end
  
  
  def getVisibleTreasures
    
    return @visibleTreasures
    
  end
  
  
  def getHiddenTreasures
    
    return @hiddenTreasures
    
  end
 
  
  def combat (monster)
    
    myLevel = getCombatLevel
    monsterLevel = monster.combatLevel

    if myLevel > monsterLevel

      applyPrize(monster)

      if getLevels() >= 10

        return CombatResult::WINANDWINGAME

      else

        return CombatResult::WIN              

      end

    else

      dice = Dice.new

      escape = dice.nextNumber

      if escape < 5

        amIDead = monster.kills

        if amIDead

            die

          return CombatResult::LOSEANDDIE

        else

          bad = monster.badConsequence

          applyBadConsequence(bad)

          return CombatResult::LOSE

        end

      else

        return CombatResult::LOSEANDESCAPE
        
      end
      
    end
    
  end
  
  
  def makeTreasureVisible (treasure)
    
    canI = canMakeTreasureVisible(treasure)
        
    if canI

      @visibleTreasures.push(treasure)
      @hiddenTreasures.delete(treasure)
      
    end
    
  end
  
  
  def discardVisibleTreasure (treasure)
    
    @visibleTreasures.delete(treasure)
    
    if (@pendingbadConsequence != nil && !@pendingbadConsequence.empty?)
            
      @pendingbadConsequence.substractVisibleTreasure(t)
      
    end
        
    dieIfNoTreasures
    
  end
  
  
  def discardHiddenTreasure (treasure)
    
    @hiddenTreasures.delete(treasure)
    
    if (@pendingbadConsequence != nil && !@pendingbadConsequence.empty?)
            
      @pendingbadConsequence.substractHiddenTreasure(t)
      
    end
        
    dieIfNoTreasures
    
  end

  
  def buyLevels (visibleTreasures, hiddenTreasures)
    
    levelsMayBought = computeGoldCoinsValue(visibleTreasures)
    levelsMayBought += computeGoldCoinsValue(hiddenTreasures)

    level = (levelsMayBought)/1000

    canI = canIBuyLevels(level)

    if (canI)

        incrementLevels(level)
        
    end

    @visibleTreasures = @visibleTreasures - visibleTreasures
    @hiddenTreasures = @hiddenTreasures - hiddenTreasures

    dealer = CardDealer.new

    for i in 0..(visibleTreasures.size-1)

        dealer.giveTreasureBack(visibleTreasures[i])
    end

    for i in 0..(hiddenTreasures.size-1)

        dealer.giveTreasureBack(hiddenTreasures[i])
    end

    return canI
    
  end
  
  
  def validState
    
    return (@pendingbadConsequence.empty? && @hiddenTreasures.size <= 4)    
    
  end
  
  
  def initTreasures
    
    dealer = CardDealer.new
        
    dice = dice.new

    bringToLife

    trs = dealer.nextTreasure

    @hiddenTreasures.push(trs)

    number = dice.nextNumber

    if number > 1

      trs = dealer.nextTreasure

      @hiddenTreasures.push(trs)
    
    end

    if number == 6

      trs = dealer.nextTreasure

      @hiddenTreasures.push(trs)
        
    end
    
  end
  
  
  def hasVisibleTreasures
    
    return (visibleTreasures.size() > 0)
    
  end
  
  
  private_class_method :new, :bringToLife, :getCombatLevel, :incrementLevels, :decrementLevels, :setPendingBadConsequence;
  private_class_method :dieIfNoTreasures, :discardNecklaceIfVisible, :die, :computeGoldCoinsValue, :canIBuyLevels, :applyPrize;
  private_class_method :applyBadConsequence, :canMakeTreasureVisible, :howManyVisibleTreasures;
  
  
end
