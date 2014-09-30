//
//  Exemplo002Tests.swift
//  Exemplo002Tests
//
//  Created by Joao Ferreira on 9/27/14.
//  Copyright (c) 2014 si. All rights reserved.
//

import UIKit
import XCTest
// import ViewController

class Exemplo002Tests: XCTestCase {
    // let viewController = ViewController()
    // var vc:ViewController = ViewController()

    // var controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("myViewController") as UINavigationController
  
    override func setUp() {
        super.setUp()
      
        var controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("myViewController") as UINavigationController

        println("Verificando controller.viewDidLoad() ")
      
        // controller.viewDidLoad()
      
        println("Terminou controller.viewDidLoad() ")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        println("tearDown() executado")
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
      
        println("executando testExample() ")
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
      println("executando testPerformanceExample() ")
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
