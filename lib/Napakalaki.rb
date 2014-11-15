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

      currentPlayer = @players[@indexCurrentPlayer] 
    
    end

    return currentPlayer
    
  end
  
  
  def nextTurnAllowed
    
  end
  
  
  def developCombat
    
  end
  
  
  def discardVisibleTreasures (treasures)
    
  end
  
  
  def discardHiddenTreasures (treasures)
    
  end
  
  
  def makeTreasuresVisible (treasures)
    
  end
  
  
  def buyLevels (visibleTreasures, hiddenTreasures)
    
  end
  
  
  def initGame (names)
    
  end
  
  
  def getCurrentPlayer
    
  end
  
  
  def getCurrentMonster
    
  end
  
  
  def nextTurn
    
  end
  
  
  def endOfGame (combatResult)
    
  end
  
  private_class_method :initPlayers, :nextPlayer, :nextTurnAllowed;
  
end
