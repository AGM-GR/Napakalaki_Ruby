# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'singleton'

require_relative 'Player.rb'
require_relative 'CardDealer.rb'
require_relative 'Monster.rb'
require_relative 'CombatResult.rb'

class Napakalaki
  
  include Singleton
  
  @players
  @indexCurrentPlayer = -1
  @currentPlayer
  @currentMonster
  @dealer = CardDealer.new
  
  
  def initPlayers (names)
    
    for i in 0..(names.size-1)

      @players.add(Player.new(names[i]))
    
    end
    
  end
  
  
  def nextPlayer
    
    if (@indexCurrentPlayer == -1)

        rand = Random.new

        @indexCurrentPlayer = rand.(0..(@players.size-1))    

    else

      @indexCurrentPlayer = (@indexCurrentPlayer + 1) % @players.size

      @currentPlayer = @players[@indexCurrentPlayer] 
    
    end

    return @currentPlayer
    
  end
  
  
  def nextTurnAllowed
    
    if @currentPlayer == nil
            
            return true
        
    else
    
      return @currentPlayer.validState
    
    end
    
  end
  
  
  def developCombat
            
    result = @currentPlayer.combat(@currentMonster)
        
    @dealer.giveMonsterBack(@currentMonster)
        
    return result
    
  end
  
  
  def discardVisibleTreasures (treasures)
    
    for i in 0..(treasures.size-1)
        
      @currentPlayer.discardVisibleTreasure(treasures[i])
      @dealer.giveTreasureBack(treasures[i])

    end
    
  end
  
  
  def discardHiddenTreasures (treasures)
    
    for i in 0..(treasures.size-1)
        
      @currentPlayer.discardHiddenTreasure(treasures[i])
      @dealer.giveTreasureBack(treasures[i])

    end
    
  end
  
  
  def makeTreasuresVisible (treasures)
    
    for i in 0..(treasures.size-1)
            
      @currentPlayer.makeTreasureVisible(treasures[i])
      
    end
    
  end
  
  
  def buyLevels (visibleTreasures, hiddenTreasures)
    
    return @currentPlayer.buyLevels(visibleTreasures,hiddenTreasures);
    
  end
  
  
  def initGame (names)
    
    @dealer.initCards
    initPlayers(names)
    nextTurn
    
  end
  
  
  def getCurrentPlayer
    
    return @currentPlayer
    
  end
  
  
  def getCurrentMonster
    
    return @currentMonster
    
  end
  
  
  def nextTurn
    
    if nextTurnAllowed
            
      nextPlayer

      @currentMonster = @dealer.nextMonster

      if @currentPlayer.dead

        @currentPlayer.initTreasures
      end

      return true
      
    else

      return false
    
    end
    
  end
  
  
  def endOfGame (combatResult)
    
    return (combatResult == CombatResult::WINANDWINGAME)
    
  end
  
  private_class_method :initPlayers, :nextPlayer, :nextTurnAllowed;
  
end
