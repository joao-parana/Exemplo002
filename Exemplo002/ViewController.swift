//
//  ViewController.swift
//  Exemplo002
//
//  Created by Joao Ferreira on 9/27/14.
//  Copyright (c) 2014 si. All rights reserved.
//

import UIKit

extension String {
  func trim() -> String {
    return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
  }
}

// http://www.learnswiftonline.com/reference-guides
// String Operator to trim the both operands inserting only one space between the operands as separator
func - (left: String, right: String) -> String {
  var ret = left.trim() + " " + right.trim()
  return ret
}

// String Operator to trim the both operands
func / (left: String, right: String) -> String {
  var ret = left.trim() + right.trim()
  return ret
}

class Coordinate: Printable {
  var x:CGFloat = 0.0 {
    willSet(newX) {
      println("About to set coordinate.x to \(newX)")
    }
    didSet {
      // if dataSourceCoordinate.x !=  0  {
      println("Updated coordinate.x to \(x). The old value was \(oldValue) ")
      //}
    }
  }
  var y:CGFloat = 0.0 {
    willSet(newX) {
      println("About to set coordinate.y to \(newX)")
    }
    didSet {
      // if dataSourceCoordinate.x !=  0  {
      println("Updated coordinate.y to \(y). The old value was \(oldValue) ")
      //}
    }
  }
  var z:CGFloat = 0.0 {
    willSet(newX) {
      println("About to set coordinate.z to \(newX)")
    }
    didSet {
      // if dataSourceCoordinate.x !=  0  {
      println("Updated coordinate.z to \(z). The old value was \(oldValue) ")
      //}
    }
  }
  
  var description: String {
    return "{ x: \(x), y: \(y), z: \(z) }"
  }
}

class ViewController: UIViewController {
  // the distance from center
  var xFromCenter: CGFloat = 0
  var counter = 0
  var rotateOnDrag = false
  var scaleOnDrag = false
  var dataSourceCoordinate: Coordinate = Coordinate()
    /*
    {
    willSet(newDataSourceCoordinate) {
      println("About to set dataSourceCoordinate to \(newDataSourceCoordinate)")
    }
    didSet {
      // if dataSourceCoordinate.x !=  0  {
        println("Updated coordinate to \(dataSourceCoordinate). The old value was \(oldValue) ")
      //}
    }
    }
    */

  
  // var map: Dictionary<String, String>
  // var map = [String: String]() // map is an empty [String: String] dictionary”
  
  var map: [String: String] = ["GIG": "Rio de Janeiro", "TYO": "Tokyo", "DUB": "Dublin"]

  override func viewDidLoad() {
    super.viewDidLoad()
    println("I have \(map.count) elements on map ")
    println("map.isEmpty = \(map.isEmpty) ")
    // adding element
    map["LHR"] = "London"
    // estava errado
    map["LHR"] = "London Heathrow"
    if let itemName = map["LHR"] {
      println("The name of the item is \(itemName).")
    } else {
      println("That item is not in the map dictionary.")
    }
    // remove Tokyo
    map["TYO"] = nil
    for (itemCode, itemName) in map {
      println("\(itemCode): \(itemName)")
    }
    
    var keys = Array(map.keys)
    var values = Array(map.values)
      
    // Do any additional setup after loading the view, typically from a nib.
    var label1: UILabel = createLabel("GIG", x: 10.0, y: 20.0)
    displayLabel(label1)
    var label2: UILabel = createLabel("LHR", x: 10.0, y: 60.0)
    displayLabel(label2)
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func displayLabel(label: UILabel) -> UILabel {
    // colon informs to send gesture to wasDragged method
    var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
    label.addGestureRecognizer(gesture)
    
    label.userInteractionEnabled = true
    
    return label
  }
  
  func createLabel(key: String, x: CGFloat, y: CGFloat) -> UILabel {
    // let posX = (self.view.bounds.width / 2) - 100;
    var posX: CGFloat = 10
    // let posY = (self.view.bounds.height / 2) - 50;
    var posY: CGFloat = 20
    posX = x
    posY = y
    
    var label: UILabel = UILabel(frame: CGRectMake(posX,
                                        posY, 200, 100))
    label.text = key - "Drag Me!"
    label.textAlignment = NSTextAlignment.Center
    self.view.addSubview(label)
    return label
  }
  
  func wasDragged(gesture: UIPanGestureRecognizer) {
    println("Dragged n = \(counter)")
    counter++
    let translation = gesture.translationInView(self.view)
    var label = gesture.view!
    // move label accordinly
    label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y + translation.y)
    
    var rotation:CGAffineTransform = CGAffineTransformMakeRotation(0)
    if (rotateOnDrag) {
      //if (translation.x < 0) {
      //  if (xFromCenter > -50) {
          println("xFromCenter = \(xFromCenter) with translation.x = \(translation.x)")
          xFromCenter += translation.x
      //  }
      //} else {
      //  if (xFromCenter > 50) {
      //    println("xFromCenter = \(xFromCenter) with translation.x = \(translation.x)")
      //    xFromCenter += translation.x
      //  }
      //}
      
      var angle = xFromCenter / 800
      println("angle = \(angle) PI radian")
      // assert(angle >= 0, "O angulo deve ser positivo")
      rotation = CGAffineTransformMakeRotation(angle)
      label.transform = rotation
      
      // reset translation for next interaction on Main View
      gesture.setTranslation(CGPointZero, inView: self.view)
    }
    
    var p:CGPoint = gesture.locationInView(self.view)
    var center:CGPoint = CGPointZero
    
    switch gesture.state {
      case .Began:
        println("began")
        println("dataSourceCoordinate = \(dataSourceCoordinate)")
      case .Changed:
        println("changed")
      case .Ended:
        println("  •••   " / "   ended   ")
        self.dataSourceCoordinate.x = label.center.x
        self.dataSourceCoordinate.y = label.center.y
        // self.dataSourceCoordinate.z = 0
      default:
      println("•••   " - " default")
    }
    
    if (scaleOnDrag) {
      
      var scale = min(100 / abs(xFromCenter), 1)
      
      // var rotation:CGAffineTransform = CGAffineTransformMakeRotation(xFromCenter / 200)
      
      var stretch:CGAffineTransform = CGAffineTransformScale(rotation, scale, scale)
      
      label.transform = stretch
      
      if label.center.x < 100 {
        println("Not Chosen")
      } else if label.center.x > self.view.bounds.width - 100 {
        println("Chosen")
      }
      
      if gesture.state == UIGestureRecognizerState.Ended {
        
        label.center = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height / 2)
        
        scale = max(abs(xFromCenter)/100, 1)
        
        rotation = CGAffineTransformMakeRotation(0)
        
        stretch = CGAffineTransformScale(rotation, scale, scale)
        
        label.transform = stretch
      }
    }
  }

}

