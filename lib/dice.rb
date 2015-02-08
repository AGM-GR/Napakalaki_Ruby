# encoding: UTF-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Napakalaki

  require "singleton"

  class Dice

    include Singleton

    def nextNumber

      rnd = Random.new

      return rnd.rand(1..6)

    end

  end

end