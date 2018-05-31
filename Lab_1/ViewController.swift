//
//  ViewController.swift
//  Lab_1
//
//  Created by Nosta on 31.03.2018.
//  Copyright © 2018 Nosta. All rights reserved.
//

import Cocoa
import CorePlot

/*func CheckPoint(x: Double) -> Bool{
    var y : Double = asin(x) + x*x
    
    y = sqrt(1-x*x)
    
    if y <=
    
    return
}*/


// здесь типа точки, по которым будет строиться график
func GenerateDataSamples() -> [Int : (Double, Double)] {

    var samples = [Int : (Double, Double)]()
    
    /*samples[0] = (-1.0, 0.0)
    samples[1] = (0.0, 1.0)
    samples[2] = (1.0, 0.0)
    samples[3] = (0.0, -1.0)
    samples[4] = (-1.0, 0.0)*/
    
    let delta = (1 - (-1))/(999.0 - 1)
    
    samples[0] = (-1.0, 0.0)
    
    for step in 1...999 {
        // это шаг
        //let x = Double(step)
        let x : Double = -1 + delta * Double(step)
        // это, собстна, сам график
        let y = sqrt(1-x*x)
        //let y : Double = asin(x) + x*x
        // это коллекция координат (х, у)
        
        samples[step] = (x, y)
    }
    
    for step in 1...999 {
        // это шаг
        //let x = Double(step)
        let x : Double = -1 + delta * Double(step)
        // это, собстна, сам график
        let y = sqrt(1-x*x)
        //let y : Double = asin(x) + x*x
        // это коллекция координат (х, у)
        
        samples[step+999] = (x, -y)
    }
    
    samples[samples.count] = (-1.0, -0.0)
    
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
        let axisStyle = CPTMutableLineStyle()
        axisStyle.lineWidth = 1
        axisStyle.lineColor = CPTColor.black()
        
        // присваиваем осям стиль линий
        x.axisLineStyle = axisStyle
        y.axisLineStyle = axisStyle
        
        // стиль отображаемого графика
        let graphStyle = CPTMutableLineStyle()
        graphStyle.lineWidth = 2
        graphStyle.lineColor = CPTColor.blue()
        
        let line : CPTScatterPlot = CPTScatterPlot()
        line.dataSource = self
        line.dataLineStyle = graphStyle
        graph.add(line)
        
        
        
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
