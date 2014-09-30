//
//  Composite.swift
//  Exemplo002
//
//  Created by Joao Ferreira on 9/29/14.
//  Copyright (c) 2014 si. All rights reserved.
//

import Foundation

struct Color {
  let red, green, blue: Double
  init(red: Double, green: Double, blue: Double) {
    self.red   = red
    self.green = green
    self.blue  = blue
  }
  init(white: Double) {
    red   = white
    green = white
    blue  = white
  }
}

struct SensorWidget {
  var color: Color
  var monochrome: Color
  init () {
    let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
    self.color = magenta
    self.monochrome = Color(white: 0.5)
  }
  init (color: Color) {
    self.color = color
    self.monochrome = Color(white: 0.5)
  }
}

public class Composite {
  var parent: Composite?
  var id = 0
  var dbId = 0
  var detail: Detail?
  init() {
    self.parent = nil
  }
  init(parent: Composite) {
    self.parent = parent
  }
  init(myParent parent: Composite, myDetail detail: Detail) {
    self.parent = parent
    self.detail = detail
  }
}

class Detail {
  var name: String = ""
  var position: Position = Position()
  var type = CompositeType.GROUP
  var cssClass: String = ""
  var analysisType = AnalysisType.AVG
  init()  {
  }
}

struct Position {
  var x: Float = 0
  var y: Float = 0
  var z: Float = 0
}

enum AnalysisType {
  case AVG
}

enum CompositeType {
  case GROUP
}

enum ACTION {
  case GET_COMPOSITES, GET_COMPOSITE, CREATE_OR_UPDATE_PLANE, GET_STATE_RULES, GET_ANALYSIS_TYPES
}