//
//  DropDownView.swift
//  DropDownViewDemo
//
//  Created by zhuxuhong on 2017/3/17.
//  Copyright © 2017年 zhuxuhong. All rights reserved.
//

import UIKit


class DropDownView: UIView {
// MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTopCons: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightCons: NSLayoutConstraint!

    
// MARK: - properties
    var callbackForCellDidSelect: ((_ index: Int) -> Void)?
    
    private var maxHeight: CGFloat = 240{
        didSet{
            animate(isShow: true)
        }
    }
    
    var items = [String](){
        didSet{
            // 适应高度
            maxHeight = min(maxHeight, CGFloat(items.count * 44))
            tableView.reloadData()
        }
    }
    
    var selectedIndex = 0
    
    var topCons: CGFloat = 0{
        didSet{
            tableViewTopCons.constant = topCons
            tableView.layoutIfNeeded()
        }
    }
    
// MARK: - initial method
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
// MARK: - lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

// MARK: - action & IBOutletAction
    @IBAction func actionOfGestureDidTrigger(_ sender: UIGestureRecognizer){
        cancel()
    }
    
    
// MARK: - private method
    private static func viewFromXib() -> DropDownView{
        let v = Bundle.main.loadNibNamed("DropDownView", owner: nil, options: nil)?.first as! DropDownView
        
        
        return v
    }
    
    private func animate(isShow: Bool){
        tableViewHeightCons.constant = isShow ? maxHeight : 0
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: { 
            self.layoutIfNeeded()
            
        }) { (finished) in
            if !isShow {
                self.removeFromSuperview()
            }
        }
    }
    
    func cancel(){
        animate(isShow: false)
    }
    
// MARK: - getters
    
// MARK: - setters
    
// MARK: - delegate method
    
// MARK: - public method
    public static func show(items: [String],
                            selectedIndex: Int,
                            sourceView: UIView,
                            completion: ((_ index: Int) -> Void)?){
        let v = DropDownView.viewFromXib()
        v.items = items
        v.callbackForCellDidSelect = completion
        v.selectedIndex = selectedIndex
        
        let window = UIApplication.shared.keyWindow!
        window.addSubview(v)
        v.frame = window.bounds
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 坐标转换
        let p = CGPoint(x: 0, y: sourceView.frame.maxY)
        v.topCons = sourceView.superview!.convert(p, to: v).y + 10
    }
}

extension DropDownView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00000001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00000001
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        cell.accessoryType = indexPath.row == selectedIndex ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let callback = callbackForCellDidSelect else {
            return
        }
        
        callback(indexPath.row)
        cancel()
    }
}
