//
//  GenericTableViewController.swift
//  GenericTableView-Swift
//
//  Created by Gazolla on 16/07/16.
//  Copyright © 2016 Gazolla. All rights reserved.
//

import UIKit

public struct ConfigureTable<Item>{
    var items:[Item]
    var cellType:AnyClass
    var configureCell:(_ cell:UITableViewCell, item:Item)->()
    var selectedRow:(tableView:UITableView, _ indexPath:NSIndexPath)->()
}

class GenericTableViewController<Item>: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items:[Item]{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var cellType:AnyClass
    var configureCell:(cell:UITableViewCell, item:Item)->()
    var selectedRow:(tableView:UITableView, indexPath:NSIndexPath)->()
  
    lazy var tableView:UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .Plain)
        tv.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        tv.delegate = self
        tv.dataSource = self
        tv.registerClass(self.cellType, forCellReuseIdentifier:"cell")
        return tv
    }()
    
    init(config:ConfigureTable<Item>){
        self.items = config.items
        self.cellType = config.cellType
        self.configureCell = config.configureCell
        self.selectedRow = config.selectedRow
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let item = self.items[indexPath.item]
        configureCell(cell: cell, item: item)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow(tableView: tableView, indexPath: indexPath)
    }

}
