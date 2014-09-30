//
//  teste-terminal.swift
//  Exemplo002
//
//  Created by Joao Ferreira on 9/30/14.
//  Copyright (c) 2014 si. All rights reserved.
//

// import Foundation
import UIKit

class People {
  
  let name:String = ""
  let age:Int = 0
  
  init(name:String, age:Int)   {
    self.name = name
    self.age = age
  }
  
  var description: String {
    return "O \(self.name) tem \(self.age) anos."
  }
  
  func print() -> Int   {
    println(self)
    return self.age;
  }
}

let anyPeopleAge = (People.init(name:"Jaum", age:23)).print()
