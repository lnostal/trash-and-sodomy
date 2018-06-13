//
//  ViewController.swift
//  Lab_1
//
//  Created by Nosta on 31.03.2018.
//  Copyright © 2018 Nosta. All rights reserved.
//

import Cocoa
import CorePlot

func GetСoordinates(textFieldX: NSTextField, textFieldY: NSTextField) -> (Double?, Double?){
    let stringX = textFieldX.stringValue
    let x = Double(stringX)
    let stringY = textFieldY.stringValue
    let y = Double(stringY)
    
    return (x, y)
}

// вывод результата в текстфилд
func ChangeLabel(isCorrect: Bool?, label: NSTextField){
    if isCorrect == nil {
        label.textColor = NSColor.orange
        label.stringValue = "ошибка ввода"
    } else if isCorrect! {
        label.textColor = NSColor.systemGreen
        label.stringValue = "принадлежит"
    } else {
        label.textColor = NSColor.red
        label.stringValue = "не принадлежит"
    }
}

// проверка принадлежности точки к выделенной области
func CheckPoint(coord: (oX: Double?, oY: Double?)) -> Bool?{
    
    guard coord.oX != nil && coord.oY != nil else { return nil }
    
    let x = coord.oX!
    let y = coord.oY!
    
    let firstQuarter    = y <= sqrt(1 - x * x) && x >= -1 && x <= 0 && y >= 0 && y <= 1
    let secondQuarter   = y >= -sqrt(1 - x * x) && x >= -1 && x <= 0 && y <= 0 && y >= -1
    let thirdQuarter    = y <= -x + 1 && x <= 1 && x >= 0 && y >= 0 && y <= 1
    let fourthQuarter   = y >= x - 1 && x <= 1 && x >= 0 && y <= 0 && y >= -1

    return firstQuarter || secondQuarter || thirdQuarter || fourthQuarter
}

class ViewController: NSViewController {
    
    @IBOutlet weak var graphView: CPTGraphHostingView!
    @IBOutlet weak var textFieldX: NSTextField!
    @IBOutlet weak var textFieldY: NSTextField!
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var button: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.graphView.hostedGraph = CreateGraph(controller: self)
        
    }

    // обработка нажатия кнопки
    @IBAction func buttonTapped(button: NSButton){
        
        let coord = GetСoordinates(textFieldX: textFieldX, textFieldY: textFieldY)
        
        ChangeLabel(isCorrect: CheckPoint(coord: coord), label: label)
    }
    
    // Do any additional setup after loading the view.
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}


