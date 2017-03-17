//
//  ViewController.swift
//  DropDownViewDemo
//
//  Created by zhuxuhong on 2017/3/17.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!

    let items1 = ["蔬菜", "水果", "食物"]
    
    var selectedIndex = 0{
        didSet{
            let title = "\(items1[selectedIndex]) ▼"
            btn1.titleLabel?.text = title
            btn1.setTitle(title, for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actionOfButtonClick(_ sender: UIButton){
        DropDownView.show(items: items1, selectedIndex: selectedIndex, sourceView: sender)
        {[unowned self] (index) in
            self.selectedIndex = index
        }
    }
}

