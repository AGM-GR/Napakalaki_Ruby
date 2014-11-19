#encoding: UTF-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'TreasureKind.rb'


class BadConsequence
  
  attr_reader :text,:levels,:nVisibleTreasures,:nHiddenTreasures,:death,:specificVisibleTreasures,:specificHiddenTreasures;
  
  def initialize (text = "", levels = 1, nVisibleTreasures = 0, nHiddenTreasures = 0, death = false, specificVisibleTreasures = Array.new(), specificHiddenTreasures = Array.new())
    
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
    
    return (@text.length == 0 && @levels == 0 && 
          @nVisibleTreasures == 0 && 
          @nHiddenTreasures == 0 && 
          @specificVisibleTreasures.empty? && 
          @specificHiddenTreasures.empty?)
    
  end
  
  def substractVisibleTreasure(trs)

    if !@specificVisibleTreasures.empty?

      @specificVisibleTreasures.delete(trs.Type)

    elsif @nVisibleTreasures != 0

      @nVisibleTreasures = @nVisibleTreasures -1

    end

  end

  def substractHiddenTreasure(trs)

      if !@specificHiddenTreasures.empty?

        @specificHiddenTreasures.delete(trs.Type);

      elsif (nHiddenTreasures != 0)

        @nHiddenTreasures = @nHiddenTreasures -1

      end
  end
  
  private_class_method :new
  
  def to_s
  
    "Text: #{@text} \n Niveles ganados: #{@levels} \n Tesoros visibles: #{@nVisibleTreasures} \n Tesoros ocultos: #{@nHiddenTreasures} \n Muerte: #{@death}"
  
  end 
  
end