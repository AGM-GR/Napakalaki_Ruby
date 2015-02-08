# encoding: UTF-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'player'
require_relative 'card_dealer'
require_relative 'cultist_player'

module Napakalaki

  require "singleton"

  class Napakalaki

    include Singleton

    def initPlayers (names)

      @dealer = CardDealer.instance
      @players = Array.new

      for i in 0..(names.size-1) do

        @players.push(Player.new(names[i]))

      end

      @indexCurrentPlayer = -1
      
    end


    def nextPlayer

      if (@indexCurrentPlayer == -1) then

          rand = Random.new

          @indexCurrentPlayer = rand(0..(@players.size-1))    

      else

        @indexCurrentPlayer = ((@indexCurrentPlayer + 1) % @players.size)

      end
      
      @currentPlayer = @players[@indexCurrentPlayer]

      return @currentPlayer

    end


    def nextTurnAllowed

      if @currentPlayer == nil then

              return true

      else

        return @currentPlayer.validState

      end

    end


    def developCombat

      result = @currentPlayer.combat(@currentMonster)

      @dealer.giveMonsterBack(@currentMonster)
      
      if result == CombatResult::LOSEANDCONVERT then
        
        cultist = @dealer.nextCultist
        cultistPLayer = CultistPlayer.new(@currentPlayer, cultist)
        
        @players.delete(@currentPlayer)
        @players.insert(@indexCurrentPlayer, cultistPLayer)
        @currentPlayer = cultistPLayer
        
      end

      return result

    end


    def discardVisibleTreasures (treasures)

      for i in 0..(treasures.size-1) do

        @currentPlayer.discardVisibleTreasure(treasures[i])
        @dealer.giveTreasureBack(treasures[i])

      end

    end


    def discardHiddenTreasures (treasures)

      for i in 0..(treasures.size-1) do

        @currentPlayer.discardHiddenTreasure(treasures[i])
        @dealer.giveTreasureBack(treasures[i])

      end

    end


    def makeTreasuresVisible (treasures)

      for i in 0..(treasures.size-1) do

        @currentPlayer.makeTreasureVisible(treasures[i])

      end

    end


    def buyLevels (visibleTreasures, hiddenTreasures)

      return @currentPlayer.buyLevels(visibleTreasures,hiddenTreasures);

    end


    def initGame (players)

      initPlayers(players)
      @dealer.initCards
      nextTurn

    end


    def getCurrentPlayer

      return @currentPlayer

    end


    def getCurrentMonster

      return @currentMonster

    end


    def nextTurn
      
      if nextTurnAllowed then

        nextPlayer

        @currentMonster = @dealer.nextMonster

        if @currentPlayer.isDead then

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

  end

end