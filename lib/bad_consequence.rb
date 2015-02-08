# encoding: UTF-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'treasure_kind'

module Napakalaki

  class BadConsequence

    attr_reader :text,:levels,:nVisibleTreasures,:nHiddenTreasures,:death,:specificVisibleTreasures,:specificHiddenTreasures;

    def initialize (text = "", levels = 1, nVisibleTreasures = 0, nHiddenTreasures = 0, death = false, specificVisibleTreasures = Array.new, specificHiddenTreasures = Array.new)

      @text = text
      @levels = levels
      @nVisibleTreasures = nVisibleTreasures
      @nHiddenTreasures = nHiddenTreasures
      @specificVisibleTreasures = specificVisibleTreasures
      @specificHiddenTreasures = specificHiddenTreasures
      @death = death

    end

    def BadConsequence.newLevelNumberOfTreasures(text,levels,nVisibleTreasures,nHiddenTreasures)

      new(text,levels,nVisibleTreasures,nHiddenTreasures, false, Array.new, Array.new)

    end

    def BadConsequence.newDeath(text)

      new(text,9,0,0, true, Array.new,Array.new)

    end

    def BadConsequence.newLevelSpecificTreasures(text,levels,tVisible,tHidden)

      new(text,levels,0,0, false, tVisible, tHidden)

    end


    def isEmpty

      return (@nVisibleTreasures == 0 && 
            @nHiddenTreasures == 0 && 
            @specificVisibleTreasures.empty? && 
            @specificHiddenTreasures.empty?)

    end

    def getSpecificVisibleTreasures
      
      return @specificVisibleTreasures
      
    end
    
    def getSpecificHiddenTreasures
      
      return @specificHiddenTreasures
      
    end
    
    def substractVisibleTreasure(trs)

      if !@specificVisibleTreasures.empty? then

        @specificVisibleTreasures.delete(trs.Type)

      elsif @nVisibleTreasures != 0 then

        @nVisibleTreasures = @nVisibleTreasures -1

      end

    end

    def substractHiddenTreasure(trs)

        if !@specificHiddenTreasures.empty? then

          @specificHiddenTreasures.delete(trs.Type);

        elsif (nHiddenTreasures != 0) then

          @nHiddenTreasures = @nHiddenTreasures -1

        end
    end

    def adjustToFitTreasureList(visible, hidden)

      specificVisible = Array.new
      specificHidden = Array.new
      
      tvisible = visible;
      thidden = hidden;
      encontrado = false;

      if (!(@specificVisibleTreasures == nil) && !@specificVisibleTreasures.empty?) then

        for n in 0..(@specificVisibleTreasures.size-1) do
          
          encontrado = false

          for i in 0..(tvisible.size-1) do
            
            if encontrado
              
              break
              
            end
            
            if (tvisible[i].getType == @specificVisibleTreasures[n]) then

              specificVisible.push(tvisible[i].getType)
              
              tvisible.delete(i)
              
              encontrado = true

            end
          end
        end
      end

      encontrado = false
      
      if (!(@specificHiddenTreasures == nil) && !@specificHiddenTreasures.empty?) then

        for n in 0..(@specificHiddenTreasures.size-1) do
        
          encontrado = false
          
          for i in 0..(thidden.size-1) do
          
            if encontrado
              
              break
              
            end
            
            if (thidden[i].getType == @specificHiddenTreasures[n]) then

              specificHidden.push(thidden[i].getType)
              
              thidden.delete(i)
              
              encontrado = true

            end
          end
       end
      end

      if @nVisibleTreasures > 0 then

        for i in 0..(visible.size-1) do
          
          if i > @nVisibleTreasures then
            
            break
            
          end 

          specificVisible.push(visible[i].getType)

        end
      end

      if @nHiddenTreasures > 0 then

        for i in 0..(hidden.size-1) do

          if i > @nVisibleTreasures then
            
            break
            
          end
          
          specificHidden.push(hidden[i].getType)

        end
      end

      adjustBad = BadConsequence.newLevelSpecificTreasures(@text, 0, specificVisible, specificHidden);

      return adjustBad;

    end

    private_class_method :new

    def to_s

      "Text: #{@text}"

    end 

  end

end