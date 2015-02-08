# encoding: UTF-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'monster'
require_relative 'treasure'
require_relative 'treasure_kind'
require_relative 'combat_result'
require_relative 'dice'
require_relative 'card_dealer'

module Napakalaki
  
  class Player

    attr_reader :name, :dead, :level, :visibleTreasures, :hiddenTreasures, :pendingBadConsequence;

    def initialize(name)

      @name = name
      @dead = true
      @level = 1
      @visibleTreasures = Array.new
      @hiddenTreasures = Array.new
      @pendingBadConsequence
      @dice = Dice.instance
      @dealer = CardDealer.instance

    end
    
    def newCopia(player)
      
      @name = player.name 
      @dead = player.dead 
      @level = player.level
      @visibleTreasures = player.visibleTreasures
      @hiddenTreasures = player.hiddenTreasures
      @pendingBadConsequence
      @dice = Dice.instance
      @dealer = CardDealer.instance
      
    end

    def getName

      return @name

    end

    def bringToLife

      @dead = false

    end
    
    def getCombatLevel

      lvl = @level
      collarVisible = false

      for i in 0..(@visibleTreasures.size - 1) do

        if @visibleTreasures[i].getType == TreasureKind::NECKLACE then

          collarVisible = true

        end
      end

      if collarVisible then

        for i in 0..(@visibleTreasures.size - 1) do

          lvl = lvl + @visibleTreasures[i].maxBonus

        end

      else

        for i in 0..(@visibleTreasures.size - 1) do

          lvl = lvl + @visibleTreasures[i].minBonus

        end
      end

      return lvl

    end


    def incrementLevels(levels)

      if (@level+levels < 10) then

        @level = @level + levels

      else

        @level = 10

      end

    end


    def decrementLevels(levels)

      if (@level-levels > 1) then

        @level =  @level - levels

      else

        @level = 1

      end

    end

    def setPendingBadConsequence(bc)

      @pendingBadConsequence = bc

    end


    def dieIfNoTreasures

      if (@visibleTreasures.empty? && @hiddenTreasures.empty?) then

        @dead = true

      end

    end


    def discardNecklaceIfVisible

      necklace_found = false

      for i in 0..(@visibleTreasures.size - 1) do

        if necklace_found
          
          break
          
        end
        
        if @visibleTreasures[i].getType == TreasureKind::NECKLACE then

          necklace_found = true

          @dealer.giveTreasureBack(@visibleTreasures[i])

          @visibleTreasures.delete_at(i)

        end

      end

    end


    def die

      @level = 1 

      for i in 0..(@visibleTreasures.size-1) do

        @dealer.giveTreasureBack(@visibleTreasures[i])

      end

      @visibleTreasures.clear

      for i in 0..(@hiddenTreasures.size-1) do

        @dealer.giveTreasureBack(@hiddenTreasures[i])

      end

      @hiddenTreasures.clear

      dieIfNoTreasures

    end

    def computeGoldCoinsValue(trs)

      gold = 0

      for i in 0..(trs.size-1) do

        gold += trs[i].goldCoins

      end

      return gold

    end


    def canIBuyLevels (levels)

      return (@level+levels < 10)

    end


    def applyPrize (currentMonster)

      nLevels = currentMonster.getLevelsGained

      incrementLevels(nLevels)

      nTreasures = currentMonster.getTreasuresGained

      if nTreasures > 0 then

        for i in 0..(nTreasures-1) do

          trs = @dealer.nextTreasure

          @hiddenTreasures.push(trs)

        end

      end

    end


    def applyBadConsequence (bad)

      nLevels = bad.levels

      decrementLevels(nLevels)

      pendingBad = bad.adjustToFitTreasureList(@visibleTreasures,@hiddenTreasures)

      setPendingBadConsequence(pendingBad)
      
      while !@pendingBadConsequence.specificVisibleTreasures.empty? do
        
        encontrado = false
        
        for i in 0..(@visibleTreasures.size-1) do
          
          if (encontrado) then
            
            break
            
          end
          
          if @visibleTreasures[i].getType == @pendingBadConsequence.specificVisibleTreasures[0]
            
            discardVisibleTreasure(@visibleTreasures[i])
            encontrado = true
            
          end
          
        end
        
      end
      
      while !@pendingBadConsequence.specificHiddenTreasures.empty? do
        
        encontrado = false
        
        for i in 0..(@hiddenTreasures.size-1) do
          
          if (encontrado) then
            
            break
            
          end
          
          if @hiddenTreasures[i].getType == @pendingBadConsequence.specificHiddenTreasures[0]
            
            discardHiddenTreasure(@hiddenTreasures[i])
            encontrado = true
            
          end
          
        end
        
      end
      
    end


    def canMakeTreasureVisible (treasure)

      if (treasure.getType == TreasureKind::SHOE && howManyVisibleTreasures(TreasureKind::SHOE) == 0) then

        return true

      elsif (treasure.getType == TreasureKind::ARMOR && howManyVisibleTreasures(TreasureKind::ARMOR) == 0) then

        return true

      elsif (treasure.getType == TreasureKind::NECKLACE && howManyVisibleTreasures(TreasureKind::NECKLACE) == 0) then

        return true

      elsif (treasure.getType == TreasureKind::HELMET && howManyVisibleTreasures(TreasureKind::HELMET) == 0) then

        return true

      elsif (treasure.getType == TreasureKind::ONEHAND && 
              howManyVisibleTreasures(TreasureKind::ONEHAND) < 2 && 
              howManyVisibleTreasures(TreasureKind::BOTHHAND) == 0) then

        return true

      elsif (treasure.getType == TreasureKind::BOTHHAND && 
              howManyVisibleTreasures(TreasureKind::BOTHHAND) == 0 && 
              howManyVisibleTreasures(TreasureKind::ONEHAND) == 0) then

        return true

      else

        return false

      end

    end


    def howManyVisibleTreasures (treasurekind)

      cont=0

      for i in 0..(@visibleTreasures.size-1) do

        if @visibleTreasures[i].getType == treasurekind then

          cont = cont + 1

        end
      end

      return cont

    end

    
    def isDead
      
      return @dead
      
    end

    
    def getVisibleTreasures

      return @visibleTreasures

    end


    def getHiddenTreasures

      return @hiddenTreasures

    end


    def combat (monster)

      myLevel = getCombatLevel
      monsterLevel = getOponentLevel(monster)

      if myLevel > monsterLevel then

        applyPrize(monster)

        if @level >= 10 then

          result = CombatResult::WINANDWINGAME

        else

          result = CombatResult::WIN

        end

      else

        escape = @dice.nextNumber

        if escape < 5 then

          amIDead = monster.kills

          if amIDead then

              die

            result = CombatResult::LOSEANDDIE

          else

            bad = monster.badConsequence

            applyBadConsequence(bad)

            cultist = shouldConvert
            
            if cultist then
              
              result = CombatResult::LOSEANDCONVERT
              
            else
              
              result = CombatResult::LOSE
             
            end
          end

        else

          result = CombatResult::LOSEANDESCAPE

        end

      end
      
      discardNecklaceIfVisible
      
      return result

    end


    def makeTreasureVisible (treasure)

      canI = canMakeTreasureVisible(treasure)

      if canI then

        @visibleTreasures.push(treasure)
        @hiddenTreasures.delete(treasure)

      end

    end


    def discardVisibleTreasure (treasure)

      @visibleTreasures.delete(treasure)

      if (@pendingBadConsequence != nil && !@pendingBadConsequence.isEmpty) then

        @pendingBadConsequence.substractVisibleTreasure(treasure)

      end

      dieIfNoTreasures

    end


    def discardHiddenTreasure (treasure)

      @hiddenTreasures.delete(treasure)

      if (@pendingBadConsequence != nil && !@pendingBadConsequence.isEmpty) then

        @pendingBadConsequence.substractHiddenTreasure(treasure)

      end

      dieIfNoTreasures

    end


    def buyLevels (visibleTreasures, hiddenTreasures)

      levelsMayBought = computeGoldCoinsValue(visibleTreasures)
      levelsMayBought += computeGoldCoinsValue(hiddenTreasures)

      level = (levelsMayBought)/1000

      canI = canIBuyLevels(level)

      if (canI) then

          incrementLevels(level)

      end

      @visibleTreasures = @visibleTreasures - visibleTreasures
      @hiddenTreasures = @hiddenTreasures - hiddenTreasures

      for i in 0..(visibleTreasures.size-1) do

          @dealer.giveTreasureBack(visibleTreasures[i])
      end

      for i in 0..(hiddenTreasures.size-1) do

          @dealer.giveTreasureBack(hiddenTreasures[i])
      end

      return canI

    end


    def validState

      if (@pendingBadConsequence == nil || @pendingBadConsequence.isEmpty && @hiddenTreasures.size < 4) then
        
          return true
      
      else
        
          return false
      end

    end


    def initTreasures

      bringToLife

      trs = @dealer.nextTreasure

      @hiddenTreasures.push(trs)

      number = @dice.nextNumber

      if number > 1 then

        trs = @dealer.nextTreasure

        @hiddenTreasures.push(trs)

      end

      if number == 6 then

        trs = @dealer.nextTreasure

        @hiddenTreasures.push(trs)

      end

    end


    def hasVisibleTreasures

      return (@visibleTreasures.size() > 0)

    end

    def to_s

      "#{@name} ,Nivel: #{@level}"

    end
    
    def getOponentLevel(monster)
      
      return (monster.getBasicValue)
      
    end
    
    def shouldConvert
      
      number = @dice.nextNumber
      
      if number == 6 then
        
        return true
        
      else
        
        return false
        
      end
      
    end
    
  end

end