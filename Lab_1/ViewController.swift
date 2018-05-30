//
//  ViewController.swift
//  Lab_1
//
//  Created by Nosta on 31.03.2018.
//  Copyright © 2018 Nosta. All rights reserved.
//

import Cocoa
import CorePlot


// здесь типа точки, по которым будет строиться график
func GenerateDataSamples() -> [Int : (Double, Double)] {
    
    // 8 - начало, -7 - конец, 10 - количество точек
    var samples = [Int : (Double, Double)]()
    let delta = (2 - (-2))/(999.0 - 1)
    
    for step in 1...999 {
        // это шаг
        //let x = Double(step)
        let x : Double = -2 + delta * Double(step)
        // это, собстна, сам график
        let y : Double = asin(x) + x*x
        // это коллекция координат (х, у)
        samples[step] = (x, y)
    }
    
    return samples
}


class ViewController: NSViewController {
    
    @IBOutlet weak var graphView: CPTGraphHostingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // создаем граф
        let graph = CPTXYGraph()
        
        // устанавливаем рабочую область графа интервалами координат
        let xMin = -2.0
        let xMax = 2.0
        let yMin = -2.0
        let yMax = 2.0
        
        // создаем саму рабочую область, собственно
        guard let plotSpace = graph.defaultPlotSpace as? CPTXYPlotSpace else { return }
        
        plotSpace.xRange = CPTPlotRange(locationDecimal: CPTDecimalFromDouble(xMin), lengthDecimal: CPTDecimalFromDouble(xMax - xMin))
        plotSpace.yRange = CPTPlotRange(locationDecimal: CPTDecimalFromDouble(yMin), lengthDecimal: CPTDecimalFromDouble(yMax - yMin))
        
        // устанавливаем внутренний отступ координат от границы рабочей области графа
        graph.paddingLeft = 15
        graph.paddingTop = 15
        graph.paddingRight = 15
        graph.paddingBottom = 15
        
        // устанавливаем оси абсцисс/ординат
        let axisSet = graph.axisSet as! CPTXYAxisSet
        let x = axisSet.xAxis!
        let y = axisSet.yAxis!
        
        // устанавливаем тип линии осей
        let lineStyle = CPTMutableLineStyle()
        lineStyle.lineWidth = 1
        lineStyle.lineColor = CPTColor.red()
        
        // присваиваем осям стиль линий
        x.axisLineStyle = lineStyle
        y.axisLineStyle = lineStyle
        
        let line : CPTScatterPlot = CPTScatterPlot()
        line.dataSource = self
        graph.add(line)
        // @todo: раскурить про self
        self.graphView.hostedGraph = graph
        
    }
    
    
    // Do any additional setup after loading the view.
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension NSViewController: CPTPlotDataSource{
    
    public func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(GenerateDataSamples().count)
    }
    
    public func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        let symbol = GenerateDataSamples()[Int(idx)];
        
        if fieldEnum == UInt(CPTScatterPlotField.X.rawValue) {
            return symbol?.0
        } else {
            return symbol?.1
        }
    }
}
