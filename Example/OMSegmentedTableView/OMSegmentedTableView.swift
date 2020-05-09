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

public struct OMTableViewSegment {
    var title: String?
    var image: UIImage?
    var index: Int
    var data: [Any]
}

open class OMSegmentedTableView: UITableView {
    var segmentedControl: UISegmentedControl?
    var segments = [OMTableViewSegment]() {
        didSet {
            updateLayout()
        }
    }
    func updateLayout() {
        let frame =  CGRect(x: 0,y: 0, width: self.bounds.width, height: 40)
        segmentedControl?.frame = frame
        if !segments.isEmpty {
            var index = 0
            segmentedControl?.removeAllSegments()
            for segment in segments {
                if let tilte = segment.title {
                    segmentedControl?.insertSegment(withTitle: tilte, at: index, animated: false)
                } else if let image = segment.image {
                    segmentedControl?.insertSegment(with: image, at: index, animated: false)
                } else {
                    assertionFailure()
                }
                index = index + 1
            }
            
            if segmentedControl?.selectedSegmentIndex == -1 {
                segmentedControl?.selectedSegmentIndex = 0
            }
        }
    }
    
    @objc func segmentedControlActionChanged(sender: UISegmentedControl) {
        self.reloadData()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let frame =  CGRect(x: 0,y: 0, width: self.bounds.width, height: 40)
        segmentedControl = UISegmentedControl(frame: frame)
        segmentedControl?.addTarget(self, action: #selector(segmentedControlActionChanged), for: .valueChanged)
        self.tableHeaderView = segmentedControl
        setNeedsLayout()
    }
    open override func layoutSubviews() {
        
        let oldFrame = self.frame

        super.layoutSubviews()
        if oldFrame != self.frame {
            updateLayout()
        }
    }
    open func removeAllSegments() {
        segments.removeAll()
        segmentedControl?.removeAllSegments()
        self.tableHeaderView = nil
        self.reloadData()
    }
    // insert before segment number. 0..#segments. value
    open func insertSegment(withTitle title: String?, at segment: Int, data: [Any], animated: Bool) {
        segments.append(OMTableViewSegment(title: title, image: nil, index: segment, data: data))
        self.setNeedsLayout()
    }
    open func insertSegment(with image: UIImage?, at segment: Int, data: [Any], animated: Bool) {
        segments.append(OMTableViewSegment(title: nil, image: image, index: segment, data: data))
        self.setNeedsLayout()
    }
    
    open func segmentForIndex() -> OMTableViewSegment? {
        
        guard let segmentedControl = segmentedControl, segmentedControl.selectedSegmentIndex != -1 else {
            return nil
        }
        return segments[segmentedControl.selectedSegmentIndex]
    }
    
}
