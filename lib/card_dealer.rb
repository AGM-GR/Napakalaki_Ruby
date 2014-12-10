# encoding: UTF-8
# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'treasure_kind'
require_relative 'bad_consequence'
require_relative 'prize'
require_relative 'treasure'

module Napakalaki

  require "singleton"

  class CardDealer

    include Singleton

    attr_accessor :used_monsters, :unused_monsters, :used_treasures, :unused_treasures;

    def initTreasureCardDeck

      @unusedTreasures = Array.new
      @usedTreasures = Array.new

      treasure = Treasure.new("!Sí mi amo¡", 0, 4, 7, TreasureKind::HELMET)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Botas de investigación", 600, 3, 4, TreasureKind::SHOE)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Capucha de Cthulhu", 500, 3, 5, TreasureKind::HELMET)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("A prueba de babas", 400, 2, 5, TreasureKind::ARMOR)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Botas de lluvia ácida", 800, 1, 1, TreasureKind::SHOE)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Casco minero", 400, 2, 4, TreasureKind::HELMET)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Ametralladora Thompson", 600, 4, 8, TreasureKind::BOTHHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Camiseta de la UGR", 100, 1, 7, TreasureKind::ARMOR)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Clavo de rail ferroviario", 400, 3, 6, TreasureKind::ONEHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Cuhillo de sushi arcano", 300, 2, 3, TreasureKind::ONEHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Fez alópodo", 700, 3, 5, TreasureKind::HELMET)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Hacha prehistórica", 500, 2, 5, TreasureKind::ONEHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("El aparato del Pr.Tesla", 900, 4, 8, TreasureKind::ARMOR)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Gaita", 500, 4, 5, TreasureKind::BOTHHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Insecticida", 300, 2, 3, TreasureKind::ONEHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Escopeta de 3 cañones", 700, 4, 6, TreasureKind::BOTHHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Garabato místico", 300, 2, 2, TreasureKind::ONEHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("La fuerza de Mr.T", 1000, 0, 0, TreasureKind::NECKLACE)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("La rebeca metálica", 400, 2, 3, TreasureKind::ARMOR)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Mazo de los antiguos", 200, 3, 4, TreasureKind::ONEHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Necroplayboycón", 300, 3, 5, TreasureKind::ONEHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Lanzallamas", 800, 4, 8, TreasureKind::BOTHHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Necrocomicón", 100, 1, 1, TreasureKind::ONEHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Necronomicón", 800, 5, 7, TreasureKind::BOTHHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Linterna a 2 manos", 400, 3, 6, TreasureKind::BOTHHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Necrognomicón", 200, 2, 4, TreasureKind::ONEHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Necrotelecom", 300, 2, 3, TreasureKind::HELMET)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Porra preternatural", 200, 2, 3, TreasureKind::ONEHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Tentáculo de pega", 200, 0, 1, TreasureKind::HELMET)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Zapato deja-amigos", 500, 0, 1, TreasureKind::SHOE)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Shogulador", 600, 1, 1, TreasureKind::BOTHHAND)
      @unusedTreasures.push(treasure)

      treasure = Treasure.new("Varita de atizamiento", 400, 3, 4, TreasureKind::ONEHAND)
      @unusedTreasures.push(treasure)

    end


    def initMonsterCardDeck

      @unusedMonsters = Array.new
      @usedMonsters = Array.new

      prize = Prize.new(4,2) 
      badConsequence = BadConsequence.newLevelNumberOfTreasures('Pierdes 5 niveles y 3 tesoros visibles',5 , 3, 0)
      @unusedMonsters.push(Monster.new('El rey de rosa',13,badConsequence,prize))

      prize = Prize.new(4,1) 
      badConsequence = BadConsequence.newLevelSpecificTreasures('Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta', 1, [TreasureKind::ONEHAND],[TreasureKind::ONEHAND])
      @unusedMonsters.push(Monster.new('Ángeles de la noche ibicenca', 14, badConsequence, prize))

      prize = Prize.new(2,1)
      badConsequence = BadConsequence.newLevelSpecificTreasures('Pierdes tu armadura visible y otra oculta', 1, [TreasureKind::ARMOR], [TreasureKind::ARMOR])
      @unusedMonsters.push(Monster.new('3 Byakhees de bonanza', 8, badConsequence, prize))

      prize = Prize.new(1,1)
      badConsequence = BadConsequence.newLevelSpecificTreasures('Embobados con el lindo primigenio te descartas de tu casco visible', 1, [TreasureKind::HELMET], Array.new)
      @unusedMonsters.push(Monster.new('Chibithulhu', 2, badConsequence, prize))

      prize = Prize.new(1,1)
      badConsequence = BadConsequence.newLevelSpecificTreasures('El primordial bostezo contagioso. Pierdes el calzado visible', 1, [TreasureKind::SHOE], Array.new)
      @unusedMonsters.push(Monster.new('El sopor de Dunwich', 2, badConsequence, prize))

      prize = Prize.new(3,1)
      badConsequence = BadConsequence.newLevelNumberOfTreasures('Pierdes todos tus tesoros visibles', 1, 10, 0)
      @unusedMonsters.push(Monster.new('El gorrón en el umbral', 10, badConsequence, prize))

      prize = Prize.new(2,1)
      badConsequence = BadConsequence.newLevelSpecificTreasures('Pierdes la armadura visible', 1, [TreasureKind::ARMOR], Array.new)
      @unusedMonsters.push(Monster.new('H.P. Munchcraft', 6, badConsequence, prize))

      prize = Prize.new(1,1)
      badConsequence = BadConsequence.newLevelSpecificTreasures('Sientes bichos bajo la ropa. Descarta la armadura visible', 1, [TreasureKind::ARMOR], Array.new)
      @unusedMonsters.push(Monster.new('Bichgooth', 2, badConsequence, prize))

      prize = Prize.new(1,1)
      badConsequence = BadConsequence.newLevelNumberOfTreasures('Toses los pulmones y pierdes 2 niveles', 2, 0, 0)
      @unusedMonsters.push(Monster.new('La que redacta en las tinieblas', 10, badConsequence, prize))

      prize = Prize.new(2,1)
      badConsequence = BadConsequence.newDeath('Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estas muerto')
      @unusedMonsters.push(Monster.new('Los hondos', 8, badConsequence, prize))

      prize = Prize.new(2,1)
      badConsequence = BadConsequence.newLevelNumberOfTreasures('Pierdes 2 niveles y 2 tesoros ocultos', 2, 0, 2)
      @unusedMonsters.push(Monster.new('Semillas Cthulhu', 4, badConsequence, prize))

      prize = Prize.new(2,1)
      badConsequence = BadConsequence.newLevelSpecificTreasures('Te intentas escaquear.Pierdes una mano visible', 1, [TreasureKind::ONEHAND], Array.new)
      @unusedMonsters.push(Monster.new('Dameargo', 1, badConsequence, prize))

      prize = Prize.new(1,1)
      badConsequence = BadConsequence.newLevelNumberOfTreasures('Da mucho asquito.Pierdes 3 niveles', 3, 0, 0)
      @unusedMonsters.push(Monster.new('Pollipólipo volante', 3, badConsequence, prize))

      prize = Prize.new(3,1)
      badConsequence = BadConsequence.newDeath('No le hace gracia que pronuncien mal su nombre. Estas muerto')
      @unusedMonsters.push(Monster.new('Yskhtihyssg-Goth', 12, badConsequence, prize))

      prize = Prize.new(4,1)
      badConsequence = BadConsequence.newDeath('La familia te atrapa. Estas muerto')
      @unusedMonsters.push(Monster.new('Familia feliz', 1, badConsequence, prize))

      prize = Prize.new(2,1)
      badConsequence = BadConsequence.newLevelSpecificTreasures('La quinta directiva primaria te obliga a perder 2 niveles y 2 manos visible', 2, [TreasureKind::ONEHAND,TreasureKind::ONEHAND,TreasureKind::BOTHHAND], Array.new)
      @unusedMonsters.push(Monster.new('Roboggoth', 8, badConsequence, prize))

      prize = Prize.new(1,1)
      badConsequence = BadConsequence.newLevelSpecificTreasures('Te asusta en la noche. Pierdes un casco visible', 1, [TreasureKind::HELMET], Array.new)
      @unusedMonsters.push(Monster.new('El espia', 5, badConsequence, prize))

      prize = Prize.new(1,1)
      badConsequence = BadConsequence.newLevelNumberOfTreasures('Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles', 2, 5, 0)
      @unusedMonsters.push(Monster.new('El Lenguas', 20, badConsequence, prize))

      prize = Prize.new(1,1)
      badConsequence = BadConsequence.newLevelSpecificTreasures('Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos', 1, [TreasureKind::ONEHAND, TreasureKind::ONEHAND, TreasureKind::BOTHHAND], Array.new)
      @unusedMonsters.push(Monster.new('Bicéfalo', 20, badConsequence, prize))

    end


    def shuffleTreasures

      @unusedTreasures.shuffle!

    end


    def shuffleMonsters

      @unusedMonsters.shuffle!

    end


    def nextTreasure

      if @unusedTreasures.empty? then

        while !@usedTreasures.empty? do

          @unusedTreasures.push(@usedTreasures[0])

          @usedTreasures.delete_at(0)

        end

        shuffleTreasures

      end

      nextTrs = @unusedTreasures[0]

      @unusedTreasures.delete_at(0)

      return nextTrs

    end


    def nextMonster

      if @unusedMonsters.empty? then

        while !@usedMonsters.empty? do

          @unusedMonsters.push(@usedMonsters[0])

          @usedMonsters.delete_at(0)

        end

        shuffleMonsters

      end

      nextMnst = @unusedMonsters[0]

      @unusedMonsters.delete_at(0)

      return nextMnst

    end


    def giveTreasureBack (treasure)

      @usedTreasures.push(treasure)    

    end


    def giveMonsterBack (monster)

      @usedMonsters.push(monster)    

    end


    def initCards

      initTreasureCardDeck
      shuffleTreasures
      initMonsterCardDeck
      shuffleMonsters

    end

  end
  
end