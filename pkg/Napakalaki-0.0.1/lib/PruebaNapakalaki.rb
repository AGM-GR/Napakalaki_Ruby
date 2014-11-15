#encoding: UTF-8

require_relative 'Prize.rb'
require_relative 'BadConsequence.rb'
require_relative 'Monster.rb'
require_relative 'TreasureKind.rb'
require_relative 'Dice.rb'

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

monsters = Array.new

prize = Prize.new(4,2) 
badConsequence = BadConsequence.newLevelNumberOfTreasures('Pierdes 5 niveles y 3 tesoros visibles',5 , 3, 0)
monsters.push(Monster.new('El rey de rosa',13,badConsequence,prize))

prize = Prize.new(4,1) 
badConsequence = BadConsequence.newLevelSpecificTreasures('Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta', 1, [TreasureKind::ONEHAND],[TreasureKind::ONEHAND])
monsters.push(Monster.new('Ángeles de la noche ibicenca', 14, badConsequence, prize))

prize = Prize.new(2,1)
badConsequence = BadConsequence.newLevelSpecificTreasures('Pierdes tu armadura visible y otra oculta', 1, [TreasureKind::ARMOR], [TreasureKind::ARMOR])
monsters.push(Monster.new('3 Byakhees de bonanza', 8, badConsequence, prize))

prize = Prize.new(1,1)
badConsequence = BadConsequence.newLevelSpecificTreasures('Embobados con el lindo primigenio te descartas de tu casco visible', 1, [TreasureKind::HELMET], Array.new)
monsters.push(Monster.new('Chibithulhu', 2, badConsequence, prize))

prize = Prize.new(1,1)
badConsequence = BadConsequence.newLevelSpecificTreasures('El primordial bostezo contagioso. Pierdes el calzado visible', 1, [TreasureKind::SHOE], Array.new)
monsters.push(Monster.new('El sopor de Dunwich', 2, badConsequence, prize))

prize = Prize.new(3,1)
badConsequence = BadConsequence.newLevelNumberOfTreasures('pierdes todos tus tesoros visibles', 1, 10, 0)
monsters.push(Monster.new('El gorrón en el umbral', 10, badConsequence, prize))

prize = Prize.new(2,1)
badConsequence = BadConsequence.newLevelSpecificTreasures('Pierdes la armadura visible', 1, [TreasureKind::ARMOR], Array.new)
monsters.push(Monster.new('H.P. Munchcraft', 6, badConsequence, prize))

prize = Prize.new(1,1)
badConsequence = BadConsequence.newLevelSpecificTreasures('Sientes bichos bajo la ropa. Descarta la armadura visible', 1, [TreasureKind::ARMOR], Array.new)
monsters.push(Monster.new('Bichgooth', 2, badConsequence, prize))

prize = Prize.new(1,1)
badConsequence = BadConsequence.newLevelNumberOfTreasures('Toses los pulmones y pierdes 2 niveles', 2, 0, 0)
monsters.push(Monster.new('La que redacta en las tinieblas', 10, badConsequence, prize))

prize = Prize.new(2,1)
badConsequence = BadConsequence.newDeath('Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estas muerto')
monsters.push(Monster.new('Los hondos', 8, badConsequence, prize))

prize = Prize.new(2,1)
badConsequence = BadConsequence.newLevelNumberOfTreasures('Pierdes 2 niveles y 2 tesoros ocultos', 2, 0, 2)
monsters.push(Monster.new('Semillas Cthulhu', 4, badConsequence, prize))

prize = Prize.new(2,1)
badConsequence = BadConsequence.newLevelSpecificTreasures('Te intentas escaquear.Pierdes una mano visible', 1, [TreasureKind::ONEHAND], Array.new)
monsters.push(Monster.new('Dameargo', 1, badConsequence, prize))

prize = Prize.new(1,1)
badConsequence = BadConsequence.newLevelNumberOfTreasures('Da mucho asquito.Pierdes 3 niveles', 3, 0, 0)
monsters.push(Monster.new('Pollipólipo volante', 3, badConsequence, prize))

prize = Prize.new(3,1)
badConsequence = BadConsequence.newDeath('No le hace gracia que pronuncien mal su nombre. Estas muerto')
monsters.push(Monster.new('Yskhtihyssg-Goth', 12, badConsequence, prize))

prize = Prize.new(4,1)
badConsequence = BadConsequence.newDeath('La familia te atrapa. Estas muerto')
monsters.push(Monster.new('Familia feliz', 1, badConsequence, prize))

prize = Prize.new(2,1)
badConsequence = BadConsequence.newLevelSpecificTreasures('La quinta directiva primaria te obliga a perder 2 niveles y 2 manos visible', 2, [TreasureKind::BOTHHAND], Array.new)
monsters.push(Monster.new('Roboggoth', 8, badConsequence, prize))

prize = Prize.new(1,1)
badConsequence = BadConsequence.newLevelSpecificTreasures('Te asusta en la noche. Pierdes un casco visible', 1, [TreasureKind::HELMET], Array.new)
monsters.push(Monster.new('El espia', 5, badConsequence, prize))

prize = Prize.new(1,1)
badConsequence = BadConsequence.newLevelNumberOfTreasures('Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles', 2, 5, 0)
monsters.push(Monster.new('El Lenguas', 20, badConsequence, prize))

prize = Prize.new(1,1)
badConsequence = BadConsequence.newLevelSpecificTreasures('Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos', 1, [TreasureKind::ONEHAND, TreasureKind::ONEHAND, TreasureKind::BOTHHAND], Array.new)
monsters.push(Monster.new('Bicéfalo', 20, badConsequence, prize))



puts ("Monstruos con lvl superior a 10: \n\n")

for i in 0..(monsters.length - 1)
  
  if monsters[i].combatLevel > 10
    
    puts (monsters[i].to_s)
    
  end
  
end

puts ("\nMonstruos que solo impliquen pérdida de niveles: \n\n")

for i in 0..(monsters.length - 1)
  
  if !monsters[i].badConsequence.death && monsters[i].badConsequence.nHiddenTreasures == 0 && 
      monsters[i].badConsequence.nVisibleTreasures == 0 && 
      monsters[i].badConsequence.specificVisibleTreasures.size == 0 && 
      monsters[i].badConsequence.specificHiddenTreasures.size == 0
    
    puts (monsters[i].to_s)
    
  end
  
end

puts ("\nMonstruos que tengan una ganancia de niveles superior a 1: \n\n")

for i in 0..(monsters.length - 1)
  
  if monsters[i].prize.levels > 1
    
    puts (monsters[i].to_s)
    
  end
  
end

puts ("\nMonstruos que implican la perdida de un determinado tesoro: \n\n")

for i in 0..(monsters.length - 1)
  
  if monsters[i].badConsequence.specificVisibleTreasures.size > 0 || 
     monsters[i].badConsequence.specificHiddenTreasures.size > 0
    
    puts (monsters[i].to_s)
    
  end
  
end