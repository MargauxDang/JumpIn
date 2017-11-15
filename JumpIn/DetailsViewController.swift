//
//  DetailViewController.swift
//  PNChartSwift
//
//  Created by YiChen Zhou on 8/14/17.
//

import UIKit
import Firebase
import FirebaseDatabase

class DetailViewController: UIViewController {
    var chartName: String?
    var jump1: String!
    var jump2: String!
    var jump3: String!
    var jump4: String!
    var jump5: String!
    var jump6: String!
    var jump7: String!
    var jump8: String!
    var jump9: String!
    var jump10: String!
    
    var ref:DatabaseReference!

    @IBOutlet var session1txt: UIButton!
    @IBOutlet var session2txt: UIButton!
    @IBOutlet var session3txt: UIButton!
    @IBOutlet var session4txt: UIButton!
    @IBOutlet var session5txt: UIButton!
    @IBOutlet var session6txt: UIButton!
    @IBOutlet var session7txt: UIButton!
    @IBOutlet var session8txt: UIButton!
    @IBOutlet var session9txt: UIButton!
    @IBOutlet var session10txt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let _chartName = self.chartName else {
            print("Invalid Chart Name")
            return
        }
        
        self.title = _chartName
        
        switch _chartName {
        case "Calories":
            let barChart = self.setBarChartCalories()
            self.view.addSubview(barChart)
        case "Jumps":
            let barChart = self.setBarChartJumps()
            self.view.addSubview(barChart)
        case "Altitude":
            let barChart = self.setBarChartAltitude()
            self.view.addSubview(barChart)
        default:
            break
        }
    }
    
    private func setBarChartJumps() -> PNBarChart {
        
        //Retrieve data
        let userID = (Auth.auth().currentUser?.uid)!
        Database.database().reference().child("sessions").child(userID).child("session1").observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? [String:Any]
                let jump = value?["jumps"] as? String ?? ""
                self.jump1 = jump
                print("1")
            }
        
            print("2")
            let barChart = PNBarChart(frame: CGRect(x: 0, y: 50, width: 320, height: 200))
            barChart.backgroundColor = UIColor.clear
            barChart.animationType = .Waterfall
            barChart.labelMarginTop = 5.0
            barChart.xLabels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10" ]
            barChart.yValues = [30, 23, 12, 18, 30, 12, 21, 8, 9, 50]
            barChart.strokeChart()
            barChart.center = self.view.center
        
        return barChart
    }

    private func setBarChartCalories() -> PNBarChart {
        let barChart = PNBarChart(frame: CGRect(x: 20, y: 50, width: 300, height: 200))
        barChart.backgroundColor = UIColor.clear
        barChart.animationType = .Waterfall
        barChart.labelMarginTop = 5.0
        barChart.xLabels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10" ]
        barChart.yValues = [1, 23, 12, 18, 30, 12, 21, 8, 12, 300]
        barChart.strokeChart()
        barChart.center = self.view.center
        return barChart
    }
    
    private func setBarChartAltitude() -> PNBarChart {
        let barChart = PNBarChart(frame: CGRect(x: 0, y: 50, width: 300, height: 200))
        barChart.backgroundColor = UIColor.clear
        barChart.animationType = .Waterfall
        barChart.labelMarginTop = 5.0
        barChart.xLabels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10" ]
        barChart.yValues = [1, 23, 12, 18, 30, 12, 21, 8, 12, 300]
        barChart.strokeChart()
        barChart.center = self.view.center
        return barChart
    }
}
