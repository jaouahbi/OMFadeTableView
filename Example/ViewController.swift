// Copyright 2018 Jorge Ouahbi
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit


class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var segmentedTableView: OMSegmentedTableView!
    
    var segmentTitles: [String] = []
    let segmentData1: [String] = ["Composición data 1",
                                  "Composición data 2"]
    let segmentData2: [String] = ["Últimos movimientos data 1",
                                  "Últimos movimientos data 2",
                                  "Últimos movimientos data 3",
                                  "Últimos movimientos data 4"]
    var segmentData: [[Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmentTitles = ["Composición", "Últimos movimientos"]
        let segmentData = [segmentData1, segmentData2]
        var index = 0
        for item in segmentTitles {
            segmentedTableView.insertSegment(withTitle: item,
                                             at: index,
                                             data: segmentData[index],
                                             animated: false)
            index = index + 1
        }
        segmentedTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let  mySegmentedControl = segmentedTableView.segmentedControl, mySegmentedControl.selectedSegmentIndex != -1 else {
            return 0
        }
        
        return self.segmentedTableView.segmentForIndex()?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        guard let  mySegmentedControl = segmentedTableView.segmentedControl,
            mySegmentedControl.selectedSegmentIndex != -1 else {
                return UITableViewCell(style: .default, reuseIdentifier: "myCell")
        }
        
        let segment = self.segmentedTableView.segmentForIndex()
        
        if let seg = segment, seg.data.count > 0, seg.data.count > indexPath.row {
            myCell.textLabel?.text =  seg.data[indexPath.row] as? String
        }
        
        
        
        return myCell
    }
    
    
    
}
