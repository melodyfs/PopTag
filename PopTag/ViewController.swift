//
//  ViewController.swift
//  PopTag
//
//  Created by Melody on 4/12/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    open var chartType: AAChartType?
    open var step : Bool?
    open var aaChartModel: AAChartModel?
    open var aaChartView: AAChartView?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectHourBasedOnDay()
        
        aaChartView = AAChartView()
        let chartViewWidth = self.view.frame.size.width
        let chartViewHeight = self.view.frame.size.height-220
        aaChartView?.frame = CGRect(x:0,y:60,width:chartViewWidth,height:chartViewHeight)
        ///AAChartViewd的内容高度(内容高度默认和 AAChartView 等高)
        aaChartView?.contentHeight = chartViewHeight-20
        self.view.addSubview(aaChartView!)
        
        aaChartModel = AAChartModel.init()
            .chartType(AAChartType.Line)//图形类型
            .colorsTheme(["#9b43b4","#ef476f","#ffd066","#04d69f","#25547c",])//主题颜色数组
            .title("")//图形标题
            .subtitle("")//图形副标题
            .dataLabelEnabled(false)//是否显示数字
            .tooltipValueSuffix("℃")//浮动提示框单位后缀
            //            .xAxisVisible(false)// X 轴是否可见
            //            .yAxisVisible(false)// Y 轴是否可见
            //            .backgroundColor("#222733")//图表背景色
            //            .animationType(AAChartAnimationType.Bounce)//图形渲染动画类型为"bounce"
            .series([
                AASeriesElement()
                    .name("Tokyo")
                    .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6])
                    .toDic()!,
                AASeriesElement()
                    .name("New York")
                    .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5])
                    .toDic()!,
                AASeriesElement()
                    .name("Berlin")
                    .data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0])
                    .toDic()!,
                AASeriesElement()
                    .name("London")
                    .data([3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8])
                    .toDic()!,])
        
//        self.configureTheStyleForDifferentTypeChart()
        
        aaChartView?.aa_drawChartWithChartModel(aaChartModel!)
    }
    
    func getCSVrows() -> [[String]] {
        var data = readDataFromCSV(fileName: "mobile_photo", fileType: ".csv")
        data = cleanRows(file: data!)
        let csvRows = csv(data: data!)
        return csvRows
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
    func collectHourBasedOnDay() {
        let csvRows = getCSVrows()
        var rates = [String]()
        
        for i in 1...csvRows.count {
            if  csvRows[i][3] == "Sunday" {
                rates.append(csvRows[i][1])
            } else {
                break
            }
        }
//        print(csvRows[1][1])
//        print(csvRows[1][3])
        
        print(rates)
    }
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }



}

